# Lucene Notes

## Lucene, could you tell the difference between StringField and TextField?

Sure! As an AI language model, I can explain the difference between StringField and TextField in the context of Apache Lucene, which is an open-source full-text search library written in Java.

> In Lucene, StringField and TextField are two different types of fields that can be used to index and store data.

StringField is used for fields that contain a single value, such as IDs, dates, and keywords. StringField indexes the entire value as a single token without any analysis or tokenization. This means that the field is **not** broken down into smaller parts, and searching for the entire value is required to find a match. StringField is stored as an unanalyzed string, so it's suitable for exact matches.

TextField is used for fields that contain multiple values or long text data, such as descriptions, content, or summaries. TextField indexes the content after analysis and tokenization, meaning that it breaks the field into smaller parts (tokens) to enable more flexible and efficient searching. The content is indexed by default using a built-in analyzer that performs tokenization, lowercasing, and filtering of common stop words. TextField is also stored in a compressed form, which makes it suitable for searching large amounts of text data.

> In summary, the main differences between StringField and TextField in Lucene are:

StringField is used for fields that contain a single value, while TextField is used for fields that contain multiple values or long text data.

StringField indexes the entire value as a single token **without any analysis or tokenization**, while TextField indexes the content after analysis and tokenization to enable more flexible and efficient searching.

StringField is stored as an unanalyzed string, while TextField is stored in a compressed form, making it suitable for searching large amounts of text data.

> My notes: StringField is "as is" during searching, i.e, no need to lower case the search string. But, TextField, the search string need to be lower cased during searching.
