<% DSN_NameLOA = "LOADB"
Set ConnLOA  = Server.CreateObject("ADODB.Connection") 
ConnLOA.Open "DSN=" & DSN_NameLOA & ";UID=Chimera;PWD=ALEX314159"
Set rsLOA = Server.CreateObject("ADODB.Recordset") %>