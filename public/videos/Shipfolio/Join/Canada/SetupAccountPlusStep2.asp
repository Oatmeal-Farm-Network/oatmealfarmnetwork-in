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
</head>
<body >

<% Current = "Home"
Current3="Register"
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->

<% 

file_name = "SetupAccountPlusStep2.asp"

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
'response.write("sitePath=" & sitePath & "<br>")

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close



sql = "select * from Country where name = '" & Region & "'"
'response.write("sql=" & sql & "<br>")

rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close


If country_id = 1228 then
  Provincetype = "State"
else
  Provincetype = "Province"
end if

websitesignupcount = 0
Membership = request.Form("Membership")
if len(Membership) < 2 then
Membership = request.querystring("Membership")
end if


PeopleFirstName = request.form("PeopleFirstName") 
variables = variables & "&PeopleFirstName=" & PeopleFirstName
PeopleLastName = request.form("PeoplelastName") 
variables = variables &  "&PeopleLastName=" & PeopleLastName
Owners = Request.form("Owners")
variables = variables & "&Owners=" & Owners
BusinessName = Request.form("BusinessName")
variables = variables &  "&BusinessName=" & BusinessName
PeopleWebsite = Request.form("PeopleWebsite")
variables = variables &  "&PeopleWebsite=" & PeopleWebsite
PeopleEmail  = Request.form("PeopleEmail")
variables = variables & "&PeopleEmail=" & PeopleEmail


AddressStreet=request.querystring("AddressStreet")
variables = variables &  "&AddressStreet=" & AddressStreet
AddressApt=request.querystring("AddressApt")
variables = variables &  "&AddressApt=" & AddressApt
AddressCity=request.querystring("AddressCity")
variables = variables &  "&AddressCity=" & AddressCity
AddressZip=request.querystring("AddressZip")
variables = variables &  "&AddressZip=" & AddressZip
PeoplePhone=request.querystring("PeoplePhone")
variables = variables &  "&PeoplePhone=" & PeoplePhone
ConfirmEmail = Request.form("ConfirmEmail")
variables = variables &  "&ConfirmEmail=" & ConfirmEmail

Stepback = Request.querystring("Stepback")
passwordmismatch = Request.querystring("passwordmismatch")

MissingPassword = Request.querystring("MissingPassword")


MissingData = False
if len(PeopleFirstName) > 2 then
else
missing = "&MissingPeopleFirstName=True"
MissingData = True
end if

if len(PeopleLastName) > 2 then
else
missing = "&MissingPeopleLastName=True"
MissingData = True
end if

if len(PeopleEmail) > 2 then
else
missing = "&MissingPeopleEmail=True"
MissingData = True
end if


If PeopleEmail = ConfirmEmail then
 EmailsMatch=True
else
 EmailsMatch=False
end if


'response.write("Stepback=" & Stepback)

if (MissingData = True or  EmailsMatch=False) and not(Stepback = "True") then
response.redirect("SetupAccountPlus.asp?Membership=" & Membership & "&EmailsMatch=" & EmailsMatch & variables )
end if


if len(website) > 0 then
else
website = request.form("website") 
end if


if InStr(website, "Livestock Of America") > 0  Then
LOASignup = True
websitesignupcount = websitesignupcount + 1
end if 

if InStr(website, "Livestock Of Canada") > 0  Then
LOCSignup = True
websitesignupcount = websitesignupcount + 1
end if 

RPI = request.querystring("RPI") 
ReferringPeopleID =  request.querystring("ReferringPeopleID") 
if len(ReferringPeopleID) > 0 then
else
ReferringPeopleID = RPI
end if

ReturnFileName = Request.querystring("ReturnFileName") 
ReturnEventID = Request.querystring("ReturnEventID") 
Update = Request.querystring("Update") 

PeopleID = request.querystring("PeopleID")
Message = request.querystring("Message")


ExistingAccount = False
sql = "select * from People  where accesslevel > 0 and (Peopleemail = '" & Peopleemail & "')"
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		ExistingAccount = True 
		PeopleID= rs("PeopleID") 
        session("PeopleID") = ""
    end if
rs.close


includesub=false
if len(PeopleID)> 0 and includesub = true then 
	sql = "select Address.*, Websites.*, People.* from Address, Websites, People where People.AddressID = Address.AddressID and People.WebsitesID = Websites.WebsitesID and PeopleID = " & PeopleID & ""
	'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	If Not rs.eof Then
		PeopleFirstName  =rs("PeopleFirstName") 
		PeopleLastName  =rs("PeopleLastName") 
		PeopleTitleID =rs("PeopleTitleID") 
		PeopleWebsite =rs("Website") 
		PeopleEmail =rs("PeopleEmail") 
		password =rs("PeoplePassword") 
		AddressStreet = rs("AddressStreet") 
		AddressApt = rs("AddressApt") 
		AddressCity  = rs("AddressCity")
		AddressState  = rs("AddressState")
		AddressZip  = rs("AddressZip")
		PeoplePhone  = rs("PeoplePhone")
		PeopleCell  = rs("PeopleCell")
		PeopleFax  = rs("Peoplefax")
