// fxMoveColumnToEnd
let func = 
    (TableName as table, ColumnsToMove as list) as table =>
    let
        // get the list of column names from the initial table i.e. the name of the previous step
        ColumnNames = Table.ColumnNames(TableName),
        // Remove the column names in the ColumnsToMove list from the list of column names from the previous step
        RightHandColumns = List.RemoveItems(ColumnNames, ColumnsToMove),
        // Recobine the column names by adding the column names from the ColumnsToMove list to the start and the remaining column names
        NewColumnOrder = List.Combine({RightHandColumns, ColumnsToMove}),
        // Reorder columns using the list created in the previous step
        ReorderColumns = Table.ReorderColumns(TableName, NewColumnOrder)
    in
        ReorderColumns,

        documentation = [
            Documentation.Name = "fxMoveColumnToEnd",
            Documentation.Description = "Using the standard Power Query Table.ReorderColumns function, all column names in the table are required to be included in the required order in the form of a list. This function allows for either one or multiple columns to be moved to the right hand side of the table. ",
            Documentation.Category = "Column Function",
            Documentation.Version = "1.0",
            Documentation.Author = "Cox, Graham",
             Documentation.Examples = {
                [
                    Description = "
`TableName` is the name of the previous step in the query calling the function. 
`ColumnsToMove` must be in the form of a list and contain the name or names of columns in quotes and in the required order once the columns have been moved",
                    Code = "
Example 1 - Move the column named `Date` to the right hand side of the table.
fxMoveColumnToEnd(Source, {""Date""})

Example 2 - Move the columns named `Project` and `Date` to the right hand side of the table
fxMoveColumnToEnd(Source, {""Project"", ""Date""})
",
Result = ""
                ]
            }]
in
    Value.ReplaceType(func, Value.ReplaceMetadata(Value.Type(func), documentation))
