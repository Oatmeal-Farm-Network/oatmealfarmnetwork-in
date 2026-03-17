<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<%  PageName = "Registry" %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<title>Create Event</title>
<meta http-equiv="Content-Language" content="en-us">

<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- Bootstrap Datepicker JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
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

<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
		numberfield.select();
		numberfield.focus();
		return false;
	}
	else
	{
		return true;
	}
}

function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789:"  ;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK  + "\" ."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{
}
}
//  End -->
</script>


</head>
<body >
<% 'associationid = 41
Current = "admin" %>
	<!--#Include virtual="/members/MembersHeader.asp"-->

<% session("EventID") = ""


    EventTypeID = request.querystring("EventTypeID")

if len(EventTypeID) > 0 then
    session("EventTypeID")  = EventTypeID
  else
     EventTypeID = session("EventTypeID") 
end if 

EventName=""
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
	TimeZone= rs2("TimeZone")
end if	

sql2 = "select * from EventSchedule where EventID= " & EventID & ""
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
while Not rs2.eof  
	ScheduleDateMonth = rs2("ScheduleDateMonth")
	ScheduleDateDay = rs2("ScheduleDateDay")
	ScheduleDateYear = rs2("ScheduleDateYear")
	ScheduleStartTimeHour = rs2("ScheduleStartTimeHour")
	ScheduleEndTimeHour = rs2("ScheduleEndTimeHour")
	ScheduleStartTimeMinute = rs2("ScheduleStartTimeMinute")
if len(ScheduleStartTimeMinute) > 0 then
else
if len(ScheduleStartTimeMinute) =1 then
ScheduleStartTimeMinute = "0" & ScheduleStartTimeMinute
else
ScheduleStartTimeMinute = "00"
end if
end if


	ScheduleEndTimeMinute = rs2("ScheduleEndTimeMinute")
	if len(ScheduleEndTimeMinute) > 0 then
else
if len(ScheduleStartTimeMinute) =1 then
ScheduleEndTimeMinute = "0" & ScheduleEndTimeMinute
else
ScheduleEndTimeMinute = "00"
end if
end if
	ScheduleStartTimeAMPM = rs2("ScheduleStartTimeAMPM")
	ScheduleEndTimeAMPM = rs2("ScheduleEndTimeAMPM")
rs2.movenext
wend


		
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
	BusinessPhone = rs2("Phone")
	BusinessCell = rs2("CellPhone")
	BusinessFax = rs2("Fax")
	BusinessTypeID = rs2("BusinessTypeID")
end if	
rs2.close

			
sql2 = "select Website from Websites where WebsitesID= " & BusinessWebsiteID 

acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	
if Not rs2.eof  Then
BusinessWebsite = rs2("Website")
end if
rs2.close

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
'******************************************************************************************
'  FIND THE EVENT TYPE
'******************************************************************************************
if len(EventTypeID) > 0 then
sql = "select EventType from EventTypesLookup where EventTypeID = " & EventTypeID   & ";" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
If Not rs.eof Then
	EventType = rs("EventType")
End If 
rs.close
end if

if rs.state > 0 then rs.close 
%>


<% Current = "EventsList" %>
<div class="container roundedtopandbottom">
	<div class ="row">
		<div class ="col">
		<H1>Create an Event: About Your Event</H1>
		<form  name=form method="post" action="RegCreateStep2.asp">



		</div>
	</div>

	<%=HSpacer %>
	<div class ="row">
		<div class ="col">
			<h2>Event Name and Website</h2>
		</div>
	</div>
	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Event Type
			<% if len(EventType) > 0 then %>
			  	<b><%=EventType %></b>
			<% end if %>
			<input name="EventTypeID" Value ="<%=EventTypeID%>"  class =" body" type = "hidden" size = "23" maxlength = "61">
		</div>
	</div>
	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Event Name<br />
			<input name="EventName" Value ="<%=EventName%>"  class ="body" size = "23" maxlength = "61">
		</div>
	</div>
	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Event Website<br />
			http://<input name="EventWebsite" Value ="<%=EventWebsite%>" size = "23" maxlength = "61" class =" body">
			<input name="EventWebsiteID" Value ="<%=EventWebsiteID%>"  type = "Hidden">
		</div>
	</div>
		<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			<h2>Date & Time <font color="#abacab">(Optional)</font></h2>
			
			
  <table class="  table-sm" style="max-width: 450px">
    <thead>
      <tr>
        <th scope="col body">Date</th>
        <th scope="col body">Start Time</th>
		<th scope="col body"></th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>

			<script>
    $(document).ready(function(){
        $('#scheduleDatePicker').datepicker({
            format: 'mm/dd/yyyy',
            autoclose: true,
            todayHighlight: true
        });
    });
