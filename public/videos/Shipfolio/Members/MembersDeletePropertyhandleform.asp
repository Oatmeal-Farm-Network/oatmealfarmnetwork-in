<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Properties" 
Current3 = "DeleteProperty" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
PropID=Request.Form("PropID" ) 
if len(PropID) < 1 then
else
Query =  "Delete From Properties where PropID = " &  PropID & "" 
Conn.Execute(Query) 
Query =  "Delete From PropertyPhotos where PropID = " &  PropID & "" 
Conn.Execute(Query) 
end if
Conn.Close
Set Conn = Nothing 
%>
<!--#Include file="MembersPropertiesTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left">
<table width = "600" border = "0" leftmargin="2" topmargin="2" marginwidth="2" marginheight="2"  cellpadding=2 cellspacing=2 align = "left">
<tr><td class = "body" valign = "top">
<br><br>
<H2>Your property has successfully been deleted.</H2><br />
<a href = "DeleteProperty.asp" class = "body"><b>Click here to go back and delete another property.</b></a><br><br>
</td>
</tr>
</table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</Body>
</HTML>





