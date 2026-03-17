<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
<!--#Include file="GlobalVariables.asp"-->
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
if (document.form.PeopleFirstName.value=="") {
themessage = themessage + " - First Name \r";
}
if (document.form.PeopleEmail.value=="") {
themessage = themessage + " - Email \r";
}

if (document.form.ConfirmEmail.value == "") {
themessage = themessage + " - Confirm Email \r";
}

if (document.form.country.value == "") {
    themessage = themessage + " - Country \r";
}

if (document.form.AddressStreet.value == "") {
    themessage = themessage + " - Street Address \r";
}

if (document.form.AddressState.value == "") {
    themessage = themessage + " - State \r";
}
if (document.form.AddressZip.value == "") {
    themessage = themessage + " - Zip Code \r";
}
if (document.form.AddressCity.value == "") {
    themessage = themessage + " - City \r";
}

if (document.form.BusinessName.value == "") {
    themessage = themessage + " - Ranch / Farm Name \r";
}

if (document.form.PeoplePhone.value == "") {
    themessage = themessage + " - Phone \r";
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

if (document.form.LeftShoe.value.length < 8 ) {
    themessage = themessage + " - Your PASSWORD must be at least 8 digits long. \r";
}

if (document.form.LeftShoe.value != document.form.RightShoe.value) {
    themessage = themessage +  " - Your PASSWORD entries do not match. \r";
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



<script type='text/javascript'>//<![CDATA[

// Countries

var country_arr = new Array( "Canada",  "USA");



// States
var s_a = new Array();
s_a[0] = "";
s_a[1] = "Alberta|British Columbia|Manitoba|New Brunswick|Newfoundland|Northwest Territories|Nova Scotia|Nunavut|Ontario|Prince Edward Island|Quebec|Saskatchewan|Yukon Territory";
s_a[2] = "Alabama|Alaska|Arizona|Arkansas|California|Colorado|Connecticut|Delaware|District of Columbia|Florida|Georgia|Hawaii|Idaho|Illinois|Indiana|Iowa|Kansas|Kentucky|Louisiana|Maine|Maryland|Massachusetts|Michigan|Minnesota|Mississippi|Missouri|Montana|Nebraska|Nevada|New Hampshire|New Jersey|New Mexico|New York|North Carolina|North Dakota|Ohio|Oklahoma|Oregon|Pennsylvania|Rhode Island|South Carolina|South Dakota|Tennessee|Texas|Utah|Vermont|Virginia|Washington|West Virginia|Wisconsin|Wyoming";

function populateStates(countryElementId, stateElementId) {

    var selectedCountryIndex = document.getElementById(countryElementId).selectedIndex;

    var stateElement = document.getElementById(stateElementId);

    stateElement.length = 0; // Fixed by Julian Woods
    stateElement.options[0] = new Option('Select State/Province', '');
    stateElement.selectedIndex = 0;

    var state_arr = s_a[selectedCountryIndex].split("|");

    for (var i = 0; i < state_arr.length; i++) {
        stateElement.options[stateElement.length] = new Option(state_arr[i], state_arr[i]);
    }
}

function populateCountries(countryElementId, stateElementId) {
    // given the id of the <select> tag as function argument, it inserts <option> tags
    var countryElement = document.getElementById(countryElementId);
    countryElement.length = 0;
    countryElement.options[0] = new Option('Select Country', '-1');
    countryElement.selectedIndex = 0;
    for (var i = 0; i < country_arr.length; i++) {
        countryElement.options[countryElement.length] = new Option(country_arr[i], country_arr[i]);
    }

    // Assigned all countries. Now assign event listener for the states.

    if (stateElementId) {
        countryElement.onchange = function () {
            populateStates(countryElementId, stateElementId);
        };
    }
}
//]]> 

</script>



<% 
websitesignupcount = 0

website = request.querystring("website") 

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
Membership= request.querystring("Membership")
if len(membership) > 0 then
else
  response.redirect("rates2.asp")
  end if

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
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&website=<%=website %>&Membership=<%=Membership %>&peopleId=<%=peopleId %>');" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if%>
<% Current = "Home"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False
session("Peopleid") = ""
%>
<!--#Include virtual="/Header.asp"-->
<% if screenwidth > 700 then %>
<!--#Include virtual="/join/JoinHeader.asp"-->
<% end if %> 


<% firstcolwidth = 300 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  valign = "top" ><tr><td align = "left" valign = "top">
		<h1>Create Your Account</h1>
        
<form  name=form method="post" action="SetupAccountStep2.asp">
<table border = "0" width = "<%=screenwidth %>" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=5 >
<tr><td class = "body2" colspan = "2" align = "center">
Please enter your information below:<br />
<font color = "red">*</font><b>Indicates Required Fields.</b>
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
<td class = "body2" align = "right" width = <%=firstcolwidth %> >
<font color = "DarkGreen"><b>First Name</b></font>
</td>
				<td class = "body2" align = "left" >
					<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>" width="200" style="width: 200px" class = "formbox">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">
					<font color = "DarkGreen"><b>Last Name</b></font>
				</td>
				<td class = "body2" align = "left">
					<input name="PeopleLastName" Value ="<%=PeopleLastName%>"  width="200" style="width: 200px" class = "formbox">
				</td>
			</tr>
<% if not (lcase(Membership)="kids") then %>
			<tr>
				<td class = "body2" align = "right">
					<a class="tooltip" href="#">Owners&nbsp;<span class="custom info body"><div align = "left"><em>Owners:</em>List the whole team (i.e. Hank and Joanne Jones,  Jebediah and Frankie Espanoza, and Bob)</div></b></span></a>
				</td>
				<td class = "body2" align = "left">
					<input name="Owners" Value ="<%=Owners%>"   width="200" style="width: 200px" class = "formbox">
				</td>
			</tr>
            <% end if %>
<% if not (lcase(Membership)="kids") then %>
		<tr> 
            <td class = "body2" align = "right">
				<font color = "DarkGreen"><b>Ranch / Farm Name</b></font>
			</td>
			<td height="20" class = "body"  align = "left"> 
 				<input name="BusinessName" size = "35" value = "<%=BusinessName %>" width="200" style="width: 200px" class = "formbox">
			</td>
		</tr>	
  <% end if %>	
  <% if not (lcase(Membership)="kids") then %>
<tr>
	<td class = "body2" align = "right">
			Website 
		</td>
		<td class = "body2" align = "left">
			<input name="PeopleWebsite" Value ="<%=PeopleWebsite%>"  width="200" style="width: 200px" class = "formbox">
		</td>
	</tr>
   <% end if %>
	<tr>
		<td   class = "body2" align = "right">
<% if not (lcase(Membership)="kids") then %>
			<font color = "DarkGreen"><b>Email:</b></font>
<% else %>
	Email or Parents Email
<% end if  %>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="PeopleEmail"  size = "30" value = "<%=PeopleEmail%>" width="200" style="width: 200px" class = "formbox">
		</td>
</tr>
<tr>
		<td class = "body2" align = "right">
			<font color = "DarkGreen"><b>Confirm Email</b></font>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="ConfirmEmail"  size = "30" value = "<%=PeopleEmail%>" width="200" style="width: 200px" class = "formbox">
		</td>
</tr>

<tr>
		<td class = "body2" align = "right">
			<font color = "DarkGreen"><b>Password</b></font>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="LeftShoe" type="password" value="<%=password%>" maxlength = 12 width="130" style="width: 130px" class = "formbox">
           <br /><font color = '#404040'><i>Must be at least 8 digits long.</font></i>
		</td>
</tr>

<tr>
		<td class = "body2" align = "right">
			<font color = "DarkGreen"><b>Confirm Password</b></font>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="RightShoe" type="password" value="<%=password%>"  maxlength = 12 width="130" style="width: 130px" class = "formbox">
		</td>
</tr>




<% 
showreferrals = false
if showreferrals = True then

if not (lcase(Membership)="kids") then %>
<tr>
		<td class ="body2"  height = "30" align = "right">
			I was referred by:
		</td>
        <td class ="body2"  height = "30" >
        <%dim PeopleIDArray(100000) 
dim BusinessNameArray(100000) 
if len(ReferringPeopleID) > 0 and not (ReferringPeopleID="notselected") then
sql = "SELECT People.PeopleId, Business.BusinessName from People, Business where People.BusinessID = Business.BusinessID and People.AISubscription = True and PeopleID = " & ReferringPeopleID
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3 
 i = 1
if Not rs.eof then
ReferringBusinessName = rs("BusinessName")
end if
end if

sql = "SELECT People.PeopleId, Business.BusinessName from People, Business where People.BusinessID = Business.BusinessID and People.AISubscription = True and  AIPublish = True and length(Business.BusinessName) > 2 order by BusinessName" 
	'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, Conn, 3, 3 
 i = 1
 While Not rs.eof 
PeopleIDArray(i) = rs("PeopleID")
BusinessNameArray(i) = rs("BusinessName")
if len(BusinessNameArray(i)) > 1 then
For loopi=1 to Len(BusinessNameArray(i))
spec = Mid(BusinessNameArray(i), loopi, 1)
specchar = ASC(spec)
if specchar < 32 or specchar > 126 then
	BusinessNameArray(i)= Replace(BusinessNameArray(i),spec, " ")
 end if
 Next
end if
i = i + 1
rs.movenext
Wend 
rs.close 


%>	

<select size="1" name="ReferringPeopleID" class = "formbox">
<% if len(ReferringBusinessName ) > 0 then %>
<option  value='<%=ReferringPeopleID %>' selected><%=ReferringBusinessName %></option>
<% else %>
<option selected=selected  value='notselected'>Select a ranch if appropriate.</option>
<% end if %>
<option  value='1016'>Andresen Group Livestock Brokering</option>
<%  x = 1
	  While x < i %>
	<option  value='<%=PeopleIDArray(x) %>'><%=BusinessNameArray(x) %></option>
<%	x = x +1
       Wend %>	  					  
</select>

        </td>
	</tr>
   <% else %>
   <tr><td class = "body2" align = 'right'>
   <input type="checkbox" name="verification" value="Under18" class = "formbox"></td>
   <td class = "body" ><br />
I certify that I am under 18 years of age. This free membership is available only to minors.<br>

   </td></tr>

	<% end if %>
<% end if%>


   

</table>

</td>

<% if screenwidth < 800 then %>
</tr>
<tr>
<% end if %>
<td  valign = "Top">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=0 " >
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<br>
		</td>
	</tr>

<tr>
	<td class = "body2" align = "right" width = <%=firstcolwidth %>>
		<font color = "DarkGreen"><b>Street Address</b></font>
	</td>
    <td align = "left" valign = "top" class = "body2">
		<input name="AddressStreet"  size = "30" value = "<%=AddressStreet%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2"  align = "right">
		<font color = "DarkGreen"><b>Apartment / Suite</b></font>
	</td>
	<td valign = "top" class = "body2" align = "left">
		<input name="AddressApt"  size = "30" value = "<%=AddressApt%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2" align = "right">
		<font color = "DarkGreen"><b>City</b></font>
	</td>
	<td align = "left"  valign = "top" class = "body2">
		<input name="AddressCity"  size = "30" value = "<%=AddressCity%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2" align = "right">
		<font color = "DarkGreen"><b>Postal Code</font>
	</td>
	<td  align = "left" valign = "top" class = "body2">
		<input name="AddressZip"  size = "8" value = "<%=AddressZip%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>

<tr>
	<td align = "right" class = "body2">
		<font color = "DarkGreen"><b>Country</b></font>	
	</td>
	<td  align = "left" valign = "top" class = "body2">
        <select id="country" name="country" width="230" style="width: 230px" class = "formbox"></select>
</tr>

<tr>
	<td  align = "right" class = "body2">
		<font color = "DarkGreen"><b>State/ Province</b></font>
	</td>
	<td  align = "left" valign = "top" class = "body2">
		<select name="AddressState" id="state" width="230" style="width: 230px" class = "formbox"></select>
        <br/>
        <script language="javascript">
            populateCountries("country", "state");
            populateCountries("country2");
        </script>
	</td>
</tr>



<tr>
	<td class = "body2" align = "right">
		<font color = "DarkGreen"><b>Phone</b></font>
	</td>
	<td align = "left" valign = "top" class = "body2">
		<input name="PeoplePhone"  size = "30" value = "<%=PeoplePhone%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>
<tr>
	<td class = "body2" align = "right">
		Cell
	</td>
	<td align = "left" valign = "top" class = "body2">
		<input name="PeopleCell"  size = "30" value = "<%=PeopleCell%>" width="210" style="width: 210px" class = "formbox">
	</td>
</tr>
</table>
</td></tr>
<tr><td  align = "center" class = "body2" valign = "top" colspan = "2">
<center>
<input name="website" type = "hidden"  value = "<%=website%>">
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">
<% showcoupons  = false
if showcoupons = true then %>
You will have a chance to enter a coupon on the next page.<br />
<% end if %>
<br />
	<% if len(PeopleID)>0 then %>
		<input type=button value="Update Your Account" class = "regsubmit2" onclick="verify();">
	<% else %>
	<input type=button value="CREATE YOUR ACCOUNT"  onclick="verify();" class = "regsubmit2">
    <% end if %></center>
</td></tr>
</table>

	</form>
<br>
</td>
</tr>
</table>


<!--#Include virtual="/Footer.asp"--> </body>
</HTML>