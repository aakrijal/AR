
import delimited "Survey_Data_Raw.csv", clear 

*Rename the variables

rename v1 StartDate
rename v2 Enddate
rename v3 Response_Type
rename v4 IP
rename v5 Q_Progress
rename v6 Duration
rename v7 Completion_Status
rename v8 Recorded_Date
rename v9 Response_ID
rename v10 Last_name
rename v11 First_name
rename v12 Email
rename v13 External_Reference
rename v14 Latitude
rename v15 Longitude
rename v16 Distribution_Channel
rename v17 Language
rename v18 Recaptcha
rename v19 Consent
rename v20 City
rename v21 zip_code
rename v22 Age 
rename v23 Ethnicity
rename v24 Gender
rename v25 Education 
rename v26 HHsize
rename v27 HH_Children
rename v28 Marital_Status
rename v29 Spouse_Education
rename v30 Annual_HHincome
rename v31 Car_Ownership
rename v32 SNAP_Enrolled

*On a scale from 0-100, use the slider to select how important the following factors are regarding choosing where to purchase groceries. 
rename v33 GConv_Home
rename v34 GConv_Work
rename v35 GArea_Cleanliness
rename v36 GQuality
rename v37 GAtmosphere_safety
rename v38 GPrice
rename v39 GOnestopshop

*GROCERY HABIT

rename v40 GS_Frequency
rename v41 GS_Spending
rename v42 FM_Spending
rename v43 GS_Traveltime
rename v44 FM_Traveltime

*Why do you frequent the farmers' market? (Drag each factor and rank in order of importance)rename v50 reasonproduce
rename v45 R_Produce
rename v46 R_Foodtruck
rename v47 R_Activities
rename v48 R_People
rename v49 R_Entertainment
rename v50 R_Leisure
rename v51 R_Supportlocal

rename v52 FM_Attendance
rename v53 FM_Name

rename v54 FM_Seasonfrequency
rename v55 SNAP_Acceptance
rename v56 FM_Days
rename v57 FM_FreqClosest
rename v58 FM_NameClosest

**Why do you not frequent your closest farmers' market? 
rename v59 R_Novisit
rename v60 R_Novisit_Other

**** CULTURAL BARRIERS, PERCEPTION AND TRUST

*For each statement, answer whether you believe it is true or false regarding farmers' market
rename v61 TOF_Bestproduce
rename v62 TOF_Freshclean
rename v63 TOF_Grownbetter
rename v64 TOF_Longlasting
rename v65 TOF_Cheaper
rename v66 TOF_Safer
rename v67 TOF_Ethnicfood
rename v68 TOF_Tastebetter

*On a scale from 0-100, use the slider to select the percentage you agree/disagree with each statement.
rename v69 FM_Overpriced
rename v70 FM_Forrich
rename v71 FM_Unavailability
rename v72 FM_NotasGS
rename v73 FM_Uncleanproduce
rename v74 FM_NotappealingComm
rename v75 FM_Restrictivetiming
rename v76 FM_Notime

*On a scale from 0-100, Please select how likely these groups/individuals are to visit their local farmers' market?
* Likelihood of Visiting Farmers' Market

rename v77 Family_Likelihood
rename v78 Friends_Likelihood
rename v79 Community_Likelihood
rename v80 HighIncomeHH_Likelihood
rename v81 LowIncomeHH_Likelihood
rename v82 Yourself_Likelihood

*On a scale from 0-100, use the slider to select the percentage you agree/disagree with each statement.
rename v83 AOD_Localtrust
rename v84 AOD_GSmoresafer
rename v85 AOD_Unusedproductsale
rename v86 AOD_Usualtimeclosed
rename v87 AOD_Untestedsafety
rename v88 AOD_Shopiffreetransp
rename v89 AOD_Shopifdiscount
rename v90 AOD_Shopifsafeguarantee
rename v91 AOD_Urbantrust
rename v92 Transaction_ID
drop v93



*Drop the info 
drop if _n<11

