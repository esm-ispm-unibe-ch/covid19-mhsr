-- Screening Forms
let Prelude = https://prelude.dhall-lang.org/v15.0.0/package.dhall

let List/map = https://prelude.dhall-lang.org/v16.0.0/List/map

let RC = ./redcap_dictionary.dhall

let review_at =
        RC.defaultField
      ⫽ { variable = "review_at"
        , instrument = "screening_at"
        , ftype = RC.FieldType.dropdown [ "No", "Yes" ]
        , flabel = Some "Excluded from the title and abstract"
        , sectionHeader = Some
            ''
                            You are screening reference no [record_id] as reviewer <b>A</b>

            [author_1] ([year]) [title]

            <a target="_blank" href="[url1]">[doi]</a>

            abstract:
             [abstract]

            Instructions:
            Inclusion criteria 

            1 Participants/population
            Included: the general population irrespective of age (i.e. including children, adolescents and elderly)
            Excluded: studies exclusively reporting on health care personnel, SARS-CoV-2 cases (suspected or confirmed) and COVID19 patients. These studies will be excluded from the current review but will be catalogued as such in the course of study selection.
            2 Intervention(s), exposure(s)
            Participants should be affected by the COVID19 epidemic/pandemic, hence the study should have taken place after December 2019.
            3 Outcomes
            We will include only studies that used validated questionnaires or interviews about the symptoms the diagnosis of the conditions of interest. We will exclude prevalence studies that rely on hospital admissions and diagnoses recorded on medical records as access to the hospitals has been avoided during the epidemic/pandemic.
                            ''
        , note = Some
            ''
            those who are not excluded from title and abstract will be
            go to the next phase were the full PDF will be considered
            ''
        , alignment = Some "RH"
        }

let ex_reas_at =
        RC.defaultField
      ⫽ { variable = "ex_reas_at"
        , instrument = "screening_at"
        , flabel = Some "Reason for exclusion"
        , ftype =
            RC.FieldType.checkbox
              [ "Wrong population (exclusively reporting on health care personnel)"
              , "Wrong population (exclusively reporting on people infected with SARS-CoV-2)"
              , "Wrong population (exclusively reporting on patients with COVID-19)"
              , "Wrong exposure (the exposure of interest is the COVID-19 pandemic. Exclude other pandemics, or any intervention study, e.g. health promotion)"
              , "Wrong outcome (the outcome of interest is prevalence/frequencies of mental health/alcohol or substance abuse/violence)"
              , "Other reasons"
              ]
        , branching = Some "[review_at]='2'"
        }

let form = [ review_at, ex_reas_at ]

let rcform = List/map RC.Field (List RC.RCFT) RC.makeRedCapMap form

in  rcform
