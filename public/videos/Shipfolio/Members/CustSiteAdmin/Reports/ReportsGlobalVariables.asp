<% 'Global Variables
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor


BorderColor = "#ebebeb"

BackgroundColor = "white"

DatabasePath = "../../../DB/AlpacaDB.mdb"
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 

 sql2 = "select * from SiteDesign where custid = 66;" 
			'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

WebSiteName = rs2("custCompany")
PhysicalPath = rs2("PhysicalPath")
UploadPath = rs2("UploadPath")
Slogan = rs2("Slogan")
WebLink= rs2("URL")
LongWeblink =  rs2("URL")
Logo =  rs2("Logo")

End If 
custid = "66"
ReportHighlightColor = "#dedede"
'**************************************************************
 ' Define Conn Object
'**************************************************************
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")


'**************************************************************
 ' Open RecordSet For Page Info
'**************************************************************
sql = "select * from Users where custID = 11;"
'response.write(sql)
rs.Open sql, conn, 3, 3
If Not rs.eof then
	WebSiteName = rs("custCompany")
	CustName = rs("custFirstname")
    City = rs("custCity")
    State = rs("custState")
	Phone = rs("custPhone")			
    Fax = rs("custFax")
    Email = rs("custEmail")
	Zip= rs("custZip")
	Street= rs("custAddr1")
	Street2= rs("custAddr2")
	Cell= rs("custphone2")
End If
rs.close

%>

