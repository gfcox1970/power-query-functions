# Custom Power Query Functions

### fxMoveColumnToStart

Moving a column or multiple columns to the beginning of a table in Power Query can create a lot of extra M code if the table contains a large amount of columns. This custom function reduces that possibility and keeps the M code to a minimum

```M
// fxMoveColumnToStart
let func = 
    (TableName as table, ColumnsToMove as list) as table =>
    let
        // get the list of column names from the initial table i.e. the name of the previous step
        ColumnNames = Table.ColumnNames(TableName),
        // Remove the column names in the ColumnsToMove list from the list of column names from the previous step
        RightHandColumns = List.RemoveItems(ColumnNames, ColumnsToMove),
        // Recobine the column names by adding the column names from the ColumnsToMove list to the start and the remaining column names
        NewColumnOrder = List.Combine({ColumnsToMove, RightHandColumns}),
        // Reorder columns using the list created in the previous step
        ReorderColumns = Table.ReorderColumns(TableName, NewColumnOrder)
    in
        ReorderColumns,

        documentation = [
            Documentation.Name = "fxMoveColumnToStart",
            Documentation.Description = "Using the standard Power Query Table.ReorderColumns function, all column names in the table are required to be included in the required order in the form of a list. This function allows for either one or multiple columns to be moved to the left hand side of the table. ",
            Documentation.Category = "Column Function",
            Documentation.Version = "1.0",
            Documentation.Author = "Cox, Graham",
            Documentation.Examples = {
                [
                    Description = "<br>The `TableName` parameter is the name of the previous step in the query calling the function. <br><br>The `ColumnsToMove` parameter must be in the form of a list and contain the name or names of columns in quotes and in the required order once the columns have been moved",
                    Code = " 
EXAMPLE 1
let
    Source = #table(
        type table[Index = number, Name = text, Date = date, Amount = number],
            { 
                {1, ""Apple"", #date(2022, 11, 17), 123.45}, 
                {2, ""Orange"", #date(2022, 10, 17), 456.21} 
            } 
        ),
    MoveColumn = fxMoveColumnToStart(Source, {""Date""})
in
    MoveColumn
    
EXAMPLE 2
let
    Source = #table(
        type table[Index = number, Name = text, Date = date, Amount = number],
            { 
                {1, ""Apple"", #date(2022, 11, 17), 123.45}, 
                {2, ""Orange"", #date(2022, 10, 17), 456.21} 
            } 
        ),
    MoveColumn = fxMoveColumnToStart(Source, {""Amount"", ""Date""})
in
    MoveColumn",
        Result = " 
EXAMPLE 1 RESULT
#table(
    type table[Date = date, Index = number, Name = text, Amount = number],
    { 
        {#date(2022, 11, 17), 1, ""Apple"", 123.45}, 
        {#date(2022, 10, 17), 2, ""Orange"", 456.21} 
    }
)

EXAMPLE 2 RESULT
#table(
    type table[Amount = number, Date = date, Index = number, Name = text],
    { 
        {123.45, #date(2022, 11, 17), 1, ""Apple""}, 
        {456.21, #date(2022, 10, 17), 2, ""Orange""} 
    }
)"
        ] } ]
in
    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))

```
