********************************************************************************
**************              Loreto Paper                  **********************
**************     Using Remote Sensing to understand malaria prevalence *******
********************************************************************************         


*** Data management
** Setting preferences 
clear
set more off					// Clear everything	
set linesize 80					// Deactivate the command more	
set scheme s1color, permanently // Setting a max of 80 per line
clear

** Importing data 
* Change your working directory to the appropriate path 
cd "C:\Users\Aneela\Desktop\LoretoPaper_Spring\Statistics\stata"

* Importing the data from the excel file
import excel "HealthCenterClimate_Malaria2009_2013.xlsx", sheet("mal_lor_prev_09_13") firstrow
save "HealthCenterClimate_Malaria2009_2013", replace

** Reshaping the data from wide to long format
reshape long precipA precipB precipC precipD precipE precipF precipG precipH ///
tempA tempB tempC tempD tempE tempF tempG tempH tempI tempJ tempK ///
tempL tempM humidA humidB humidC humidD humidE humidF ///
pressureA pressureB pressureC pressureD pressureE pressureF ///
soilmoistA soilmoistB soilmoistC soilmoistD soilmoistE evi ndvi pmviv pmfal pmtot ///
mviv mfal mtot pop_, i(id) j(year) 
save "HealthCenterClimate_Malaria2009_2013_long", replace

** Encoding strings into numberic for red, microreds, hcname_id
*Red
encode red, gen(red_id)
tab red_id, nolabel
tab red_id
*Microreds
encode microred, gen(microred_id)
tab microred_id, nolabel 
tab microred_id
*Hcname_id
encode hcname, gen(hcname_id)
tab hcname_id, nolabel sort 
tab hcname_id, sort

*** Descripitive Analysis ***
**Total population and malaria cales 
table year, c(sum mtot)
table year, c(sum pop_)
bysort red: table year, c(mean pmtot sd  pmtot)

bysort red: table year, c(sum mtot)
bysort red: table year, c(sum pop_)


*** Data Analysis *** 
** Variable transformation
* Precipitation 
gen precipA1000=precipA/1000
gen precipB1000=precipB/1000
gen precipC1000=precipC/1000

* Elevation 
histogram elevA
tab elevA
recode elevA (min/99.9=0) (100.0/149.9=1) (150.0/199.9=2) (200/max=3), gen(elevA_x50)
recode elevA (min/99.9=0) (100.0/199.9=1) (200/max=2), gen(elevA_x100)
recode elevA (min/99.9=0) (100.0/max=1), gen(elevA_100)
recode elevA (min/149.9=0) (150.0/max=1), gen(elevA_150)
recode elevA (min/199.9=0) (200.0/max=1), gen(elevA_200)
tab elevA_x50
tab elevA_x100
tab  elevA_100
tab  elevA_150
tab  elevA_200

** Univariate Analysis for the variables to calculate AIC&BIC
* Precipitation 
meqrpoisson pmtot precipA1000 year || red_id: ,irr		
estat ic // 219412.8    219434.3
meqrpoisson pmtot precipB1000 year || red_id: ,irr			
estat ic // 218222    218243.5
meqrpoisson pmtot precipC1000 year || red_id: ,irr	
estat ic // 222214.4    222235.9
meqrpoisson pmtot precipD year || red_id: ,irr			
estat ic // 220440.6    220462.1
meqrpoisson pmtot precipE year || red_id: ,irr	
estat ic  // 220110.1    220131.5
meqrpoisson pmtot precipF year || red_id: ,irr	
estat ic // 220088.8    220110.2
meqrpoisson pmtot precipG year || red_id: ,irr	
estat ic  // 219707.2    219728.6
meqrpoisson pmtot precipH year || red_id: ,irr	
estat ic // 221169.8    221191.3

* Temperature 
meqrpoisson pmtot tempA year || red_id: ,irr		
estat ic // 219411.7    219433.1
meqrpoisson pmtot tempB year || red_id: ,irr			
estat ic // 222804    222825.5
meqrpoisson pmtot tempC year || red_id: ,irr	
estat ic // 216885.1    216906.6
meqrpoisson pmtot tempD year || red_id: ,irr			
estat ic //  221102.7    221124.1
meqrpoisson pmtot tempE year || red_id: ,irr	
estat ic //  220892.3    220913.7
meqrpoisson pmtot tempF year || red_id: ,irr	
estat ic // 222675.9    222697.3
meqrpoisson pmtot tempG year || red_id: ,irr	
estat ic  // 221505.7    221527.2
meqrpoisson pmtot tempH year || red_id: ,irr	
estat ic // 222799.4    222820.8
meqrpoisson pmtot tempI year || red_id: ,irr			
estat ic // 215851.4    215872.9
meqrpoisson pmtot tempJ year || red_id: ,irr	
estat ic //  222701.3    222722.8
meqrpoisson pmtot tempK year || red_id: ,irr	
estat ic // 222857.9      222874
meqrpoisson pmtot tempL year || red_id: ,irr	
estat ic //  220360    220381.4
meqrpoisson pmtot tempM year || red_id: ,irr	
estat ic // 219256.7    219278.1


