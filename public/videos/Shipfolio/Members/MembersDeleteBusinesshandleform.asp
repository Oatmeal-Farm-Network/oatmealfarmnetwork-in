<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
<title><%=Sitenamelong %> Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
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
<% Current2="business" 
Current3 = "Deletebusiness" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
BFSID=Request.Form("BFSID" ) 
if len(BFSID) < 1 then
else
Query =  "Delete From businessforsale where BFSID = " &  BFSID & "" 
Conn.Execute(Query) 
end if
Conn.Close
Set Conn = Nothing 
%>
<!--#Include file="MembersbusinessTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left">
<table width = "600" border = "0" leftmargin="2" topmargin="2" marginwidth="2" marginheight="2"  cellpadding=2 cellspacing=2 align = "left">
<tr><td class = "body" valign = "top">
<br><br>
<H2>Your business has successfully been deleted.</H2><br />
<a href = "MembersDeleteBusiness.asp" class = "body"><b>Click here to go back and delete another business.</b></a><br><br>
</td>
</tr>
</table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</Body>
</HTML>