*Consent
drop if Consent=="No"
replace Consent="1" if Consent=="Yes"
destring Consent, replace

*Completion status
drop if Completion_Status=="False"
replace Completion_Status="1" if Completion_Status=="True"
destring Completion_Status, replace

*Recaptcha 

destring Recaptcha,replace
gen bot=(Recaptcha<0.5)

destring  Latitude Longitude, replace

*Zip_Code

destring zip_code, replace
sort zip_code


*Tennessee Only
drop if zip_code< 37010
drop if zip_code> 38601

** City

drop if City=="I do not live in Tennessee"

*Age
destring Age, replace
drop if Age==100 //suspicious

* Ethnicity
gen White=(Ethnicity=="White/Caucasian")
gen Asian=(Ethnicity== "Asian/Pacific Islander")
gen American_indian=( Ethnicity=="American Indian or Alaskan Native")
gen Black=(Ethnicity=="Black or African American")
gen Other=(Ethnicity=="other")


*Gender
replace Gender="0" if Gender=="Female"
replace Gender="1" if Gender=="Male"
replace Gender="2" if Gender=="Non-binary / third gender"
replace Gender="3" if Gender== "Prefer not to say"
destring Gender, replace

*HHsize
destring HHsize, replace
destring HH_Children, replace

drop if HH_Children> HHsize

* Education

tab Education
replace Education="1" if Education=="Less than a high school diploma"
replace Education="2" if Education=="High school diploma or equivalent (e.g., GED)"
replace Education="3" if Education=="Some college, no degree"
replace Education="4" if Education=="Associate degree"
replace Education="5" if Education=="Bachelor's degree"
replace Education="6" if Education=="Master's degree or higher"
destring Education, replace

*maritalstatus
replace Marital_Status="0" if Marital_Status=="No"
replace Marital_Status="1" if Marital_Status=="Yes"
destring Marital_Status, replace

*Highest education of spouse
replace Spouse_Education="1" if Spouse_Education=="Less than high school diploma"
replace Spouse_Education="2" if Spouse_Education=="High school diploma or equivalent (e.g. GED)"
replace Spouse_Education="3" if Spouse_Education=="Some college, no degree"
replace Spouse_Education="4" if Spouse_Education=="Associate degree"
replace Spouse_Education="5" if Spouse_Education=="Bachelor's degree"
replace Spouse_Education="6" if Spouse_Education=="Master's degree or higher"
destring Spouse_Education, replace

replace Spouse_Education=0 if Spouse_Education==.

*Annual household income (midpoint)

gen A_Income=5000 if  Annual_HHincome =="Under $10,000"
replace A_Income=12500 if Annual_HHincome=="$10,000 - $24,999"
replace  A_Income=37500 if Annual_HHincome=="$25,000 - $49,000"
replace  A_Income=62500 if Annual_HHincome=="$50,000 - $74,999"
replace  A_Income=87500 if Annual_HHincome=="$75,000 - $99,000"
replace  A_Income=125000 if Annual_HHincome=="$100,000 - $149,999"
replace  A_Income=225000 if Annual_HHincome=="$150,000 or over"

drop if Annual_HHincome=="Prefer not to answer"



foreach var of varlist Car_Ownership SNAP_Enrolled {
    replace `var' = "1" if `var' == "Yes"
    replace `var' = "0" if `var' == "No"
}

replace SNAP_Enrolled = "2" if SNAP_Enrolled== "Prefer not to answer"

foreach var of varlist Car_Ownership-SNAP_Enrolled {
    destring `var', replace 
}

************************************************************************************************************************
*factors are regarding choosing where to purchase groceries.

foreach var of varlist(GConv_Home-GOnestopshop){
destring `var', replace 
}
*spending at grocery storetravel time to grocery shopping

