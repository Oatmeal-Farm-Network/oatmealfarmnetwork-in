<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Business" 
Current3 = "DeleteBusiness"  %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
%>
<!--#Include file="MembersbusinessTabsInclude.asp"-->
<table width = "<%=screenwidth %>" height = "300"  class = "roundedtopandbottom" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
<td class = "body" valign = "top" width = "600" align = "left" height = "300" valign = "top" >
<table width = "600" border = "0" leftmargin="2" topmargin="2" marginwidth="2" marginheight="2"  cellpadding=2 cellspacing=2 align = "left">
<tr><td class = "body" valign = "top">
			 <br><H1>Delete a Business<br></H1>
			To delete an business listing simply select it below and push the delet button.<br> <b>But careful. Once a business is deleted from your database, it's gone!</b><br><br>
</td></tr>
<tr><td>
<%  
Dim BFSIDArray(2000)
Dim BFSNameArray(2000)
sql2 = "select Count(*) as count, BFSID, BFSName  from BusinessForSale where PeopleID = " & session("peopleid") & " order by BFSname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
recordcount = clng(rs2("count"))
While Not rs2.eof  
BFSIDArray(acounter) = rs2("BFSID")
BFSNameArray(acounter) = rs2("BFSName")
'response.write (SSName(studcounter))
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing
set conn = Nothing
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" ><tr><td width = "10">&nbsp;</td><td class = "body" valign = "top" align = "center">
	
			<%If recordcount = 0 then %>		
					<b>You do not currently have any businesses listed to delete.</b><br><br>
			<% Else %>
			<form action= 'Deletebusinesshandleform.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "center" class = "body">
					<b>Select the business you want deleted: </b>
					<select size="1" name="BFSID">
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=BFSIDArray(count)%>">
							<%=BFSNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Delete"  class = "regsubmit2" >
				</td>
			  </tr>
			  <tr>
			     <td height = "200">&nbsp;
				 </td>
				</tr>
		    </table>
		  </form>
		  <% End If %>
		</td>
	</tr>
</table>
</td></tr></table>
</td></tr></table>
<!--#Include virtual="/Footer.asp"-->
</Body>
</HTML>