<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/includefiles/globalvariables.asp"--> 
</head>
<body border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% 
Dim PropIDArray(2000)
Dim PropNameArray(2000)

PropID= Request.QueryString("PropID") 
If Len(PropID) > 0 Then
else
PropID= Request.Form("PropID") 
End If 

Session("PropID")= PropID
sql2 = "select distinct PropID, PropName from Properties where PeopleID = " & Session("PeopleID") & " order by PropName"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof  
PropIDArray(acounter) = rs2("PropID")
PropNameArray(acounter) = rs2("PropName")
acounter = acounter +1
rs2.movenext
Wend
Numproperties   = acounter
    		
rs2.close
set rs2=nothing
Numproperties=  acounter
Current2 = "Properties" 
Current3 = "PropertyEdit" %> 
 <!--#Include File="MembersHeader.asp"--> 
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<table width = "<%=screenwidth %>" class = "roundedtopandbottom"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" valign = "top">
<% 
If Len(PropID) > 0 Then
else
 %>

 <form  action="EditProperty0.asp" method = "post" name = "edit1">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth-20 %>" class = "roundedtopandbottom">
<tr><td colspan ="30">
&nbsp;
</td>
<td class = "body">
<br>Select one of your properties:
<select size="1" name="PropID">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter%>
<option name = "AID1" value="<%=PropIDArray(count)%>">
<%=PropNameArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value="Submit" class = "regsubmit2" >
</td></tr></table>
</form>
<% End If %>
<%
If Len(PropID) > 0 then %>
 <!--#Include virtual="/Members/EditaProperty.asp"--> 
 <% End if %>
</td>
</tr>
</table>
<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</HTML>