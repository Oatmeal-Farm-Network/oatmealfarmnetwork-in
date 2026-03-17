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

file_name = "SetupAccountfree.asp"

script_name = request.servervariables("script_name")

str1 = script_name
str2 = "Join"
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 
str1 = sitePath
str2 = file_name
If InStr(str1,str2) > 0 Then
sitePath= Replace(str1,  str2, "")
End If 

str1 = sitePath
str2 = "/"
If InStr(str1,str2) > 0 Then
Region= Replace(str1,  str2, "")
End If 


'response.write("Region=" & Region & "<br>")

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

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
<body >

<% Current = "Home"
Current3="Register"
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "480"  valign = "top" >
    <tr><td align = "left" valign = "top">
		<h2><center>Create Your Account</center></h2>
        
<form name=form method="post" action="SetupAccountFreestep2.asp">
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


<font color = "red"><b>*</font></b>First Name<br />

					<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>" width="450" style="width: 450px" class = "formbox">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "left" colspan = 2>
					<font color = "red"><b>*</font></b>Last Name<br />
					<input name="PeopleLastName" Value ="<%=PeopleLastName%>"  width="450" style="width: 450px" class = "formbox">
				</td>
			</tr>

			<tr>
				<td class = "body2" align = "left" colspan = 2>
					Owners&nbsp;<br />
					<input name="Owners" Value ="<%=Owners%>"   width="450" style="width: 450px" class = "formbox">
                    <small>List the whole team (i.e. Hank and Joanne Jones,  Jebediah and Frankie Espanoza, and Bob).</small>

				</td>
			</tr>


		<tr> 
            <td class = "body2" align = "left" colspan = 2>
				<font color = "red"><b>*</font></b>Business Name
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

			<font color = "red"><b>*</font></b>Email
<br />
			<input name="PeopleEmail"  size = "30" value = "<%=PeopleEmail%>" width="450" style="width: 450px" class = "formbox">
		</td>
</tr>
<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b>Confirm Email
		<br />
			<input name="ConfirmEmail"  size = "30" value = "<%=PeopleEmail%>" width="450" style="width: 450px" class = "formbox">
		</td>
</tr>

<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b>Password
		<br />
			<input name="LeftShoe" type="password" value="<%=password%>" maxlength = 12 width="450" style="width: 450px" class = "formbox">
           <br /><small><font color = '#404040'><i>Must be at least 8 digits long.</small></font></i>
		</td>
</tr>

<tr>
		<td class = "body2" align = "left" colspan = 2>
			<font color = "red"><b>*</font></b>Confirm Password
		<br />
			<input name="RightShoe" type="password" value="<%=password%>"  maxlength = 12 width="450" style="width: 450px" class = "formbox">
     <br /><small><font color = '#404040'><i>Must be at least 8 digits long.</small></font></i>
		</td>
</tr>



<tr><td  align = "right" class = "body2" valign = "top" colspan = "2">
<center>

<input name="country_id" type = "hidden"  value = "<%=country_id%>">
<input name="country" type = "hidden"  value = "<%=country%>">
<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "free">

<br />

	<div align = right>	<input type=button value="CREATE YOUR ACCOUNT"  onclick="verify();" class = "regsubmit2"></div>
</center>

</td></tr>
</table>

	</form>
<br>
</td>
</tr>
</table>
</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"--> </body>
</HTML>