</script>


        <input type="text" class="form-control form-control-sm" name="ScheduleDate" id="scheduleDatePicker" placeholder="Date"  style="max-width:120px">
        </td>
        <td>
          <div class="input-group input-group-sm">
            <input type="text" class="form-control" name="ScheduleStartTimeHour" maxlength="2" placeholder="HH">
            <span class="input-group-text">:</span>
            <input type="text" class="form-control" name="ScheduleStartTimeMinute" maxlength="2" placeholder="MM">
            <select class="form-select form-select-sm" name="ScheduleStartTimeAMPM"  style="max-width:76px">
              <option value="AM">AM</option>
              <option value="PM">PM</option>
            </select>

          </div>
        </td>
		<td>
			<% Set rs3 = Server.CreateObject("ADODB.Recordset") %>
			<% if len(EventTimeZoneID) > 0 then
                  if rs.state > 0 then
                    rs.close
                  end if

                   sql = "select * from TimeZoneLookup where EventTimeZoneID = " & LocalTimeZoneID
                   rs.Open sql, conn, 3, 3 
                   if not rs.eof then
                                 TimeZoneAbbreviation = rs("Abbreviation")
                               end if
                                rs.close
                           end if
                          %>
                      <select size="1" name="EventTimeZoneID" class="form-select form-select-sm" style="max-width:90px" >
                        <% if len(EventLocationStateIndex) > 0 then %>
                            <option value="<%=EventLocationStateIndex %>" selected><%=AssociationstateName %></option>
                         <% else %>
                             <option value="" selected></option>
                          <% end if %>
                          <%  
                              
                          sql = "select * from TimeZoneLookup order by TimeZoneID" 
							  'response.write("sql=" & sql)
                          if rs3.state > 0 then rs3.close 
                           rs3.Open sql, conn, 3, 3 
                          while not rs3.eof %>
                              <option  value="<%=rs3("TimeZoneID")%>"><%=rs3("Abbreviation") %> (<%=rs3("DisplayName") %>)</option>
                           <% rs3.movenext
                            wend %>
                          </select>
		</td>
      </tr>

      <tr>
        <th scope="col"></th>
        <th scope="col">End Time</th>
      </tr>
      <tr>
        <td>

  
 
        </td>
        <td>
          <div class="input-group input-group-sm" >
            <input type="text" class="form-control" name="ScheduleEndTimeHour" maxlength="2" placeholder="HH">
            <span class="input-group-text">:</span>
            <input type="text" class="form-control" name="ScheduleEndTimeMinute" maxlength="2" placeholder="MM">
            <select class="form-select form-select-sm" name="ScheduleEndTimeAMPM" style="max-width:76px">
              <option value="AM">AM</option>
              <option value="PM">PM</option>
            </select>


          </div>
        </td>
		  <td></td>
      </tr>



    </tbody>
  </table>

<i>You will have opportunities to add extra days later.</i>
		</div>
	</div>
	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			<h2>Event Location</h2>
			Name of Location<br />
				<input name="EventLocationName" Value ="<%=EventLocationName%>" class ="body" size = "30" maxlength = "61">
			
		</div>
	</div>
	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Location's Website<br />
				<input name="EventLocationWebsiteID" Value ="<%=EventLocationWebsiteID%>"  class =" body" type = "Hidden">
				http://<input name="EventLocationWebsite" Value ="<%=EventLocationWebsite%>"  size = "23" maxlength = "61" class =" body">
		</div>
	</div>

	<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Contact Email<br />
			<input name="EventLocationEmail" Value ="<%=EventLocationEmail%>"  size = "23" maxlength = "61" class ="body">
		</div>
	</div>
		<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Address<br />
			<input name="EventLocationAddressID" Value ="<%=EventLocationAddressID%>"  type = "Hidden">
			<input name="EventLocationStreet" Value ="<%=EventLocationStreet%>"  size = "23" maxlength = "61" class ="body">
		</div>
	</div>
		<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Apartment / Suite<br />
			<input name="EventLocationApt" Value ="<%=EventLocationApt%>"  size = "23" maxlength = "61" class ="body">

		</div>
	</div>
		<%=HSpacer %>

