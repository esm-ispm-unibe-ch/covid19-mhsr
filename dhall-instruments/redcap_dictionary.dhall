let Prelude = https://prelude.dhall-lang.org/v16.0.0/package.dhall

let List/map = https://prelude.dhall-lang.org/v16.0.0/List/map

let RCFieldType = < text | notes | radio | dropdown | checkbox | calc | file >

let FieldType =
      < text
      | notes
      | radio : List Text
      | dropdown : List Text
      | checkbox : List Text
      | calc : Text
      | file
      | YesNo
      >

let fieldTypeToRC
    : FieldType → { ftype : RCFieldType, multiples : Optional Text }
    =   λ(ft : FieldType)
      → let listToText =
                λ(lt : List Text)
              → let ilt = List/indexed Text lt

                let args =
                      List/map
                        { index : Natural, value : Text }
                        Text
                        (   λ(iv : { index : Natural, value : Text })
                          → Natural/show iv.index ++ " , " ++ iv.value
                        )
                        ilt

                in  Prelude.Text.concatSep " | " args

        in  merge
              { text = { ftype = RCFieldType.text, multiples = None Text }
              , notes = { ftype = RCFieldType.notes, multiples = None Text }
              , radio =
                    λ(ch : List Text)
                  → { ftype = RCFieldType.radio
                    , multiples = Some (listToText ch)
                    }
              , dropdown =
                    λ(ch : List Text)
                  → { ftype = RCFieldType.dropdown
                    , multiples = Some (listToText ch)
                    }
              , checkbox =
                    λ(ch : List Text)
                  → { ftype = RCFieldType.checkbox
                    , multiples = Some (listToText ch)
                    }
              , YesNo =
                { ftype = RCFieldType.radio, multiples = Some "1, Yes | 2, No" }
              , calc =
                  λ(f : Text) → { ftype = RCFieldType.calc, multiples = Some f }
              , file = { ftype = RCFieldType.file, multiples = None Text }
              }
              ft

let IDType = < y >

let Validation = < number | date_ymd | email >

let FieldRecordType =
      < Text : Text
      | OptText : Optional Text
      | OptInteger : Optional Integer
      | OptIDType : Optional IDType
      | FieldType : RCFieldType
      | OptValidation : Optional Validation
      >

let Field =
      { variable : Text
      , instrument : Text
      , ftype : FieldType
      , sectionHeader : Optional Text
      , flabel : Optional Text
      , note : Optional Text
      , validation : Optional Validation
      , minv : Optional Integer
      , maxv : Optional Integer
      , isID : Optional IDType
      , branching : Optional Text
      , required : Optional IDType
      , alignment : Optional Text
      , surveyNumber : Optional Text
      , matrixGroupName : Optional Text
      , matrixRanking : Optional Text
      , annotation : Optional Text
      }

let RCField =
      { variable : { value : FieldRecordType }
      , instrument : { value : FieldRecordType }
      , ftype : { value : FieldRecordType }
      , sectionHeader : { value : FieldRecordType }
      , flabel : { value : FieldRecordType }
      , multiples : { value : FieldRecordType }
      , note : { value : FieldRecordType }
      , validation : { value : FieldRecordType }
      , minv : { value : FieldRecordType }
      , maxv : { value : FieldRecordType }
      , isID : { value : FieldRecordType }
      , branching : { value : FieldRecordType }
      , required : { value : FieldRecordType }
      , alignment : { value : FieldRecordType }
      , surveyNumber : { value : FieldRecordType }
      , matrixGroupName : { value : FieldRecordType }
      , matrixRanking : { value : FieldRecordType }
      , annotation : { value : FieldRecordType }
      }

