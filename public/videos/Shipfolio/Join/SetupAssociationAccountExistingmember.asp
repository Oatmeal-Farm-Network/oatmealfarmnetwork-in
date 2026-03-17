<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/globalvariables.asp"-->
<title>Create an Association Account</title>

<meta charset="UTF-8">
<meta name="revisit-after" content="7 Days"/>
<link rel="stylesheet" type="text/css" href="style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="Content-Language" content="en-us">
<% Region = Request.querystring("Region") %>

</head>
<body >
<!--#Include virtual="/Header.asp"-->

<% Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")
%>

<% 

Current = "CreateAccount"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>

<% Set rs2 = Server.CreateObject("ADODB.Recordset")

PeopleEmail=Trim(Request.Form("PeopleEmail")) 
PeoplePassword=Trim(Request.Form("PeoplePassword")) 

if len(PeopleEmail) > 0 then
else
PeopleEmail = request.querystring("PeopleEmail")
end if


if len(PeoplePassword) > 0 then
else
PeoplePassword = request.querystring("PeoplePassword")
end if
'response.write("PeopleEmail=" & PeopleEmail)
'response.write("PeoplePassword=" & PeoplePassword)


'if len(peopleid) > 0 then
'else

if len(Email) < 5 or len(password) < 8 then
  fail = "True"
  'response.Redirect("SetupAssociationAccountStep1.asp?AssociationError=True")
else
  fail = "False"
end if 

	
sql2 = "select * from  People where people.accesslevel > 0 and trim(lower(PeopleEmail)) = '" & trim(lcase(PeopleEmail)) & "'  and peoplePassword = '" & PeoplePassword & "'"
'response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if rs2.eof Then
	
   Session("WebsiteAccess")=False
fail ="True"
	else 

	'	response.write("custemail=" & rs2("Email") & " ")
	'response.write("custPasswd=" & rs2("Password"))
PeopleID = rs2("PeopleID")
Session("PeopleID")= rs2("PeopleID")
Session("WebsiteAccess")=True

'end if

rs2.close

'response.write("fail=" & fail )

end if


If fail ="True" then
'response.Redirect("SetupAssociationAccountStep1.asp?AssociationError=True")
End If
'Response.write("Region=" & Region)

 %>


 <div class="container-fluid" style="max-width: 600px" >
<h1>Create an Association Account</h1>
   <div class="row">
    <div class="col" style="background-color:eee0c4">

<% Region = Request.form("Region")
if len(Region) < 3 then
    Region = Request.querystring("Region")
end if 

sql = "select * from Country where name = '" & Region & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
AssociationCountry  = rs("name")
country_id = rs("country_id")
end if
rs.close

'response.write("Region=" & Region )

existing = request.querystring("existing")
SpeciesID = Request.querystring("SpeciesID")

PeopleFirstName = Request.querystring("PeopleFirstName")
PeopleLastName = Request.querystring("PeopleLastName")
'PeopleEmail = Request.querystring("PeopleEmail")
MemberPosition = Request.querystring("MemberPosition")
'ConfirmEmail = Request.querystring("PeopleEmail")

AssociationContactPosition = Request.Form("AssociationContactPosition")
if len(AssociationContactPosition) < 1 then
AssociationContactPosition = Request.querystring("AssociationContactPosition")
end if

AssociationName = Request.Form("AssociationName")
if len(AssociationName) < 1 then
AssociationName = Request.querystring("AssociationName")
end if

Associationwebsite = Request.Form("Associationwebsite") 
if len(Associationwebsite) < 1 then
Associationwebsite = Request.querystring("Associationwebsite")
end if

AssociationEmailaddress = Request.Form("AssociationEmailaddress")
if len(AssociationEmailaddress) < 1 then
AssociationEmailaddress = Request.querystring("AssociationEmailaddress")
end if
 
AssociationAcronym = request.form("AssociationAcronym")
if len(AssociationAcronym) < 1 then
AssociationAcronym = Request.querystring("AssociationAcronym")
end if

AssociationStreet = Request.Form("AssociationStreet")
if len(AssociationStreet) < 1 then
AssociationStreet = Request.querystring("AssociationStreet")
end if
 
AssociationApt = Request.Form("AssociationApt")
if len(AssociationApt) < 1 then
AssociationApt = Request.querystring("AssociationApt")
end if
 
AssociationCity  = Request.Form("AssociationCity")
if len(AssociationCity) < 1 then
AssociationCity = Request.querystring("AssociationCity")
end if

AssociationState  = Request.Form("StateIndex")
if len(AssociationState) < 1 then
AssociationState = Request.querystring("AssociationState")
end if

AssociationCountry  = Request.Form("Country")
if len(AssociationCountry) < 1 then
AssociationCountry = Request.querystring("AssociationCountry")
end if

AddressZip  = Request.Form("AddressZip")
if len(AddressZip) < 1 then
AddressZip = Request.querystring("AddressZip")
end if

