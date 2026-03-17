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



        if (document.form.PeopleEmail.value.indexOf("@") < 1 || document.form.PeopleEmail.value.lastIndexOf(".") < document.form.PeopleEmail.value.indexOf("@") + 2
|| document.form.PeopleEmail.value.lastIndexOf(".") + 2 >= document.form.PeopleEmail.value.length) {
            themessage = themessage + " - The EMAIL address you entered is not valid. \r";
        }



        if (document.form.PeopleEmail.value != document.form.ConfirmEmail.value) {
            themessage = themessage + " - Your EMAIL entries do not match. \r";
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
<H2>Add an Administrator</H2>

Enter an administrators name and email address below. As an administrator they will have access to your association's administration area and make changes to your associations' information.<br /><br />

If they are not an existing Livestock Of The World member a membership will be created for them.
<% Added = request.querystring("Added")
If Added  = "True" Then
 %>
 <font color = maroon><b>The account has been added.</b></font>
 <% end if %>
<br>
</td>
</tr>
<tr>
<td >
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0>
<form action= 'AssociationAddUAdministratorhandleform1.asp' name = "form" method = "post">
<% ExistingAssociationAccount = request.querystring("ExistingAssociationAccount")
if ExistingAssociationAccount = "True" then
 %>
<tr>
<td colspan = 2>
<font color = maroon><b>An administrative account with that email address already exists.</b></font>
</td></tr>
<% end if %>
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
			Position
		</td>
		<td  class = "body">
			<input name="Position" size = "50" class = formbox>
		</td>
	</tr>
    	
	<tr>
<td  class = "body2" align = "right">
			<font color = Maroon>Email</font>
		</td>
		<td>
			<input name="PeopleEmail" size = "50" class = formbox>
		</td>
	</tr>
    	<tr>
<td  class = "body2" align = "right">
			<font color = Maroon>Confirm email</font>
		</td>
		<td>
			<input name="ConfirmEmail" size = "50" class = formbox>
		</td>
	</tr>
<tr>
		<td  align = "center" valign = "middle" colspan = "2">
        <br />
  <input type=button value = "ADD ADMINISTRATOR"  onclick="verify();" class = "regsubmit2">
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