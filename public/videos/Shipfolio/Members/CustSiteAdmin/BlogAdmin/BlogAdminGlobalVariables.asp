<% 'Global Variables
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor

DatabasePath = "/DB/AGCMSDB.mdb"
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
						
sql2 = "select * from SiteDesign where Peopleid = 695;" 

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then


WebSiteName = rs2("WebSiteName")
PhysicalPath = request.servervariables("APPL_PHYSICAL_PATH")
UploadPath = request.servervariables("APPL_PHYSICAL_PATH") & "Uploads\"

Slogan = rs2("Slogan")
WebLink= rs2("WebLink")
LongWeblink =  "http://" &  request.servervariables("HTTP_HOST") 

End If 


sql = "select * from People where Peopleid=695" 
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	BusinessID = rs("BusinessID")

rs.close

 sql = "select * from Business where BusinessID=" & BusinessID
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	BusinessName = rs("BusinessName")

rs.close


Slogan = ""
style = "Style.css"
Slogan = ""
%>
<!--#Include virtual="/administration/AdminMobileWidthInclude.asp"--> 
