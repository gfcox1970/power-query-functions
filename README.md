# Custom Power Query Functions

Moving a column or multiple columns to the beginning of a table in Power Query can create a lot of extra M code if the table contains a large amount of columns. This custom function reduces that possibility and keeps the M code to a minimum.

## fxMoveColumnToStart

### [fxMoveColumnToStart](fxMoveColumnToStart.pq)

### Parameters

`Source` - The name of the previous Power Query step that contains the required columns to move
`ColumnsToMove` - The names of the columns to be moved. Column names must be in the form of a list i.e. within curly brackets

**Example 1**

Move the column named `Date` to the left hand side of the table.

```mcode
fxMoveColumnToStart(Source, {""Date""})
```

**Example 2**

Move the columns named `Project` and `Date` to the left hand side of the table

```mcode
fxMoveColumnToStart(Source, {""Project"", ""Date""})
```

----

## fxMoveColumnToEnd

### [fxMOveColumnToEnd](fxMoveColumnToEnd.pq)

### Parameters

`Source` - The name of the previous Power Query step that contains the required columns to move
`ColumnsToMove` - The names of the columns to be moved. Column names must be in the form of a list i.e. within curly brackets

**Example 1**

Move the column named `Date` to the right hand side of the table.

```mcode
fxMoveColumnToStart(Source, {""Date""})
```

**Example 2**

Move the columns named `Project` and `Date` to the right hand side of the table

```mcode
fxMoveColumnToStart(Source, {""Project"", ""Date""})
```







