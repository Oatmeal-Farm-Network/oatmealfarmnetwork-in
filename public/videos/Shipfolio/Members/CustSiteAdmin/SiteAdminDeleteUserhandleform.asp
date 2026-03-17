<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<!--#Include file="AdminGlobalVariables.asp"-->
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white" >
<%

dim PeopleID

	PeopleID=Request.Form("PeopleID") 
	
	sql2 = "select * from People where PeopleID = " & PeopleID
		Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   

if Not rs2.eof  then
		BusinessID= rs2("BusinessID")
		AddressID= rs2("AddressID")
		WebsitesID= rs2("WebsitesID")
		rs2.movenext
end if		
    if len(BusinessID)> 0 then
	Query =  "Delete * From Business where BusinessID = " & BusinessID & "" 
	Response.Write("Query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
	end if
	    if len(AddressID)> 0 then
		Query =  "Delete * From Address where AddressID = " & AddressID & "" 
	Response.Write("Query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
	end if
	
	    if len(WebsitesID)> 0 then
		Query =  "Delete * From Websites where WebsitesID = " & WebsitesID & "" 
	Response.Write("Query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
	end if
		Query =  "Delete * From People where PeopleID = " & PeopleID & "" 
	Response.Write("Query=" & Query)
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
DataConnection.Execute(Query) 
DataConnection.close
set DataConnection = Nothing
response.Redirect("SiteAdminDeleteUser.asp")
	
%>
	

 </Body>
</HTML>
