# MS SQL 

## JSON_MODIFY 

### insert into an array in JSON string

To insert a new object into a JSON array in a column in SQL Server, you can use the JSON_MODIFY function in conjunction with string manipulation to add the new object to the array. SQL Server doesn't provide a built-in function to directly append objects to a JSON array, so you need to manually concatenate the new object into the array.

Example JSON in JsonColumn
Assume you have the following JSON in the JsonColumn:

```
{
  "myArray": [
    {"objId": 7, "name": "Item 1"},
    {"objId": 8, "name": "Item 2"},
    {"objId": 9, "name": "Item 3"}
  ]
}
SQL Query to Insert a New Object into the Array
Here's how you can insert a new object into myArray:

sql
Copy code
-- Define the new object to insert
DECLARE @NewObject NVARCHAR(MAX) = '{"objId": 10, "name": "New Item"}';

-- Update the JsonColumn by appending the new object
UPDATE MyTable
SET JsonColumn = JSON_MODIFY(
    JsonColumn,
    '$.myArray',
    JSON_QUERY(
        CASE 
            WHEN JSON_QUERY(JsonColumn, '$.myArray') IS NULL THEN
                '[' + @NewObject + ']'
            ELSE
                JSON_QUERY(JsonColumn, '$.myArray') + ',' + @NewObject
        END
    )
)
WHERE SomeCondition;
```

