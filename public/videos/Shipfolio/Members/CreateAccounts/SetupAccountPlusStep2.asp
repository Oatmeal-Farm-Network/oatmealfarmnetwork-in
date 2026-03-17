<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ Language="VBScript" %> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%  PageName = "Registry" %>
	 <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<meta http-equiv="Content-Language" content="en-us">
<title>Create Account - <%=WebSiteName %> Online Animal Marketplaces</title>
<meta name="Title" content="Create Account - <%=WebSiteName %>">
<meta name="description" content="Create your account at <%=WebSiteName %> ." >
<meta name="robots" content="index, nofollow">
<meta name="revisit-after" content="never">
<meta name="author" content="Global Grange Inc.">
<link rel="stylesheet" type="text/css" href="/includefiles/Style.css">

	    <script>
        function validateInput(event) {
            const input = event.target;
            input.value = input.value.replace(/[^0-9]/g, ''); // Remove non-numeric characters
            if (input.value.length > 20) {
                input.value = input.value.slice(0, 20); // Truncate to 20 characters
            }
        }
    </script>

</head>
<body >


<!--#Include virtual="/Header.asp"-->

<% 
country_id = Request.form("country_id")
BusinessTypeID = request.form("BusinessTypeID")
response.write("BusinessTypeID=" & BusinessTypeID )
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


sql = "select * from Country where country_id = '" & country_id & "'"
'response.write("sql=" & sql & "<br>")

rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
ProvinceTitle = rs("ProvinceTitle")
end if
rs.close


websitesignupcount = 0
Membership = request.Form("Membership")
if len(Membership) < 2 then
Membership = request.querystring("Membership")
end if


BusinessName = Request.form("BusinessName")
variables = variables &  "&BusinessName=" & BusinessName
BusinessWebsite = Request.form("BusinessWebsite")
variables = variables &  "&BusinessWebsite=" & BusinessWebsite
BusinessEmail  = Request.form("BusinessEmail")
variables = variables & "&BusinessEmail=" & BusinessEmail


AddressStreet=request.querystring("AddressStreet")
variables = variables &  "&AddressStreet=" & AddressStreet
AddressApt=request.querystring("AddressApt")
variables = variables &  "&AddressApt=" & AddressApt
AddressCity=request.querystring("AddressCity")
variables = variables &  "&AddressCity=" & AddressCity
AddressZip=request.querystring("AddressZip")
variables = variables &  "&AddressZip=" & AddressZip
BusinessPhone=request.querystring("BusinessPhone")
variables = variables &  "&BusinessPhone=" & BusinessPhone
ConfirmEmail = Request.form("ConfirmEmail")
variables = variables &  "&ConfirmEmail=" & ConfirmEmail

Stepback = Request.querystring("Stepback")


MissingData = False
if len(BusinessFirstName) > 2 then
else
missing = "&MissingBusinessFirstName=True"
MissingData = True
end if

if len(BusinessLastName) > 2 then
else
missing = "&MissingBusinessLastName=True"
MissingData = True
end if

if len(BusinessEmail) > 2 then
else
missing = "&MissingBusinessEmail=True"
MissingData = True
end if


If BusinessEmail = ConfirmEmail then
 EmailsMatch=True
else
 EmailsMatch=False
end if


'response.write("Stepback=" & Stepback)

if (MissingData = True or  EmailsMatch=False)  then
'response.redirect("SetupAccountPlus.asp?stepback=True&Membership=" & Membership & "&EmailsMatch=" & EmailsMatch & variables )
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


	
Subscription = Request.querystring("Subscription") 
ReturnFileName = Request.querystring("ReturnFileName") 
ReturnEventID = Request.querystring("ReturnEventID") 
Update = Request.querystring("Update") 

'BusinessID = request.querystring("BusinessID")
Message = request.querystring("Message")

%>


<div class="container-fluid"  >
  <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Setup Account</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
<br />

<div class = "container roundedtopandbottom mx-auto" style="max-width:450px" >