BusinessID = rs("BusinessID")
	End If 
	rs.close

	if len(PeopleTitleID) > 0 then 
		sql = "select 	BusinessName  from Business where BusinessID = " & BusinessID & ""
		'response.write(sql)
		Set rs = Server.CreateObject("ADODB.Recordset")
	    rs.Open sql, conn, 3, 3   
		If Not rs.eof Then
			BusinessName  = rs("BusinessName")
		end if 
	end if
end if
%>



<div class = "container" style="max-width:450px" >
<h1>Create Your Ranch Account</h1>

<div class = "col" >
  <form  name=form method="post" action="SetupAccountPlusstep3.asp">
 <% StateIndexFound = Request.querystring("StateIndexFound")
 if StateIndexFound = "False" then  %>
 <font color = "maroon"><br /><b>Please, select your <%=Provincetype %>.</b></font>
 <% end if %>
 
  <% if passwordmismatch ="False" then %>
<font color = "maroon"><br /><b>Your passwords did not match.</b></font>
<% end if %>
<% if SpecialChecterFound ="False" then %>
<font color = "maroon"><br /><b>Your password needs a special charecter.</b></font>
<% end if %>

<% 
MissingProvince = request.querystring("MissingProvince")

if MissingProvince = "True" then %>
<br><font color = "maroon"><b>Please select your <%=Provincetype %>.</b></font>
<% end if %>

<div class="form-group"><br />
    <label for="AddressStreet">Street</label>
    <input type="Text" name="AddressStreet" class="form-control" id="AddressStreet" Value ="<%=AddressStreet%>" placeholder="Street address.">
</div>

<div class="form-group"><br />
    <label for="AddressApt">Address2</label>
    <input type="Text" name="AddressApt" class="form-control" id="AddressApt" Value ="<%=AddressApt%>" placeholder="Address 2.">
</div>		

<div class="form-group"><br />
    <label for="AddressCity">City</label>
    <input type="Text" name="AddressCity" class="form-control" id="AddressCity" Value ="<%=AddressCity%>" placeholder="City.">
</div>	


<div class="form-group"><br />
<% if len(StateIndex) < 1 then %>
    <label for="StateIndex"><font color = "maroon"><b><%=Provincetype %>*</font></b></label>
<% else %>
    <label for="StateIndex"><%=Provincetype %><font color = "maroon"><b>*</font></b></label>
<% end if %>
<br /><select size="1" name="StateIndex" class=formbox width="250" style="width: 250px">
<option value="" > Select Your <%=Provincetype %></option>

<% sql = "select *  from state_province where country_id =" & country_id & " order by name"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
while Not rs.eof 
province = rs("name") 
TempStateIndex= rs("StateIndex") 

if lcase(province) = lcase(AddressState) then
  selected = "Selected"
else
  selected = ""
end if
%>

<option value="<%=TempStateIndex %>" <%=selected%> > <%=province %></option>

<% rs.movenext
wend %>
</select>
</div>
	
<div class="form-group"><br />
    <label for="AddressZip">Postal Code</label>
    <input type="Text" name="AddressZip" class="form-control" id="AddressZip" Value ="<%=AddressZip%>" placeholder="Address 2.">
</div>	


<div class="form-group"><br />
    <label for="PeoplePhone">Phone</label>
    <input type="Text" name="PeoplePhone" class="form-control" id="PeoplePhone" Value ="<%=PeoplePhone%>" placeholder="Your primary business phone number.">
</div>



<div class="form-group"><br />
<% if passwordmismatch="False" or MissingPassword = "True" then %>
    <label for="LeftShoe"><font color = "maroon"><b>Password*</font></b></label>
<% else %>
    <label for="LeftShoe">Password<font color = "maroon"><b>*</font></b></label>
<% end if %>

    <input type="password" name="LeftShoe" class="form-control" id="LeftShoe" Value ="<%=Password%>" placeholder="Your password.">
    <small>Your password must be at least 8 digits long and have at least 1 special character.</small>
</div>

<div class="form-group"><br />

<% if passwordmismatch="False" or MissingPassword = "True" then %>
    <label for="RightShoe"><font color = "maroon"><b>Confirm Password<b>*</font></b></label>
<% else %>
    <label for="RightShoe">Confirm Password<font color = "maroon"><b>*</font></b></label>
<% end if %>
    <input type="password" name="RightShoe" class="form-control" id="RightShoe" Value ="<%=Password%>" placeholder="Reenter your password">
</div>


<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="password"  type= "hidden" value = "<%=password%>">


<input name="PeopleFirstName"  type= "hidden" value = "<%=PeopleFirstName%>">
<input name="PeopleLastName"  type= "hidden" value = "<%=PeopleLastName%>">
<input name="BusinessName"  type= "hidden" value = "<%=BusinessName%>">
<input name="PeopleWebsite"  type= "hidden" value = "<%=PeopleWebsite%>">
<input name="PeopleEmail"  type= "hidden" value = "<%=PeopleEmail%>">
<input name="Owners"  type= "hidden" value = "<%=Owners%>">

<input name="Membership" type= "hidden" value = "<%=Membership %>">

<br />

	<div align = right><input type=submit value="NEXT" class = "regsubmit2"></div>
	</form>
<br>



<% session("Confirmationsent") = False %>

<!--#Include virtual="/Footer.asp"--> </body>
</HTML>