foreach var of varlist(GS_Spending-FM_Traveltime){
	destring `var', replace
}

*  FM Frequency(FM_Attendance) Have you frequented a farmers' market in your area in the past two years? 

replace  FM_Attendance="1" if   FM_Attendance== "Yes"
replace  FM_Attendance= "0" if   FM_Attendance=="No"
destring FM_Attendance, replace



*Does the farmers' market you frequent accept SNAP benefits?
replace  SNAP_Acceptance="1" if  SNAP_Acceptance== "Yes"
replace  SNAP_Acceptance= "0" if  SNAP_Acceptance=="No"
replace  SNAP_Acceptance= "2" if  SNAP_Acceptance=="Not sure"
destring SNAP_Acceptance, replace 





*frequency of grocery shopping

replace GS_Frequency="1" if GS_Frequency=="Less than once per month"
replace GS_Frequency="2" if GS_Frequency=="Once per month"
replace GS_Frequency="3" if GS_Frequency=="Once every two weeks"
replace GS_Frequency="4" if GS_Frequency=="Once per week"
replace GS_Frequency="5" if GS_Frequency=="More than once per week"

destring GS_Frequency, replace


*frequency in season

replace FM_Seasonfrequency="1" if FM_Seasonfrequency=="Less than once per month"
replace FM_Seasonfrequency="2" if FM_Seasonfrequency=="Once per month"
replace FM_Seasonfrequency="3" if FM_Seasonfrequency=="Once every two weeks"
replace FM_Seasonfrequency="4" if FM_Seasonfrequency=="Once per week"
replace FM_Seasonfrequency="5" if FM_Seasonfrequency=="More than once per week"

destring FM_Seasonfrequency, replace 
replace FM_Seasonfrequency = 0 if missing(FM_Seasonfrequency)


*days of FM visit
*It checks the position of a substring (e.g., "Monday") within a longer string (e.g., the variable Days), 
*and it returns the position number where that substring starts.

*strpos(Days, "Monday") > 0 checks if "Monday" exists in the string Days.
*If "Monday" is found (i.e., strpos() returns a value greater than 0), it assigns 1 to the new variable monday.
*If "Monday" is not found (i.e., strpos() returns 0), it assigns 0 to the variable monday.

replace  FM_Days="1" if  FM_Days== "Monday"
replace  FM_Days= "2" if  FM_Days=="Tuesday"
replace  FM_Days= "3" if  FM_Days=="Wednesday"
replace  FM_Days= "4" if  FM_Days=="Thursday"
replace  FM_Days= "5" if  FM_Days=="Friday"
replace  FM_Days= "6" if  FM_Days=="Saturday"
replace  FM_Days= "7" if  FM_Days=="Sunday"

gen Monday=(strpos(FM_Days,"Monday")>0)
gen Tues=(strpos(FM_Days,"Tuesday")>0)
gen Wed=(strpos(FM_Days,"Wednesday")>0)
gen Thur=(strpos(FM_Days,"Thursday")>0)
gen Fri=(strpos(FM_Days,"Friday")>0)
gen Sat=(strpos(FM_Days,"Saturday")>0)
gen Sun=(strpos(FM_Days,"Sunday")>0)


*Do you frequent the closest farmers' market to your home?
replace FM_FreqClosest="0" if FM_FreqClosest=="No"
replace FM_FreqClosest="1" if FM_FreqClosest== "Yes"
replace FM_FreqClosest="2" if FM_FreqClosest== "Maybe"
destring FM_FreqClosest, replace

** Reasons for not visiting the FM

gen Not_Welcomed         = strpos(R_Novisit, "Do not feel welcomed") > 0
gen Crime                = strpos(R_Novisit, "Crime") > 0
gen Poor_Quality         = strpos(R_Novisit, "Poor food quality") > 0
gen Inconsistent_Timing  = strpos(R_Novisit, "Inconsistent hours and days of operation") > 0
gen Inconsistent_Quality = strpos(R_Novisit, "Inconsistent quality of overall market") > 0
gen Not_Interested       = strpos(R_Novisit, "Not interested in farmers markets") > 0
gen I_Frequent_Better    = strpos(R_Novisit, "The farmers' market I frequent is better") > 0
gen Other_Reasons        = strpos(R_Novisit, "Other") > 0

foreach reason in Not_Welcomed Crime Poor_Quality Inconsistent_Timing ///
                  Inconsistent_Quality Not_Interested I_Frequent_Better Other_Reasons {
    count if `reason' == 1
}

