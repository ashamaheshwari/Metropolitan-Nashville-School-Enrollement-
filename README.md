# Metropolitan-Nashville-School-Enrollement-


##Executive Summary
Choosing a school for your child is extremely important decision. Easy excess to reliable
information makes this process less overwhelming. Therefore. I proposed building a data
visualization via the shiny app to visualize Metro Nashville Public Schools (MNPS) data
for year 2020-2022. The datasets used for this analysis scrapped from MNPS data portal. I was curious about trends in enrollment, diversity, attendance, and demographics for different school zones over the years. 

##Motivation

Even a thought of choosing a school for my child overwhelms me. There are so many
things to consider and making a right choice comes with lot of challenges and risks.
Even though child is automatically assigned to the school within the zone of your living
address, there are other consideration to make an informed decision.
The MNPS website has a useful interactive tool that enables users to look at the
enrollment, demographics, and other limited number of metrics for MNPS schools for
different school years. This website also allows users to download a much larger dataset
that contains number of other variables that can be explored further for deriving useful
information. Even though it’s a great and informative tool, the visualization used are not
appealing and shows large amount of information making it difficult to follow. My aim is
to develop a user-friendly shiny dashboard that can help parents, families, educators,
and communities to visually explore a MNPS datasets to understand different trends.
The app will include an interactive dashboard, with detailed and easy-to-understand
information about enrollment, demographics, diversity, attendance, disabilities,
economics, and students’ behavioral issues of different MNPS schools.


Data Question
https://www.newschannel5.com/news/mnps-enrollment-drop-attributed-to-
nashvilles-growth
https://tennesseeconservativenews.com/metro-nashville-public-schools-see-declining-
enrollment-and-declining-funds/
https://www.msn.com/en-us/news/us/inside-mnps-enrollment-challenges/ar-
AAYY7Fu
 Are there any changes in enrollment rate for different school zones over the
years?
 Which school zones have highest enrollment rates?
 Any correlation between population of school zones and enrollment rates?
 What are the different ethnicity groups enrolled in schools?

 Does population diversity of school zones contribute to MNPS students’
diversity?
 What is the enrollment to attendance ratio for MNPS schools?
 What proportion of students are economically disadvantage and have physical
disabilities?
 What are different types of behavioral issues among students?

Minimum Viable Product (MVP)
 Maps of school zones and MNPS schools in those zones
For each school zones
 Total enrollment for different grades for year 2020-2022 with selector for each
school zone (year, school, grade, gender, ethnicity)
 Interactive visualization for enrolment, demographics, and diversity
 Visualization for proportion of economically and physically challenged students
in each school zone.
Schedule (through 1/21/2023)
1. Get the Data (1/3/2023)
2. Clean &amp; Explore the Data (1/5/2023)
3. Create Presentation and Shiny App (1/14/2013)
4. Internal Demos (1/17/2023)
5. Midcourse Project Presentations (1/23/2023)
Data Sources
 MNPS open data: https://www.mnps.org/about/communications/opendata
 MNPS Map shapefiles: https://www.mnps.org/learn/register-for-school/maps
 Census data filtered for population, diversity, and demographics
Known Issues and Challenges
 Datasets retrieved from the MNPS portal does not contain latitude and longitude
information for different schools. Need to find an alternative source for this
information for generation of maps
 Multiple files for different years, challenge to merge all those files
 Need to find a way to filter required information from census data based on
school zones.