<% if len(EventLocationStateIndex) > 1 then %>
	<div class ="row">
		<div class ="col body">
			State/ Provence<br />
		</div>
	</div>

	<%=HSpacer  %> 

                 <div class ="row">
                    <div class ="col body">
                       <%   If len(EventLocationStateIndex) > 0 then
						   else
						   EventLocationStateIndex = CustomerAddressCountry
						   end if

                           if len(EventLocationStateIndex) > 0 then
                                if rs.state > 0 then
                                 rs.close
                               end if

                               sql = "select Name from state_province where Stateindex = " & EventLocationStateIndex
                          ' response.write("sql=" & sql)

                               rs.Open sql, conn, 3, 3 
                               if not rs.eof then
                                 AssociationstateName = rs("Name")
                               end if
                                rs.close
                           end if
                          %>
                            Province / State  <font color="#abacab">(Optional)</font><br />
                            <select size="1" name="EventLocationStateIndex" class = "body" style="min-width:320px; min-height:40px" >
                            <% if len(EventLocationStateIndex) > 0 then %>
                            <option value="<%=EventLocationStateIndex %>" selected><%=AssociationstateName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  
                              
                          sql = "select Stateindex, Name from state_province where country_id=" & AssociationCountry_id
                             'response.write("sql=" & sql)
                          if rs3.state > 0 then rs3.close 
                           rs3.Open sql, conn, 3, 3 
                          while not rs3.eof %>
                              <option  value="<%=rs3("Stateindex")%>"><%=rs3("Name") %></option>
                           <% rs3.movenext
                            wend %>
                          </select>
                     </div>
                </div>
<% end if %>
	<div class ="row">
		<div class ="col body">
                 <div class ="row">
                    <div class ="col body">
                        Country<br />
                       <% 
						    if len(EventLocationCountry_id) > 1 then
						   else
							EventLocationCountry_id = Customercountry_id
						   end if
						   
						   if len(EventLocationCountry_id) > 1 then
                            if rs.state > 0 then
                                rs.close
                            end if
                            Set rs = Server.CreateObject("ADODB.Recordset")

                            sql = "select Name from Country where country_id = " & EventLocationCountry_id
                             rs.Open sql, conn, 3, 3 
                            if not rs.eof then
                            AssociationCountryName = rs("Name")

                            end if
                          end if %>


                        <select size="1" name="EventLocationCountry_id" class = "formbox" style="min-width:320px; min-height:40px" required>
                            <% if len(EventLocationCountry_id) > 0 then %>
                            <option value="<%=EventLocationCountry_id %>" class = "body" selected><%=AssociationCountryName %></option>
                            <% else %>
                             <option value="" class = "body"selected></option>
                            <% end if %>
                          <%  sql = "select country_id, Name from Country"
                             'response.write("sql=" & sql)
                          Set rs3 = Server.CreateObject("ADODB.Recordset")
                           rs3.Open sql, conn, 3, 3 
                          while not rs3.eof %>
                              <option class = "body" value="<%=rs3("country_id")%>"><%=rs3("Name") %></option>
                           <% rs3.movenext
                            wend %>
                          </select>
                    </div>
                </div>

		</div>
	</div>
		<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Postal Code<br />
			<input name="EventLocationZip"  size = "8" value = "<%=EventLocationZip%>" class ="body">
		</div>
	</div>
		<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Phone<br />
			<input name="EventLocationPhoneID" Value ="<%=EventLocationPhoneID%>"  type = "Hidden">
			<input name="EventLocationPhone" Value ="<%=EventLocationPhone%>"  size = "23" maxlength = "61" class ="body">
		</div>
	</div>
			<%=HSpacer %>
	<div class ="row">
		<div class ="col body">
			Cell<br />
			<input name="EventLocationCell" Value ="<%=EventLocationCell%>" class ="body" size = "23" maxlength = "61">
		</div>
	</div>





<%'Payment Options Table
If EventTypeID = 5 then

