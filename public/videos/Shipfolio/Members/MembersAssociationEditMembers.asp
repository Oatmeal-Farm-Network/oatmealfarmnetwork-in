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
End If 
 	
%>
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&associationid=<%=associationid %>');" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>


<!--#Include file="SiteMembersTabsInclude.asp"-->


<table class = 'roundedtopandbottom' width = "<%=screenwidth%>">
<tr>
<td class = "body" >

<!--#Include file="MembersAssociationAccountTabsInclude.asp"-->
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">
 <tr>
		<td colspan = "9" align = "center">
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  height = "125"><tr><td class = "roundedtop" align = "left" valign = "top">

		<H1><div align = "left">Edit Users</div></H1>

        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<% 

sql = "select * from AssociationMembers where associationID=" & AssociationID & " order by MemberLastName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim AssociationMemberID(800)
	dim MemberFirstName(800)
	dim MemberLastName(800)
	dim MemberEmail(800)
	dim MemberPosition(800)
	dim MemberAccessLevel(800)



Recordcount = rs.RecordCount +1
%>

<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">

<% showaccesslevel = True
order = "odd"	
recordcount = 0
if not rs.eof then %>


 <tr>
		<td colspan = "5" align = "center" >
<% if CurrentMemberAccessLevel = 3 then %>
	<H2>Edit an Existing Entry</H2>
<% else %>
<% end if %>
		</td>
	</tr>
<tr bgcolor = "#93AFD0">
<% if showaccesslevel = True then %>
		<th width = "150" class = "body"><b>Access Level</b></th>
<% end if %>
		<th width = "150" align = "center" class = "body"><b>Last Name</b></th>
		<th width = "170" align = "center" class = "body"><b>First Name</b></th>
		<th width = "100" align = "center" class = "body"><b>Position</b></th>
        <th width = "100" align = "center" class = "body"><b>Email Adress</b></th>
		<th  align = "center" class = "body"><b>Action</b></th>
	</tr>
<% else %>
<tr>
	<td colspan = "5" align = "center" class = "body" >
		Currently, your associations account has no members associated with it. To add members select the <a href="AddMembers.asp" class = "body">Add Members</a> tab.
	</td>
</tr>

<% end if %>
<form action= 'Membershandleform.asp' method = "post">
<% While  Not rs.eof  
 recordcount = recordcount + 1       
	 AssociationMemberID(rowcount) =   rs("AssociationMemberID")
	 MemberFirstName(rowcount) =   rs("MemberFirstName")
	 MemberLastName(rowcount) =   rs("MemberLastName")
	 MemberEmail(rowcount) =   rs("MemberEmail")
	 MemberPosition(rowcount) =   rs("MemberPosition")
     MemberAccessLevel(rowcount) = rs("MemberAccessLevel")

	%>

	

<% 
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#93AFD0">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "white">    
	<% end if %>

    <% if showaccesslevel = True then %>
		<td class = "body">
			
<% if CurrentMemberAccessLevel = 3 then %>  
            
 &nbsp;<select size="1" name="MemberAccessLevel(<%=rowcount%>)">
	<% if len(MemberAccessLevel(rowcount)) > 0 then 
		if MemberAccessLevel(rowcount) = "1" then %>
			<option value="1" selected >Basic User</option>
			<option  value="2">Membersistrator</option>
		<% else %>
			<option  value="2" selected >Membersistrator</option>
			<option value="1">Basic User</option>
         <% end if %>
<% end if %>
</select>
<% else %>
Basic User
<% end if %>

		</td>
        <% end if %>
		 <td class = "body">
			<input  name="MemberFirstName(<%=rowcount%>)" value= "<%=MemberFirstName(rowcount)%>" size = "18" class = "body">
		</td>
		<td class = "body">
			<input  name="MemberLastName(<%=rowcount%>)" value= "<%=MemberLastName(rowcount)%>" size = "20" class = "body">
		</td>
        <td class = "body">
			<input  name="MemberPosition(<%=rowcount%>)" value= "<%=MemberPosition(rowcount)%>" size = "20" class = "body">
		</td>
		<td class = "body">
			<input  name="MemberEmail(<%=rowcount%>)" value= "<%=MemberEmail(rowcount)%>" size = "30" class = "body">
		
		  <input  type = "hidden" name="AssociationMemberID(<%=rowcount%>)" value= "<%= AssociationMemberID(rowcount)%>" >

		 </td>
	  	<td class = "body" align = "right"><a href = "AssociationResetpassword.asp?AssociationMemberID=<%=AssociationMemberID(rowcount)%>" class = "body">Reset Password</a></td>

	</tr>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<% if recordcount > 0 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" >
<tr>
		<td  valign = "middle">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" Class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
<% end if %>

<% if CurrentMemberAccessLevel = 3 then%>
<div align = "left" class = "body">
<b>Access Levels:</b> <br />
&nbsp;<b>Basic users</b> can only make changes to their own login information.<br />
&nbsp;<b>Membersistrators</b> have access to all association login information; however, they do not have access to any farm membership information. <br /></div>
<% end if %>
</td>
</tr>
</table>

<br /><br />

</Body>
</HTML>