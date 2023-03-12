Attribute VB_Name = "Módulo1"
Sub Importar_CSV()
Attribute Importar_CSV.VB_ProcData.VB_Invoke_Func = " \n14"
' Importar CSV e Ajustar Tabela
    ActiveWorkbook.Queries.Add Name:="data_file", Formula:= _
        "let" & Chr(13) & "" & Chr(10) & "    Fonte = Csv.Document(File.Contents(""C:\Users\Public\data_file.csv""),[Delimiter="","", Columns=2, Encoding=1252, QuoteStyle=QuoteStyle.None])," & Chr(13) & "" & Chr(10) & "    #""Tipo Alterado"" = Table.TransformColumnTypes(Fonte,{{""Column1"", type text}, {""Column2"", Currency.Type}})" & Chr(13) & "" & Chr(10) & "in" & Chr(13) & "" & Chr(10) & "    #""Tipo Alterado"""
    ActiveWorkbook.Worksheets.Add
    With ActiveSheet.ListObjects.Add(SourceType:=0, Source:= _
        "OLEDB;Provider=Microsoft.Mashup.OleDb.1;Data Source=$Workbook$;Location=data_file;Extended Properties=""""" _
        , Destination:=Range("$A$1")).QueryTable
        .CommandType = xlCmdSql
        .CommandText = Array("SELECT * FROM [data_file]")
        .RowNumbers = False
        .FillAdjacentFormulas = False
        .PreserveFormatting = True
        .RefreshOnFileOpen = False
        .BackgroundQuery = True
        .RefreshStyle = xlInsertDeleteCells
        .SavePassword = False
        .SaveData = True
        .AdjustColumnWidth = True
        .RefreshPeriod = 0
        .PreserveColumnInfo = True
        .ListObject.DisplayName = "data_file"
        .Refresh BackgroundQuery:=False
    End With
    Application.CommandBars("Queries and Connections").Visible = False
    Range("data_file[[#Headers],[Column1]]").Select
    ActiveCell.FormulaR1C1 = "Título / Produto (Conforme resultado da consulta)"
    Range("data_file[[#Headers],[Column2]]").Select
    ActiveCell.FormulaR1C1 = "Preço (na moeda da consulta)"
    Range("B2").Select
    Columns("B:B").EntireColumn.AutoFit

' Limpar_linhas_em_branco
    ActiveSheet.ListObjects("data_file").Range.AutoFilter Field:=1, Criteria1:= _
        "="
    Range("A3:B37").Select
    Selection.EntireRow.Delete
    ActiveSheet.ListObjects("data_file").Range.AutoFilter Field:=1
        
'Formatar o preço para padronizar a quantidade de casas decimais
    Columns("B:B").Select
    Selection.Style = "Comma"
    Range("D15").Select

'Ordenar o  preço
    ActiveWorkbook.ActiveSheet.ListObjects("data_file").Sort. _
        SortFields.Clear
    ActiveWorkbook.ActiveSheet.ListObjects("data_file").Sort. _
        SortFields.Add2 Key:=Range("data_file[[#All],[Preço (na moeda da consulta)]]" _
        ), SortOn:=xlSortOnValues, Order:=xlDescending, DataOption:=xlSortNormal
    With ActiveWorkbook.ActiveSheet.ListObjects("data_file").Sort
        .Header = xlYes
        .MatchCase = False
        .Orientation = xlTopToBottom
        .SortMethod = xlPinYin
        .Apply
    End With
'Renomear a planilha
    ActiveSheet.Name = "Resultados iPhone Amazon"
'Finalizar formatação para quebra de linha
    Columns("A:A").Select
    With Selection
        .HorizontalAlignment = xlGeneral
        .VerticalAlignment = xlBottom
        .WrapText = True
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    Cells.Select
    With Selection
        .HorizontalAlignment = xlGeneral
        .VerticalAlignment = xlCenter
        .Orientation = 0
        .AddIndent = False
        .IndentLevel = 0
        .ShrinkToFit = False
        .ReadingOrder = xlContext
        .MergeCells = False
    End With
    Range("A2").Select
'Congelar painéis para facilitar visualização
    Range("B2").Select
    ActiveWindow.FreezePanes = True
End Sub