%>
<table border = "0" cellspacing="0" cellpadding = "0" width = "100%"><tr><td class = "roundedtop" align = "left"><h2>Payment Options!</h2></td></tr>
<tr><td class = "roundedBottom">	

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=3  width = "420" align = "center">
	<tr>			
	  	<td  colspan = "2" class = "body2" align = "left">
	     	How will you accept payments?  (paypal only, checks only, paypal or checks)
	  	</td>
	 </tr>
	<tr>
		<td class = "body2" colspan = "2" align = "left">
		<% if PayPal = True then
		    PayPalCheck = "checked"
		   else
		   	PayPalCheck = ""
		   end if 
		   
		   if Checks = True then
		    ChecksCheck = "checked"
		   else
		   	ChecksCheck = ""
		   end if
		   %>
					<input name="PaymentOptionsID" Value ="<%=PaymentOptionsID%>"  type = "hidden"><br>
			<input type="checkbox" name="PayPal"  <%=PayPalCheck %> >Paypal<br>
			<img src = "images/px.gif" width = "20" height = "1">Paypal Email Address: &nbsp;
	
				<input name="PaypalEmail" Value ="<%=PaypalEmail%>"  size = "33" ><br>
				<img src = "images/px.gif" width = "20" height = "1"><small>This is the email address associated with your Paypal account.</small>
			</td>
		</tr>
		<tr>
		<td class = "body2" colspan = "2" align = "left">
				<input type="checkbox" name="Checks"  <%=ChecksCheck%> >Check<br>
				<img src = "images/px.gif" width = "20" height = "1">Pay To: <input name="PaymentName"  size = "30" value = "<%=PaymentName%>"><br>
				<img src = "images/px.gif" width = "20" height = "1"><small>Enter the name of the person or organization the check should <br><img src = "images/px.gif" width = "20" height = "1">be addressed to.</small>

			</td>
		</tr>
		<tr>
		  <td   class = "body2" colspan = "2" align = "left">
				<img src = "images/px.gif" width = "20" height = "1">Address that the check should be sent to:
			</td>
		</tr>
		<tr>
		  	<td   class = "body2" align = "right">
				<div align = "right">Mailing Address: &nbsp;</div>
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PaymentStreet"  size = "30" value = "<%=PaymentStreet%>">
			</td>
		</tr>
		<tr>
			<td   class = "body2"  align = "right">
				<div align = "right">Apartment / Suite: &nbsp;</div>
			</td>
			<td  valign = "top" class = "body2" align = "left">
				<input name="PaymentStreet2"  size = "30" value = "<%=PaymentStreet2%>">
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				<div align = "right">City: &nbsp;</div>
			</td>
			<td  valign = "top" class = "body2" align = "left">
				<input name="PaymentCity"  size = "30" value = "<%=PaymentCity%>">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body2">
				<div align = "right">State/ Provence: &nbsp;</div>
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<select size="1" name="PaymentState">
				<% If Len(PaymentState) > 0 then%>
					<option value="<%=PaymentState%>" selected><%=PaymentState%></option>
				<% Else %>
					<option value="" selected>-----</option>
				<% End If %>
				<option value="AL">AL</option>
				<option  value="AK">AK</option>
				<option  value="AZ">AZ</option>
				<option  value="AR">AR</option>
				<option  value="CA">CA</option>
				<option  value="CO">CO</option>
				<option  value="CT">CT</option>
				<option  value="DE">DE</option>
				<option  value="DC">DC</option>
				<option  value="FL">FL</option>
				<option  value="GA">GA</option>
				<option  value="HI">HI</option>
				<option  value="ID">ID</option>
				<option  value="IL">IL</option>
				<option  value="IN">IN</option>
				<option  value="IA">IA</option>
				<option  value="KS">KS</option>
				<option  value="KY">KY</option>
				<option  value="LA">LA</option>
				<option  value="ME">ME</option>
				<option  value="MD">MD</option>
				<option  value="MA">MA</option>
				<option  value="MI">MI</option>
				<option  value="MN">MN</option>
				<option  value="MS">MS</option>
				<option  value="MO">MO</option>
				<option  value="MT">MT</option>
				<option  value="NE">NE</option>
				<option  value="NV">NV</option>
				<option  value="NH">NH</option>
				<option  value="NJ">NJ</option>
				<option  value="NM">NM</option>
				<option  value="NY">NY</option>
				<option  value="NC">NC</option>
				<option  value="ND">ND</option>
				<option  value="OH">OH</option>
				<option  value="OK">OK</option>
				<option  value="OR">OR</option>
				<option  value="PA">PA</option>
				<option  value="RI">RI</option>
				<option  value="SC">SC</option>
				<option  value="SD">SD</option>
				<option  value="TN">TN</option>
				<option  value="TX">TX</option>
				<option  value="UT">UT</option>
				<option  value="VT">VT</option>
				<option  value="VA">VA</option>
				<option  value="WA">WA</option>
				<option  value="WV">WV</option>
				<option  value="WI">WI</option>
				<option  value="WY">WY</option>
				<option  value=""></option>
				<option  value="ON">ON</option>
				<option  value="QC">QC</option>
				<option  value="BC">BC</option>
				<option  value="AB">AB</option>
				<option  value="MB">MB</option>
				<option  value="SK">SK</option>
				<option  value="NS">NS</option>
				<option  value="NB">NB</option>
				<option  value="NL">NL</option>
				<option  value="PE">PE</option>
				<option  value="NT">NT</option>
				<option  value="YK">YK</option>
				<option  value="NU">NU</option>
			</select>
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Postal Code: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="PaymentZip"  size = "8" value = "<%=PaymentZip%>">
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body2">
			<div align = "right">Country:  &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
		
			<select size="1" name="PaymentCountry">
					<% if PaymentCountry = "Canada" then %>
				<option value="USA" >USA</option>
				<option value="Canada" selected>Canada</option>
				<% else %>	
				<option value="USA" selected>USA</option>
				<option value="Canada">Canada</option>
				<% end if %>
		
	        </select>
		</td>
	</tr>
