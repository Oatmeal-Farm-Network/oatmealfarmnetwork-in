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
file_name = "SetupAccountPlusstep3.asp"

script_name = request.servervariables("script_name")

country_id = request.form("country_id")

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
'response.write("Status=" & Status & "<br>")
if  Status="Test" then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BasicPriceID = rs("StripeAPIIDTest")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BusinessPriceID = rs("StripeAPIIDTest")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        GlobalPriceID = rs("StripeAPIIDTest")
    end if
    rs.close


end if
if  Status="Live" Then
sql = "select * from SubscriptionLevels where SubscriptionID = 2 " 'USA Basic Account
   ' response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BasicPriceID = rs("StripeAPIID")
    end if
	'response.write("BasicsPriceID =" & BasicsPriceID  )
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 3 " 'USA Business Account
    'response.write("sql =" & sql  )
    rs.Open sql, conn, 3, 3  
    if  Not rs.eof then 
        BusinessPriceID = rs("StripeAPIID")
    end if
   rs.close

sql = "select * from SubscriptionLevels where SubscriptionID = 5 " 'USA Global Account
  rs.Open sql, conn, 3, 3   
    if  Not rs.eof then 
        GlobalPriceID = rs("StripeAPIID")
    end if
    rs.close
End if


sql = "select * from Country where country_id = '" & country_id & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
LocalCurrency  = rs("Currency") 
CurrencyCode  = rs("CurrencyCode")
country_id = rs("country_id")
end if
rs.close

Permission = request.form("Permission")
	If Permission = "on" then
		Permission = 1
	end if
LivestockLegalDisclaimer= request.form("LivestockLegalDisclaimer")
		If LivestockLegalDisclaimer = "on" then
		LivestockLegalDisclaimer = 1
	end if
SalesLegalDisclaimer= request.form("SalesLegalDisclaimer")
		If SalesLegalDisclaimer = "on" then
		SalesLegalDisclaimer = 1
	end if
BusinessTypeID = request.form("BusinessTypeID")
response.write("BusinessTypeID=" & BusinessTypeID )

BusinessName=request.form("BusinessName")
BusinessWebsite=request.form("BusinessWebsite")
BusinessEmail=request.form("BusinessEmail")


AddressStreet=request.form("AddressStreet")
variables = "?AddressStreet=" & AddressStreet
AddressApt=request.form("AddressApt")
variables = variables & "&AddressApt=" & AddressApt
AddressCity=request.form("AddressCity")
variables = variables & "&AddressCity=" & AddressCity
AddressZip=request.form("AddressZip")
variables = variables & "&AddressZip=" & AddressZip
BusinessPhone=request.form("BusinessPhone")
variables = variables & "&BusinessPhone=" & BusinessPhone
StateIndex=request.form("StateIndex")
'response.write("StateIndex=" & StateIndex )


'response.write("Password=" & Password )
'response.write("SpecialChecterFound=" & SpecialChecterFound )


Membership = Request.Form("Membership")
if len(Membership) > 0 then
else
Membership = Request.querystring("Membership")
end if
'response.write("Membership=" & Membership )
if len(Membership) > 0 then
else
Membership = session("Membership")
end if
variables = variables & "&Membership=" & Membership



file_name = "SetupAccountPlusstep3.asp"

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

showcoupons = false
showyears = False
showdonation = False
donationsavailable = False



sql = "select distinct * from SubscriptionLevels where Region = 'USA' and SubscriptionTitle = '" & Membership & "'"
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
OrderTotal = rs("SubscriptionMonthlyRate") 
end if
rs.close



StateIndexFound = False
if len(StateIndex) > 0 then
StateIndexFound = True
end if

'response.write("MissingData=" & MissingData &"<br>")
'response.write("SpecialChecterFound=" & SpecialChecterFound  &"<br>")
'response.write("StateIndex=" & StateIndex &"<br>")
'response.write("passwordmatch=" & passwordmatch &"<br>")


if MissingData = True  or  len(StateIndex) < 1 or passwordmatch = False then
'response.redirect("SetupAccountPlusStep2.asp" & variables & "&Stepback2=True&StateIndexFound=" & StateIndexFound & "&StateIndex=" & StateIndex & "&EmailsMatch=" & EmailsMatch  & "&passwordmismatch=" & passwordmismatch & "&SpecialChecterFound=" & SpecialChecterFound & "&MissingPassword=" & MissingPassword)
end if


Owner=request.form("Owner")


websitesignupcount = 0


