<!DOCTYPE HTML >

<HTML>
<HEAD>
<link rel="stylesheet" type="text/css" href="/members/membersstyle.css" />

<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";
        if (document.form.PeopleFirstName.value == "") {
            themessage = themessage + " - First Name \r";
        }
        if (document.form.PeopleEmail.value == "") {
            themessage = themessage + " - Email \r";
        }

        if (document.form.ConfirmEmail.value == "") {
            themessage = themessage + " - Confirm Email \r";
        }


        if (document.form.PeoplePassword.value == "") {
            themessage = themessage + " - Password \r";
        }

        if (document.form.ConfirmPassword.value == "") {
            themessage = themessage + " - Confirmation Password \r";
        }

        if (document.form.PeopleEmail.value.indexOf("@") < 1 || document.form.PeopleEmail.value.lastIndexOf(".") < document.form.PeopleEmail.value.indexOf("@") + 2
|| document.form.PeopleEmail.value.lastIndexOf(".") + 2 >= document.form.PeopleEmail.value.length) {
            themessage = themessage + " - The EMAIL address you entered is not valid. \r";
        }



        if (document.form.PeopleEmail.value != document.form.ConfirmEmail.value) {
            themessage = themessage + " - Your EMAIL entries do not match. \r";
        }

        if (document.form.PeoplePassword.value.length < 8) {
            themessage = themessage + " - Your PASSWORD must be at least 8 digits long. \r";
        }

        if (document.form.ConfirmPassword.value != document.form.PeoplePassword.value) {
            themessage = themessage + " - Your PASSWORD entries do not match. \r";
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

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current1="Account"
Current2 = "AccountInfo" %>
<!--#Include file="AssociationGlobalVariables.asp"--> 
<!--#Include file="AssociationHeader.asp"--> 

        
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "<%=screenwidth -30%>" align = center  >
 <tr>
		<td colspan = "9" align = "center">
<% 



Message = request.querystring("Message") 
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


<tr ><td class = "body">
<a name="Add"></a><br />
<H2>&nbsp;&nbsp;Add a New User</H2>
<br>
</td>
</tr>
<tr>
<td >
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0>
<form action= 'AssociationAddUserhandleform.asp' name = "form" method = "post">



<tr><td width = "190" class = "body2" align = "right">
Access Level
</td>
<td>
<select size="1" name="AccessLevel" class = formbox>
<% if tempAccesslevel = 1 or tempAccesslevel = 0 then %>
<option name = "AID0" value= "3" selected>Basic User</option>
<option name = "AID0" value= "4" >Account Administrator</option>
<% end if %>

<% if tempAccesslevel = 2 then %>
<option name = "AID0" value= "3" >Basic User</option>
<option name = "AID0" value= "4" selected>Account Administrator</option>
<% end if %>

	
</select>
</td>
</tr>
<tr>
<td width = "190"  class = "body2" align = "right">
			First Name
		</td>
		<td  class = "body">
			<input name="PeopleFirstName" size = "50" class = formbox>
		</td>
	</tr>
    	<tr>
		<td  class = "body2" align = "right">
			Last Name
		</td>
		<td  class = "body">
			<input name="PeopleLastName" size = "50" class = formbox>
		</td>
	</tr>
	
	<tr>
<td  class = "body2" align = "right">
			Street Address
		</td>
		<td>
			<input name="AddressStreet" size = "50" class = formbox>
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Address 2
		</td>
		<td>
			<input name="AddressApt" size = "50" class = formbox>
		</td>
	</tr>
	<tr>
	<td  class = "body2" align = "right">
			City
		</td>
		<td>
			<input name="AddressCity" size = "50" class = formbox>
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			State
		</td>
		<td>
			<input name="AddressState" size = "50" class = formbox>
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			Zip
		</td>
		<td>
			<input name="AddressZip" size = "50" class = formbox>
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Phone
		</td>
		<td>
			<input name="PeoplePhone" size = "50" class = formbox>
		</td>
	</tr>
<tr>
<td  class = "body2" align = "right">
			Cell
		</td>
		<td>
			<input name="PeopleCell" size = "50" class = formbox>
		</td>
	</tr>
	<tr>
<td  class = "body2" align = "right">
			<font color = Maroon>EMail</font>
		</td>
		<td>
			<input name="PeopleEmail" size = "50" class = formbox>
		</td>
	</tr>
    	<tr>
<td  class = "body2" align = "right">
			<font color = Maroon>Confirm EMail</font>
		</td>
		<td>
			<input name="ConfirmEmail" size = "50" class = formbox>
		</td>
	</tr>
<td  class = "body2" align = "right">
			<font color = maroon>Password</font>
		</td>
		<td>
			<input name="PeoplePassword" size = "50" type = password class = formbox>
		</td>
</tr>
<tr>
<td  class = "body2" align = "right">
			<font color = maroon>Confirm Password</font>
		</td>
		<td>
			<input name="ConfirmPassword" size = "50" type = password class = formbox>
		</td>
</tr>
<tr>
		<td  align = "center" valign = "middle" colspan = "2">
        <br />
  <input type=button value = "ADD USER"  onclick="verify();" class = "regsubmit2">
</form>
</td>
</tr>
</table>
<br /><br />
</td>
</tr>
</table><br /><br />
 <!--#Include virtual="/Associationadmin/AssociationFooter.asp"--> 

</Body>
</HTML>