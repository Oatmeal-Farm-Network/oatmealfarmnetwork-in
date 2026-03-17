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
 	


<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";
        if (document.form.MemberFirstName.value == "") {
            themessage = themessage + " - Contact First Name \r";
        }

        if (document.form.MemberLastName.value == "") {
            themessage = themessage + " - Contact Last Name \r";
        }


        if (document.form.MemberEmail.value == "") {
            themessage = themessage + " - Contact E-mail \r";
        }

        if (document.form.ConfirmEmail.value == "") {
            themessage = themessage + " - Confirm Email \r";
        }

        if (document.form.MemberEmail.value != document.form.ConfirmEmail.value) {
            themessage = themessage + " -Please check your email addresses; the confirmation entry does not match. \r";
        }

        if (document.form.MemberPassword.value == "") {
            themessage = themessage + " - Contact Password \r";
        }

        if (document.form.ConfirmPassword.value == "") {
            themessage = themessage + " - Confirm Password \r";
        }

        if (document.form.MemberPassword.value != document.form.ConfirmPassword.value) {
            themessage = themessage + " -Please check your Passwords; the confirmation entry does not match. \r";
        }



        
        //alert if fields are empty and cancel form submit
        if (themessage == "Please fill out the following fields: \r") {
            document.form.submit();
        }
        else {
            alert(themessage);
            return false;
        }
    }
    //  End -->
</script>

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
	
        
<table border = "0" bordercolor = "bbbbbb" cellpadding=0 cellspacing=0 width = "980" align = "center">
 <tr>
		<td colspan = "9" align = "center">

<% Message = request.querystring("Message") 
AssociationMemberID= request.querystring("AssociationMemberID")
MemberFirstName= request.querystring("MemberFirstName")
MemberLastName= request.querystring("MemberLastName")
MemberEmail= request.querystring("MemberEmail")
MemberPosition= request.querystring("MemberPosition")
MemberAccessLevel= request.querystring("MemberAccessLevel")
MemberPassword = request.querystring("MemberPassword")
MemberAccessLevel = request.querystring("MemberAccessLevel")


if len(Message2) > 5 then 
%>
 <table border = "0" bordercolor = "bbbbbb"  cellpadding=0 cellspacing=0 width = "900" >
 <tr>
	<td  Class = "body">
		<font color = "brown"><b><%=Message2%></b></font>
   </td>
  </tr>
 </table>
<% end if %>



	<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  height = "125"><tr><td class = "roundedtop" align = "left" valign = "top">
		<H1><div align = "left">Add a User</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
   <form  name=form method="post" action="AddMembershandleform.asp">
<table border = "0" bordercolor = "bbbbbb" cellpadding=0 cellspacing=0 width = "900" >
  <tr>
		<td  colspan = "4" align = "right" class = "body">&nbsp;</td>
		
<% if len(Message) > 5 then %>
		<font color = "brown"><b><blockquote><%=Message %></blockquote></b></font>
<% end if %>


		</td>
	</tr>
<% showaccesslevel = True
If showaccesslevel = True then
 %>
<tr>
<td  align = "right" class = "body2">Access Level</td>
<td colspan = "3" class = "body" valign = "top">
	<select size="1" name="MemberAccessLevel">
	<% if len(AccessLevel) > 0 then 
    	   if AccessLevel = "1" then %>
		   	<option value="1">Basic Users</option>
		  <% else %>
		  	<option  value="3">Membersistrator</option>
		  <% end if %>
	<% end if %>
	<option value="1">Basic Users</option>
	<option value="3">Membersistrator</option>
	</select>
</td>
</tr>
<% end if %>
<tr>
<td  align = "right" class = "body2">
			First Name:
		</td>
		<td  align = "left" class = "body">
					<input name="MemberFirstName" value= "<%=MemberFirstName%>" size = "30">
		</td>
		<td  align = "right" class = "body2">
		    Position in Association:
		</td>
		<td  align = "left" class = "body">
		    <input name="MemberPosition" value= "<%=MemberPosition%>" size = "30">
		</td>

	</tr>

    	<td  align = "right" class = "body2">
			Last Name:
		</td>
		<td  align = "left" class = "body">
			<input name="MemberLastName" value= "<%=MemberLastName%>" size = "30">
		</td>
		<td  align = "right" class = "body">
		 
		</td>
		<td  align = "left" class = "body">
		   
		</td>

	</tr>


	<tr>
		<td  align = "right" class = "body2">
			Email:
		</td>
		<td  align = "left" class = "body">
			<input name="MemberEmail" value= "<%=MemberEmail%>" size = "30">
		</td>
		<td  align = "right" class = "body2">
			Password:
		</td>
		<td  align = "left" class = "body">
			<input name="MemberPassword" value= "" type = "MemberPassword" size = "12" maxsize="12">
		</td>
	</tr>
	<tr>
    <td  align = "right" class = "body2">
			Confirm Email:
		</td>
		<td  align = "left" class = "body">
			<input name="ConfirmEmail" value= "<%=ConfirmEmail%>" size = "30">
		</td>

		<td  align = "right" class = "body2">
			Confirm Password:
		</td>
	<td  align = "left" class = "body">
				<input name="ConfirmPassword" type = "text" value= "" size = "12" maxsize="12">
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body"></td>
		<td colspan = "3" class = "body">
			<b><i>Password must be at least 6 charecters long, 12 charecters maximum, and have no spaces.</i></b><br><br>
		</td>
	</tr>
<tr>
		<td colspan = "4" valign = "middle" align = "center">
		<input name="AssociationID" type = "hidden" value= "<%=Associationid %>" size = "12" maxsize="12">
<input type=button value="Create Account"  onclick="verify();" class = "regsubmit2"><br>
<br>
</form>
	</td>
</tr>
</table>



<div align = "left" class = "body">
<b>Access Levels:</b> <br />
&nbsp;<b>Basic users</b> can only make changes to their own login information.<br />
&nbsp;<b>Membersistrators</b> have access to all association login information; however, they do not have access to any farm membership information. <br /></div>

</td>
</tr>
</table><br /><br />


</Body>
</HTML>