<% 'Global Variables
Dim DatabasePath
Dim AdministrationPath
Dim WebSiteName
Dim Slogan
Dim PhysicalPath
Dim BorderColor
dim conn, sql2, rs2, UploadPath, WebLink, LongWeblink, Style, loginpage, showonmenu, acounter, showdesign
DatabasePath = "/DB/AGCMSDB.mdb"
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
"User Id=;Password=;" 
sql2 = "select * from SiteDesign where PeopleId = 667;" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then
WebSiteName = rs2("WebSiteName")
Slogan = rs2("Slogan")
WebLink= rs2("WebLink")
End If 
LongWeblink =  "http://" &  request.servervariables("HTTP_HOST") 
PhysicalPath = request.servervariables("APPL_PHYSICAL_PATH")
UploadPath = request.servervariables("APPL_PHYSICAL_PATH") & "\Uploads\"
Slogan = ""
style = "Style.css"
Slogan = ""					
%>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<!--#Include file="AdminMobileWidthInclude.asp"-->