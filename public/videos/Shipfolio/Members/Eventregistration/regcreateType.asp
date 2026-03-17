<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<%  PageName = "Registry" %>
<!--#Include file="AdminEventGlobalVariables.asp"-->
<title>Add New Event</title>
<meta http-equiv="Content-Language" content="en-us">

<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.EventTypeID.value=="") {
themessage = themessage + " - Event Type \r";
}
if (document.form.EventName.value=="") {
themessage = themessage + " - Event Name \r";
}
if (document.form.EventStartMonth.value=="") {
themessage = themessage + " - Event Start Month \r";
}

if (document.form.EventStartDay.value=="") {
themessage = themessage + " - Event Start Day \r";
}

if (document.form.EventStartYear.value=="") {
themessage = themessage + " - Event Start Year \r";
}

if (document.form.EventEndMonth.value=="") {
themessage = themessage + " - Event End Month \r";
}

if (document.form.EventEndDay.value=="") {
themessage = themessage + " - Event End Day \r";
}

if (document.form.EventEndYear.value=="") {
themessage = themessage + " - Event End Year \r";
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

edit = request.querystring("Edit")
eventID = request.querystring("EventID")

if len(edit) < 3 then
  Edit = False
end if 

If Edit = "True" then

sqlA =  "Select * from PaymentOptions where EventID= " & EventID & " order by  PaymentOptionsID DESC "
Set rsA = Server.CreateObject("ADODB.Recordset")

rsA.Open sqlA, conn, 3, 3 
	
if Not rsA.eof  Then

   Checks  = rsA("Checks")
   Paypal  = rsA("Paypal")
   PaypalEmail = rsA("PaypalEmail")
   Checkaddress = rsA("Checkaddress")
   PaymentName = rsA("PaymentName")
   PaymentStreet = rsA("PaymentStreet")
   PaymentStreet2 = rsA("PaymentStreet2")
   PaymentCity = rsA("PaymentCity")
   PaymentState = rsA("PaymentState")
   PaymentZip= rsA("PaymentZip")
   PaymentCountry= rsA("PaymentCountry")
   PaymentOptionsID = rsA("PaymentOptionsID")
end if
				
sql2 = "select * from Event, address, websites, phone where Event.EventID= " & EventID & "  and Event.WebsiteID = Websites.WebsitesID "

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
if Not rs2.eof  Then
	PeopleID = rs2("PeopleID")
	if PeopleID > 0 then
		Session("PeopleID") = PeopleID
	end if
	EventName = rs2("EventName")
	EventTypeID = rs2("EventTypeID")
	AddressID = rs2("AddressID")
	WebsiteID = rs2("WebsiteID")
	BusinessID = rs2("BusinessID")
	EventAddressID = rs2("AddressID")
	EventStartMonth = rs2("EventStartMonth")
	EventStartDay = rs2("EventStartDay")
	EventStartYear = rs2("EventStartYear")
	EventEndMonth = rs2("EventEndMonth")
	EventEndDay = rs2("EventEndDay")
	EventWebsite = rs2("Website")
	EventWebsiteID = rs2("WebsiteID")
end if	
		
sql2 = "select * from Event, Business, address, websites, phone where Event.BusinessID = Business.BusinessID and Event.EventID= " & EventID & " and business.addressId = Address.AddressID and Business.BusinessWebsiteID = Websites.WebsitesID and business.phoneid = Phone.PhoneID"

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
if Not rs2.eof  Then
	BusinessID = rs2("BusinessID")
	BusinessName = rs2("BusinessName")
	BusinessWebsiteID = rs2("BusinessWebsiteID")
	BusinessEmail = rs2("BusinessEmail")
	BusinessHours = rs2("BusinessHours")
	BusinessPhoneID = rs2("PhoneID")
	BusinessAddressID = rs2("AddressID")
	BusinessAddress = rs2("AddressStreet")
	BusinessApt= rs2("AddressApt")
	BusinessCity = rs2("AddressCity")
	BusinessState = rs2("AddressState")
	BusinessCountry = rs2("AddressCountry")
	BusinessZip = rs2("AddressZip")
	BusinessWebsite = rs2("Website")
	BusinessWebsiteID = rs2("WebsiteID")
	BusinessPhone = rs2("Phone")
	BusinessCell = rs2("CellPhone")
	BusinessFax = rs2("Fax")
	BusinessTypeID = rs2("BusinessTypeID")
end if	

sql2 = "select * from Event, EventLocation, address, Phone, Websites where EventLocation.WebsiteID = Websites.WebsitesID and Event.EventLocationID = Eventlocation.EventLocationID and EventLocation.AddressID = Address.AddressID  and Eventlocation.PhoneID = Phone.PhoneID and event.eventid = " & eventid 

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
if Not rs2.eof  Then
	EventLocationWebsite = rs2("Website")
	EventLocationWebsiteID = rs2("WebsiteID")
	EventLocationStreet = rs2("AddressStreet")
	EventLocationApt= rs2("AddressApt")
	EventLocationCity = rs2("AddressCity")
	EventLocationState = rs2("AddressState")
	EventLocationCountry = rs2("AddressCountry")
	EventLocationZip = rs2("AddressZip")
	EventLocationPhone = rs2("Phone")
	EventLocationPhoneID = rs2("PhoneID")
	EventLocationCell = rs2("CellPhone")
	EventLocationFax = rs2("Fax")
	EventEndYear = rs2("EventEndYear")
	EventLocationID = rs2("EventLocationID")
	EventLocationName = rs2("EventLocationName")
	EventLocationHours = rs2("EventLocationHours")
	EventLocationEmail = rs2("EventLocationEmail")
	EventLocationAddressID = rs2("AddressID")
end if	

'******************************************************************************************
'  FIND THE EVENT TYPE
'******************************************************************************************

sql = "select EventType from EventTypesLookup where EventTypeID = " & EventTypeID   & ";" 

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	EventType = rs("EventType")
End If 

rs.close

'******************************************************************************************
'  FIND THE BUSINESS TYPE
'******************************************************************************************

sql = "select BusinessType from BusinessTypeLookup where BusinessTypeID = " & BusinessTypeID   & " order by BusinessType Desc;" 

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If Not rs.eof Then
	BusinessType = rs("BusinessType")
End If 

rs.close
end if 	

%>

</head>
<body >

<!--#Include virtual="/members/MembersHeader.asp"-->
<% Current = "admin" %>
<% Current = "Createevent" %>
<!--#Include file="EventsHeaderTabsInclude.asp"-->


<div class="container">
    <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">

             <form name=form method="post" action="RegCreateTypeCheckAccount.asp">
                 
                 <h2>Get Together</h2>
                  The Basic Event package is ideal if you just need to let people know about the event and receive registration, but nothing fancy (no classes, meals, etc.). Includes:
                 <ul><li>Receive online registrations.</li>
                 <li>Describe your event.</li>
                 <li>List when and where your event is.</li>
                 <li>Information about your organization.</li>
                 <li>Schedule of activities.</li>
                 </ul> <br>
                 <% Comingsoon = false
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <div align = "center"><input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "6">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
					<% end if  %>		</div>  <br>
 </form>

        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Dining Event</h2>
                <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                  This is a good package for an event with meals - a banquet, retreat, or perhaps a reunion.<br />
                  Includes:
                 <ul><li>Receive online registrations.</li>
                 <li>Meal registration (includes menus and options).</li>
                 <li>Describe your event.</li>
                 <li>List when and where your event is.</li>
                 <li>Information about your organization.</li>
                 <li>Schedule of activities.</li>
                 </ul> <br>

               <br>
	           <input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "9">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
                <br>
            </form>

        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Seminar (Field Day)</h2>
                  <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                  This is a good package for any seminar, class, workshop type of event, such as farm classes, corporate retreat, or even reunions.<br />
                   Includes:
                 <ul><li>Receive online registrations.</li>
                 <li>Class registration (including instructor's information).</li>
                 <li>Meal registration.</li>
                 <li>Describe your event.</li>
                 <li>List when and where your event is.</li>
                 <li>Information about your organization.</li>
                 <li>Schedule of activities.</li>
                 </ul> <br>
                   <% Comingsoon = False
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "4">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
						<% end if %>	<br>
            </form>



        </div>

        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Conference</h2>
                <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                  <br />Includes:
                 <ul>
                     <li>Receive payments online.</li>
                    <li>Map & directions.</li>
                    <li>Invatations.</li>
                    <li>Directory listing.</li>
                    <li>Event registration.</li>
                    <li>Schedule Of activities.</li>
                    <li>Vendors.</li>
                    <li>Meals (times, menu).</li>
                    <li>Classes.</li>
                    <li>Reports.</li>
                 </ul> <br>
                   <% Comingsoon = false
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "3">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
				<% end if %>		 <br> 
            </form>


        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Harvest Festival <small></small></h2>
               <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                <br />Includes:
                 <ul>
                     <li>Receive payments online.</li>
                     <li>Reports.</li>
                     <li>Map & directions.</li>
                     <li>Invatations.</li>
                     <li>Directory listing.</li>
                     <li>Event registration.</li>
                     <li>Schedule Of activities.</li>
                     <li>Vendors.</li>
                     <li>Meals (times, menu).</li>
                     <li>Classes.</li>
                     <li>Staff.</li>
                     <li>Volenteers.</li>
                     <li>Sponsors.</li>
                     <li>Advertiser.</li>
                     <li>Silent auction.</li>
                     <li>Contests.</li>
                     <li>Ticket vendors.</li>
                     <li>Rides.</li>
                 </ul> <br>
                   <% Comingsoon = False
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <div align = "center"><input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "2">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
						<% end if %>	</div>  <br>
             </form></div>
      <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Trade Show</h2>
                <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                 <br />Includes:
               
                 <ul><li>Receive payments online.</li>
                    <li>Reports.</li>
                    <li>Map & directions.</li>
                    <li>Invatations.</li>
                    <li>Directory listing.</li>
                    <li>Event registration.</li>
                    <li>Schedule Of activities.</li>
                    <li>Vendors.</li>
                    <li>Meals (times, menu).</li>
                    <li>Classes.</li>
                    <li>Staff.</li>
                    <li>Volenteers.</li>
                    <li>Sponsors.</li>
                    <li>Advertiser.</li>
                 </ul>
                       
                 <br>
                   <% Comingsoon = False
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <div align = "center"><input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "1">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
				<% end if %>	
                </form></div>
    </div>
</div>
 <div class="row">
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
            <h2>Livestock Show</h2>
              <form  name=form method="post" action="RegCreateTypeCheckAccount.asp">
                  Spin-Off meets fleece show with this special type of composit show.<br />
                   Includes:
               <ul><li>Receive payments online.</li>
                    <li>Reports.</li>
                    <li>Map & directions.</li>
                    <li>Invatations.</li>
                    <li>Directory listing.</li>
                    <li>Event registration.</li>
                    <li>Schedule Of activities.</li>
                    <li>Vendors.</li>
                    <li>Meals (times, menu).</li>
                    <li>Classes.</li>
                    <li>Staff.</li>
                    <li>Volenteers.</li>
                    <li>Sponsors.</li>
                    <li>Advertiser.</li>
                    <li>Silent Auction.</li>
                    <li>Contests.</li>
                    <li>Live Auctions.</li>
                    <li>Fleece.</li>
                    <li>Spin-Off.</li>
                    <li>Halter show.</li>
                    <li>Tickets.</li>
                    <li>Rides.</li>
                    <li>Performances.</li>
                 </ul>
      <br>
        <% Comingsoon = False
                 if Comingsoon = True then %>
                 <center><b>Coming Soon!:</b></center>
                 <% else %>
               <br>
	           <input name="EventID"  type = "hidden" value = "<%=EventID%>">
	            <input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
                <input name="EventTypeID"  type = "hidden" value = "7">
            	<input name="Edit"  type = "hidden" value = "<%=Edit%>">
        		<input type=submit value="Get Started"  class = "regsubmit2" >
					<% end if %>	  <br>
            </form>
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 roundedtopandbottom">
        
        
        
        </div>
        <div class="col-lg-4 col-md-4 col-sm-6 col-6 d-md-none d-lg-block roundedtopandbottom">
            
        
        
        
        </div>
    </div>
</div>



<!--#Include File ="Footer.asp"--> 
</body>
</HTML>