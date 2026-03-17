<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<% KeepUserID = True %>
<!--#Include file="AdminGlobalVariables.asp"-->

<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&PeopleID=<%=PeopleID %>');">
<% end if  %>
<% Current2 = "SiteAdmin" 
Current3 = "DeleteAccount" %> 
<!--#Include file="AdminHeader.asp"--> 
<br />
<!--#Include file="SiteAdminCorporatTabsInclude.asp"-->
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth%>" >
<tr><td class = roundedtop><H2>Delete Association Account</H2></td></tr>
<tr><td valign = "top" class = "roundedBottom" >
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<%

AssociationID= Request.QueryString("AssociationID") 
If Len(AssociationID) < 1 then
AssociationID= Request.Form("AssociationID") 
End If 
If Len(AssociationID) < 1 then
AssociationID= Session("AssociationID") 
End If 

If Len(AssociationID) < 1 Then
 else 

sql = "select distinct * from Associations where AssociationID = " & AssociationID


Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3   
if  Not rs.eof then   
AssociationName  =rs("AssociationName")
AssociationAcronym  = rs("AssociationAcronym")

end if
rs.close
%>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H2>Delete Account <%= AssociationName%></H2><br>
 			
			<br>
		</td>
	</tr>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="5"  cellpadding=0 cellspacing=0>
<form  name=form method="post" action="SiteAdminDeleteAccounthandleform.asp?AssociationID=<%=AssociationID %>">

<tr>
<td width = "320" height = 20 class = "body2" align = "right">
Company Name
		</td>
        <td width = 5></td>
		<td  class = "body">
<%= AssociationName%>
		</td>
	</tr>
<tr>
<td height = 20 class = "body2" align = "right">
Acronym
</td>
<td></td>
<td  class = "body">
<%=AssociationAcronym  %>
</td>
</tr>
</table>	
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0 width = "<%=screenwidth -40%>">
<tr><td class = "body2" align = "center" valign = "middle" align ="center">
<input type="hidden" value = "<%= UserID%>" name = "PeopleID" >
<b>Are you sure that you want to delete this association account? Once you delete it, it's gone!</b><br /><br />
<center><input type=submit value="DELETE ASSOCIATION ACCOUNT"   class = "regsubmit2"></center>

</form>
</td></tr></table><br /><br />
<% End if %>
</td></tr></table>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>