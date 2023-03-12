Option Explicit

Dim OXL
Set OXL = CreateObject("Excel.Application") 

OXL.Application.Visible = True
OXL.Workbooks.add
OXL.Application.DisplayAlerts = False
OXL.VBE.ActiveVBProject.VBComponents.Import "C:\Users\Public\leitorCSV.bas"
OXL.Activeworkbook.SaveAs "C:\Users\Public\resultadoAmazon.xlsm", 52
OXL.Application.Run "'C:\Users\Public\resultadoAmazon.xlsm'!Importar_CSV"
OXL.Activeworkbook.SaveAs "C:\Users\Public\resultadoAmazon.xlsm", 52
