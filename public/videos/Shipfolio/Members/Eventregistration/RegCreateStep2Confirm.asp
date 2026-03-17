<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<%  PageName = "Registry" %>
<!--#Include file="AdminEventGlobalVariables.asp"-->
<title>Create Event</title>
<meta http-equiv="Content-Language" content="en-us">
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminEventsHeader.asp"-->
<% Current = "Createevent" %>
<!--#Include file="OverviewHeader.asp"-->

<%
EventID = Request.Querystring("EventID")
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>"><tr><td class = "roundedtop" align = "left">
	<H1>Create an Event:  Confirm Your Information</H1>
</td></tr>
<tr><td class = "roundedBottom">

<form  name=form method="post" action="RegCreateStep2.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "100%" align = "center">
<tr>
		<td class ="body2" valign = "top" colspan = "2" >
			Please verify your information below, then select either of the options at the bottom of this page to either go back and make changes or proceed to the text step.
			<br>* Required field
		</td>
	</tr>
	<tr>
	<% if screenwidth < 898 then %>	
</tr><tr><td width = "100%">
<% else %>
<td width = "50%" valign = "top">
<% end if %>
	
	   
	
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
	<H1>A Little About Your Event</H1>
</td></tr>
<tr><td class = "roundedBottom">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%" align = "center">
	<tr>
				<td  class = "body2right" width = "200">
					Event Type:
				</td>
				<td class = "body2"  align = "left">
					
		<%=EventType %>
    	</td>
	</tr>
	<tr>
		<td class = "body2right">
			Event Name:&nbsp;
		</td>
		<td class = "body2" align = "left">
			<%=EventName%>
		</td>
</tr>
	<tr>
		<td class = "body2right">
			Date: &nbsp;</td>
		<td class = "body2" align = "left">
				<%=ScheduleDateMonth %>/<%= ScheduleDateDay %>/<%=ScheduleDateYear %><br />
					<%=ScheduleStartTimeHour%>:<%=ScheduleStartTimeMinute%> - <%=ScheduleEndTimeHour%>:<%=ScheduleEndTimeMinute%>
		</td>
	   </tr>
	   <tr>
		<td class = "body2right">
			Event Website: &nbsp;
		</td>
		<td class = "body2" align = "left">
			<%=EventWebsite%>
		</td>
</tr>
</table>
	</td>
</tr>
</table>
        <br>
        	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
	<H1>Event Location</H1>
</td></tr>
<tr><td class = "roundedBottom">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%" align = "center">
<tr>							<td class = "body2right" width = "200">
								Name of Location: &nbsp;
							</td>
							<td class = "body2" align = "left" >
								<%=EventLocationName%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								Location's Website: &nbsp;
							</td>
							<td class = "body2" align = "left">
									<%=EventLocationWebsite%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								Hours Of Operation: &nbsp;
							</td>
							<td class = "body2" align = "left">
									<%=EventLocationHours%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								Contact Email: &nbsp;
							</td>
							<td class = "body2" align = "left">
									<%=EventLocationEmail%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								Mailing Address: &nbsp;
							</td>
							<td class = "body2" align = "left">
									<%=EventLocationStreet%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								Apartment / Suite: &nbsp;
							</td>
							<td class = "body2" align = "left">
								<%=EventLocationApt%>
							</td>
						</tr>
						<tr>
							<td class = "body2right">
								City: &nbsp;
							</td>
							<td class = "body2" align = "left">
								<%=EventLocationCity%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
							<%=EventLocationState%>
						</td>
					</tr>
					<tr>
							<td   class = "body2right">
								Country: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
							<%=EventLocationCountry%>
						</td>
					</tr>

					<tr>
						<td class = "body2right">
								Phone: &nbsp;
							</td>
						<td class = "body2" align = "left">
								<%=EventLocationPhone%>
							</td>
					</tr>
					<tr>
						<td class = "body2right">
								Cell: &nbsp;
							</td>
						<td class = "body2" align = "left">
								<%=EventLocationCell%>
							</td>
					</tr>
					<tr>
						<td class = "body2right">
								Fax: &nbsp;
							</td>
						<td class = "body2" align = "left">
								<%=EventLocationFax%>
							</td>
					</tr>
</table>
</td>
					</tr>
</table>

       </td>
       
   <% if screenwidth < 898 then %>	
</tr><tr><td width = "100%">
<% else %>
<td width = "50%" valign = "top">
<% end if %>    

	  <%'Payment Options Table

If not EventTypeID = 5 then

%>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
	<H1>Payment Options</H1>