</table>

		</td>
	</tr>
</table><br>
<% end if %>


<%' Who is Putting on the Event Table
if not EventTypeID = 6 then
	%>




 <table border = "0" cellspacing="0" cellpadding = "0" width = "100%">

<tr><td class = "roundedtop" align = "left"><h2>Who is Putting on the Event?</h2></td></tr>
<tr><td class = "roundedBottom">	


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=3  width = "100%" align = "center">
	<tr>			
	  	<td  colspan = "2" class = "body2">
	     	Please enter below information about the Association or business that is hosting the event, if applicable.
	  	</td>
	</tr>
	<tr>
		<td class = "body2" align = "right" width = "200">
			<div align = "right">Organization's Name: &nbsp;</div>
		</td>
		<td class = "body2" align = "left">
		<input name="BusinessID" Value ="<%=BusinessID%>"  type = "Hidden">
			<input name="BusinessName" Value ="<%=BusinessName%>"  size = "23" maxlength = "61">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			<div align = "right">Organization's Type: &nbsp;</div>
		</td>
		<td class = "body2" align = "left">
					
			<select size="1" name="BusinessTypeID">
			<option value= "2">N/A</option>
<% 
  sql = "select * from BusinessTypeLookup where not BusinessTypeID = 2 "
  Set rs = Server.CreateObject("ADODB.Recordset")
  rs.Open sql, conn, 3, 3   
  if not rs.eof then
  while not rs.eof %>
  
		<option value= "<%=rs("BusinessTypeID") %>"><%=rs("BusinessType") %></option>
<% 
  rs.movenext
  wend 
