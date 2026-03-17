<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >

<% Current3 = "Dashboard" %> 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->
<div border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth%>" >
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
<div class ="container roundedtopandbottom">
	<div class ="row">
		<div class = "col body">
			<a name="Add"></a>
 			
			<form  name=form method="post" action="AssociationDeleteAccounthandleform.asp?AssociationID=<%=AssociationID %>">
		<table>
		<tr>
		<td width = "320" height = 20 class = "body2" align = "right">
			<b>Association Name:</b>
		</td>
        <td width = 5></td>
		<td  class = "body">
			<b><%= AssociationName%></b>
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

		<input type="hidden" value = "<%= UserID%>" name = "PeopleID" >
		<b>Are you sure that you want to delete this association account? Once you delete it, it's gone!</b><br /><br />
		<center><input type=submit value="Delete"   class = "regsubmit2"></center>
		<br /><br />
	</form>
</div>
</div>
</div>
<% End if %>
<br /><br />
<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 

</Body>
</HTML>