* Humidity 
meqrpoisson pmtot humidA year || red_id: ,irr		
estat ic // 222143.3    222164.8
meqrpoisson pmtot humidB year || red_id: ,irr			
estat ic  // 221067.9    221089.4
meqrpoisson pmtot humidC year || red_id: ,irr	
estat ic // 222652.3    222673.8
meqrpoisson pmtot humidD year || red_id: ,irr			
estat ic // 220335.4    220356.8
meqrpoisson pmtot humidE year || red_id: ,irr	
estat ic //  222362.8    222384.2
meqrpoisson pmtot humidF year || red_id: ,irr	
estat ic //  222121.2    222142.7

* Soil Moisture 
meqrpoisson pmtot soilmoistA year || red_id: ,irr		
estat ic // 219376.1    219397.6
meqrpoisson pmtot soilmoistB year || red_id: ,irr			
estat ic // 220638.8    220660.2
meqrpoisson pmtot soilmoistC year || red_id: ,irr	
estat ic // 218650.1    218671.5
meqrpoisson pmtot soilmoistD year || red_id: ,irr			
estat ic //  218015.7    218037.2
meqrpoisson pmtot soilmoistE year || red_id: ,irr	
estat ic // 221520.7    221542.1

* Vegetation index 
meqrpoisson pmtot evi year || red_id: ,irr		
estat ic // 222858.3    222879.8
meqrpoisson pmtot ndvi year || red_id: ,irr		
estat ic // 219755.7    219777.2

*Elevation 
meqrpoisson pmtot elevA year || red_id: ,irr		
estat ic // 222858.8    222880.2
meqrpoisson pmtot elevA_100 year || red_id: ,irr		
estat ic // 216387.8    216409.2
meqrpoisson pmtot elevA_150 year || red_id:, irr		
estat ic //  222858.6      222880
meqrpoisson pmtot elevA_200 year || red_id: ,irr		
estat ic // 221168.3    221189.8

** Summary of the Univariate Analysis
* Multivariable analysis / ranking based on binory analysis 
* tempI year  // 215851.4    215872.9
* pmtot elevA_100 // 216387.8    216409.2
* soilmoistD  //  218015.7    218037.2
* precipB1000 year // 218222    218243.5
* ndvi  // 219755.7    219777.2
* humidD year  // 220335.4    220356.8


** Correlation / Multivariable Analysis

* m0 model
meqrpoisson pmtot year || red_id:  ,irr	
estat ic // 222857.9      222874 * 

* m1 model
meqrpoisson pmtot tempI year || red_id:,irr	
estat ic //  215851.4    215872.9

* m2 model
pwcorr tempI elevA_100, sig
meqrpoisson pmtot tempI elevA_100 year || red_id:,irr	
estat ic //  210815.9    210842.7

* m3 model
pwcorr tempI elevA_100 soilmoistD, sig
meqrpoisson pmtot tempI elevA_100 soilmoistD year || red_id:,irr	
estat ic //  208848.3    208880.4

* m4 model
pwcorr tempI elevA_100 soilmoistD precipB1000, sig
meqrpoisson pmtot tempI elevA_100 soilmoistD precipB1000 year || red_id:,irr	
estat ic // 205998.5      206036

* m4 model
pwcorr tempI elevA_100 soilmoistD precipB1000 ndvi, sig
meqrpoisson pmtot tempI elevA_100 soilmoistD precipB1000 ndvi year || red_id:,irr	
estat ic //  205805.5    205848.4 *** Final model 

* m5 model
pwcorr tempI elevA_100 soilmoistD precipB1000 ndvi humidD, sig //Humidity correlated with both ndvi&soil moisture
meqrpoisson pmtot tempI elevA_100 soilmoistD precipB1000 ndvi humidD year || red_id:,irr	
estat ic //   204769.7 

* m6 model * remove soilmoistD and ndvi 
pwcorr tempI elevA_100 precipB1000 humidD, sig
meqrpoisson pmtot tempI elevA_100 precipB1000 humidD year || red_id:,irr	
estat ic //   206882.7    206920.2



***** FINAL MODEL* **** *

* m4 model
pwcorr tempI elevA_100 soilmoistD precipB1000 ndvi, sig
meqrpoisson pmtot tempI elevA_100 soilmoistD precipB1000 ndvi year || red_id:,irr	
estat ic //  205805.5    205848.4


