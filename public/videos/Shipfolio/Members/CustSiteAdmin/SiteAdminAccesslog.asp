<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include virtual="/Conn.asp"-->
<% Current2 = "SiteAdmin" 
Current3 = "Accesslog" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<!--#Include file="SiteAdminTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" bgcolor = "white" width = "100%">
<tr><td class = "body roundedtopandbottom" align = "left">
<H1><div align = "left">Website Administration</div></H1>
The report below shows when members have last accessed the website.
<table border = "0" bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td  valign = "top" class = "body">
<table border = "0" width = "800"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td width = "475" valign = "top" class = "body">
<%  sql = "select * from People  order by custLastAccess Desc"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
if rs.eof then
else    
rowcount = 1
dim PeopleIDArray(99999) 
dim custLastAccess(99999)  
dim PeopleFirstName(99999)  
dim PeoplelastName(99999)  
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
   
    <td></td>
    
    </tr>
</table>
</td>
</tr>
</table>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td><br><br>
<table width = "900"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr bgcolor = "antiquewhite">
<td class = "body" align = "center" ><b>User</b></td>
<td class = "body" align = "center" ><b>Last Accessed</b></td>
</tr>
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	PeopleIDArray(rowcount) =   rs("PeopleID")
	custLastAccess(rowcount) =   rs("custLastAccess")
	PeopleFirstName(rowcount) =   rs("PeopleFirstName")
    PeoplelastName(rowcount) =   rs("PeopleLastName")
showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
		

	</td>
	<td class = "body" width = "250" align = "left">
		<a href = "SiteAdminEditUser.asp?UserID=<%= PeopleIDArray(rowcount)%>#BasicFacts" class = "body"><%= PeopleFirstName(rowcount)%> &nbsp;<%= PeoplelastName(rowcount)%></a>
	</td>
		<td class = "body" align = "center" ><%=custLastAccess(rowcount) %></td>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing

 %>


</table>

<br>

</td>
</tr>
</table>
</td>
</tr>

</table>
<% end if %>
</td>
</tr>
</table>

</td></tr></table>
<!--#Include virtual="/Footer.asp"--> 
</body></html>