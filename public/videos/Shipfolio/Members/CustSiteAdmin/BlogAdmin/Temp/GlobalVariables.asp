<% 
'**************************************************************
' Global Variables
'**************************************************************
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor
Dim BackgroundColor
Dim style

'**************************************************************
' Hard Coded Variables
'**************************************************************
BorderColor = "#ebebeb"
BackgroundColor = "white"

WebLink= "www.Andresenacres.com"
LongWeblink = "http://www.Andresenacres.com"
DatabasePath = "../../DB/Andresenacres.mdb"
AdministrationPath = "/Administration"
WebSiteName = "Andresen Acres Alpacas"
PhysicalPath = "E:\\Inetpub\\wwwroot\\internet-host\\alpacas2\\Andresenacres.com\\www"
UploadPath = "E:\\Inetpub\\wwwroot\\internet-host\\alpacas2\\Andresenacres.com\\www\\Uploads\\"
WebLink= "www.Andresenacres.com"
DSN_Name = "AndresenDSN"

'**************************************************************
' Define Conn Object
'**************************************************************
'conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
'		"Data Source=" & server.mappath(DatabasePath) & ";" & _
'		"User Id=;Password=;" 

Set Conn = Server.CreateObject("ADODB.Connection") 
Conn.Open "DSN=" & DSN_Name & ";UID=alpacas2;PWD=golden"
Set rs = Server.CreateObject("ADODB.Recordset")

%>
