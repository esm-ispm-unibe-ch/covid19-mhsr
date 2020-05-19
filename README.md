###Living systematic review on the effects of the COVID-19 pandemic on the general populations' mental health, alcohol/substance abuse and violence

[The protocol](https://www.crd.york.ac.uk/prospero/display_record.php?RecordID=180049)

###Setting up REDCap
All data including studies and users are stored in [IPSM's](https://redcap.ispm.unibe.ch/) REDCap server.
The screening and data extraction will be done through croudsourcing and thus we
decided on using the survey functionality of REDCap where each record is
assigned to a reviewer indicated in the database. 

Since we follow a three stage
review process we had to multiply each instrument for screening and extraction
three times. As the complexity increased the dictionnary functionality of REDCap
was not sufficiently efficient and we moved on using the programming language
**Dhall** to describe our schema which made changes through the protoptyping
phase much faster.
The dhall-REDCap api we build can be found 
<a href="dhall-instruments" target="_blank"> here </a>

####Surveys
<a href="https://redcap.ispm.unibe.ch/surveys/?s=jzaY6WCR7A" target="_blank">screening demo link</a>

<a href="https://redcap.ispm.unibe.ch/surveys/?s=Y8P2d9QFHI" target="_blank">data extraction demod link</a>

###Search strategy 
We are using studies from ISPM's 
[Living Evidence on COVID-19](https://ispmbern.github.io/covid-19/living-review/collectingdata.html)
systematic review.
We then filter using the keys:

The search is available [here]("./search-strategy/screening.R") and the list of current studies can be
found [here]("./search-strategy/studies.csv")

The search updates our REDCap database 