**True/False Question Regarding FM
foreach var of varlist TOF_Bestproduce-TOF_Tastebetter {
    replace `var' = "1" if `var'== "True"
    replace `var' = "0" if `var'== "False"
}

foreach var of varlist TOF_Bestproduce-Yourself_Likelihood{
	
	destring `var', replace
}

foreach var of varlist AOD_Localtrust-AOD_Urbantrust {
	destring `var', replace
}

*----------------------CONTROLS---------------------------------------------

*Zip code demographics

merge m:1 zip_code using "Zip_controls.dta"

drop if _merge != 3
drop _merge 

*-------------------------------------------------------------------

merge m:1 zip_code using "Pop_Centroid.dta"

drop if _merge!=3
drop _merge 

*-------------------------------------------------------------------

merge m:1 zip_code using "zip_distance.dta"

drop if _merge!=3
drop _merge 


*** FARMERS MARKET ************

	
merge 1:1 Transaction_ID using "FINAL_names_fm.dta"

drop if _merge!=3
drop _merge 
	
********** FARMERS MARKET DETAILS ***********************

	
merge m:1 FM_Closest using "FM_Complete_Details.dta"

drop if _merge ==2

drop _merge


*** Income Quintiles ************	

merge m:1 zip_code using "TN_income.dta"

drop if _merge!=3
drop _merge 


