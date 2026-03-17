<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
<% Current2 = "SiteMembers" 
Current3 = "Associations" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If  

AssociationID= Request.QueryString("AssociationID")
If Len(AssociationID) < 1 then
AssociationID= Request.Form("AssociationID") 
End If %>
 	
</head>
<body >


<!--#Include file="SiteMembersTabsInclude.asp"-->


<table class = 'roundedtopandbottom' width = "<%=screenwidth%>">
<tr>
<td class = "body" >

<!--#Include file="MembersAssociationAccountTabsInclude.asp"-->
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "980" align = "center">
 <tr>
		<td colspan = "9" align = "center">
		
		



	<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  height = "125"><tr><td class = "roundedtop" align = "left" valign = "top">
		<H1><div align = "left">Delete a User</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<% Message = request.querystring("Message") 
   
if len(Message) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<br><big><b><font color = 'maroon'><%=Message %></font></b></big><br><br>
   </td>
  </tr>
 </table>
<% end if %>        

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" >
	<tr>
		<td class = "body">
			&nbsp;&nbsp;Select a user to be deleted from the list below:
			
		</td>
	</tr>

<%  
dim OldAssociationMemberID(800)
dim OldMemberFirstName(800)
dim OldMemberLastName(800)

sql2 = "select * from Associationmembers where associationID=" & session("associationID") & " order by MemberLastName"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
While Not rs2.eof  
	OldAssociationMemberID(acounter) = rs2("AssociationMemberID")
	OldMemberFirstName(acounter) = rs2("MemberFirstName")
	OldMemberLastName(acounter) = rs2("MemberLastName")
	'response.write ("name=" & OldMemberLastName(acounter))

	acounter = acounter +1
	rs2.movenext
Wend		
	
rs2.close
set rs2=nothing
%>
	<tr>
		<td align = "left">
		<table width = "700" align = "center"><tr><td>

			<form action= 'DeleteMembersHandleform.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
			   <tr>
			   <td width = "150" class = 'body' align = "right"><div align = "right">Users:</div></td>
				 <td align = "left">
						<select size="1" name="AssociationMemberID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=oldAssociationMemberID(count)%>">
							<%=OldMemberLastName(count)%> , <%=OldMemberFirstName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select><br>
				</td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type=submit value = "Delete User"   Class = "regsubmit2" ><br><br>
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
		</td>
	</tr>
</table>
<br><br>


</Body>
</HTML>