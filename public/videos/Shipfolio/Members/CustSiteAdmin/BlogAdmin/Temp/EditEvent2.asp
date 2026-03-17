<html>

<head>

<!--#Include file="GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title>Registry Registration</title>

<meta name="author" content="AndresenEvents.com">
<link rel="stylesheet" type="text/css" href="Style.css">

</head>

<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >

<!--#Include file="Header.asp"--> 
<!--#Include file="OverviewHeader.asp"--> 
<!--#Include file="Scripts.asp"--> 

<%
'rowcount = CInt
rowcount = 1 

Checks= Request.Form("Checks")
Paypal= Request.Form("Paypal")
PaypalEmail= Request.Form("PaypalEmail")
Checkaddress= Request.Form("Checkaddress")
PaymentOptionsID= Request.Form("PaymentOptionsID")
PaymentName= Request.Form("PaymentName")
PaymentStreet= Request.Form("PaymentStreet")
PaymentStreet2= Request.Form("PaymentStreet2")
PaymentCity= Request.Form("PaymentCity")
PaymentState= Request.Form("PaymentState")
PaymentCountry = Request.Form("PaymentCountry")
PaymentZip= Request.Form("PaymentZip")



Edit = Request.Form("Edit")
'response.write("Edit = " &  Edit)
eventID = Request.Form("EventID")
BusinessName = Request.Form("BusinessName")
EventName= Request.form("EventName")
EventWebsite= Request.form("EventWebsite")
EventWebsiteID= Request.form("EventWebsiteID")
EventTypeID =Request.Form("EventTypeID")
session("EventTypeID") = EventTypeID
EventStartMonth =Request.Form("EventStartMonth")
EventStartDay =Request.Form("EventStartDay")
EventStartYear =Request.Form("EventStartYear")
EventEndMonth =Request.Form("EventEndMonth")
EventEndDay =Request.Form("EventEndDay")
EventEndYear =Request.Form("EventEndYear")
EventLocationID = Request.Form("EventLocationID")
EventLocationName =Request.Form("EventLocationName")
EventLocationWebsite =Request.Form("EventLocationWebsite")
EventLocationWebsiteID =Request.Form("EventLocationWebsiteID")
EventLocationHours =Request.Form("EventLocationHours")
EventLocationEmail =Request.Form("EventLocationEmail")
EventLocationAddressID =Request.Form("EventLocationAddressID")
EventLocationStreet =Request.Form("EventLocationStreet")
EventLocationApt =Request.Form("EventLocationApt")
EventLocationCity =Request.Form("EventLocationCity")
EventLocationState =Request.Form("EventLocationState")
EventLocationPhone =Request.Form("EventLocationPhone")
EventLocationPhoneID =Request.Form("EventLocationPhoneID")
EventLocationCell =Request.Form("EventLocationCell")
EventLocationFax =Request.Form("EventLocationFax")
BusinessTypeID =Request.Form("BusinessTypeID")
BusinessWebsite = Request.Form("BusinessWebsite")
BusinessWebsiteID = Request.Form("BusinessWebsiteID")
BusinessHours = Request.Form("BusinessHours")
BusinessEmail = Request.Form("BusinessEmail")
BusinessAddress  = Request.Form("BusinessAddress")
BusinessAddressID = Request.Form("BusinessAddressID")
BusinessApt  = Request.Form("BusinessApt")
BusinessCity  = Request.Form("BusinessCity")
BusinessState = Request.Form("BusinessState")
BusinessZip  = Request.Form("BusinessZip")
BusinessPhone = Request.Form("BusinessPhone")
BusinessPhoneID = Request.Form("BusinessPhoneID")
BusinessCell  = Request.Form("BusinessCell")
BusinessFax = Request.Form("BusinessFax")


'*******  Payment data checked for single quote
str1 = PayPalEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	PayPalEmail = Replace(str1,  str2, "''")
End If 

str1 = Checkaddress
str2 = "'"
If InStr(str1,str2) > 0 Then
	Checkaddress= Replace(str1,  str2, "''")
End If 

str1 = PaymentName
str2 = "'"
If InStr(str1,str2) > 0 Then
	PaymentName= Replace(str1,  str2, "''")
End If 

str1 = PaymentStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	PaymentStreet= Replace(str1,  str2, "''")
End If 

str1 = PaymentStreet2
str2 = "'"
If InStr(str1,str2) > 0 Then
	PaymentStreet2= Replace(str1,  str2, "''")
End If 

