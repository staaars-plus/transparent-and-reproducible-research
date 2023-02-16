************************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************************
********************************************************************REPLICATION FILE: New Figure Schemes for Stata: plotplain & plottig********************************************************************
************************************************************************************************************************************************************************************************************
************************************************************************************************************************************************************************************************************
*Replication should be straightforward after the installation of the two scheme files and their subfiles. The dataset used is the Global Terrorism Database, downloadable under:
*http://www.start.umd.edu/gtd/contact/  (after registration free of charge)
*NOTICE: FOR REPLICATION PURPOSES THE DIRECTORY UNDER 1.1 BELOW NEEDS TO BE ADAPTED TO THE USER'S WORKING DIRECTORY. 

*****1: dataset import
clear all
*1.2: Import excel from shorted file (original too big for stata):
import excel "globalterrorismdb_0615dist_short.xlsx", sheet("Blatt1") firstrow
*1.3: Save the data in stata 14 format:
save "rep_plotplain_plottig.dta", replace 
drop _all

use "rep_plotplain_plottig.dta"
*****2: recodings and labelling:
rename country country1  
rename region region1
encode country_txt, gen(country)
encode region_txt, gen(region)
gen counter=1

****3: rearrange dataset into yearly region panel:
collapse (sum) counter nkill nwound, by(region iyear)
xtset region iyear
tsfill
*label rearranged data:
rename counter nevents
label var nevents "logged number of terrorist events"
label var nkill "logged number of people killed"
label var nwound "logged number of people wounded"
label var iyear "incident year"

forval i=1/15 {
	gen n`i'=`i'
}
replace nkill=log(nkill+1)
replace nwound=log(nwound+1)
replace nevents=log(nevents+1)

*****4: create figures:
*4.1 scatters:
graph twoway (scatter nkill nevents if region==12 & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==7  & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==6  & nevents<=500 & nkill<=1000) ///
, scheme(s2mono) legend(label(1 Western Europe) label(2 North America) label(3 MENA)) title("s2mono")
graph export plotplain1.eps, replace

*4.2 lines:
graph twoway (line nevents iyear if region==12) (line nevents iyear if region==7) (line nevents iyear if region==6), ///
scheme(s2mono) legend(order(1 "Western Europe" 2 "North America" 3 "MENA"))  title("s2mono") xline(2003) ///
text(8 2003  "Iraq war", place(e)) xlabel(1970(10)2015)
graph export plotplain2.eps, replace

*****************************************************************************************************************************
*4.2 scatters with plotplain:
graph twoway (scatter nkill nevents if region==12 & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==7  & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==6  & nevents<=500 & nkill<=1000) ///
, scheme(plotplainblind) legend(label(1 Western Europe) label(2 North America) label(3 MENA)) title("plotplain") 
graph export plotplain3.eps, replace
*4.2 lines:
graph twoway (line nevents iyear if region==12) (line nevents iyear if region==7) (line nevents iyear if region==6), ///
scheme(plotplainblind) legend(order(1 "Western Europe" 2 "North America" 3 "MENA"))  name(s2m2) title("plotplain") xline(2003) ///
text(8 2003  "Iraq war", place(e)) xlabel(1970(10)2015) 
graph export plotplain4.eps, replace

*****************************************************************************************************************************
*4.3 scatters with plottig:
graph twoway (scatter nkill nevents if region==12 & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==7  & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==6  & nevents<=500 & nkill<=1000) ///
, scheme(plottig) legend(label(1 Western Europe) label(2 North America) label(3 MENA)) name(s2m1) title("plottig")
graph twoway (scatter nkill nevents if region==12 & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==7  & nevents<=500 & nkill<=1000) ///
(scatter nkill nevents if region==6  & nevents<=500 & nkill<=1000) ///
, scheme(plottigblind) legend(label(1 Western Europe) label(2 North America) label(3 MENA)) name(s2c1) title("plottigblind")
*4.2 lines:
graph twoway (line nevents iyear if region==12) (line nevents iyear if region==7) (line nevents iyear if region==6), ///
scheme(plottig) legend(order(1 "Western Europe" 2 "North America" 3 "MENA")) name(s2m2, replace) title("plottig") xline(2003) ///
text(8 2003  "Iraq war", place(e))
graph twoway (line nevents iyear if region==12) (line nevents iyear if region==7) (line nevents iyear if region==6), ///
 scheme(plottigblind) legend(order(1 "Western Europe" 2 "North America" 3 "MENA"))  name(s2c2) title("plottigblind") xline(2003) ///
text(8 2003  "Iraq war", place(e))
*graph combine  
graph combine s2m1 s2c1 s2m2 s2c2, iscale(0.5)  
graph export plotplain5.eps, replace
graph drop s2m1 s2c1 s2m2 s2c2
*****************************************************************************************************************************
*4.4 histogram to introduce colors:
*plotplainblind
graph bar (mean) n1 (mean) n2 (mean) n3 (mean) n4 (mean) n5 (mean) n6 (mean) n7 (mean) n8 (mean) n9, ///
scheme(plotplainblind) legend(order(1 "black" 2 "gs10" 3 "sky" 4 "turquoise" 5 "orangebrown" 6 "reddish" 7 "vermillion" 8 "sea" 9 "ananas")) name(color1) title("plotplainblind")
*plottig
graph bar (mean) n1 (mean) n2 (mean) n3 (mean) n4 (mean) n5 (mean) n6 (mean) n7 (mean) n8 (mean) n9 (mean) n10 (mean) n11 (mean) n12 (mean) n13 (mean) n14 (mean) n15, ///
scheme(plottig) legend(order(1 "black" 2 "plr1" 3 "ply1" 4 "plg1" 5 "plb1" 6 "pll1" 7 "plr2" 8 "ply2" 9 "plg2" 10 "plb2" 11 "pll2" 12 "ply3" 13 "plg3" 14 "plb3" 15 "pll3")) name(color2) title("plottig")
graph combine color1 color2, col(1) xcommon
graph export plotplain6.eps, replace
graph drop color1 color2
***
*4.5 polynomial fit:
lpoly nkill iyear if region==12, ///
ci legend(off) title("Polynomial fit of terrorist casualties in Western Europe") ///
note("") xlabel(, nogrid) 
graph export plotplain7.eps, replace
