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
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="Style.css">

<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";


        if (document.form.StateIndex.value == "") {
            themessage = themessage + " - State \r";
        }

 
        if (document.form.PeoplePhone.value == "") {
            themessage = themessage + " - Phone \r";
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

PeopleFirstName = request.form("PeopleFirstName") 
PeopleLastName = request.form("PeoplelastName") 
Owners = Request.form("Owners")
BusinessName = Request.form("BusinessName")
PeopleWebsite = Request.form("PeopleWebsite")
country = Request.form("country")
country_id = Request.form("country_id")



PeopleEmail  = Request.form("PeopleEmail")
ConfirmEmail = Request.form("ConfirmEmail")
password =Request.form("LeftShoe")


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
CurrentWebsite = "LivestockofAmerica" 
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
		<font color = "red"><b>*</font></b><b>State</b>
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
	<td align = "left" valign = top class = "body2">
		<font color = "red"><b>*</font></b><b>Country</b>
		<br />
               USA
               <input name="country_id"  type= "hidden" value = "1228">
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
		<font color = "red"><b>*</font>Phone</b>
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
	<div align = right><input type=button value="GO TO THE NEXT STEP ->"  onclick="verify();" class = "regsubmit2"></div>
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