</td></tr>
<tr><td class = "roundedBottom">	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%" align = "center">
	<tr>			
	  	<td  colspan = "2" class = "body2" align = "left">
	     <%  if Checks = "on" or Checks = "True" or len(PaymentName) > 1 or len(PaymentStreet) > 1 or len(PaymentStreet2) > 1 or len(PaymentCity) > 1  or len(PaymentZip) > 1 or  PayPal = "on" or PayPal = "True" or len(PaypalEmail) > 1 then %>	
	     	
	     	
       	 	Accept payment in the following ways:<br>
			<input name="PaymentOptionsID" Value ="<%=PaymentOptionsID%>"  type = "hidden"> 
			</td>
		</tr>
				<% 	if PayPal = "on" or PayPal = "True" or len(PaypalEmail) > 1  then %>
		   		<tr>
				<td class = "body2" colspan = "2" align = "left">
				<img src = "images/px.gif" width = "20" height = "1">Paypal Email Address: &nbsp;
				<%=PaypalEmail%><br>
				</td>
				</tr>
				<% end if %>
				
				<%  if Checks = "on" or Checks = "True" or len(PaymentName) > 1 or len(PaymentStreet) > 1 or len(PaymentStreet2) > 1 or len(PaymentCity) > 1 or len(PaymentState) > 1 or len(PaymentCountry) > 1 or len(PaymentZip) > 1 then %>

						
					<tr>
						  <td   class = "body2" colspan = "2" align = "left">
								<img src = "images/px.gif" width = "20" height = "1">Address that the check should be sent to:
							</td>
						</tr>
					<tr>
						<td   class = "body2right" width = "170">
								Pay To:&nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2" width = "280">
							<%=PaymentName%>
							</td>
					</tr>
					<tr>
						  <td   class = "body2right">
								Mailing Address: &nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2">
								<%=PaymentStreet%>
							</td>
						</tr>
						<tr>
						<td    class = "body2right">
								Apartment / Suite: &nbsp;
						</td>
						<td  valign = "top" class = "body2" align = "left">
								<%=PaymentStreet2%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2" align = "left">
								<%=PaymentCity%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right" >
								State / Provence: &nbsp;
					</td>
					<td  align = "left" valign = "top" class = "body2">

							<%=PaymentState%>
							</td>
						</tr>
						<tr>
					<td   class = "body2right">
								Country:  &nbsp;
					</td>
					<td  align = "left" valign = "top" class = "body2">
					
						<%=PaymentCountry%>
					</td>
					</tr>

						<tr>
							<td   class = "body2right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=PaymentZip%>
							</td>
						</tr>
					<% end if %>
			<% else %>
				<tr>
					<td   class = "body2" colspan = "2">
						Currently you do not have any payment options selected.
							</td>
						</tr>

			
			<% end if %>
		</table>
</td>
</tr>
</table><br>
	<% end if %>

	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
	<H1>Who is Putting on the Event?</H1>
</td></tr>
<tr><td class = "roundedBottom">	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%" align = "center">
					<tr>
						<td class = "body2right" width = "150">
							Organization's Name: &nbsp;
						</td>
						<td class = "body2" width = "300" align = "left">
							<%=BusinessName%>
						</td>
					</tr>
					<tr>
						<td class = "body2right">
							Organization's Type: &nbsp;
						</td>
						<td class = "body2" align = "left">
						<%=BusinessType %>
						</td>
					</tr>
					<tr>
						<td class = "body2right">
							Website: &nbsp;
						</td>
						<td class = "body2" align = "left">
								<%=BusinessWebsite%>
							</td>
						</tr>
						<tr>
						<td class = "body2right">
							Hours of Operation: &nbsp;
						</td>
						<td class = "body2" align = "left">
							<%=BusinessHours%>
							</td>
						</tr>
					<tr>
							<td class = "body2right">
								Contact Email: &nbsp;
							</td>
						<td class = "body2" align = "left">
							<%=BusinessEmail%>
						</td>

					<tr>
						  <td   class = "body2right">
								Mailing Address: &nbsp;
							</td>

							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessAddress%>
							</td>
						</tr>
						<tr>
						<td   class = "body2"  align = "right">
								Apartment / Suite: &nbsp;
						</td>
						<td  valign = "top" class = "body2" align = "left">
							<%=BusinessApt%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2" align = "left">
								<%=BusinessCity%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessState%>

							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessZip%>
							</td>
						</tr>

								<tr>
							<td   class = "body2right">
								Country: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
							<%=BusinessCountry%>
						</td>
					</tr>

						<tr>
							<td   class = "body2right">
								Postal Code: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessZip%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								Phone: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessPhone%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								Cell: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessCell%>
							</td>
						</tr>
						<tr>
							<td   class = "body2right">
								Fax: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
								<%=BusinessFax%>
					</td>
				</tr>
				<tr><td height = "65"><br>
				</td>
				</tr>
		</table>
			</td>
				</tr>
		</table>
	</td>
</tr>
</table>

<table width = "100%"  align = "center"  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<tr>
	<td class ="body2" valign = "top"  align = "center">
			<center><a href = "regcreate.asp?EventID=<%=EventID %>&PeopleID=<%=session("PeopleID")%>&Edit=True" class = "body2"><h2><center>Make Change</center></h2></a>
			<a href = "regcreate.asp?EventID=<%=EventID %>&PeopleID=<%=session("PeopleID")%>&Edit=True" class = "body2">Click here to go back and make changes.</a><br><br></center>
	</td>
	<td class ="body2" valign = "top"  align = "center">
			<center><a href = "regcreateStep3.asp?EventID=<%=EventID%>&EventTypeID=<%=EventTypeID%>&PeopleID=<%=session("PeopleID")%>" class = "body2"><h2><center>Proceed</center></h2></a>
			<a href = "regcreateStep3.asp?EventID=<%=EventID%>&EventTypeID=<%=EventTypeID%>&PeopleID=<%=session("PeopleID")%>" class = "body2">Click here to proceed to the next step.</a><br><br></center>
		</td>
	</tr>
</table>
		
					
 </form> 
<br>
		</td>
	</tr>
</table><br><br>








		<!--#Include file="Footer.asp"-->

		</Body>
</HTML>