<div class = "col" >
  <form  name=form method="post" action="SetupAccountPlusstep3.asp?Subscription=<%=Subscription%>">
 <% StateIndexFound = Request.querystring("StateIndexFound")
 if StateIndexFound = False and Stepback2 = "True" then  %>
 <font color = "maroon"><br /><b>Please select your <%=ProvinceTitle %>.</b></font>
 <% end if %>
 

<% 
MissingProvince = request.querystring("MissingProvince")

if MissingProvince = "True" and Stepback2 = "True" then %>
<br><font color = "maroon"><b>Please select your <%=ProvinceTitle %>.</b></font>
<% end if %>
<b>Organization's Address</b><br />
<div class="form-group"><br />
    <label for="AddressStreet">Street</label>
    <input type="Text" name="AddressStreet" class="form-control" id="AddressStreet" Value ="<%=AddressStreet%>" required>
</div>

<div class="form-group"><br />
    <label for="AddressApt">Address2 <font color= "#abacab">(Optional)</font></label>
    <input type="Text" name="AddressApt" class="form-control" id="AddressApt" Value ="<%=AddressApt%>" >
</div>		

<div class="form-group"><br />
    <label for="AddressCity">City</label>
    <input type="Text" name="AddressCity" class="form-control" id="AddressCity" Value ="<%=AddressCity%>" required>
</div>	


<div class="form-group"><br />
    <label for="StateIndex"><%=	ProvinceTitle %></label>
<br /><select size="1" name="StateIndex" class="form-control" width="250" style="width: 250px" required>
<option value="" > </option>

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
    <label for="AddressZip">Postal Code <font color= "#abacab">(Optional)</font></label>
    <input type="Text" name="AddressZip" class="form-control" id="AddressZip" Value ="<%=AddressZip%>" >
</div>	


<div class="form-group"><br />
	<label for="phoneField">Phone</label><br />
	<input type="text" id="numericInput" oninput="validateInput(event)" title="BusinessPhone" name="BusinessPhone" class="form-control" required>

</div>

<script>
function validatePhone() {
  var phoneField = document.getElementById('phoneField');
  var phoneValue = phoneField.value;

  var regex = /^[0-9()-]+$/-.;

  if (!regex.test(phoneValue)) {
    phoneField.setCustomValidity("Please enter a valid phone number.");
  } else {
    phoneField.setCustomValidity("");
  }
}
</script>



	<br />
<style>
  .custom-checkbox input[type="checkbox"] {
    background-color: #517031;
  }
</style>


<label class="custom-checkbox">
  <input type="checkbox" id="permissionCheckbox" Name="Permission" checked>
  Yes, you have my permission to share my listings in mass emails and on social media.
</label>
	<% if BusinessTypeID = 8 then %>  <br /> <br />
<label class="custom-checkbox">
  <input type="checkbox" id="disclaimerCheckbox" Name="LivestockLegalDisclaimer" required>
  <b>Livestock Legal Disclaimer:</b> I acknowledge and agree that I am solely responsible for negotiating all livestock sales. Global Grange Inc. bears no legal responsibility for any facet of such sales as well as any ensuing consequences arising from said transactions.
</label>
	   <br /> <br />
<label class="custom-checkbox">
  <input type="checkbox" id="disclaimerCheckbox" Name="SalesLegalDisclaimer" required>
  <b>Sales Legal Disclaimer:</b> I acknowledge and agree that Global Grange Inc. bears no legal responsibility for any facet of sales, including but not limited to the sale of livestock, eggs, fiber/wool, products, and services, as well as any ensuing consequences arising from said transactions.
</label>

	   <br /> <br />
<% end if %>


<input name="BusinessWebsite" type = "hidden"  value = "<%=BusinessWebsite%>"/>
<input name="BusinessName"  type= "hidden" value = "<%=BusinessName%>"/>
<input name="BusinessTypeID"  type= "text" value = "<%=BusinessTypeID%>"/>
      
<input name="BusinessEmail" type= "text" value = "<%=BusinessEmail %>"/>

<input name="Membership" type= "hidden" value = "<%=Membership %>"/>

<br />

	<div align = center><input type=submit value="Next" class = "submitbutton"></div>
	</form>
<br><br>
</div>
</div>
<br>


<% session("Confirmationsent") = False %>

<!--#Include virtual="/Footer.asp"--> </body>
</HTML>