foreach var of varlist income_p20 income_p40 income_p60 income_p80 income_p95  {
    replace `var' = "" if `var' == "NA"
    destring `var', replace
}


********* Distance to City *********

merge m:1 zip_code using "City_Distance.dta"

drop if _merge!=3
drop _merge 


******** City level Characteristics ********

merge m:1 nearest_city using "City_Controls_TN.dta"

drop if _merge!=3
drop _merge 
	
	
********************************************************************************

**Farmers market 

replace FM_Attendance = 0 if FM_Attend == "Not Farmers Market"

replace FM_Attendance = 0 if missing(FM_Attend)

replace FM_Attendance = 0 if FM_Attend == "Unsure"


**zipcode**

gen urban_zip = .              
replace urban_zip = 1 if urban == "TRUE"
replace urban_zip = 0 if urban == "FALSE"




**  you dont know  if your fm accepts snap***

gen SNAP_Binary = SNAP_Enrolled
replace SNAP_Binary = . if SNAP_Enrolled == 2
	

	

* Create necessary dummy variables

gen Male = (Gender == 1) if !missing(Gender)
gen Snap_yes = (SNAP_Enrolled == 1) if !missing(SNAP_Enrolled)

gen edu_bachup= (Education >= 5)


	
*MONTHLY FOOD EXPENDITURE CALCULATION

* calculate the monthly grocery expenditure = monthly spending at grocery * number of grocery visits

gen Grocery_PerMonth=1 if GS_Frequency==2
replace Grocery_PerMonth=0.5 if GS_Frequency==1 
replace Grocery_PerMonth=2 if GS_Frequency==3
replace Grocery_PerMonth=4 if GS_Frequency==4
replace Grocery_PerMonth=8 if GS_Frequency==5

replace Grocery_PerMonth = 0 if missing(Grocery_PerMonth)

gen Monthly_GSExpenditure =GS_Spending*Grocery_PerMonth


* calculate the monthly expenditure at farmers market = monthly spending at FM * number of FM visits 

gen FM_PerMonth=0.5 if FM_Seasonfrequency==1
replace FM_PerMonth=1 if FM_Seasonfrequency==2
replace FM_PerMonth=2 if FM_Seasonfrequency==3
replace FM_PerMonth=4 if FM_Seasonfrequency==4
replace FM_PerMonth=8 if FM_Seasonfrequency==5


replace FM_PerMonth = 0 if missing(FM_Seasonfrequency)

gen Monthly_FMExpenditure =FM_Spending*FM_PerMonth

 * if they are not aware, they are not spending at farmers market 
 
replace Monthly_FMExpenditure=0 if FM_Attendance==0

summ FM_Spending if FM_Attendance == 1, meanonly
replace Monthly_FMExpenditure = r(mean) if FM_Attendance == 1 & missing(FM_Spending)

 ** Total expenditure 
 
gen Total_Expenditure =Monthly_FMExpenditure+ Monthly_GSExpenditure
																																					
*Find the lower bound for the individual:

gen LB_Income=1 if Annual_HHincome=="Under $10,000"
replace LB_Income=10000 if Annual_HHincome=="$10,000 - $24,999"

replace LB_Income=25000 if Annual_HHincome=="$25,000 - $49,000"

replace LB_Income=50000 if Annual_HHincome=="$50,000 - $74,999"
replace LB_Income=75000 if Annual_HHincome=="$75,000 - $99,000"
replace LB_Income=100000 if Annual_HHincome=="$100,000 - $149,999"
replace LB_Income=150000 if Annual_HHincome=="$150,000 or over"

*Find the upper  for the individual:
gen UB_Income=10000 if Annual_HHincome=="Under $10,000"
replace UB_Income=24999 if Annual_HHincome=="$10,000 - $24,999"
replace UB_Income=49000 if Annual_HHincome=="$25,000 - $49,000"
replace UB_Income=74999 if Annual_HHincome=="$50,000 - $74,999"
replace UB_Income=99000 if Annual_HHincome=="$75,000 - $99,000"
replace UB_Income=149999 if Annual_HHincome=="$100,000 - $149,999"
replace UB_Income=500000 if Annual_HHincome=="$150,000 or over"


/*

*Identify whether or not they classify as wealthy.

gen Wealthy=.


replace Wealthy = 1 if A_Income <= income_p40           // poor

replace Wealthy = 2 if A_Income > income_p40 &    A_Income < income_p60        // poor

replace Wealthy = 3 if A_Income > LB_Income               // wealthy

*/



*  WEALTH CLASSIFICATION												

bysort zip_code: egen Aincome=mean(A_Income)

replace A_Income= Aincome if missing(A_Income)

*Identify whether or not they classify as wealthy.

gen Wealthy=.

replace Wealthy = 1 if  A_Income < median_hh_income        // poor

replace Wealthy = 2 if A_Income == median_hh_income  // mid income

replace Wealthy = 3 if A_Income > median_hh_income           // wealthy

*===============================================================


gen M_Income= A_Income/12				


** SNAP_Income

gen SNAP_Income = .

replace SNAP_Income = 1696 if HHsize == 1

replace SNAP_Income = 1696 + 596*(HHsize - 1) if HHsize >= 2

gen SNAP_Eligible = .


* Clearly eligible: upper bound of income < threshold

replace SNAP_Eligible = 1 if M_Income < SNAP_Income

* Clearly NOT eligible: lower bound of income >= threshold
replace SNAP_Eligible = 0 if M_Income > SNAP_Income


* Ambiguous:

replace SNAP_Eligible = . if M_Income == SNAP_Income



**Minorities


gen Minority_White=(White==1 & pct_white<50) //White individuals living in majority non-white areas

gen Minority_NonWhite=(White==0 & pct_white>50) // Non-white individuals living in majority white areas

gen Minority=(Minority_White==1 | Minority_NonWhite==1) //Anyone who is a racial minority in their area

gen Non_White=(White==0)


/*
*===============================================================================

 BARRIER CATEGORIES

* --------- Economic Demand Barriers--------------------------------------


Price Barriers: AOD_Shopifdiscount FM_Overpriced TOF_Cheaper
 
Time Barriers:  FM_Restrictivetiming FM_Notime  AOD_Usualtimeclosed

Travel Barriers: AOD_Shopiffreetransp No_Car  RelTravel_Scaled 


* --------- Economic Supply Barriers ------------------------------------


Quality Barriers: TOF_Bestproduce TOF_Freshclean TOF_Grownbetter  TOF_Longlasting TOF_Tastebetter

Inconvenience  Barriers: FM_Unavailability  FM_NotasGS

*/


 
*  Price Barriers

replace TOF_Cheaper = (1 - TOF_Cheaper)


* Travel Barriers

gen No_Car=(Car_Ownership==0)

// relative travel time measure



replace GS_Traveltime = . if GS_Traveltime == 0 

gen RelTravel= FM_Traveltime/GS_Traveltime


summarize RelTravel, meanonly
local min_rel = r(min)
local max_rel = r(max)

gen RelTravel_Scaled = (RelTravel - `min_rel') / (`max_rel' - `min_rel') //Transforms any range to 0-1 scale
replace RelTravel_Scaled = RelTravel_Scaled * 100




* Quality Barriers  

foreach var in TOF_Bestproduce TOF_Freshclean TOF_Grownbetter TOF_Longlasting TOF_Tastebetter {
    replace `var' = 1 - `var'
}

 
*===============================================================
 
