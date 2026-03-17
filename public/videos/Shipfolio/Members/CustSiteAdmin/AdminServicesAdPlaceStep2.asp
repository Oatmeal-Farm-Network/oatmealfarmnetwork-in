<!DOCTYPE HTML>
<HTML>
<HEAD>
 <title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="style.css">					  
</HEAD>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include file="AdminSecurityInclude.asp"--> 
<!--#Include file="AdminGlobalVariables.asp"--> 
<!--#Include file="AdminHeader.asp"--> 
<%	
PeopleID=session("PeopleID" ) 
LinkName=Request.Form("LinkName")
variables = variables & "&LinkName=" & LinkName
ServiceID=trim(request.form("ServiceID")) 
variables = variables & "&ServiceID=" & ServiceID
ServiceTitle=trim(request.form("ServiceTitle")) 
variables = variables & "&ServiceTitle=" & ServiceTitle
ServicePrice =trim(request.form("ServicePrice"))
variables = variables & "&ServicePrice=" & ServicePrice
ServiceAvailable=trim(request.form("ServiceAvailable"))
variables = variables & "&ServiceAvailable=" & ServiceAvailable
ServiceDescription   =trim(request.form("ServiceDescription"))
variables = variables & "&ServiceDescription=" & ServiceDescription
ServiceContactForPrice =trim(request.form("ServiceContactForPrice"))
variables = variables & "&ServiceContactForPrice=" & ServiceContactForPrice 
PagegroupID =trim(request.form("PagegroupID"))
variables = variables & "&PagegroupID=" & PagegroupID 
PageType =trim(request.form("PageType"))
variables = variables & "&PageType=" & PageType
PagelayoutID = request.QueryString("PagelayoutID")

response.Write("PagegroupID=" & PagegroupID)
if len(ServiceContactForPrice) > 0 then

else
ServiceContactForPrice = False
end if


Missing = "?Missing=True"

if len(LinkName) > 1 then
else
    Missing = Missing & "&MissingLinkName=True"
 end if

if len(ServiceTitle) > 1 then
else
    Missing = Missing & "&MissingServiceTitle=True"
 end if
 
 if len(Missing) > 13 then
  'response.Redirect("AdminPageAdd.asp" & Missing & variables)
end if

str1 = ServiceTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceTitle= Replace(str1, "'", "''")
End If

PageName = ServiceTitle
DirectoryName = ServiceTitle
	str1 = DirectoryName
	str2 = " "
	If InStr(str1,str2) > 0 Then
		DirectoryName= Replace(str1,  str2, "")
	End If  
	

str1 = ServicePrice
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServicePrice= Replace(str1, "'", "''")
End If

str1 = ServiceDiscount
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceDiscount= Replace(str1, "'", "''")
End If


str1 = ServiceDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceDescription= Replace(str1, "'", "''")
End If



str1 = ServiceID
str2 = "'"
If InStr(str1,str2) > 0 Then
	ServiceID = Replace(str1, "'", "''")
End If


	str1 = LinkName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		LinkName= Replace(str1,  str2, "''")
	End If  

if len(LinkName) < 1 then
  Message=Message & "<br>Please enter a menu title."
  Proceed="False"
end if 
	
Session("Step2") = false
If 	Session("Step2") = false then
			
	ServiceTitleFound = False
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _  
if len(ServicePrice) < 1 then
 ServicePrice = 0
end if
if len(PagelayoutID) > 0 then
sql2 = "select * from Services where  PagelayoutID = '" & PagelayoutID & "'  order by PagelayoutID Desc"
else
sql2 = "select * from Services where  ServiceTitle = '" & ServiceTitle & "'  order by ServicesID"
end if

response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if  Not rs2.eof then
		ServiceTitleFound = True
		ServicesID = rs2("ServicesID")
		session("ID") = rs2("ServicesID")
		session("ServicesID") = rs2("ServicesID")
		PagelayoutID = rs2("PagelayoutID")
	End if
rs2.close	
	
If ServiceTitleFound = True then
		 response.Redirect("AdminPageAdd.asp?PageAlreadyExists=True"  & variables)
end if

	If ServiceTitleFound = False then
	
sql2 = "select * from Pagelayout "	
	response.write(sql2)
	acounter = 1
	rs2.Open sql2, conn, 3, 3  
if Not rs2.eof then
    LinkOrder = rs2.recordcount - 1
end if
rs2.close
	
	
	
	sql2 = "select * from Services  order by ServiceTitle"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	If Not rs2.eof then

		ServicesID = rs2.recordcount + 1
		session("ID") = ServicesID
		session("ServicesID") = ServicesID
		rs2.close
   End If 

If ServicesID > 0 Then
Else
	ServicesID = 1
		session("ID") = ServicesID
		session("ServicesID") = ServicesID
End If

		sql2 = "select * from Services where ServicesID  = " & ServicesID 

	'	response.write(sql2)
		rs2.Open sql2, conn, 3, 3 
		If Not rs2.eof Then
		    notfound=true
				While notfound=true
						sql2 = "select * from Services where ServicesID  = " & ServicesID 

					'response.write(sql2)
					Set rs2 = Server.CreateObject("ADODB.Recordset")
					rs2.Open sql2, conn, 3, 3 
					If Not rs2.eof Then
						ServicesID = ServicesID+ 1
						notfound=True
					Else
					    notfound=false
					End If
							rs2.close
				wend	
		End If

