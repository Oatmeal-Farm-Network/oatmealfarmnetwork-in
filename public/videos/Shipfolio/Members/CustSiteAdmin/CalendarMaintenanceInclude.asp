<%
Dim CalendarCatID(100,100)
		Dim CategoryName(100,100)


		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from CalendarCategories where  len(CategoryName)> 1 order by CategoryName  " 
			'response.write(sql2)
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3 
			CatCounter= 0
			While Not rs.eof 
				CatCounter = CatCounter + 1
				CalendarCatID(CatCounter,0) = rs("CalendarCatID")
				CategoryName(CatCounter,0) = rs("CategoryName")
				rs.movenext
			Wend
		FinalCatCounter = CatCounter - 1

		CatCounter= 0
		SubCatCounter2 = 0

%>

<!--#Include file="CalendarHeader.asp"--> 
<table width = "780" align = "center">
  <tr>
     <td>
   


<%
'response.write(DatabasePath)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Calendar order by CalendarDateYear, CalendarDateMonth, CalendarDateDay"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim CalendarID(40000)
	dim CalendarTitle(40000)
	dim Calendar(40000)
	dim Calendardescription(40000)

	
Recordcount = rs.RecordCount +1
%>

<table border = "0">
   <tr>
    <td colspan = "3">
	
	


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "700">
	<tr>
		<td class = "body">
			<H2>Event Maintenance<br>
			<img src = "images/underline.jpg"></H2>
			Edit your changes in the tables below then select the "Submit Changes" button located under the table.<br><br>
			On this page you can:
				<ul>
					<li><a href = "#Add" class = "body">Add a New Event</a>
					<li><a href = "#Edit" class = "body">Edit Events</a>
					<li><a href = "#Delete" class = "body">Delete Events</a>
				</ul>
			<br>
		</td>
	</tr>
</table>



	 </td>
	</tr>
	<tr>
	  <td>

	<form action= 'CalendarAddhandleform.asp' method = "post">
<table border = "0"  bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700" align = "left">
    <tr>
		<td class = "body" colspan = "2">
		<a name = "Add"></a>
		<H2>Add a New Event Entry<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right"> Start Date:</td>
		<td colspan = "" class= "body">
					<select size="1" name="CalendarDateWeekDay">
					<option value="" selected></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>

				<select size="1" name="CalendarDateMonth">
					<option value="" selected></option>
					<option value="1">January</option>
					<option  value="2">February</option>
					<option  value="3">March</option>
					<option  value="4">April</option>
					<option  value="5">May</option>
					<option  value="6">June</option>
					<option  value="7">July</option>
					<option  value="8">August</option>
					<option  value="9">September</option>
					<option  value="10">October</option>
					<option  value="11">November</option>
					<option  value="12">December</option>
				</select>
				<select size="1" name="CalendarDateDay">
					<option value="" selected></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="CalendarDateYear">
					<option value="" selected></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=(year(date) -1) To currentyear +1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>


				
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">End Date:</td>
		<td colspan = "" class= "body">
					<select size="1" name="CalendarEndDateWeekDay">
					<option value="" selected></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>

				<select size="1" name="CalendarEndDateMonth">
					<option value="" selected></option>
					<option value="1">January</option>
					<option  value="2">February</option>
					<option  value="3">March</option>
					<option  value="4">April</option>
					<option  value="5">May</option>
					<option  value="6">June</option>
					<option  value="7">July</option>
					<option  value="8">August</option>
					<option  value="9">September</option>
					<option  value="10">October</option>
					<option  value="11">November</option>
					<option  value="12">December</option>
				</select>
				<select size="1" name="CalendarEndDateDay">
					<option value="" selected></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="CalendarEndDateYear">
					<option value="" selected></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=(year(date) -1) To currentyear +1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>


				
		</td>
	</tr>
<tr>
		<td width = "80" class = "body" align = "right">
			Time:
		</td>
		<td>
			<input name="CalendarTime" class = "body" size = "80">
		</td>
	</tr>



	
	
	<tr>
		<td width = "80" class = "body" align = "right">
			Cost:
		</td>
		<td>
			<input name="CalendarPrice" class = "body" size = "80">
		</td>
	</tr>
	<tr>
		<td width = "80" class = "body" align = "right">
			Title:
		</td>
		<td>
			<input name="CalendarTitle" class = "body" size = "80">
		</td>
	</tr>
  
	<tr>
		<td class = "body" align = "right" valign = "top">
			Description:
		</td>
		<td>
			<textarea name="CalendarDescription"  cols="85" rows="20"   class = "body"  ></textarea>
		</td>
	</tr>
	
	<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Event" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>

  </td>
 