swindex AOD_Shopifdiscount FM_Overpriced TOF_Cheaper FM_Restrictivetiming FM_Notime  AOD_Usualtimeclosed AOD_Shopiffreetransp No_Car  RelTravel_Scaled , generate(Econ_DemandB) displayw
matrix list r(wt)



swindex  TOF_Bestproduce TOF_Freshclean TOF_Grownbetter  TOF_Longlasting TOF_Tastebetter FM_Unavailability  FM_NotasGS, generate(Econ_SupplyB) displayw
matrix list r(wt)


 /*
*===============================================================================

 BARRIER CATEGORIES

* --------- Cultural Demand Barriers--------------------------------------

Community Barriers: FM_NotappealingComm FM_Forrich HighIncomeHH_Likelihood LowIncomeHH_Likelihood
 

* --------- Cultural Supply Barriers ------------------------------------

Trust Barriers: FM_Uncleanproduce AOD_Shopifsafeguarantee AOD_Untestedsafety AOD_Localtrust AOD_Urbantrust

*/


* Community Barrier

 
gen FM_Forrich_flip = FM_Forrich

replace FM_Forrich_flip = 100 - FM_Forrich if Wealthy == 3 
 
 
gen HighIncomeHH_flip = HighIncomeHH_Likelihood 

replace HighIncomeHH_flip = 100 - HighIncomeHH_Likelihood if Wealthy==3
 
gen LowIncomeHH_flip = LowIncomeHH_Likelihood 

replace LowIncomeHH_flip = 100 - LowIncomeHH_Likelihood if Wealthy==1

* Trust Barriers

replace AOD_Localtrust=100-AOD_Localtrust
replace AOD_Urbantrust=100-AOD_Urbantrust


*===============================================================

swindex  FM_NotappealingComm  FM_Forrich_flip HighIncomeHH_flip LowIncomeHH_flip, generate(Cultural_DemandB) displayw

swindex  FM_Uncleanproduce AOD_Shopifsafeguarantee AOD_Untestedsafety AOD_Localtrust AOD_Urbantrust, generate(Cultural_SupplyB) displayw

* Barriers* Non_White
 gen Econ_DemandB_NW = Econ_DemandB*Non_White
 gen Econ_SupplyB_NW= Econ_SupplyB*Non_White
 
 gen Cultural_DemandB_NW= Cultural_DemandB*Non_White
 gen Cultural_SupplyB_NW= Cultural_SupplyB*Non_White
  

**CONTROLS **************

global Survey_Demographics  Education Marital_Status Spouse_Education Age A_Income SNAP_Binary HHsize Total_Expenditure

global G_Shopper GConv_Home GConv_Work GArea_Cleanliness GQuality GPrice GOnestopshop


global ZipCode urban_zip median_hh_income pop_density pct_white population

global Distance  dist_nearest_miles  dist_nearest_snap_miles fm_count_5mile