BusinessName = Request.Form("BusinessName")



	str1 = BusinessName 
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessName = Replace(str1,  str2, "''")
	End If 

	str1 = Owners
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Owners= Replace(str1,  str2, "''")
	End If  





	str1 = BusinessTitleID
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessTitleID= Replace(str1,  str2, "''")
	End If  


	str1 = BusinessWebsite
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessWebsite= Replace(str1,  str2, "''")
	End If  

	str1 = lcase(BusinessWebsite)
	str2 = "http://"
	If InStr(str1,str2) > 0 Then
		BusinessWebsite= right(BusinessWebsite, len(BusinessWebsite) - 7)
	End If  


	str1 = BusinessEmail
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessEmail= Replace(str1,  str2, "''")
	End If 



	str1 = AddressStreet
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		AddressStreet= Replace(str1,  str2, "''")
	End If 

	str1 = StreetApt
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		StreetApt= Replace(str1,  str2, "''")
	End If 

	str1 = AddressApt 
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		AddressApt= Replace(str1,  str2, "''")
	End If

	str1 = AddressCity
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		AddressCity= Replace(str1,  str2, "''")
	End If

	str1 = AddressZip
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		AddressZip= Replace(str1,  str2, "''")
	End If

	str1 = BusinessPhone
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessPhone= Replace(str1,  str2, "''")
	End If

	str1 = BusinessCell
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessCell= Replace(str1,  str2, "''")
	End If

	str1 = BusinessFax 
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		BusinessFax= Replace(str1,  str2, "''")
	End If


	Dim str1
	Dim str2

	Query =  "INSERT INTO Websites (Website)" 
	Query =  Query + " Values ('" & BusinessWebsite & "')" 
	Conn.Execute(Query) 


	sql = "select WebsitesID from Websites where Website = '" & BusinessWebsite & "' order by WebsitesID Desc"
	'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3   
		ExistingEvent = False
		If Not rs.eof Then
			WebsitesID = rs("WebsitesID")
		End If 
	rs.close


'response.write("Website query = " & Query & "<br>")	


		Query =  "INSERT INTO Address (AddressStreet, AddressApt, AddressCity, StateIndex, country_id, AddressZip)" 
	    Query =  Query + " Values ('" & AddressStreet  & "'," 
	    Query =  Query & " '" &  AddressApt & "', " 
		Query =  Query & " '" &  AddressCity & "', " 
		Query =  Query & " '" &  StateIndex & "', " 
        Query =  Query & " '" &  country_id & "', " 
		Query =  Query & " '" &  AddressZip & "')" 
Conn.Execute(Query) 
response.Write("Query=" & Query )


sql = "select AddressID from Address  Order by AddressID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		AddressID  =rs("AddressID") 
	End If 

rs.close



daynow= day(now)
monthnow = month(now)
yearnow = year(now)
datenow = monthnow & "/" & daynow & "/" & yearnow
if membership = "FreeTrial" then
datenownext = DateAdd("m", 6, datenow)
else

years = request.form("years")
if len(years) > 0 then
else
years = 1
end if
if len(animals) > 0 then
else
animals = 5
end if


datenownext =  monthnow & "/" & daynow & "/" & (yearnow + years )
end if

datenownextlife =  monthnow & "/" & daynow & "/" & (yearnow + 20 )
'response.write("years = " & years)
'response.write("datenownext  = " & datenownext )
'response.write("datenownextlife  = " & datenownextlife )
'response.write("Password=" & Password & "!")





 

str1 = BusinessName
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "'")
End If 


str1 = BusinessTitleID
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessTitleID= Replace(str1,  str2, "'")
End If  

str1 = BusinessWebsite
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= Replace(str1,  str2, "'")
End If  

str1 = BusinessEmail
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessEmail= Replace(str1,  str2, "'")
End If 


str1 = confirm
str2 = "''"
If InStr(str1,str2) > 0 Then
	confirm= Replace(str1,  str2, "'")
End If 

str1 = AddressStreet
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressStreet= Replace(str1,  str2, "'")
End If 

str1 = StreetApt
str2 = "''"
If InStr(str1,str2) > 0 Then
	StreetApt= Replace(str1,  str2, "'")
End If 

str1 = AddressApt 
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressApt= Replace(str1,  str2, "'")
End If

str1 = AddressCity
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressCity= Replace(str1,  str2, "'")
End If

str1 = AddressZip
str2 = "''"
If InStr(str1,str2) > 0 Then
	AddressZip= Replace(str1,  str2, "'")
End If

str1 = BusinessPhone
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessPhone= Replace(str1,  str2, "'")
End If

str1 = BusinessCell
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessCell= Replace(str1,  str2, "'")
End If

str1 = BusinessFax 
str2 = "''"
If InStr(str1,str2) > 0 Then
	BusinessFax= Replace(str1,  str2, "'")
End If


	Query =  "INSERT INTO Phone (Phone, Cellphone, Fax)" 
	    Query =  Query + " Values ('" & BusinessPhone  & "'," 
	    Query =  Query & " '" &  Cellphone & "', " 
		Query =  Query & " '" &  Fax & "')" 
'response.Write("Query=" & Query )

Conn.Execute(Query) 



