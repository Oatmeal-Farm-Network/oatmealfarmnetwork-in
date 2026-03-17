<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

  </head>
<body >
<% Current1="Account"
Current2 = "Add User" %>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<% Current3 = "DeleteMembers"  %>
<div class ="container roundedtopandbottom">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center">
 <tr>
<td  align = "center">
<H1><div align = "left">Remove a User</div></H1>
<% Message = request.querystring("Message") 

if len(Message) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0  >
 <tr>
	<td  Class = "body">
		<br><big><b><font color = 'maroon'><%=Message %></font></b></big><br><br>
   </td>
  </tr>
 </table>
<% end if %>        

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

<%  
dim associationmemberidArray(100000)
dim MemberFirstNameArray(100000)
dim MemberLastNameArray(100000)
dim PositionArray(100000)
dim AccessLevelArray(100000)
dim AssociationMemberID(100000)
dim associationmemberPeopleidArray(100000)
sql = "select associationmembers.AccessLevel, People.Peopleid, associationmemberid, PeopleFirstName, PeopleLastName, MemberPosition  from associations, associationmembers, people where associationmembers.associationid = associations.associationid and associationmembers.peopleid = people.peopleid and associations.associationID=" & session("associationID") 


acounter = 0
admincounter = 0
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3
'response.write("sql2=" & sql & "!<br><br>")
 
While Not rs2.eof  
  tempAccessLevel =rs2("AccessLevel")

   if tempAccessLevel > 3 then
   admincounter = admincounter + 1
   end if
    if tempAccessLevel > 3 and admincounter > 1 then
		AccessLevelArray(acounter) = rs2("associationmembers.AccessLevel")
		associationmemberPeopleidArray(acounter) = rs2("Peopleid")
		MemberFirstNameArray(acounter) = rs2("PeopleFirstName")
		MemberLastNameArray(acounter) = rs2("PeopleLastName")
		PositionArray(acounter) = rs2("Position")
    end if

    if tempAccessLevel < 4 then
		AccessLevelArray(acounter) = rs2("AccessLevel")
		associationmemberPeopleidArray(acounter) = rs2("Peopleid")
		PositionArray(acounter) = rs2("MemberPosition")
		MemberFirstNameArray(acounter) = rs2("PeopleFirstName")
		MemberLastNameArray(acounter) = rs2("PeopleLastName")
		AssociationMemberID(acounter) = rs2("AssociationMemberID")
    end if


	acounter = acounter +1
	rs2.movenext
Wend		

rs2.close
set rs2=nothing
%>
 <% if acounter > 1 then %>
	<tr>
		<td class = "body">
			&nbsp;&nbsp;Select a user to be removed from the list below:
		</td>
	</tr>
<% end if %>
	<tr>
		<td align = "left">

        <% if acounter = 1 then %>
        <b>Your association account only has one (1) user assigned to it. You must leave at lease one account Administrator account active.</b>
        <% else %>

		<table align = "center"><tr><td>

			<form action= 'DeleteMemberStep1.asp' method = "post">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" cellpadding=0 cellspacing=0 align = "left">
			   <tr>
			   <td class = 'body'><div align = "right">Users:&nbsp;
					<select size="1" name="CurrentPeopleID" class ="formbox" style="min-height:38px">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
					%>
						<option name = "AID1" value="<%=associationmemberPeopleidArray(count)%>">
	  					<%= MemberLastNameArray(count)%> , <%=MemberFirstNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				   &nbsp;
	      			<input type=submit value = "Remove" Class = "submitbutton"><br><br>
				</td>
			  </tr>
		    </table>
		  </form>
			<br /><br /><br /><br />
			<font class ="#abacab">Note: the account will be disassociated from the organization's account. However, their information will not be permanently deleted.</font>

		</td>
	</tr>
</table>
<% end if %>

		</td>
	</tr>
</table>
	</td>
	</tr>
</table>
</div>
<br><br>

<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</Body>
</HTML>