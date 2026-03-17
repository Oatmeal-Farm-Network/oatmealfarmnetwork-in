<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplaces</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplaces">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="Style.css">

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

        if (document.form.BusinessName.value == "") {
            themessage = themessage + " - Ranch / Farm Name \r";
        }


        if (document.form.LeftShoe.value == "") {
            themessage = themessage + " - Password \r";
        }

        if (document.form.RightShoe.value == "") {
            themessage = themessage + " - Confirmation Password \r";
        }

        if (document.form.PeopleEmail.value.indexOf("@") < 1 || document.form.PeopleEmail.value.lastIndexOf(".") < document.form.PeopleEmail.value.indexOf("@") + 2
|| document.form.PeopleEmail.value.lastIndexOf(".") + 2 >= document.form.PeopleEmail.value.length) {
            themessage = themessage + " - The EMAIL address you entered is not valid. \r";
        }



        if (document.form.PeopleEmail.value != document.form.ConfirmEmail.value) {
            themessage = themessage + " - Your EMAIL entries do not match. \r";
        }

        if (document.form.LeftShoe.value.length < 8) {
            themessage = themessage + " - Your PASSWORD must be at least 8 digits long. \r";
        }

        if (document.form.LeftShoe.value != document.form.RightShoe.value) {
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

<% 
websitesignupcount = 0

website = request.querystring("website") 

if len(website) > 0 then
else
website = request.form("website") 
end if


ReturnFileName = Request.querystring("ReturnFileName") 
Update = Request.querystring("Update") 

PeopleID = request.querystring("PeopleID")
Message = request.querystring("Message")
Membership= "free"


%>

</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&website=<%=website %>&Membership='free'&peopleId=<%=peopleId %>');" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
<% Current = "Home"
Current3="Register"
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% end if %> 


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "480"  valign = "top" >
    <tr><td align = "left" valign = "top">
		<h2><center>Create Your Account</center></h2>
        
<form  name=form method="post" action="/join/SetupAccountFreestep2.asp">
<table border = "0" width = "480" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5 >
<tr><td class = "body2" colspan = "2" align = "center">
Please enter your information below:<br />
<font color = "red"><b>*</font></b>Indicates a Required Field.
<% if len(Message) > 1 then %><br>
<font color = "red"><b><%=Message%></b></font>
<% end if %>
		</td>
	</tr>
	<tr>
		<td valign = "top" >
		
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0 " width = "100%">
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>
<tr>
<td class = "body2" colspan = 2 align = "left" width = <%=firstcolwidth %> >
<font color = "red"><b>*</font></b><b>First Name</b><br />

					<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>" width="450" style="width: 450px" class = "formbox">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "left" colspan = 2>
					<font color = "red"><b>*</font></b><b>Last Name</b><br />
					<input name="PeopleLastName" Value ="<%=PeopleLastName%>"  width="450" style="width: 450px" class = "formbox">
				</td>
			</tr>

			<tr>
				<td class = "body2" align = "left" colspan = 2>
					<a class="tooltip" href="#">Owners&nbsp;<span class="custom info body"><div align = "left"><em>Owners:</em>List the whole team (i.e. Hank and Joanne Jones,  Jebediah and Frankie Espanoza, and Bob)</div></b></span></a>
<br />
					<input name="Owners" Value ="<%=Owners%>"   width="450" style="width: 450px" class = "formbox">
				</td>
			</tr>


		<tr> 
            <td class = "body2" align = "left" colspan = 2>
				<font color = "red"><b>*</font>Business Name</b>
			<br />
 				<input name="BusinessName" size = "35" value = "<%=BusinessName %>" width="450" style="width: 450px" class = "formbox">
			</td>


<tr>
	<td class = "body2" align = "left" colspan = 2>
			Website 
		<br />
			<input name="PeopleWebsite" Value ="<%=PeopleWebsite%>"  width="450" style="width: 450px" class = "formbox">
		</td>
	</tr>

<tr>
	<td class = "body2" align = "left" colspan = 2>

			<font color = "red"><b>*</font></b><b>Email</b>
<br />
			<input name="PeopleEmail"  size = "30" value = "<%=PeopleEmail%>" width="450" style="width: 450px" class = "formbox">
		</td>
</tr>
<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b><b>Confirm Email</b>
		<br />
			<input name="ConfirmEmail"  size = "30" value = "<%=PeopleEmail%>" width="450" style="width: 450px" class = "formbox">
		</td>
</tr>

<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b><b>Password</b>
		<br />
			<input name="LeftShoe" type="password" value="<%=password%>" maxlength = 12 width="450" style="width: 450px" class = "formbox">
           <br /><small><font color = '#404040'><i>Must be at least 8 digits long.</small></font></i>
		</td>
</tr>

<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b><b>Confirm Password</b>
		<br />
			<input name="RightShoe" type="password" value="<%=password%>"  maxlength = 12 width="450" style="width: 450px" class = "formbox">
     <br /><small><font color = '#404040'><i>Must be at least 8 digits long.</small></font></i>
		</td>
</tr>



<tr><td  align = "right" class = "body2" valign = "top" colspan = "2">
<center>
<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "free">

<br />

	<div align = right>	<input type=button value="CREATE YOUR ACCOUNT"  onclick="verify();" class = "regsubmit2"></div>
</center>
<% showcoupon = false

if showcoupon = true then %>
<br /><br />
<b>Note: You will have the chance to enter a coupon code on the next page.</b>
<% end if %>
</td></tr>
</table>

	</form>
<br>
</td>
</tr>
</table>


<!--#Include virtual="/Footer.asp"--> </body>
</HTML>