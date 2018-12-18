Attribute VB_Name = "Module1"
Sub TotalVolume()
    'Create a script that will loop through each year of stock data and grab the total amount of volume each stock had over the year.
    For Each ws In Worksheets
    'Nested For Loop to solve this... Make it loop through all work sheets.
        Dim Ticker As String
        Dim TotalStockVol As Double
        Dim SummaryTableRow As Integer
        
            TotalStockVol = 0
            
            SummaryTableRow = 2
            
            ws.Range("I1").Value = "Ticker"
            ws.Range("J1").Value = "Total Stock Volume"
        
        LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
            For i = 2 To LastRow
                'Still same value?
                TotalStockVol = TotalStockVol + (ws.Cells(i, 7).Value)
                    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                        Ticker = ws.Cells(i, 1).Value
        'Store that number as an integer called SummaryTableRow, place total volume in column J. which is cell i, 7
                          ws.Range("I" & SummaryTableRow).Value = Ticker
                        
                      
            'Make sure it restarts the count everytime the value of column A variable changes!
                        ws.Range("J" & SummaryTableRow).Value = TotalStockVol
                        SummaryTableRow = SummaryTableRow + 1
                        TotalStockVol = 0
                    End If
            Next i
            Next ws
            
End Sub
