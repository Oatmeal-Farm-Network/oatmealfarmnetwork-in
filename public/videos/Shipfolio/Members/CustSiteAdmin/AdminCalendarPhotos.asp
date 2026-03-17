<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <Link rel="stylesheet" type="text/css" href="/administration/style.css">

</head>
<body >

    <!--#Include file="GlobalVariables.asp"--> 
    <!--#Include virtual="/Administration/Header.asp"--> 
    <!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
    <!--#Include virtual="/administration/Dimensions.asp"--> 

<%  
CalendarID=Trim(Request.Form("CalendarID")) 
If Len(CalendarID) < 1 then
	CalendarID= Request.QueryString("CalendarID") 
End if

session("CalendarID") = CalendarID
'response.write("CalendarID=")
'response.write(CalendarID)
Dim CalendarIDArray2(1000)
Dim CalendarTitleArray(1000)
Dim CalendarMonthArray(1000)
Dim CalendarYearArray(1000)

 If Len(CalendarID) = 0 Then 

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Calendar order by CalendarDateYear, CalendarDateMonth, CalendarDateDay"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		CalendarIDArray2(acounter) = rs2("CalendarID")
		CalendarTitleArray(acounter) = rs2("CalendarTitle")
		CalendarMonthArray(acounter) = rs2("CalendarDateMonth")
			CalendarYearArray(acounter) = rs2("CalendarDateYear")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
  <!--#Include virtual="/administration/CalendarHeader.asp"--> 
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
			<tr>
				<td class = "body">
					<H1>Upload Photos </H1>			
				</td>
			</tr>
		</table>
<form action="AdminPhotosCalendar.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your Events:
					<select size="1" name="CalendarID">
					<option name = "ACalendarID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "ACalendarID1" value="<%=CalendarIDArray2(count)%>">
							<%=CalendarMonthArray(count)%>/<%=CalendarYearArray(count)%> &nbsp;<%=CalendarTitleArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" size = "210" class = "Submit" >
				</td>
			  </tr>
		    </table>
		  </form>
<% Else %>
	
 <!-- #include file="AdminCalendarPhotoFormInclude.asp" -->
 <% End if %>

  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
