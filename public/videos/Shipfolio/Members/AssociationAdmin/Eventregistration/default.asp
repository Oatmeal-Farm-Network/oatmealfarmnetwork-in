<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<title>List of Events</title>

<%  PageName = "Home Page" %>
<!--#Include file="AdminEventGlobalVariables.asp"-->
</head>
<% if mobiledevice = True  then %>
<BODY border="0"cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center">
<% else %>
<body border="0"cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>

<% 
associationid = session("AssociationID")
Current1="EventRegistration"
Current2 = "Eventhome"
Current = "EventsList" %>
<!--#Include virtual="/associationadmin/AssociationHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>"><tr><td align = "left">
<H1>Your Events</H1>
<table border="0" cellspacing="0" cellpadding="0" align = "left"  width = "<%=screenwidth - 35 %>" >
<tr><td>


<%	

if len(PeopleID) < 1 and len(AssociationID) < 1 then
       Response.redirect("/associationadmin/associationLogin.asp")
     
end if 


sql2 = "select * from Event where Event.AssociationID = " & session("AssociationID")
'response.write("sql2=" & sql2)

	'response.write("Reg Home sql2 = " & sql2 & "<br/>")
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof Then %>
<table border = "0" cellspacing="0" cellpadding="0" align = "left"  valign ="top"  width = "<%=screenwidth - 35 %>" >
<tr><td class = "body2" width = "50" align = "center">
</td>
<td class = "body2" width = "400" align = "center" height = "40">
<b>Event Name</b>
</td>
<td class = "body2" width = "100" align = "center">
<b>Event Status</b>
</td>
<td class = "body2" width = "100" align = "center">
<b>Start Date</b>
</td>
<td class = "body2" width = "100" align = "center">
<b>End Date</b>
</td>
<td class = "body2" width = "50" align = "center">
</td>
</tr>
<% while Not rs2.eof 	%>
<tr><td class = "body2" align = "center">
<a href="RegManageHome.asp?EventID=<%=rs2("EventID") %>" class = "body2">Edit</a>
</td>
<td class = "body2">
		&nbsp;&nbsp;&nbsp;<a href = "RegManageHome.asp?EventID=<%=rs2("EventID") %>" class = "body"><%=rs2("EventName")%></a>
	</td>
	<td   class = "body2" align = "center"><%=rs2("EventStatus")%>
	</td>
	<td class = "body2" align = "right">
		<%=rs2("EventStartMonth")%>/<%=rs2("EventStartDay")%>/<%=rs2("EventStartYear")%>&nbsp;&nbsp;&nbsp;
	</td>
	<td class = "body2" align = "right">
		<%=rs2("EventEndMonth")%>/<%=rs2("EventEndDay")%>/<%=rs2("EventEndYear")%>&nbsp;&nbsp;&nbsp;
	</td>
	<td class = "body2" align = "center"> 
		<a href = "DeleteEvent.asp?EventID=<%=rs2("EventID") %>&PeopleID=<%=PeopleID %>" class = "body2">delete</a>
		</td>
</tr>
		<% rs2.movenext
	Wend %>
		</table>

<% else %>
 <table cellpadding = 0 cellspacing = 0 border = 0 width = "<%=screenwidth - 35 %>">
    <tr><td class = "body2"><h2>No Events Available</h2>
 You do not currently have any events listed. <a href = "regcreateType.asp?PeopleID=<%=PeopleID%>" class = "body2" >Click here to add an event</a>.
</td></tr></table>

		<% End if
rs2.close
Set conn = Nothing	%>

	  </TD>
	</tr>
</table>
</TD>
	</tr>
</table>
<br /><br />
</TD>
	</tr>
</table>
<!--#Include virtual="/associationadmin/AssociationFooter.asp"-->
</body>
</html>