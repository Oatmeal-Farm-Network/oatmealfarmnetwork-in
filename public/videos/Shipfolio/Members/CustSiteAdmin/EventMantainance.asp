<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
</HEAD>
<%
EventID = request.form("EventID")
if len(EventID) > 0 then
else
EventID = request.querystring("EventID")
end if

if len(EventID) > 0 then
else
EventID = Session("EventID")
end if

if len(EventID) > 0 then
session("EventID") = EventID
end if

 if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?eventID=<%=EventID%>&ScreenWidth=' + self.innerWidth);">
<% end if 

%>
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>


 <%  Current4 = "EventsAdmin" 
Current3 = "EditEvents"    %> 
<!--#Include file="EventsTabsInclude.asp"-->



<%
dim EventIDArray(1000)
dim EventNameArray(1000)


	
sql2 = "select * from Event order by EventStartYear Desc, EventStartMonth, EventStartDay desc "
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if rs2.eof then %>
<% if screenwidth < 989 then %>
<table border = "1" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Edit an Event</div></H2>
 </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" >
        Currently you do not have any events entered. To add event please select the <a href = "EventsAdd.asp" class = "body">Add Events</a> tab.
        </td>
        </tr>
        </table>
        
<%	else
	
	While Not rs2.eof  
		EventIDArray(acounter) = rs2("EventID")
		EventNameArray(acounter) = rs2("EventName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

  %>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr><td class = "roundedtop" align = "left">
		<H2>Edit a Listing</H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left" valign = "top" width = "100%">
			<form  action="EventMantainance.asp" method = "post" name = "edit1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
			   <tr>
				<td colspan ="10">
					&nbsp;
				</td>
				 <td class = "body" >
					<br>Select one of your events:
					<select size="1" name="EventID" class = "regsubmit2 body">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
					%>
						<option name = "AID1" value="<%=EventIDArray(count)%>">
							<%=EventNameArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2 body" >
				</td>
			  </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
<tr><td></td></tr>
</table>
<% If Len(EventID) > 0 Then %>
<!--#Include file="AdminEditEventInclude.asp"--> 
 

<% End if %>
<% End if %>









<!--#Include file="adminfooter.asp"--> 
</Body>
</HTML>