<%    

Dim CalendarID2(40000)
Dim CalendarImage2(40000)
Dim CalendarIDArray(4000)
Dim CalendarTitleArray(4000)
Dim CalendarArray(4000)
Dim CalendarDescriptionArray(4000)
Dim CalendarImageArray(4000)
Dim CategoryNameArray(4000)
Dim CategoryIDArray(4000)
Dim CalendarPriceArray(4000)
Dim CalendarDateArray(4000)
Dim CalendarTimeArray(4000)

Dim CalendarDateMonthArray(4000)
Dim 	  CalendarDateDayArray(4000)
Dim 	  CalendarDateYearArray(4000)
Dim	  CalendarDateWeekdayArray(4000)

Dim CalendarEndDateMonthArray(4000)
Dim 	  CalendarEndDateDayArray(4000)
Dim 	  CalendarEndDateYearArray(4000)
Dim	  CalendarEndDateWeekdayArray(4000)
%>

</tr>
  <tr>
		<td class = "body" colspan = "4">
		<a name = "Edit"></a><H2>Edit Event Information<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 

						
		

 sql = "select * from Calendar "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>

<table border = "0">
 
<tr>
  <td colspan = "2">

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	
	<tr>
		<th >Image</th>
		<th  >Event</th>
		
	</tr>



	
<%
 While  Not rs.eof         
  'CatNameArray(rowcount) =   rs("CategoryName")

	 CalendarIDArray(rowcount) =   rs("CalendarID")
	 CalendarTitleArray(rowcount) =   rs("CalendarTitle")
	  CalendarPriceArray(rowcount) =   rs("CalendarPrice")
	  	  CalendarDateMonthArray(rowcount) =   rs("CalendarDateMonth")
		  	  CalendarDateDayArray(rowcount) =   rs("CalendarDateDay")
			  	  CalendarDateYearArray(rowcount) =   rs("CalendarDateYear")
				  	  CalendarDateWeekdayArray(rowcount) =   rs("CalendarDateWeekday")

					    CalendarEndDateMonthArray(rowcount) =   rs("CalendarEndDateMonth")
		  	  CalendarEndDateDayArray(rowcount) =   rs("CalendarEndDateDay")
			  	  CalendarEndDateYearArray(rowcount) =   rs("CalendarEndDateYear")
				  	  CalendarEndDateWeekdayArray(rowcount) =   rs("CalendarEndDateWeekday")


		  	  CalendarTimeArray(rowcount) =   rs("CalendarTime")
	 CalendardescriptionArray(rowcount) =   rs("CalendarDescription")
	'CalendarCatIDArray2(rowcount) =   rs("Calendarcategories.CalendarCatID")
	CalendarImageArray(rowcount) =   rs("CalendarImage")
	 CalendarID2(rowcount) =   rs("CalendarID")
