<!--#Include file="CalendarHeader.asp"--> 

<%

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from Calendar where Calendarid = " & CalendarID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO Calendars (ID)" 
					Query =  Query & " Values (" &  CalendarID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
				rs.close

				sql = "select * from Calendars where CalendarID = " & CalendarID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				
				End If 

					If Len(rs("CalendarImage")) > 2 Then
							File1= rs("CalendarImage")
				else
						File1 = "ImageNotAvailable.jpg"
					End if

				

			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

			TempCalendarTitle = rs("CalendarTitle")

	rs.close
			
%>
    <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
		<tr>
			<td class = "body">
				<H1>Upload Image for <%=TempCalendarTitle %></H1>			
			</td>
		</tr>
	</table>


	
			<%  
Dim CalendarImage(1000)
Dim CalendarTitle(1000)
Dim CalendarIDArray(1000)
Dim CalendarMonth(1000)
Dim CalendarYear(1000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Calendar order by CalendarDateYear, CalendarDateMonth, CalendarDateDay ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		CalendarIDArray(acounter) = rs2("CalendarID")
		CalendarTitle(acounter) = rs2("CalendarTitle")
		CalendarImage(acounter) = rs2("CalendarImage")
			CalendarMonth(acounter) = rs2("CalendarDateMonth")
				CalendarYear(acounter) = rs2("CalendarDateYear")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		<font class = "body">
		<form  action="adminCalendarphotos.asp" method = "post">
			<h2>Select Another Event</h2>
			Select a Calendar below and push the edit button to update an Calendar:<br>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your events:
					<select size="1" name="CalendarID">
					<option name = "ACalendarID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "ACalendarID1" value="<%=CalendarIDArray(count)%>">
							<%=CalendarMonth(count)%>/<%=CalendarYear(count)%> &nbsp;<%=CalendarTitle(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
	 </form>
	 </font>
   <table Border = "1" Bgcolor = "#dddddd" width = "750" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Event Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "../../Uploads/Calendars/<%=File1%>" width = "100">
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadCalendarImage.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>
									Current Image Name: <b><%=File1%></b><br>
						<% Else %>
							Current Image Name: <b>Not Defined</b><br>
						<% End If %>

						
						
					
						Upload New Photo: <input name="attach1" type="file" size=35 >
						<input  type=submit value="Upload">
					</form>

					
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
						<tr>
							<td bgcolor = "#abacab" height = "2" width = "700"><img src = "images/px.gif" height = "2"></td>
						</tr>
					</table>
					<form action= 'CalendarRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="CalendarID" value= "<%= CalendarID %>" >
							<input type=submit value="Remove This Image">
					</form>
			</td>
		</table>

		
  
    <br> 