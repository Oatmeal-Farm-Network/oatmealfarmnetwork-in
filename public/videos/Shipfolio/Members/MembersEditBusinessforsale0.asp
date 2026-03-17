<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 

<% 
Dim BFSIDArray(2000)
Dim BFSNameArray(2000)

BFSID= Request.QueryString("BFSID") 
		If Len(BFSID) > 0 Then
		else
			BFSID= Request.Form("BFSID") 
		End If 
Session("BFSID")= BFSID
sql2 = "select * from BusinessForSale where peopleID = " & session("peopleid") & " order by BFSname"
acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
NumBusinesses = rs2.recordcount
  If NumBusinesses = 1 Then
	BFSID  = rs2("BFSID")
  End if

	While Not rs2.eof  
		BFSIDArray(acounter) = rs2("BFSID")
		BFSNameArray(acounter) = rs2("BFSName")
		acounter = acounter +1
		rs2.movenext
	Wend		
rs2.close
set rs2=nothing
%>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2 = "Business"
Current3 = "BusinessEdit" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersBusinessTabsInclude.asp"-->
<table width = "<%=screenwidth %>" class = "roundedtopandbottom"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" valign = "top">
<% If  Len(BFSID) > 0 Then
else
 %>
 <form  action="EditBusinessforsale0.asp" method = "post" name = "edit1">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth-20 %>" class = "roundedtopandbottom">
		   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select another one of your businesses:
					<select size="1" name="BFSID">
					<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
%>
<option name = "AID1" value="<%=BFSIDArray(count)%>">
<%=BFSNameArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
<input type=submit value="Submit" class = "regsubmit2" >
</td></tr></table></form>
<% End If %>
<%If Len(BFSID) > 0 then %>
<!--#Include file="MembersEditbusinessFrorSaleInclude.asp"-->
<% End if %>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</Body>
</HTML>