global City city_median_income  city_pct_nonwhite city_pct_white city_pop_density city_population city_poverty_rate

global  Cdistance  dist_nearest_city_miles 

*===============================================================
encode nearest_city, gen(city_id)


**# *******************************************************************************	


global Treat  Econ_DemandB Econ_DemandB_NW Econ_SupplyB Econ_SupplyB_NW Cultural_DemandB Cultural_DemandB_NW Cultural_SupplyB Cultural_SupplyB_NW 


*===============================================================
* FULL SAMPLE
*===============================================================

reg FM_Attendance $Treat $G_Shopper $Survey_Demographics $ZipCode $Distance $Cdistance Non_White i.city_id, robust	

estimates store Full


esttab Full using "City_FE_Table1_FullSample.rtf", replace rtf ///
b(3) se(3) ///
star(* 0.10 ** 0.05 *** 0.01) ///
keep(Econ_DemandB Econ_DemandB_NW Econ_SupplyB Econ_SupplyB_NW ///
     Cultural_DemandB Cultural_DemandB_NW Cultural_SupplyB Cultural_SupplyB_NW ///
     "*.city_id") ///
order(Econ_DemandB Econ_DemandB_NW Econ_SupplyB Econ_SupplyB_NW ///
      Cultural_DemandB Cultural_DemandB_NW Cultural_SupplyB Cultural_SupplyB_NW ///
      "*.city_id") ///
	    coeflabels( ///
        Econ_DemandB        "Economic Demand Barrier " ///
        Econ_DemandB_NW     "  Economic Demand × Non-White" ///
        Econ_SupplyB        "Economic Supply Barrier " ///
        Econ_SupplyB_NW     " Economic Supply × Non-White" ///
        Cultural_DemandB    "Cultural Demand Barrier " ///
        Cultural_DemandB_NW " Cultural Demand × Non-White" ///
        Cultural_SupplyB    "Cultural Supply Barrier " ///
        Cultural_SupplyB_NW " Cultural Supply  × Non-White") ///
mtitles("Full Sample") ///
stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc %9.3f)) ///
addnotes("Robust standard errors in parentheses." ///
         "City fixed effects included (Knoxville omitted as base)." ///
         "* p<0.10 ** p<0.05 *** p<0.01") ///
compress nogaps varwidth(30)

		
**************************************************************************


global Treat1  Econ_DemandB Econ_SupplyB Cultural_DemandB  Cultural_SupplyB


*===============================================================
* WHITE SUBSAMPLE
*===============================================================

reg FM_Attendance $Treat1  $G_Shopper $Survey_Demographics $ZipCode $Distance $Cdistance i.city_id if Non_White== 0, robust //  white

estimates store White
	
	
*===============================================================
* NON-WHITE SUBSAMPLE
*===============================================================

reg FM_Attendance $Treat1  $G_Shopper $Survey_Demographics $ZipCode $Distance $Cdistance i.city_id if Non_White== 1, robust //non-white

estimates store NonWhite




esttab White NonWhite using "City_FE_Table2_RaceComparison.rtf", replace rtf ///
b(3) se(3) ///
star(* 0.10 ** 0.05 *** 0.01) ///
keep(Econ_DemandB Econ_SupplyB Cultural_DemandB Cultural_SupplyB "*.city_id") ///
order(Econ_DemandB Econ_SupplyB Cultural_DemandB Cultural_SupplyB "*.city_id") ///
coeflabels( ///
    Econ_DemandB "Economic Demand " ///
    Econ_SupplyB "Economic Supply " ///
    Cultural_DemandB "Cultural Demand " ///
    Cultural_SupplyB "Cultural Supply " ///
    2.city_id "Memphis (vs Knoxville)" ///
    3.city_id "Nashville (vs Knoxville)") ///
mtitles("White" "Non-White") ///
stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc %9.3f)) ///
addnotes("Robust standard errors in parentheses." ///
         "City fixed effects included. Knoxville is the omitted base city." ///
         "* p<0.10 ** p<0.05 *** p<0.01") ///