let defaultField =
      { variable = "undefined"
      , instrument = "undefined"
      , ftype = FieldType.text
      , flabel = None Text
      , sectionHeader = None Text
      , note = None Text
      , validation = None Validation
      , minv = None Integer
      , maxv = None Integer
      , isID = None IDType
      , required = Some IDType.y
      , branching = None Text
      , surveyNumber = None Text
      , matrixGroupName = None Text
      , matrixRanking = None Text
      , annotation = None Text
      , alignment = None Text
      }

let redcapOriginalFieldNames =
      { variable.name = "Variable / Field Name"
      , instrument.name = "Form Name"
      , ftype.name = "Field Type"
      , sectionHeader.name = "Section Header"
      , flabel.name = "Field Label"
      , multiples.name = "Choices Calculations OR Slider Labels"
      , note.name = "Field Note"
      , validation.name = "Text Validation Type OR Show Slider Number"
      , minv.name = "Text Validation Min"
      , maxv.name = "Text Validation Max"
      , isID.name = "Identifier?"
      , branching.name = "Branching Logic (Show field only if...)"
      , required.name = "Required Field?"
      , alignment.name = "Custom Alignment"
      , surveyNumber.name = "Question Number (surveys only)"
      , matrixGroupName.name = "Matrix Group Name"
      , matrixRanking.name = "Matrix Ranking?"
      , annotation.name = "Field Annotation"
      }

let fieldNames =
      { variable.name = "A"
      , instrument.name = "B"
      , sectionHeader.name = "C"
      , ftype.name = "D"
      , flabel.name = "E"
      , multiples.name = "F"
      , note.name = "G"
      , validation.name = "H"
      , minv.name = "I"
      , maxv.name = "J"
      , isID.name = "K"
      , branching.name = "L"
      , required.name = "M"
      , alignment.name = "N"
      , surveyNumber.name = "O"
      , matrixGroupName.name = "P"
      , matrixRanking.name = "Q"
      , annotation.name = "R"
      }

let FT = { mapKey : Text, mapValue : { name : Text, value : FieldRecordType } }

let RCFT = { mapKey : Text, mapValue : FieldRecordType }

let makeRedCapField =
        λ(field : Field)
      → let ftm = fieldTypeToRC field.ftype

        in  { variable.value = FieldRecordType.Text field.variable
            , instrument.value = FieldRecordType.Text field.instrument
            , ftype.value = FieldRecordType.FieldType ftm.ftype
            , flabel.value = FieldRecordType.OptText field.flabel
            , sectionHeader.value = FieldRecordType.OptText field.sectionHeader
            , multiples.value = FieldRecordType.OptText ftm.multiples
            , note.value = FieldRecordType.OptText field.note
            , validation.value = FieldRecordType.OptValidation field.validation
            , minv.value = FieldRecordType.OptInteger field.minv
            , maxv.value = FieldRecordType.OptInteger field.maxv
            , isID.value = FieldRecordType.OptIDType field.isID
            , required.value = FieldRecordType.OptIDType field.required
            , branching.value = FieldRecordType.OptText field.branching
            , surveyNumber.value = FieldRecordType.OptText field.surveyNumber
            , matrixGroupName.value =
                FieldRecordType.OptText field.matrixGroupName
            , matrixRanking.value = FieldRecordType.OptText field.matrixRanking
            , annotation.value = FieldRecordType.OptText field.annotation
            , alignment.value = FieldRecordType.OptText field.alignment
            }

let makeRedCapMap =
        λ(field : Field)
      → let fieldValues = makeRedCapField field

        let rcfield = fieldValues ∧ fieldNames

        let mf = toMap rcfield

        let rcfieldmap =
              List/map
                FT
                RCFT
                (   λ(f : FT)
                  → { mapKey = f.mapValue.name, mapValue = f.mapValue.value }
                )
                mf

        in  rcfieldmap

in  { Field
    , RCField
    , RCFieldType
    , defaultField
    , fieldNames
    , FieldRecordType
    , FieldType
    , FT
    , RCFT
    , makeRedCapMap
    , makeRedCapField
    }
