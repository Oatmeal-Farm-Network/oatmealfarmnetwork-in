<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplaces</title>
<meta name="Title" content="Create Account - <%=WebSiteName %> Online Animal Marketplaces">
<meta name="description" content="Create your account at <%=WebSiteName %> - Animals for Sale." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="<%=WebSiteName %>">
<link rel="stylesheet" type="text/css" href="/includefiles/Style.css">


<% 
file_name = "SetupAccountPlus.asp"

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
'stepback = False
stepback = request.querystring("stepback") 

if len(website) > 0 then
else
website = request.form("website") 
end if

ReturnFileName = Request.querystring("ReturnFileName") 
Update = Request.querystring("Update") 
PeopleID = request.querystring("PeopleID")
Message = request.querystring("Message")
Membership = request.querystring("Membership")
PeopleFirstName = request.querystring("PeopleFirstName") 
PeopleLastName = request.querystring("PeoplelastName") 
Owners = Request.querystring("Owners")
BusinessName = Request.querystring("BusinessName")
PeopleWebsite = Request.querystring("PeopleWebsite")
PeopleEmail  = Request.querystring("PeopleEmail")

EmailsMatch = Request.querystring("EmailsMatch")

SpecialChecterFound = Request.querystring("SpecialChecterFound")
ConfirmEmail = Request.querystring("ConfirmEmail")
%>
</head>
<body >

<% Current = "Home"
Current3="Register"
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->


<div class="container-fluid" >
  <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Create Your Membership</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br />

<div class = "container roundedtopandbottom mx-auto" style="max-width:450px" >
<div class = "col" >
<form name=form method="post" action="SetupAccountPlusStep2.asp"> 

<% if (len(PeopleFirstName) < 1 or len(PeopleLastName) < 1 or len(PeopleEmail)) and stepback = "True" then %>
<font color = "maroon"><b>You are mising some needed information.</b></font>
<% end if %>




<% if EmailsMatch ="False" then %>
<font color = "maroon"><br /><b>Your email addresses do not match.</b></font>
<% end if %>
	
<div class="form-group"><br />
    <label for="PeopleFirstName">First Name</label>
    <input type="Text" name="PeopleFirstName" class="form-control" id="PeopleFirstName" Value ="<%=PeopleFirstName%>"  required>
</div>

<div class="form-group"><br />
    <label for="PeopleLastName">Last Name</label>


    <input type="Text" name="PeopleLastName" class="form-control" id="PeopleLastName" Value ="<%=PeopleLastName%>"  Required>
</div>

<div class="form-group"><br />
    <label for="Owners">Owners <font color= "#abacab">(Optional)</font></label>
    <input type="Text" name="Owners" class="form-control" id="Owners" Value ="<%=Owners%>" >
</div>

<div class="form-group"><br />
    <label for="BusinessName">Business Name <font color= "#abacab">(Optional)</font></label>
    <input type="Text" name="BusinessName"  class="form-control" id="BusinessName" Value ="<%=BusinessName%>" >
</div>


<div class="form-group"><br />
    <label for="PeopleWebsite">Website <font color= "#abacab">(Optional)</font></label>
    <input type="Text" name="PeopleWebsite" class="form-control" id="PeopleWebsite" Value ="<%=PeopleWebsite%>" >
</div>


<div class="form-group"><br />
<label for="email">Email</label>
<input type="email" id="email" class="form-control" name="email"  required>
</div>

<div class="form-group"><br />
 <label for="confirm_email">Confirm Email</label>
<input type="email" id="confirm_email" class="form-control" name="confirm_email"  required onkeyup="checkEmailMatch();">
</div>

    
<script>
function checkEmailMatch() {
    var email = document.getElementById("email");
    var confirm_email = document.getElementById("confirm_email");

    if (email.value != confirm_email.value) {
        confirm_email.setCustomValidity("Email addresses do not match");
    } else {
        confirm_email.setCustomValidity("");
    }
}
</script>

<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">

<br />
	<input type=submit value="Next" class = "regsubmit2">


	</form><br><br>
</div>
<br>
</div>
<br>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>