compress




*-------------------------------------------------------------------


**CONTROLS **************

global Survey_Demographics1  Education Marital_Status Spouse_Education Age A_Income HHsize Total_Expenditure


* SNAP-ELIGIBLE SUBSAMPLE

global Treat1 Econ_DemandB Econ_SupplyB Cultural_DemandB Cultural_SupplyB


reg FM_Attendance $Treat1 $G_Shopper $Survey_Demographics1 $ZipCode $Distance $Cdistance i.city_id if SNAP_Eligible == 1, robust

reg FM_Attendance $Treat1 $G_Shopper $Survey_Demographics1 $ZipCode $Distance $Cdistance i.city_id if SNAP_Eligible == 0, robust

*-------------------------------------------------------------------

reg FM_Attendance $Treat1 $G_Shopper $Survey_Demographics1 $ZipCode $Distance $Cdistance i.city_id if SNAP_Eligible == 1, robust
est store SNAP_Eligible

reg FM_Attendance $Treat1 $G_Shopper $Survey_Demographics1 $ZipCode $Distance $Cdistance i.city_id if SNAP_Eligible == 0, robust
est store SNAP_Ineligible

esttab SNAP_Eligible SNAP_Ineligible ///
    using "City_FE_Table4_SNAPComparison.rtf", replace rtf ///
    b(3) se(3) ///
    star(* 0.10 ** 0.05 *** 0.01) ///
    keep(Econ_DemandB Econ_SupplyB Cultural_DemandB Cultural_SupplyB) ///
    order(Econ_DemandB Econ_SupplyB Cultural_DemandB Cultural_SupplyB) ///
    coeflabels( ///
        Econ_DemandB     "Economic Demand Barrier" ///
        Econ_SupplyB     "Economic Supply Barrier" ///
        Cultural_DemandB "Cultural Demand Barrier" ///
        Cultural_SupplyB "Cultural Supply Barrier") ///
    mtitles("SNAP-Eligible" "SNAP-Ineligible") ///
    stats(N r2, labels("Observations" "R-squared") fmt(%9.0fc %9.3f)) ///
    addnotes("Robust standard errors in parentheses." ///
             "SNAP eligibility based on TN Gross Income Standard (130% FPL, 2026)." ///
             "Ambiguous income bracket cases excluded (set to missing)." ///
             "City fixed effects included. Knoxville is the omitted base city." ///
             "* p<0.10 ** p<0.05 *** p<0.01") ///
    compress



tab FM_Attendance if missing(FM_Attendance)

*===============================================================
* FIND WHERE THE  OBSERVATIONS GO

*===============================================================

* --- Treatment variables ---
foreach var of varlist Econ_DemandB Econ_SupplyB ///
                       Cultural_DemandB Cultural_SupplyB {
    quietly count if missing(`var') 
    display "Missing in `var': " r(N)
}

* --- Grocery shopper preferences ---
foreach var of varlist GConv_Home GConv_Work GArea_Cleanliness ///
                       GQuality GPrice GOnestopshop {
    quietly count if missing(`var')
    display "Missing in `var': " r(N)
}

* --- Survey demographics ---
foreach var of varlist Education Marital_Status Spouse_Education ///
                       Age A_Income SNAP_Binary HHsize Total_Expenditure {
    quietly count if missing(`var') 
    display "Missing in `var': " r(N)
}

* --- Zip code controls ---
foreach var of varlist urban_zip median_hh_income pop_density ///
                       pct_white population {
    quietly count if missing(`var') 
    display "Missing in `var': " r(N)
}

* --- Distance variables ---
foreach var of varlist dist_nearest_miles dist_nearest_snap_miles ///
                       fm_count_5mile dist_nearest_city_miles {
    quietly count if missing(`var') 
    display "Missing in `var': " r(N)
}

* --- City ID ---
quietly count if missing(city_id) 
display "Missing in city_id: " r(N)	
	
