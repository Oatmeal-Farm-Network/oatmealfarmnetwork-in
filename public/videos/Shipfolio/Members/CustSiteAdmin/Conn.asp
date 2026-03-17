<%'**************************************************************
 ' Hard Coded Variables
'**************************************************************
DatabasePath = "../DB/AGCMSDB.mdb"
style = "Style.css"


'**************************************************************
 ' Define Conn Object
'**************************************************************
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
	"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
%>