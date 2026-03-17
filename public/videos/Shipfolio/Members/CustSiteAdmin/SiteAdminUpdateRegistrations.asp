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
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current = "siteadmin" %>
<% Current2="siteAdmin" %> 
<!--#Include file="siteadminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Update Registration</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "<%=screenwidth %>">
<% Set rsx = Server.CreateObject("ADODB.Recordset")
Set rs = Server.CreateObject("ADODB.Recordset")

Set rsx = Server.CreateObject("ADODB.Recordset")
sqlx = "select ID from Animals " 
rsx.Open sqlx, conn, 3, 3   
while not rsx.eof

CurrentID =rsx("ID")

sql = "select AnimalRegistrationID from Animals where Animals.ID = " & currentID

rs.Open sql, conn, 3, 3   
if not rs.eof then
CurrentAnimalRegistrationID = rs("AnimalRegistrationID")

response.write("CurrentAnimalRegistrationID=" & CurrentAnimalRegistrationID )

Query =  " UPDATE animalRegistration Set AnimalID = " & CurrentID & ", "
Query =  Query & " RegNumber = ''"
Query =  Query & " where AnimalRegistrationID = " & CurrentAnimalRegistrationID & " and RegType = 'ARI'"
response.write("Query=" & Query )
Conn.Execute(Query) 
end if
rs.close
rsx.movenext
wend
%>


	
<!-- #include virtual="/Footer.asp" -->
 </Body>
</HTML>
