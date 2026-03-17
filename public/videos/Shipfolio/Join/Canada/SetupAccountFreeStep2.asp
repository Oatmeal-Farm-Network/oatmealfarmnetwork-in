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

file_name = "SetupAccountFreestep2.asp"

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

PeopleFirstName = request.form("PeopleFirstName") 
PeopleLastName = request.form("PeoplelastName") 
Owners = Request.form("Owners")
BusinessName = Request.form("BusinessName")
PeopleWebsite = Request.form("PeopleWebsite")

PeopleEmail  = Request.form("PeopleEmail")
ConfirmEmail = Request.form("ConfirmEmail")
password =Request.form("LeftShoe")


if len(website) > 0 then
else
website = request.form("website") 
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
Membership= "free"



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



if len(PeopleID)> 0 then 
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

</head>

<body >

<% Current = "Home"
Current3="Register"
CurrentWebsite = "LivestockofCanada" 
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->

<% firstcolwidth = 300 %>
<table border = "0" cellspacing="0" cellpadding = "5" align = "center" width = 480" height = 480 valign = "top" >
   
<% 
if ExistingAccount = True then %>
<tr><td class = body valign = top>
<h2>Existing Account</h2>

There already is an account with email address <b><%=Peopleemail %></b>. To make changes to your account please <a href = "/members/" class = "body">Sign Into Your Account,</a> and make your changes there. <br><br>
<center><a href = "/members/" class = "regsubmit2">Sign Into Your Account </a></center>
</td></tr>

<% else %>
  <tr><td align = "center" valign = "top">
				<h2><center>Create Your Account</center></h2>
 </td><tr> 
<form  name=form method="post" action="SetupAccountFreestep3.asp">

<tr><td class = "body2" colspan = "2" align = "center">
<font color = "red"><b>*</font></b>= Required Field.
<% if len(Message) > 1 then %>
<br><font color = "red"><b><%=Message%></b></font>
<% end if %>
		</td>
	</tr>
<tr>
	<td class = "body2" align = "left" width = <%=firstcolwidth %>>
		Street Address
<br />
		<input name="AddressStreet"  size = "35" value = "<%=AddressStreet%>" width="450" style="width: 450px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2"  align = "left">
		Address 2
	<br />
		<input name="AddressApt"  size = "35" value = "<%=AddressApt%>" width="450" style="width: 450px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2" align = "left">
		City
		<br />
		<input name="AddressCity"  size = "35" value = "<%=AddressCity%>" width="450" style="width: 450px" class = "formbox">
	</td>
</tr>



<tr>
	<td  align = "left" class = "body2">
		<font color = "red"><b>*</font></b>Province
		<br />
		<select size="1" name="StateIndex" class=formbox width="300" style="width: 300px">


<% sql = "select *  from state_province where country_id = " & country_id & " order by name"
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

</br>
	</td>
</tr>
<tr>
	<td class = "body2" align = "left">
		Postal Code
	<br />
		<input name="AddressZip"  size = "35" value = "<%=AddressZip%>" width="450" style="width:450px" class = "formbox">
	</td>
</tr>


<tr>
	<td class = "body2" align = "left">
		<font color = "red"><b>*</font></b>Phone
		<br />
		<input name="PeoplePhone" size = "45" value = "<%=PeoplePhone%>" width="450" style="width:450px" class = "formbox">
	</td>
</tr>


<tr><td  align = "center" class = "body2" valign = "top" colspan = "2">
<center>
<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="password"  type= "hidden" value = "<%=password%>">
<input name="Membership"  type= "hidden" value = "free">

<input name="PeopleFirstName"  type= "hidden" value = "<%=PeopleFirstName%>">
<input name="PeopleLastName"  type= "hidden" value = "<%=PeopleLastName%>">
<input name="BusinessName"  type= "hidden" value = "<%=BusinessName%>">
<input name="PeopleWebsite"  type= "hidden" value = "<%=PeopleWebsite%>">
<input name="PeopleEmail"  type= "hidden" value = "<%=PeopleEmail%>">
<input name="Owners"  type= "hidden" value = "<%=Owners%>">


<% showcoupons  = false
if showcoupons = true then %>
You will have a chance to enter a coupon on the next page.<br />
<% end if %>
<br />
	<% if len(PeopleID)>0 then %>
		<input type=button value="Update Your Account" class = "regsubmit2" onclick="verify();">
	<% else %>
	<div align = right><input type=submit value="GO TO THE NEXT STEP ->" class = "regsubmit2"></div>
    <% end if %></center>

</td></tr>
</table>

	</form>
<br>

<% end if %>
</td>
</tr>
</table>

<% session("Confirmationsent") = False %>
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>