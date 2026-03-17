<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Associations & Clubs | Create Account</title>
<meta name="author" content="Livestock Of The World">
<link rel="stylesheet" type="text/css" href="/style.css">
<!--#Include Virtual="/includefiles/GlobalVariables.asp"-->
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.PeopleFirstName.value == "") {
themessage = themessage + " - Contact First Name \r";
}

if (document.form.PeopleLastName.value == "") {
    themessage = themessage + " - Contact Last Name \r";
}


if (document.form.Associationcountry.value == "") {
    themessage = themessage + " - Association Country \r";
}


if (document.form.PeopleEmail.value == "") {
themessage = themessage + " - Contact email \r";
}

if (document.form.ConfirmEmail.value == "") {
themessage = themessage + " - Confirm email \r";
}

if (document.form.PeopleEmail.value != document.form.ConfirmEmail.value) {
    themessage = themessage + " -Please check your email addresses; the confirmation entry does not match. \r";
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




<% Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")
dim CountryList(2000)
dim StateList(2000, 2000)
Dim statetotal(2000)

w = 1 
CountryList(w) =  "United States"
currentcountrycode = 1228

        x = 1 
        sql5 = "select * from  state_province where country_id = " & currentcountrycode & " order by trim(name)"
        StateListcounter = 1
        rs5.Open sql5, conn, 3, 3 

        While Not rs5.eof
        StateList(w, x) =  rs5("name") 
        rs5.movenext
        x = x + 1
        wend  
        rs5.close

statetotal(w) = x
w = w + 1


CountryList(w) =  "Canada"
currentcountrycode = 1039

        x = 1 
        sql5 = "select * from  state_province where country_id = " & currentcountrycode & " order by trim(name)"
        StateListcounter = 1
        rs5.Open sql5, conn, 3, 3 

        While Not rs5.eof
        StateList(w, x) =  rs5("name") 
        rs5.movenext
        x = x + 1
        wend  
        rs5.close

statetotal(w) = x
w = w + 1



 sql4 = "select * from country order by trim(name)"

CountryListcounter = 1
rs4.Open sql4, conn, 3, 3 

While Not rs4.eof
  CountryList(w) =  rs4("name") 
  currentcountrycode = rs4("country_id")

        x = 1 
        sql5 = "select * from  state_province where country_id = " & currentcountrycode & " order by trim(name)"
        StateListcounter = 1
        rs5.Open sql5, conn, 3, 3 

        While Not rs5.eof
        StateList(w, x) =  rs5("name") 
        rs5.movenext
        x = x + 1
        wend  
        rs5.close

statetotal(w) = x
rs4.movenext
 w = w + 1
wend  

 rs4.close
CountryTotal = w

 %>


<script type='text/javascript'>//<![CDATA[

// Countries

//var country_arr = new Array( "Canada",  "USA");

var country_arr = new Array(
<% w= 1
while w < CountryTotal  %>
"<%=CountryList(w) %>",
<% w = w + 1
wend %>
);

// States
//var s_a = new Array();
//s_a[0] = "";
//s_a[1] = "Alberta|British Columbia|Manitoba|New Brunswick|Newfoundland|Northwest Territories|Nova Scotia|Nunavut|Ontario|Prince Edward Island|Quebec|Saskatchewan|Yukon Territory";
//s_a[2] = "Alabama|Alaska|Arizona|Arkansas|California|Colorado|Connecticut|Delaware|District of Columbia|Florida|Georgia|Hawaii|Idaho|Illinois|Indiana|Iowa|Kansas|Kentucky|Louisiana|Maine|Maryland|Massachusetts|Michigan|Minnesota|Mississippi|Missouri|Montana|Nebraska|Nevada|New Hampshire|New Jersey|New Mexico|New York|North Carolina|North Dakota|Ohio|Oklahoma|Oregon|Pennsylvania|Rhode Island|South Carolina|South Dakota|Tennessee|Texas|Utah|Vermont|Virginia|Washington|West Virginia|Wisconsin|Wyoming";


// States
var s_a = new Array();
s_a[0] = "";

 <% w = 1 
 while w < (CountryTotal + 1)  %>
  s_a[<%=w %>] = "<%= StateList(w, 1) %> 
  <% x = 2
   while x < statetotal(w) %>
    <%= "|" & StateList(w, x) %> 
<% x = x + 1
 wend %>";
<% w = w + 1
wend %>



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


</head>
<body >
<% Current = "CreateAccount"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>
<!--#Include Virtual="/includefiles/Header.asp"-->
 <div class="container-fluid" style="max-width: 600px" >
<% 
existing = request.querystring("existing")
SpeciesID = Request.querystring("SpeciesID")

PeopleFirstName = Request.querystring("PeopleFirstName")
PeopleLastName = Request.querystring("PeopleLastName")
PeopleEmail = Request.querystring("PeopleEmail")
MemberPosition = Request.querystring("MemberPosition")
ConfirmEmail = Request.querystring("PeopleEmail")

AssociationContactPosition = Request.querystring("AssociationContactPosition")
AssociationName = Request.querystring("AssociationName")
Associationwebsite = Request.querystring("Associationwebsite") 
AssociationEmailaddress = Request.querystring("AssociationEmailaddress") 
AssociationAcronym= request.querystring("AssociationAcronym")
AddressStreet = Request.querystring("AddressStreet") 
AddressApt = Request.querystring("AddressApt") 
AddressCity  = Request.querystring("AddressCity")
AddressState  = Request.querystring("AddressState")
AddressCountry  = Request.querystring("AddressCountry")
AddressZip  = Request.querystring("AddressZip")
AssociationPhone  = Request.querystring("AssociationPhone")


if existing = "True" then
%>
<h2><center><font color = maroon>Account Already Exists</font></center></h2>
<center><font color = maroon>An association account with the email address <%=PeopleEmail  %> already exists. Please select</font> <a href = "/memberlogin.asp" class = "body">sign in</a><font color = maroon> to log into your account.</font><br><br /></center>
<% end if %>
<form  name=form method="post" action="SetupAssociationAccountStep2.asp?ReturnFileName=<%=ReturnFileName%>&ReturnEventID=<%=ReturnEventID%>">
 <div class="row form-group">
    <div class="col" style="background-color:eee0c4">
      <h2>Account Information</h2>

<% if len(Message) > 1 then %><br>
<font color = "maroon"><%=Message%></font>
<% end if %>
		
<font color = maroon>* </font><label for="PeopleFirstName">First Name</label><br />
<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>" placeholder="Enter First Name" width="300" style="width: 300px" class = formbox><br />
<font color = red>* </font>Last Name<br />
<input name="PeopleLastName" Value ="<%=PeopleLastName%>" placeholder = "Enter Last Name" width="300" style="width: 300px" class = formbox><br />
Ranch Name<br />
<input name="Businessname" Value ="<%=BusinessName%>"  placeholder ="Enter Your Ranch / Farm Name" width="300" style="width: 300px"  class = formbox><br />
Website<br /> 
<input name="PeopleWebsite" Value ="<%=PeopleWebsite%>"  placeholder ="Your Website" width="300" style="width: 300px"  class = "formbox"><br />
Phone<br />
<input name="PeoplePhone" Value ="<%=PeoplePhone%>"  placeholder ="Phone Number" width="300" style="width: 300px"  class = "formbox"><br />
Cell <br />
<input name="PeopleCell" Value ="<%=PeopleCell%>"  placeholder ="Your Cell Number" width="300" style="width: 300px"  class = "formbox"><br />
<font color = maroon>* </font>Email<br />
<input name="PeopleEmail"  placeholder ="Your Email Address" width="300" style="width: 300px" value = "<%=PeopleEmail %>" class = formbox><br />
<font color = maroon>* </font>Confirm Email<br />
<input name="ConfirmEmail"  placeholder ="Your Email Address" width="300" style="width: 300px"  value = "<%=PeopleEmail%>" class = formbox><br />
<input name="hidden" type="hidden" value="<%=password%>" maxlength = 12 >
<input name="confirm" type="hidden" value="<%=password%>"  maxlength = 12 >
Mailing Address <br />
<input name="AddressStreet"   placeholder = "Your Street Address" width="300" style="width: 300px"  value = "<%=AddressStreet%>" class = formbox><br />
Apartment / Suite <br />
<input name="AddressApt"  placeholder ="Street Address 2"  width="300" style="width: 300px"  value = "<%=AddressApt%>" class = formbox><br />
City <br />
<input name="AddressCity"  placeholder = "City" placeholder = =   width="300" style="width: 300px"  value = "<%=AddressCity%>" class = formbox><br />
<font color = "maroon">*</font>Country<br />
<select id="country" name="country"  placeholder = "Country" width="300" style="width: 300px" class = "formbox"></select><br />
<font color = "maroon">*</font>State / Province<br />
<select name="state" id="state"  width="300" style="width: 300px"  class = "formbox"></select>
<br/>
  <script language="javascript">
      populateCountries("country", "state");
  </script>
<br />
Postal Code<br />
<input name="AddressZip"  placeholder ="Postal Code" width="300" style="width: 300px"  value = "<%=AddressZip%>" class = formbox><br />

<h2>Association Information</h2>
As the creator of the associations account, you will have administrative rights to the account.<br /><br />

<font color = maroon>* </font>Organization's Name<br />
<input name="AssociationName"  placeholder ="The Name of Your Association" width="300" style="width: 300px"  value = "<%=AssociationName %>" class = formbox><br />
Organization's Acronym<br />
<input name="AssociationAcronym"   placeholder ="Your Association's Acronym" width="300" style="width: 300px"  value = "<%=AssociationAcronym %>" class = formbox><br />
Your Position<br />
<input name="MemberPosition"  placeholder = "Your Position in the Association" Value ="<%=MemberPosition%>"   width="300" style="width: 300px" class = formbox><br />
Organization's Website<br />
<input name="Associationwebsite"  placeholder ="Your Association's Website" Value ="<%=Associationwebsite%>"   width="300" style="width: 300px" class = formbox><br />
Association	Email<br />
<input name="AssociationEmailaddress"  placeholder ="Your Association's Contact Email Address" width="300" style="width: 300px" value = "<%=AssociationEmailaddress%>" class = formbox ><br />
Organization's Phone<br />
<input name="AssociationPhone" placeholder ="Your Association's Contact Phone Number" width="300" style="width: 300px" value = "<%=AssociationPhone%>" class = formbox><br />
Association's Address<br />
Mailing Address <br />
<input name="AssociationStreet1" placeholder ="Your association's street address" width="300" style="width: 300px" value = "<%=AddressStreet%>" class = formbox><br />
Street 2<br />
<input name="AssociationStreet2" placeholder ="Street address 2" width="300" style="width: 300px" value = "<%=AssociationStreet2%>" class = formbox><br />
City <br />
<input name="AssociationCity" placeholder ="The city that your association is in" width="300" style="width: 300px" value = "<%=AssociationCity%>" class = formbox><br />
<font color = "red">*</font>Country<br />
<select id="Associationcountry" placeholder ="The country that your association is in" name="Associationcountry" width="300" style="width: 300px" class = "formbox"></select><br />
<font color = "red">*</font>State/ Province<br />
<select name="AssociationState" placeholder ="The state or province that your association is in" id="AssociationState" width="300" style="width: 300px" class = "formbox"></select><br />
        <script language="javascript">
            populateCountries("Associationcountry", "AssociationState");
        </script>

Postal Code <br />
		<input name="AssociationZip" placeholder ="Postal code" size = "30" value = "<%=AssociationZip%>" class = formbox><br />

<% 
' begin random function
randomize

' random numbers is the varible that will contain a numeriv value
' between one and nine
random_number=int(rnd*10)
Select Case random_number
Case 0
 MIMage = "/images/X987045.jpg"
Case 1 
 MIMage = "/images/X583198.jpg"
 Case 2 
 MIMage = "/images/X949256.jpg"
 Case 3 
 MIMage = "/images/X096367.jpg"
 Case 4 
 MIMage = "/images/X583198.jpg"
 Case 5 
 MIMage = "/images/X912578.jpg"
Case 6 
 MIMage = "/images/X234697.jpg"
Case 7 
 MIMage = "/images/X781736.jpg"
Case 8 
 MIMage = "/images/X987834.jpg"
Case 9 
 MIMage = "/images/X983999.jpg"
End Select

' write the random number out to the browser
%>
<table width = "320"  align = "center" border="0"  cellspacing="0" cellpadding=5 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<tr><td colspan = "2" class = "body2" align = "center">
<font color = red>*</font> Are You Human?<br />
Please answer the math question below:
 </td>
</tr> 
<tr>
    <td align = "right" valign = top>
        <img src = "<%=MIMage %>" alt = "Contact Us" valign = "bottom">
    </td>
    <td valign = top>
<INPUT TYPE="TEXT" NAME="fieldX" size="3">
        <INPUT TYPE="hidden" NAME="Question" Value="<%=MIMage %>">	     
    </td>
 </tr>


<tr><td  align = "center" class = "body2" valign = "top" colspan = 2>
<br />
<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership"  type= "hidden" value = "<%=Membership%>">
	<input type=button value="CREATE ACCOUNT"  onclick="verify();" class = "regsubmit2">
</center>
    <br /><br />
<div align = "left">Your privacy is important to us! We will not share your email address without your permission.</div>
</td></tr>


</table>

	</form>
<br>
<br /><br />
<%   conn.close
  set conn = nothing %>
<!--#Include Virtual="/includefiles/Footer.asp"--> </body>
</HTML>