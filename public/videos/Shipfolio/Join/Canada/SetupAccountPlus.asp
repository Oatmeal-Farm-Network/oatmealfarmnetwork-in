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

<div class = "container" style="max-width:450px" >
<h1>Create Your Ranch Account</h1>
<div class = "col" >
<form name=form method="post" action="SetupAccountPlusStep2.asp"> 


<% if len(PeopleFirstName) < 1 or len(PeopleLastName) < 1 or len(Owners) < 1 or len(BusinessName) < 1 or len(PeopleWebsite) < 1 or len(PeopleEmail) then %>
<font color = "maroon"><b>You are mising some needed information.</b></font>
<% end if %>




<% if EmailsMatch ="False" then %>
<font color = "maroon"><br /><b>Your email addresses do not match.</b></font>
<% end if %>
	



<div class="form-group"><br />
<% if len(PeopleFirstName) < 1 then %>
    <label for="PeopleFirstName"><font color = "maroon"><b>First Name*</font></b></label>
<% else %>
    <label for="PeopleFirstName">First Name<font color = "maroon"><b>*</font></b></label>
<% end if %>
    <input type="Text" name="PeopleFirstName" class="form-control" id="PeopleFirstName" Value ="<%=PeopleFirstName%>" placeholder="Your first name.">
</div>

<div class="form-group"><br />
<% if len(PeopleLastName) < 1 then %>
    <label for="PeopleLastName"><font color = "maroon"><b>Last Name*</font></b></label>
<% else %>
    <label for="PeopleLastName">Last Name<font color = "maroon"><b>*</font></b></label>
<% end if %>

    <input type="Text" name="PeopleLastName" class="form-control" id="PeopleLastName" Value ="<%=PeopleLastName%>" placeholder="Your last name.">
</div>

<div class="form-group"><br />
    <label for="Owners">Owners</label>
    <input type="Text" name="Owners" class="form-control" id="Owners" Value ="<%=Owners%>" placeholder="List your management team.">
</div>

<div class="form-group"><br />
    <label for="BusinessName">Business Name</label>
    <input type="Text" name="BusinessName"  class="form-control" id="BusinessName" Value ="<%=BusinessName%>" placeholder="Your ranch, farm, or business name.">
</div>


<div class="form-group"><br />
    <label for="PeopleWebsite">Website</label>
    <input type="Text" name="PeopleWebsite" class="form-control" id="PeopleWebsite" Value ="<%=PeopleWebsite%>" placeholder="Your website address.">
</div>


<div class="form-group"><br />
<% if EmailsMatch ="False" or len(PeopleEmail) < 2 then %>
<label for="PeopleEmail"><font color = "maroon"><b>Email*</font></b></label>
<% else %>
<label for="PeopleEmail">Email<font color = "maroon"><b>*</font></b></label>
<% end if %>
    
    <input type="email" name="PeopleEmail" class="form-control" id="PeopleEmail" Value ="<%=PeopleEmail%>" placeholder="Your email address.">
</div>

<div class="form-group"><br />
<% if EmailsMatch ="False" or len(ConfirmEmail) < 2 then %>
    <label for="ConfirmEmail"><font color = "maroon"><b>Confirm Email*</font></b></label>
<% else %>
    <label for="ConfirmEmail">Confirm Email<font color = "maroon"><b>*</font></b></label>
<% end if %>

    <input type="email" name="ConfirmEmail" class="form-control" id="ConfirmEmail" Value ="<%=ConfirmEmail%>" placeholder="Reenter your email address.">
</div>



<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">

<br />
	<div align = right>	<input type=submit value="NEXT" class = "btn regsubmit2"></div>


	</form>
</div>
<br>
</div>

<!--#Include virtual="/Footer.asp"--> </body>
</HTML>