sql = "select PhoneID from Phone Order by PhoneID Desc"
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	ExistingEvent = False
	If Not rs.eof Then
		PhoneID  =rs("PhoneID") 
	End If 

rs.close



if len(BusinessID) < 1 then
	Query =  "INSERT INTO Business (AddressID, Accesslevel, BusinessName, BusinessTypeID, WebsitesID, Businessemail, PhoneID  )" 
	Query =  Query & " Values (" & AddressID & ", 3, '" & BusinessName & "', " & BusinessTypeID & ", " & WebsitesID & ", '" & Businessemail & "', '" & PhoneID & "' )" 
	'response.write("Query=" & Query )
	Conn.Execute(Query) 
	
	sql = "select BusinessID from Business where BusinessName = '" & BusinessName & "' order by BusinessID Desc"

		
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3   
		ExistingEvent = False
		If Not rs.eof Then
			BusinessID = rs("BusinessID")
		End If 
	rs.close
end if



 Current = "Home"
Current3="Register"
session("LoggedIn") = False%>
<!--#Include virtual="/Header.asp"-->

    <div class="container-fluid"  >
    <div align = "center">
     <div class = "container" >
    <div>
      <div class = "body">
       <br /><h1>Account Verification</h1>
          </div>
        </div>
    </div>
    </div>
 </div>
	<br />
<div class="container d-flex justify-content-center roundedtopandbottom mx-auto " style = "max-width:460px; min-height: 200px">
  <div class="row">
  <div class="col">

<div>
   <div>
      
<% if membership = "Intro" then %>


		<blockquote><h2>One last step.</h2>
			
		

			</blockquote>


<%
'********************************Paid Memberships*******************************
 else   %>


<blockquote>
	<br />
<h2>Your Order</h2>
<center>
<table width = 280 >
<tr><td class = "body"><%=membership %> Membership<br>
Order: <%=formatcurrency(OrderTotal)%> / Month<br>
</td></tr></table>



	
	 <form action="/StripeFile/checkout-billing.asp" method="post">
     <input type="hidden" name="PeopleID" value="<%=PeopleID %>" /> 
     <input type="hidden" name="membership" value="<%=membership %>" /> 
     <input type="hidden" name="Membership_price" value="<%=OrderTotal %>" /> 
     <input type="hidden" name="membershipStripePriceID" value="<%=membershipStripePriceID %>" /> 

	 <input type="hidden" name="PeopleFirstName" value="<%=PeopleFirstName %>" />
	 <input type="hidden" name="PeopleLastName" value="<%=PeopleLastName %>" />
	 <input type="hidden" name="PeopleEmail" value="<%=PeopleEmail %>" />
	 <input type="hidden" name="PeoplePhone" value="<%=PeoplePhone %>"

     <div class="select"><br />
     <div> <button type="submit" class="submitbutton" name="plan_submit">Pay Now</button> </div><br />
     </div>
     </form>



<% showpaypal = False
test = False
	if showpaypal = True then
			if test = False then %>
			<form action="https://www.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
			<% else %>
			<form action="https://www.sandbox.paypal.com/cgi-bin/webscr" method="post" target = "_blank">
			<% end if %>
<br />

			<input type="hidden" name="cmd" value="_xclick-subscriptions">
			<input type = "hidden" name = "business" value = "kim@livestockoftheworld.com">
			<input type="hidden" name="lc" value="IN">
			<input type = "hidden" name = "item_name" value = "<%=Membership %> Membership">
			<input type="hidden" name="no_note" value="1">
			<input type="hidden" name="src" value="1">
			<input type="hidden" name="srt" value="12">
			<input type="hidden" name="a3" value="<%=OrderTotal%>">
			<input type="hidden" name="p3" value="1">
			<input type="hidden" name="t3" value="M">
			<input type="hidden" name="currency_code" value="<%=LocalCurrency %>">
			<input type="hidden" name="cancel_return" value="http://www.globalgrange.world/Join/USA/Default.asp?PeopleID=<%=PeopleID%>&Peopleemail=<%=Peopleemail %>">
			<input type="hidden" name="return" value="http://www.globalgrange.world/SignUpCompletionPage.asp">
			<input type="hidden" name="bn" value="PP-SubscriptionsBF:btn_subscribeCC_LG.gif:NonHostedGuest">
			<input type="hidden" name="cbt" value="Return to Global Grange inc.">
			<input type="hidden" name="notify_url" value="https://www.globalgrange.world/Join/LOTWOrderCompletion.asp">
			<input type="submit" class ="submitbutton" value ="Pay Now" height = 130px border="0" name="Pay Now" >
			</form>
			</center>
			<br /><br /><br /><br />
			</blockquote>
	 <% end if %>
<% end if %>


		

   </div>
</div>

<br /><br />

</div>
</div>
</div>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<!--#Include virtual="/Footer.asp"--> </body>
</HTML>