CalendarImage2(rowcount) =   rs("CalendarImage")


 %>


	
	<tr >
	 <td class = "body" valign = "top">
	 <% If Len(CalendarImageArray(rowcount)) < 2 Then
	         CalendarImageArray(rowcount) = "ImageNotAvailable.jpg"
		End If %>

			<img src = "../../uploads/Calendars/<%= CalendarImageArray(rowcount)%>" width = "65"><br>
		   <a href = "AdminCalendarPhotos.asp?CalendarID=<%= CalendarIDArray(rowcount)%>" class = "body" >Edit Photo</a>

		<form action= 'Calendarhandleform.asp' method = "post">
		<input type = "hidden" name="CalendarID(<%=rowcount%>)" value= "<%= CalendarIDArray( rowcount)%>" >
		 </td>
		 

		<td nowrap>
		    <table>
			    <tr>
				    <td colspan = "2" valign = "top" class= "body">
				Start Date:
					<select size="1" name="CalendarDateWeekDay(<%=rowcount%>)">
					<option value="<%= CalendarDateWeekdayArray( rowcount)%>" selected><%= CalendarDateWeekdayArray( rowcount)%></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>	

				<select size="1" name="CalendarDateMonth(<%=rowcount%>)">
					<option value="<%= CalendarDateMonthArray( rowcount)%>" selected><%= CalendarDateMonthArray( rowcount)%></option>
							<option value="1">January</option>
					<option  value="2">February</option>
					<option  value="3">March</option>
					<option  value="4">April</option>
					<option  value="5">May</option>
					<option  value="6">June</option>
					<option  value="7">July</option>
					<option  value="8">August</option>
					<option  value="9">September</option>
					<option  value="10">October</option>
					<option  value="11">November</option>
					<option  value="12">December</option>
				</select>
				<select size="1" name="CalendarDateDay(<%=rowcount%>)">
					<option value="<%= CalendarDateDayArray( rowcount)%>" selected><%= CalendarDateDayArray( rowcount)%></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="CalendarDateYear(<%=rowcount%>)">
					<option value="<%= CalendarDateYearArray( rowcount)%>" selected><%= CalendarDateYearArray( rowcount)%></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=(year(date) -1) To currentyear +1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>


					
			
		</td>

				</tr>
				 <tr>
				    <td colspan = "2" valign = "top" class= "body">
				End Date:
					<select size="1" name="CalendarEndDateWeekDay(<%=rowcount%>)">
					<option value="<%= CalendarEndDateWeekdayArray( rowcount)%>" selected><%= CalendarEndDateWeekdayArray( rowcount)%></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>	

				<select size="1" name="CalendarEndDateMonth(<%=rowcount%>)">
					<option value="<%= CalendarEndDateMonthArray( rowcount)%>" selected><%= CalendarEndDateMonthArray( rowcount)%></option>
					<option value="1">January</option>
					<option  value="2">February</option>
					<option  value="3">March</option>
					<option  value="4">April</option>
					<option  value="5">May</option>
					<option  value="6">June</option>
					<option  value="7">July</option>
					<option  value="8">August</option>
					<option  value="9">September</option>
					<option  value="10">October</option>
					<option  value="11">November</option>
					<option  value="12">December</option>
				</select>
				<select size="1" name="CalendarEndDateDay(<%=rowcount%>)">
					<option value="<%= CalendarEndDateDayArray( rowcount)%>" selected><%= CalendarEndDateDayArray( rowcount)%></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="CalendarEndDateYear(<%=rowcount%>)">
					<option value="<%= CalendarEndDateYearArray( rowcount)%>" selected><%= CalendarEndDateYearArray( rowcount)%></option>
					
				
			<% currentEndyear = year(date) 
						response.write(currentyear)
					For yearv=(year(date) -1) To currentyear +1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>


					
			
		</td>

				</tr>
				 <tr>
				    <td colspan = "2" class= "body">Time: <input type = "Text" name="CalendarTime(<%=rowcount%>)" value= "<%= CalendarTimeArray(rowcount)%>" size = "56">
					</td>
				</tr>
				
				 <tr>
				    <td colspan = "2" class= "body">Price: <input type = "Text" name="CalendarPrice(<%=rowcount%>)" value= "<%= CalendarPriceArray( rowcount)%>" size = "56">
					</td>
				</tr>
				  <tr>
				    <td colspan = "2" class= "body">Title: <input type = "Text" name="CalendarTitle(<%=rowcount%>)" value= "<%= CalendarTitleArray( rowcount)%>" size = "56">
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="CalendarDescription(<%=rowcount%>)"  cols="85" rows="20"   class = "body"  ><%= CalendarDescriptionArray( rowcount)%></textarea>
					</td>
				</tr>
			</table>
		
		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "8" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 <br><br>


  </td>
</tr>
<tr>
  <td colspan = "2">




		
		<%  
				dim aID(40000)
				dim aCalendarTitle(40000)
				dim aCalendarMonth(40000)
					dim aCalendarYear(40000)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select * from Calendar "

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("CalendarID")
				aCalendarTitle(acounter) = rs2("CalendarTitle")
				aCalendarMonth(acounter) = rs2("CalendarDateMonth")
				aCalendarYear(acounter) = rs2("CalendarDateYear")

		acounter = acounter +1
		rs2.movenext
	Wend		
	'acounter = acounter - 1
		rs2.close
		set rs2=nothing
		set conn = nothing



%>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<a name = "Delete"></a><H2>Delete an Event<br>
			<img src = "images/underline.jpg" width = "300" height = "2"></H2>
			<form action= 'CalendarDeletehandleform.asp' method = "post">
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
							<%=aCalendarMonth(count)%>/<%=aCalendarYear(count)%>&nbsp;<%=aCalendarTitle(count)%> 
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br><br>
<br><br><br><br>
	</td>
	</tr>
</table>