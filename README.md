### Living systematic review on the effects of the COVID-19 pandemic on the general populations' mental health, alcohol/substance abuse and violence

<a href="https://www.crd.york.ac.uk/prospero/display_record.php?RecordID=180049" target="_blank">The protocol</a>

### Setting up REDCap
All data including studies and users are stored in [IPSM](https://redcap.ispm.unibe.ch/).
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

#### Surveys
<a href="https://redcap.ispm.unibe.ch/surveys/?s=jzaY6WCR7A" target="_blank">screening demo link</a>

<a href="https://redcap.ispm.unibe.ch/surveys/?s=Y8P2d9QFHI" target="_blank">data extraction demo link</a>

### Search strategy 
We are using published studies from ISPM's 
[Living Evidence on COVID-19](https://ispmbern.github.io/covid-19/living-review/collectingdata.html)
systematic review.

Detailed description can be found
<a href="https://esm-ispm-unibe-ch.github.io/covid19-mhsr/search-strategy" download>here</a> 

Current list of papers to be extracted is in search strategy folder
<a href="https://esm-ispm-unibe-ch.github.io/covid19-mhsr/search-strategy/20200520_174601_newrefs.csv"> here </a>
.

### Data Extraction

You can find data extraction instructions 
<a href="https://esm-ispm-unibe-ch.github.io/covid19-mhsr/search-strategy/Explanations_for_Data_extraction.docx"> here </a>

List of collaborators <a href="https://esm-ispm-unibe-ch.github.io/covid19-mhsr/search-strategy/Reviewers_for_COVID_and_MH.pdf"> here </a>

