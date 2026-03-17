<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Administration</title>
<meta name="Title" content="<%=Sitenamelong %> Administration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   	
%>
<%  Current4 = "EventsAdmin" 
Current3 = "DeleteEvents"   %> 
<!--#Include file="EventsTabsInclude.asp"--> 
<table width = "<%=screenwidth %>" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body roundedtopandbottom" valign = "top" height = "500">
<table width = "<%=screenwidth -35 %>" align = "center">
  <tr><td>
<%  
dim aID(40000)
dim aEventTitle(40000)
dim aEventMonth(40000)
dim aEventYear(40000)
sql2 =  "select * from Events order by EventsDateYear, EventsDateMonth, EventsDateDay"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("EventsID")
				aEventTitle(acounter) = rs2("EventsTitle")
				aEventMonth(acounter) = rs2("EventsDateMonth")
				aEventYear(acounter) = rs2("EventsDateYear")

		acounter = acounter +1
		rs2.movenext
	Wend		
	'acounter = acounter - 1
		rs2.close
		set rs2=nothing

%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<H1>Delete an Event</H1>
			<form action= 'EventsDeletehandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
				 
					<b>Event's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aEventMonth(count)%>/<%=aEventYear(count)%>&nbsp;<%=aEventTitle(count)%> 
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete Event"  class = "Regsubmit2"  >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
<!--#Include virtual="/Footer.asp"--> 
</Body>
</HTML>