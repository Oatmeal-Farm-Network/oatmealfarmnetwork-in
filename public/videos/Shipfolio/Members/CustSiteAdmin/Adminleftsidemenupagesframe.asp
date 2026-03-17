<html>
<head>
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminFrameGlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="style.css">
<base target="_parent">
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<table border = 0 cellspacing = 0 cellpadding = 0 width = 180 >
<%  
row = "even"
sql2 = "select * from PageLayout where PageAvailable = Yes order by PageName, PageGroupID "
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not  rs2.eof then
 acounter = 1
recordcount = rs2.recordcount
While Not rs2.eof 
 PageLayoutID = rs2("PageLayoutID")

PageGroupID = rs2("PageGroupID")
PageType = rs2("PageType")
ShowPage = rs2("ShowPage")
LinkName = rs2("LinkName")
EditLinkName = rs2("EditLink")
PageAvailable  = rs2("PageAvailable")
if PageAvailable = "True" then
   PageAvailable = "Yes"
else
PageAvailable = "No"
end if
 if (MenuDropdowns  = "Yes" or MenuDropdowns = True) and len(PageGroupID)> 0 then 
   
sql = "select * from PageGroups where PageGroupID = " & PageGroupID & ""
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
if not  rs.eof then
PageGroupTitle = rs("PageGroupTitle")
end if
   else
   PageGroupTitle = ""
end if
if len(EditLinkName)> 0 then
else
if PageType  = "Standard" or len(PageType) < 3 then
 EditLinkName ="AdminPagedata.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
end if

if PageType  = "Service" then
 EditLinkName ="AdminServicesEdit2.asp?PageLayoutID=" & PageLayoutID & "#BasicFacts"
end if
end if

 If row = "even" Then 
 row = "odd"
 %>
<tr >
<% Else 
row = "even"%>
<tr bgcolor = "#e6e6e6">
<%End If %>
<td class= "body"  width = '100%' height = "25"><a href = "<%=EditLinkName %>" class = "body" ><%=rs2("PageName")%></a>
</td>
</tr>
<%catcounter  = catcounter  +1
rs2.movenext
Wend
end if
rs2.close%>
</table>
</body>
</html>