Query =  "INSERT INTO PageLayout (PageName, PageType, PagegroupID, DirectoryName,  Linkname, ShowPage, LinkOrder, PageTitle, FileName, PageAvailable, EditLink)" 
	Query =  Query & " Values ('" &  ServiceTitle & "', "
		Query =  Query &  " '" & PageType & "' , " 
	Query =  Query &  " " & PagegroupID & " , " 
	Query =  Query &  " '" & DirectoryName & "' , " 
    Query =  Query &  " '" & LinkName & "'," 
    Query =  Query &  " False," 
    Query =  Query &  " " & Linkorder & "," 
    Query =  Query &  " '" &  Heading & "'," 
    Query =  Query &  " 'StandardPage.asp?Pagename=" & PageName & "' ," 
    Query =  Query &  " True, " 
  	Query =  Query &  " 'AdminPageData.asp?pagename=" & PageName & "' )" 

response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
Set DataConnection = Nothing

set Conn = Nothing

%>

<!--#Include file="AdminConn.asp"-->  

<%
Query =  "INSERT INTO PageSEO (PageName)" 
	Query =  Query & " Values ('" &  DirectoryName & "' )" 

response.write(Query)	

Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
Set DataConnection = Nothing

set Conn = Nothing

%>

<!--#Include file="AdminConn.asp"-->  

<% sql2 = "select * from Pagelayout where PageName = '" & PageName & "' order by PageLayoutID Desc"	
	response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3  
if Not rs2.eof then
    PageLayoutID = rs2("PageLayoutID")
end if
rs2.close

set Conn = Nothing%>

<!--#Include file="AdminConn.asp"-->  

<%

Set rs = Server.CreateObject("ADODB.Recordset")
BlockNum = 1
while BlockNum < 9 
Query =  "INSERT INTO PageLayout2 (PageLayoutID, BlockNum)" 
Query =  Query & " Values ('" &  PageLayoutID & "', "
Query =  Query & " " & BlockNum & " )" 
  	response.write(Query)	
Set DataConnection = Server.CreateObject("ADODB.Connection")
	DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
	DataConnection.Execute(Query) 


	DataConnection.Close
	Set DataConnection = Nothing 
BlockNum = BlockNum + 1
wend



sql2 = "select * from services  where  ServiceTitle = '" & ServiceTitle & "';"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
 session("ID") = ServicesID
  session("ServicesID") = ServicesID

	Query =  "INSERT INTO Services (ServicesID, PagelayoutID, ServiceTitle, ServiceContactForPrice,  ServiceAvailable, "
	
if len(ServicePrice) > 0 then
Query = Query & " ServicePrice," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " ServiceDiscount," 
end if
	
Query = Query & "  ServiceDescription)" 
Query =  Query & " Values (" &  ServicesID & "," 
Query =  Query & " " &  PagelayoutID & ","
Query =  Query & " '" &  ServiceTitle & "',"
Query =  Query & " " &  ServiceContactForPrice & ","
	Query =  Query & " " & ServiceAvailable & ","
	
if len(ServicePrice) > 0 then
Query = Query & " "  &  ServicePrice & "," 
end if
if len(ServiceDiscount) > 0 then
Query = Query & " "  &  ServiceDiscount & "," 
end if

Query =  Query & " '" &  ServiceDescription  & "')"
		
response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
Set DataConnection = Nothing
 %>

<!--#Include file="AdminConn.asp"-->  

<%
sql2 = "select * from services  where  ServiceTitle = '" & ServiceTitle & "';"

'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
    if not rs2.eof then
        ProdServiceID = rs2("ServicesID")
    end if
    rs2.close

Query =  "INSERT INTO ProdServiceReferenceTable (PageLayoutID, ProdServiceIDType, ProdServiceID)" 
	Query =  Query & " Values ('" &  PageLayoutID & "', "
	Query =  Query &  " 'Service' , " 
		   Query =  Query &  " '" & ProdServiceID & "'  )" 

response.write(Query)	
Set DataConnection = Server.CreateObject("ADODB.Connection")
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) 	& ";" 
DataConnection.Execute(Query) 
Set DataConnection = Nothing %>

<!--#Include file="AdminConn.asp"-->  

<%
PhysicalPath = request.servervariables("APPL_PHYSICAL_PATH") 
newdirectory = PhysicalPath &  DirectoryName & "\"
response.Write("newdirectory=" & newdirectory )
  set filesys=CreateObject("Scripting.FileSystemObject")
  If  Not filesys.FolderExists(PhysicalPath & "\" & DirectoryName ) Then      
    filesys.CreateFolder (newdirectory)   
 
  
sourcepath = physicalPath & "\TemplateFolderServices\*.asp"
sendpath = PhysicalPath  & DirectoryName & "\"
response.Write("DirectoryName=" & DirectoryName )
dim fs
set fs=Server.CreateObject("Scripting.FileSystemObject")
fs.CopyFile sourcepath, sendpath
set fs=nothing
 End If

Session("Step2") = True
End if
End if

'End if

response.Redirect("AdminServicesEdit2.asp?ServicesID=" & ServicesID & "&PageLayoutID=" &  PageLayoutID)
%>
</Body>
</HTML>
