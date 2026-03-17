<% 
databasename = "LivestockOfTheWorldDB (LOTWDB)"

Set conn = Server.CreateObject("ADODB.Connection") 

Set rs = Server.CreateObject("ADODB.Recordset")

'Conn.close
'set Conn = nothing

'On Error Resume Next

Set Conn  = Server.CreateObject("ADODB.Connection")

Conn.ConnectionString = "Driver={SQL Server};" _ 
        & " Server=centralusdbserver.database.windows.net,1433;" _
       & " Database=OatmealAILive;" _
       & " UID=Frosty;" _ 
       & " PWD=Snowman31415926!;" _
       & " Encrypt=yes;" _
       & " TrustServerCertificate=False;"
  
       
Conn.Open  
Set rs = Server.CreateObject("ADODB.Recordset")
%>