end if %>
 			</select>
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			<div align = "right">Website: &nbsp;</div>
		</td>
		<td class = "body2" align = "left">
			<input name="BusinessWebsiteID" Value ="<%=BusinessWebsiteID%>"  type = "Hidden">
			http://<input name="BusinessWebsite" Value ="<%=BusinessWebsite%>"  class =" body" size = "23" maxlength = "61">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			<div align = "right">Hours of Operation: &nbsp;</div>
		</td>
		<td class = "body2" align = "left">
			<input name="BusinessHours" Value ="<%=BusinessHours%>"  size = "23" maxlength = "61">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			<div align = "right">Contact Email: &nbsp;</div>
		</td>
		<td class = "body2" align = "left">
			<input name="BusinessEmail" Value ="<%=BusinessEmail%>"  size = "23" maxlength = "61">
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Mailing Address: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="BusinessAddressID" Value ="<%=BusinessAddressID%>"  type = "Hidden">
			<input name="BusinessAddress"  size = "30" value = "<%=BusinessAddress%>">
		</td>
	</tr>
	<tr>
		<td   class = "body2"  align = "right">
			<div align = "right">Apartment / Suite: &nbsp;</div>
		</td>
		<td  valign = "top" class = "body2" align = "left">
			<input name="BusinessApt"  size = "30" value = "<%=BusinessApt%>">
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">City: &nbsp;</div>
		</td>
		<td  valign = "top" class = "body2" align = "left">
			<input name="BusinessCity"  size = "30" value = "<%=BusinessCity%>">
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body2">
			<div align = "right">State/ Provence: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<select size="1" name="BusinessState">
				<% If Len(BusinessState) > 0 then%>
				<option value="<%=BusinessState%>" selected><%=BusinessState%></option>
				<% Else %>
				<option value="" selected>-----</option>
				<% End If %>
				<option value="AL">AL</option>
				<option  value="AK">AK</option>
				<option  value="AZ">AZ</option>
				<option  value="AR">AR</option>
				<option  value="CA">CA</option>
				<option  value="CO">CO</option>
				<option  value="CT">CT</option>
				<option  value="DE">DE</option>
				<option  value="DC">DC</option>
				<option  value="FL">FL</option>
				<option  value="GA">GA</option>
				<option  value="HI">HI</option>
				<option  value="ID">ID</option>
				<option  value="IL">IL</option>
				<option  value="IN">IN</option>
				<option  value="IA">IA</option>
				<option  value="KS">KS</option>
				<option  value="KY">KY</option>
				<option  value="LA">LA</option>
				<option  value="ME">ME</option>
				<option  value="MD">MD</option>
				<option  value="MA">MA</option>
				<option  value="MI">MI</option>
				<option  value="MN">MN</option>
				<option  value="MS">MS</option>
				<option  value="MO">MO</option>
				<option  value="MT">MT</option>
				<option  value="NE">NE</option>
				<option  value="NV">NV</option>
				<option  value="NH">NH</option>
				<option  value="NJ">NJ</option>
				<option  value="NM">NM</option>
				<option  value="NY">NY</option>
				<option  value="NC">NC</option>
				<option  value="ND">ND</option>
				<option  value="OH">OH</option>
				<option  value="OK">OK</option>
				<option  value="OR">OR</option>
				<option  value="PA">PA</option>
				<option  value="RI">RI</option>
				<option  value="SC">SC</option>
				<option  value="SD">SD</option>
				<option  value="TN">TN</option>
				<option  value="TX">TX</option>
				<option  value="UT">UT</option>
				<option  value="VT">VT</option>
				<option  value="VA">VA</option>
				<option  value="WA">WA</option>
				<option  value="WV">WV</option>
				<option  value="WI">WI</option>
				<option  value="WY">WY</option>
				<option  value=""></option>
				<option  value="ON">ON</option>
				<option  value="QC">QC</option>
				<option  value="BC">BC</option>
				<option  value="AB">AB</option>
				<option  value="MB">MB</option>
				<option  value="SK">SK</option>
				<option  value="NS">NS</option>
				<option  value="NB">NB</option>
				<option  value="NL">NL</option>
				<option  value="PE">PE</option>
				<option  value="NT">NT</option>
				<option  value="YK">YK</option>
				<option  value="NU">NU</option>
			</select>
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Postal Code: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="BusinessZip"  size = "8" value = "<%=BusinessZip%>">
		</td>
	</tr>
	<tr>
		<td  align = "right" class = "body2">
			<div align = "right">Country:  &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<select size="1" name="BusinessCountry">
					<% if BusinessCountry = "Canada" then %>
				<option value="USA" >USA</option>
				<option value="Canada" selected>Canada</option>
				<% else %>	
				<option value="USA" selected>USA</option>
				<option value="Canada">Canada</option>
				<% end if %>
	    	</select>
		</td>
	</tr>				
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Phone: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="BusinessPhoneID" Value ="<%=BusinessPhoneID%>"  type = "Hidden">
			<input name="BusinessPhone"  size = "30" value = "<%=BusinessPhone%>">
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Cell: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="BusinessCell"  size = "30" value = "<%=BusinessCell%>">
		</td>
	</tr>
	<tr>
		<td   class = "body2" align = "right">
			<div align = "right">Fax: &nbsp;</div>
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="BusinessFax"  size = "30" value = "<%=BusinessFax%>">
		</td>
		</tr>
			<tr>
		<td   class = "body2" align = "right">
			 &nbsp;
		</td>
		<td  align = "left" valign = "top" class = "body2">
			
		</td>
		</tr>		
	</table>
	</td>
</tr>
</table>
	</td>
</tr>
</table>

<% end if %>

<div>
	<div>
		<br>
	<input name="EventID"  type = "hidden" value = "<%=EventID%>">
	<input name="PeopleID"  type = "hidden" value = "<%=PeopleID%>">
		<input name="EventLocationID"  type = "hidden" value = "<%=EventLocationID%>">

	<input name="Edit"  type = "hidden" value = "<%=Edit%>">

		<input type=submit value="Next"  class = "regsubmit2" >
		<br>	<br>

	</div>
</div>
</div>
<br><br>
	</div>

<br />

<!--#Include virtual="/members/membersFooter.asp"-->
</body>
</HTML>