str1 = PaymentCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	PaymentCity= Replace(str1,  str2, "''")
End If 

str1 = PaymentZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	PaymentZip= Replace(str1,  str2, "''")
End If 



str1 = EventDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventDescription= Replace(str1,  str2, "''")
End If 



str1 = lcase(EventWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	EventWebsite= right(EventWebsite, len(EventWebsite) - 7)
End If  


'***** 
' Event Location data checked for single quote
'*****
str1 = lcase(EventLocationWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	EventLocationWebsite= right(EventLocationWebsite, len(EventLocationWebsite) - 7)
End If  

str1 = lcase(BusinessWebsite)
str2 = "http://"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= right(BusinessWebsite, len(BusinessWebsite) - 7)
End If  

Dim str1
Dim str2

str1 = EventName
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventName= Replace(str1,  str2, "''")
End If  

str1 = EventLocationName
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationName = Replace(str1,  str2, "''")
End If  

str1 = EventLocationWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationWebsite= Replace(str1,  str2, "''")
End If  

str1 = EventLocationHours
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationHours= Replace(str1,  str2, "''")
End If  

str1 = EventLocationEmail
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationEmail= Replace(str1,  str2, "''")
End If  

str1 = EventLocationStreet
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationStreet= Replace(str1,  str2, "''")
End If  

str1 = EventLocationApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationApt= Replace(str1,  str2, "''")
End If  

str1 = EventLocationCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationCity= Replace(str1,  str2, "''")
End If  

str1 = EventLocationPhone
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationPhone= Replace(str1,  str2, "''")
End If

str1 = EventLocationCell
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationCell= Replace(str1,  str2, "''")
End If

str1 = EventLocationFax 
str2 = "'"
If InStr(str1,str2) > 0 Then
	EventLocationFax= Replace(str1,  str2, "''")
End If

'***** 
' Business data checked for single quote
'*****
str1 = BusinessName
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessName= Replace(str1,  str2, "''")
End If 

str1 = BusinessWebsite
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessWebsite= Replace(str1,  str2, "''")
End If 

str1 = BusinessHours
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessHours= Replace(str1,  str2, "''")
End If 

str1 = BusinessAddress
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessAddress= Replace(str1,  str2, "''")
End If 

str1 = BusinessApt
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessApt= Replace(str1,  str2, "''")
End If 

str1 = BusinessCity
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessCity= Replace(str1,  str2, "''")
End If

str1 = BusinessZip
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessZip= Replace(str1,  str2, "''")
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

str1 = BusinessEmail 
str2 = "'"
If InStr(str1,str2) > 0 Then
	BusinessEmail= Replace(str1,  str2, "''")
End If


'**************************************************************************************************************
'  UPDATE THE EVENT AND BUSINESS WEBSITES INTO THE WEBSITES TABLE
'**************************************************************************************************************

'response.write("edit = true")

Query =  " UPDATE Websites Set Website = '" &  EventLocationWebsite & "' " 
Query =  Query & " where WebsitesID = " & EventLocationWebsiteID & ";" 
Conn.Execute(Query) 

Query =  " UPDATE Websites Set Website = '" &  BusinessWebsite & "' " 
Query =  Query & " where WebsitesID = " & BusinessWebsiteID & ";"
Conn.Execute(Query) 


Query =  " UPDATE Websites Set Website = '" &  EventWebsite & "' " 
Query =  Query & " where WebsitesID = " & EventWebsiteID & ";"

Conn.Execute(Query) 



				
'**************************************************************************************************************
'  INSERT OR UPDATE THE PAYMENT OPTIONS
'**************************************************************************************************************

If Edit = "True" then
if Checks = "on" then
  Checks = "True"
else
  checks = "False"
end if 

if PayPal = "on" then
  PayPal = "True"
else
  PayPal = "False"
end if 

 Query =  " UPDATE PaymentOptions Set Checks = " &  Checks & " ," 
 Query =  Query & " Paypal  = " &  Paypal & "," 
 Query =  Query & " PaypalEmail  = '" &  PaypalEmail & "'," 
 Query =  Query & " PaymentName = '" &  PaymentName & "'," 
 Query =  Query & " PaymentStreet = '" &  PaymentStreet & "'," 
 Query =  Query & " PaymentStreet2 = '" & PaymentStreet2 & "'," 
 Query =  Query & " PaymentCity = '" &  PaymentCity & "'," 
 Query =  Query & " PaymentState = '" &  PaymentState & "'," 
 Query =  Query & " PaymentCountry = '" &  PaymentCountry & "',"
 Query =  Query & " PaymentZip = '" &  PaymentZip & "',"  
 Query =  Query & " EventID = '" &  EventID & "'"  
 Query =  Query & " where PaymentOptionsID = " & PaymentOptionsID & ";" 
 
	Conn.Execute(Query) 
	
end if

'**************************************************************************************************************
'   UPDATE THE EVENT AND BUSINESS ADDRESSES INTO THE ADDRESS TABLE IF THIS IS A NEW EVENT
'**************************************************************************************************************

Query =  " UPDATE Address Set AddressStreet = '" &  EventLocationStreet & "' ,"
Query =  Query & " AddressApt  = '" &  EventLocationApt & "'," 
 Query =  Query & " AddressCity  = '" &  EventLocationCity & "'," 
 Query =  Query & " AddressState  = '" &  EventLocationState & "'," 
 Query =  Query & " AddressZip = '" &  EventLocationZip & "'" 
Query =  Query & " where AddressID = " & EventLocationAddressID & ";" 

'response.write("A update address Query = " & Query & "<br/>")
Conn.Execute(Query) 

Query =  " UPDATE Address Set AddressStreet = '" &  BusinessAddress & "' ,"
Query =  Query & " AddressApt  = '" &  BusinessApt & "'," 
 Query =  Query & " AddressCity  = '" &  BusinessCity & "'," 
 Query =  Query & " AddressState  = '" &  BusinessState & "'," 
 Query =  Query & " AddressZip = '" &  BusinessZip & "'" 
Query =  Query & " where AddressID = " & BusinessAddressID & ";" 
'response.write("B update address Query = " & Query & "<br/>")

Conn.Execute(Query) 


'**************************************************************************************************************
'   UPDATE EVENT AND BUSINESS PHONE NUMBERS INTO THE PHONE TABLE
'**************************************************************************************************************


Query =  " UPDATE Phone Set Phone = '" &  EventLocationPhone & "', "
Query =  Query & " Cellphone  = '" &  EventLocationCell & "'," 
Query =  Query & " Fax  = '" &  EventLocationFax & "'" 
Query =  Query & " where PhoneID = " & EventLocationPhoneID & ";" 

'response.write("Phone Query= " & Query  & "<br/>")
Conn.Execute(Query) 

Query =  " UPDATE Phone Set Phone = '" &  BusinessPhone & "' ,"
Query =  Query & " Cellphone  = '" &  BusinessCell & "'," 
 Query =  Query & " Fax  = '" &  BusinessFax & "'" 
Query =  Query & " where PhoneID = " & BusinessPhoneID & ";" 
'response.write("phone update = " & Query & "<br>")
Conn.Execute(Query) 

'**************************************************************************************************************
'  FIND THE WEBSITE ID'S FOR THE LOCATION WEBSITE AND THE BUSINESS WEBSITE
'**************************************************************************************************************

sql = "select WebsitesID from websites where Website = '" & EventLocationWebsite & "' order by WebsitesID Desc;" 
''response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	EventLocationWebsiteID = rs("WebsitesID")
End If 

sql = "select WebsitesID from websites where Website = '" & BusinessWebsite & "' order by WebsitesID Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	BusinessWebsiteID = rs("WebsitesID")
End If 


sql = "select WebsitesID from websites where Website = '" & EventWebsite & "' order by WebsitesID Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	EventWebsiteID = rs("WebsitesID")
End If 

rs.close




'**************************************************************************************************************
'  FIND THE ADDRESS ID'S FOR THE LOCATION ADDRERSS AND THE BUSINESS ADDRESS
'**************************************************************************************************************

sql = "select * from Address where AddressStreet = '" & EventLocationStreet  & "' and AddressApt = '" & EventLocationApt & "' and  AddressCity = '" & EventLocationCity & "' and AddressZip = '" & EventLocationZip & "' order by AddressID Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	EventLocationAddressID = rs("AddressID")
End If 

sql = "select * from Address where AddressStreet = '" & BusinessAddress  & "' and AddressApt = '" & BusinessApt & "' and  AddressCity = '" & BusinessCity & "' and AddressZip = '" & BusinessZip & "' order by AddressID Desc;" 
'response.write("<br>select from address =" & sql & "<br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	BusinessAddressID = rs("AddressID")
End If 

rs.close

'**************************************************************************************************************
'  FIND THE PHONE ID'S 
'**************************************************************************************************************

sql = "select * from Phone where Phone = '" & EventLocationPhone  & "' and Cellphone = '" & EventLocationCell & "' and  fax = '" & EventLocationFax & "' order by PhoneID Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	EventLocationPhoneID = rs("PhoneID")
End If 

sql = "select * from Phone where Phone = '" & BusinessPhone  & "' and Cellphone = '" & BusinessCell & "' and  fax = '" & BusinessFax & "' order by PhoneID Desc"
'response.write("business phone sql = " & sql & "<br><br>")
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	BusinessPhoneID = rs("PhoneID")
End If 

rs.close






'**************************************************************************************************************
'  UPDATE EVENT LOCATION INFORMATION INTO THE EVENTLOCATION TABLE
'**************************************************************************************************************

Query =  " UPDATE Eventlocation Set EventLocationName = '" &  EventLocationName & "', "
Query =  Query & " EventLocationHours = '" &  EventLocationHours & "'," 
Query =  Query & " AddressID = " & EventLocationAddressID & "," 
Query =  Query & " PhoneID = " &  EventLocationPhoneID & "," 
Query =  Query & " EventLocationEmail = '" &  EventLocationEmail & "'" 
Query =  Query & " where EventLocationID = " & EventLocationID & ";" 

'response.write("<br>event location update Query = " & Query & "<br>")

Conn.Execute(Query) 

'**************************************************************************************************************
'  FIND THE EVENT LOCATION ID
'**************************************************************************************************************

sql = "select EventLocationID from EventLocation where EventLocationName = '" & EventLocationName  & "' and EventLocationHours = '" & EventLocationHours & "' and  AddressID = " & EventLocationAddressID & " order by EventLocationID Desc"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
'response.write("<br>event location sql=" & sql & "<br>") 
If Not rs.eof Then
	EventLocationID = rs("EventLocationID")
End If 


rs.close




'**************************************************************************************************************
'  FIND THE BUSINESS ID
'**************************************************************************************************************

sql = "select BusinessID from business where BusinessTypeID = " & BusinessTypeID  & " and BusinessName = '" & BusinessName & "' and  BusinessWebsiteID = " & BusinessWebsiteID & " and BusinessEmail = '" & BusinessEmail & "' and BusinessHours = '" & BusinessHours &  "' order by BusinessID Desc;"  
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

'response.write("business query=" & sql )
If Not rs.eof Then
	BusinessID = rs("BusinessID")
End If 

rs.close



'**************************************************************************************************************
'  FIND THE BUSINESS TYPE
'**************************************************************************************************************

sql = "select BusinessType from BusinessTypeLookup where BusinessTypeID = " & BusinessTypeID   & " order by BusinessType Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

'response.write("business query=" & sql )
If Not rs.eof Then
	BusinessType = rs("BusinessType")
End If 

rs.close



'**************************************************************************************************************
'  FIND THE EVENT TYPE
'**************************************************************************************************************

sql = "select EventType from EventTypesLookup where EventTypeID = " & EventTypeID   & " order by EventTypeid Desc;" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

'response.write("business query=" & sql )
If Not rs.eof Then
	EventType = rs("EventType")
End If 

rs.close




PeopleID = request.Form("PeopleID")
if len(PeopleID) > 1 then
else
PeopleID =  Session("PeopleID")
end if
Session("PeopleID") = PeopleID

'response.write("PeopleID = " & PeopleID & "wwww<br>")

'**************************************************************************************************************
'  UPDATE THE EVENT INFORMATION INTO THE EVENT TABLE
'**************************************************************************************************************


Query =  " UPDATE Event Set EventName = '" &  EventName & "', "
Query =  Query & " EventDescription = " &  EventDescription & "," 
Query =  Query & " EventTypeID = " &  EventTypeID & "," 
Query =  Query & " AddressID = " & EventLocationAddressID & "," 
Query =  Query & " WebsiteID = " &  EventWebsiteID & "," 
Query =  Query & " EventStartMonth = '" &  EventStartMonth & "'," 
Query =  Query & " EventStartDay = '" &  EventStartDay & "'," 
Query =  Query & " EventStartYear = '" &  EventStartYear & "'," 
Query =  Query & " EventEndMonth = '" &  EventEndMonth & "'," 
Query =  Query & " EventEndDay = '" &  EventEndDay & "'," 
Query =  Query & " EventEndYear = '" &  EventEndYear & "'" 
Query =  Query & " where EventID = " & EventID & ";" 

'response.write("Query = " & Query)
Conn.Execute(Query) 

'**************************************************************************************************************
'  FIND THE EVENT ID
'**************************************************************************************************************

sql = "select EventID from Event where EventName = '" & EventName   & "'  and WebsiteID = " & EventWebsiteID & " and EventStartMonth = " & EventStartMonth & " and EventStartDay = " & EventStartDay & " and EventStartYear = " & EventStartYear & " and EventEndMonth = " & EventEndMonth & " and EventEndDay = " & EventEndDay & " and EventLocationID  = " & EventLocationID & " order by eventid desc;"
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

'response.write("<br><br> EventID query=" & sql & "<br><br>")
If Not rs.eof Then
	EventID = rs("EventID")
	session("EventID")= EventID
End If 

rs.close


	
	
'response.write("EventID =" & EventID & "<br>" )
%>
<br>
<form  name=form method="post" action="RegCreateStep2.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "800" align = "center">

	<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			<H1>Review Your Event Information</H1>
			<br>
		</td>
	</tr>
	<tr>
	   <td width = "450" valign = "top">
	
	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 bgcolor = "#DBF5F3" width = "450" align = "center">
	<tr>
		<td CLASS = "body2"  colspan = "2">
			<h3>A Little About Your Event</h3>
		</td>
	</tr>
	<tr>
				<td  class = "body2" align = "right" width = "200">
					Event Type:
				</td>
				<td class = "body2"  >
					
		<%=EventType %>
    	</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			Event Name:&nbsp;
		</td>
		<td class = "body2">
			<%=EventName%>
		</td>
</tr>
	<tr>
		<td class = "body2" align = "right">
			Start Date: &nbsp;</td>
		<td class = "body2">
				<%=EventStartMonth %>/<%= EventStartDay %>/<%=EventStartYear %>
					
		</td>
	   </tr>
	   <tr>
		<td class = "body2" align = "right">
			End Date: &nbsp;</td>
		<td class = "body2">
				<%=EventEndMonth %>/<%=EventEndDay %>/<%=EventEndYear %>
					
		</td>
	   </tr>
	   <tr>
		<td class = "body2" align = "right">
			Event Website: &nbsp;
		</td>
		<td class = "body2">
			<%=EventWebsite%>
		</td>
</tr>

     </table>
      <br>
<table border = "0" cellpadding=5 cellspacing=5 bgcolor = "#DBF5F3" width = "450" height = "320" align = "center">
				<tr>
				  <td  colspan = "2">
				     <h3>Event Description</h3>
 
				  </td>
				 </tr>
						<tr>
							<td class = "body2" align = "left" >
								<%=EventDescription%>
							</td>
						</tr>
</table>
        <br>
<table border = "0" cellpadding=5 cellspacing=5 bgcolor = "#DBF5F3" width = "450" height = "320" align = "center">
				<tr>
				  <td  colspan = "2">
				     <h3>Event Location</h3>
 
				  </td>
				 </tr>
						<tr>
							<td class = "body2" align = "right" width = "200">
								Name of Location: &nbsp;
							</td>
							<td class = "body2" align = "left" >
								<%=EventLocationName%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								Location's Website: &nbsp;
							</td>
							<td class = "body2">
									<%=EventLocationWebsite%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								Hours Of Operation: &nbsp;
							</td>
							<td class = "body2">
									<%=EventLocationHours%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								Contact Email: &nbsp;
							</td>
							<td class = "body2">
									<%=EventLocationEmail%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								Street: &nbsp;
							</td>
							<td class = "body2">
									<%=EventLocationStreet%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								Apartment / Suite: &nbsp;
							</td>
							<td class = "body2">
								<%=EventLocationApt%>
							</td>
						</tr>
						<tr>
							<td class = "body2" align = "right">
								City: &nbsp;
							</td>
							<td class = "body2">
								<%=EventLocationCity%>
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
							<%=EventLocationState%>
						</td>
					</tr>
					<tr>
						<td class = "body2" align = "right">
								Phone: &nbsp;
							</td>
						<td class = "body2">
								<%=EventLocationPhone%>
							</td>
					</tr>
					<tr>
						<td class = "body2" align = "right">
								Cell: &nbsp;
							</td>
						<td class = "body2">
								<%=EventLocationCell%>
							</td>
					</tr>
					<tr>
						<td class = "body2" align = "right">
								Fax: &nbsp;
							</td>
						<td class = "body2">
								<%=EventLocationFax%>
							</td>
					</tr>
				<tr>
</table>


       </td>	
	   <td width = "450" valign = "top">
		
	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 bgcolor = "#DBF5F3" width = "450" align = "center">
	<tr>			
				  <td  colspan = "2" class = "body2">
				     <h3>Payment Options</h3>
			        Accept payment in the following ways:
				  </td>
				 </tr>
					
						<input name="PaymentOptionsID" Value ="<%=PaymentOptionsID%>"  type = "hidden">
						<% 
						   if PayPal = "True" then

						   %><tr>
						<td class = "body2" colspan = "2">
								<img src = "images/px.gif" width = "20" height = "1">Paypal Email Address: &nbsp;
					
								<%=PaypalEmail%><br>

							</td>
						</tr>
						<% end if %>
						<%  if Checks = "True" then %>

						
					<tr>
						  <td   class = "body2" colspan = "2">
								<img src = "images/px.gif" width = "20" height = "1">Address that the check should be sent to:
							</td>
						</tr>
					<tr>
						<td   class = "body2" align = "right" width = "170">
								Pay To:&nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2" width = "280">
							<%=PaymentName%>
							</td>
					</tr>
					<tr>
						  <td   class = "body2" align = "right">
								Street: &nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2">
								<%=PaymentStreet%>
							</td>
						</tr>
						<tr>
						<td   class = "body2"  align = "right">
								Apartment / Suite: &nbsp;
						</td>
						<td  valign = "top" class = "body2">
								<%=PaymentStreet2%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2">
								<%=PaymentCity%>
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2" >
								State / Provence: &nbsp;
					</td>
					<td  align = "left" valign = "top" class = "body2">

							<%=PaymentState%>
							</td>
						</tr>
						<tr>
					<td  align = "right" class = "body2">
								Country:  &nbsp;
					</td>
					<td  align = "left" valign = "top" class = "body2">
					
						<%=PaymentCountry%>
					</td>
					</tr>

						<tr>
							<td   class = "body2" align = "right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=PaymentZip%>
							</td>
						</tr>
					<% end if %>
		</table>


<br>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 bgcolor = "#DBF5F3" width = "450" align = "center">
	<tr>			
				  <td  colspan = "2" class = "body2">
				     <h3>Who is Putting on the Event?</h3>
				  </td>
				 </tr>
					<tr>
						<td class = "body2" align = "right" width = "150">
							Organization's Name: &nbsp;
						</td>
						<td class = "body2" width = "300">
							<%=BusinessName%>
						</td>
					</tr>
					<tr>
						<td class = "body2" align = "right">
							Organization's Type: &nbsp;
						</td>
						<td class = "body2">
						<%=BusinessType %>
						</td>
					</tr>
					<tr>
						<td class = "body2" align = "right">
							Website: &nbsp;
						</td>
						<td class = "body2">
								<%=BusinessWebsite%>
							</td>
						</tr>
						<tr>
						<td class = "body2" align = "right">
							Hours of Operation: &nbsp;
						</td>
						<td class = "body2">
							<%=BusinessHours%>
							</td>
						</tr>
					<tr>
							<td class = "body2" align = "right">
								Contact Email: &nbsp;
							</td>
						<td class = "body2">
							<%=BusinessEmail%>
						</td>

					<tr>
						  <td   class = "body2" align = "right">
								Street: &nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessAddress%>
							</td>
						</tr>
						<tr>
						<td   class = "body2"  align = "right">
								Apartment / Suite: &nbsp;
						</td>
						<td  valign = "top" class = "body2">
							<%=BusinessApt%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2">
								<%=BusinessCity%>
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessState%>

							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessZip%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Phone: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessPhone%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Cell: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessCell%>
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								Fax: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessFax%>
					</td>
				</tr>
		</table>
	</td>
</tr>
</table>

<table width = "900"  align = "center" bgcolor = "#DBF5F3" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<tr>
	<td class ="body2" valign = "top"  align = "center">
			<h2><center>Make More Changes</center></h2>
			<a href = "editEvent.asp?EventID=<%=EventID %>&Edit=True" class = "body2">Click here to go back and make changes.</a><br><br>
	</td>
	<td class ="body2" valign = "top"  align = "center">
			<h2><center>Event Page</center></h2>
			<a href = "RegManageHome.asp?EventID=<%=EventID%>" class = "body2">Go to Event Page.</a><br><br>
		</td>
	</tr>
</table>
		
					
 </form> 
<br><br><br>








		<!--#Include file="Footer.asp"-->

		</Body>
</HTML>

