<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Delete Class"  %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 class ="roundedtopandbottom" width = "<%=screenwidth%>" >
<tr><td height = "560" valign = "top">

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body">
<H2>Delete a Class</H2>
</td></tr></table>
<%  
dim ClassInfoIDArray(5000) 
dim ClassInfoTitleArray(5000) 
		
sql2 = "select * from ClassInfo order by ClassInfoTitle"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   

While Not rs2.eof  
ClassInfoIDArray(acounter) = rs2("ClassInfoID")
ClassInfoTitleArray(acounter) = rs2("ClassInfoTitle")
acounter = acounter +1
rs2.movenext
Wend %>
<form action= 'AdminClassesDeletehandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td colspan ="30">
&nbsp;
</td>
<td class = "body">
<% if rs2.recordcount > 0 then %>
<br>Select a Class:
<select size="1" name="ClassInfoID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
%>
<option name = "AID1" value="<%=ClassInfoIDArray(count)%>">
<%=ClassInfoTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value = "Delete" class = "regsubmit2" >
<% else %>
There currently are no classes to delete.

<% end if %>
</td></tr></table>
</form>
</td></tr></table>

<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>