AssociationPhone  = Request.Form("AssociationPhone")
if len(AssociationPhone) < 1 then
AssociationPhone = Request.querystring("AssociationPhone")
end if

PeopleWebsite = request.form("PeopleWebsite")
if len(PeopleWebsite) < 1 then
PeopleWebsite = Request.querystring("PeopleWebsite")
end if
AddressStreet = Request.querystring("AddressStreet") 
AddressApt = Request.querystring("AddressApt") 
AddressCity  = Request.querystring("AddressCity")
State  = Request.querystring("State")
Country  = Request.querystring("Country")
AssociationPhone  = Request.querystring("AssociationPhone")


if existing = "True" then
%>
<h2><center><font color = maroon>Account Already Exists</font></center></h2><center><font color = maroon>An association account with the email address <b><%=PeopleEmail  %></b> already exists. Please select</font> <a href = "/memberlogin.asp" class = "body"><b>sign in</b></a><font color = maroon> to log into your account.</font><br><br /></center>
<% end if %>

<%
Message = request.querystring("Message")
if len(Message) > 1 then
%>
<h2><center><font color = maroon><b><%=Message  %></b> </font></h2><br></center>
<% end if %>


<form name=form method="post" action="SetupAssociationAccountExistingmemberStep2.asp">
<b>As the creator of the associations account, you will have administrative rights to the account.</b><br />

<div class="form-group"><br />
    <label for="AssociationName">Association's Name<font color = maroon><b>*</b></font></label>
    <input type="Text" name="AssociationName" class="form-control" id="AssociationName" Value ="<%=AssociationName%>" placeholder="Your organization's name.">
</div>

<div class="form-group"><br />
    <label for="AssociationAcronym">Acronym</label>
    <input type="Text" name="AssociationAcronym" class="form-control" id="AssociationAcronym" Value ="<%=AssociationAcronym%>" placeholder="Your acronym.">
</div>

<div class="form-group"><br />
    <label for="MemberPosition">Your Position</label>
    <input type="Text" name="MemberPosition" class="form-control" id="MemberPosition" Value ="<%=MemberPosition%>" placeholder="Your position in the organization.">
</div>

<div class="form-group"><br />
    <label for="Associationwebsite">Association's Website</label>
    <input type="Text" name="Associationwebsite" class="form-control" id="Associationwebsite" Value ="<%=MemberPosition%>" placeholder="Your organization's website.">
</div>

<div class="form-group"><br />
    <label for="AssociationEmailaddress">Association Email</label>
    <input type="Text" name="AssociationEmailaddress" class="form-control" id="AssociationEmailaddress" Value ="<%=MemberPosition%>" placeholder="Your organization's primary contact email.">
</div>

<div class="form-group"><br />
    <label for="AssociationPhone">Association's Phone</label>
    <input type="Text" name="AssociationPhone" class="form-control" id="AssociationPhone" Value ="<%=MemberPosition%>" placeholder="Your organization's phone number.">
</div>
<br />
<br />
<h3>Mailing Address</h3>
<div class="form-group">
    <label for="AAssociationStreet1">Street</label>
    <input type="Text" name="AssociationStreet1" class="form-control" id="AssociationStreet1" Value ="<%=AssociationStreet1%>" placeholder="Your organization's street address.">
</div>
<div class="form-group"><br />
    <label for="AssociationStreet2">Street 2</label>
    <input type="Text" name="AssociationStreet2" class="form-control" id="AssociationStreet2" Value ="<%=AssociationStreet1%>" placeholder="Bonus address line.">
</div>

<div class="form-group"><br />
    <label for="AssociationCity">Street 2</label>
    <input type="Text" name="AssociationCity" class="form-control" id="AssociationCity" Value ="<%=AssociationStreet1%>" placeholder="City">
</div>




<% sql = "select *  from country where country_id = " & country_id
if len(country_id) > 1 then
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
AssociationCountry = rs("name")
end if
end if 
if country_id= 1228 then
   ProvidenceName="State"
else
   ProvidenceName="Province"
end if

%>
<input name="AssociationCountry"  value = "<%=AssociationCountry%>" type = "hidden">


<div class="form-group"><br />
    <label for="StateIndex"><%=ProvidenceName %></label><br />
<select size="1" name="StateIndex" class=formbox width="300" style="width: 300px">


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
    <label for="AssociationZip">Postal Code</label>
    <input type="Text" name="AssociationZip" class="form-control" id="AssociationZip" Value ="<%=AssociationZip%>" placeholder="Postal Code">
</div>




<br />
<input name="Region" value = "<%=Region %>" type = "hidden">
<input name="PeopleID" value = "<%=PeopleID %>" type = "hidden">

	<div align = right><input type=submit value="NEXT" class = "regsubmit2"></div>
</form>
<br>

    <br />
<div align = "left" class = body>Your privacy is important to us! We will not share your email address without your permission.</div>
<br /><br />



</body>
</HTML>