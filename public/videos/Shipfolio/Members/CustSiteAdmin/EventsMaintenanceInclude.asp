
<table width = "100%" align = "center">
  <tr>
     <td>
   


<%
'response.write(DatabasePath)

 sql = "select * from Events order by EventsDateYear, EventsDateMonth, EventsDateDay"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim EventsID(40000)
	dim EventsTitle(40000)
	dim Events(40000)
	dim Eventsdescription(40000)

	
Recordcount = rs.RecordCount +1
%>

<table border = "0">
   <tr>
    <td colspan = "3">
	
	


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "700">
	<tr>
		<td class = "body">
			<H2>Events Maintenance<br>
			<img src = "images/underline.jpg"></H2>
			Edit your changes in the tables below then select the "Submit Changes" button located under the table.<br><br>
		
			<br>
		</td>
	</tr>
</table>



	 </td>
	</tr>
	<tr>
	  <td>

	<form action= 'EventsAddhandleform.asp' method = "post">
<table border = "0"  bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700" align = "left">
    <tr>
		<td class = "body" colspan = "2">
		<H2>Add a New Events Entry<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right"> Start Date:</td>
		<td colspan = "" class= "body">
					<select size="1" name="EventsDateWeekDay">
					<option value="" selected></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>

				<select size="1" name="EventsDateMonth">
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
				</select>
				<select size="1" name="EventsDateDay">
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
		<select size="1" name="EventsDateYear">
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
					<select size="1" name="EventsEndDateWeekDay">
					<option value="" selected></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>

				<select size="1" name="EventsEndDateMonth">
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
				</select>
				<select size="1" name="EventsEndDateDay">
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
		<select size="1" name="EventsEndDateYear">
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
			<input name="EventsTime" class = "body" size = "80">
		</td>
	</tr>
	<tr>
		<td width = "80" class = "body" align = "right">
			Cost:
		</td>
		<td>
			<input name="EventsPrice" class = "body" size = "80">
		</td>
	</tr>
	<tr>
		<td width = "80" class = "body" align = "right">
			Title:
		</td>
		<td>
			<input name="EventsTitle" class = "body" size = "80">
		</td>
	</tr>
  
	<tr>
		<td class = "body" align = "right" valign = "top">
			Description:
		</td>
		<td>
			<textarea name="EventsDescription"  cols="80" rows="20"   class = "body"  ></textarea>
		</td>
	</tr>
	
	<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Events"  size = "110" >
			</form>
		</td>
</tr>
</table>

  </td>
 
<%    

Dim EventsID2(40000)
Dim EventsImage2(40000)
Dim EventsIDArray(1000)
Dim EventsTitleArray(1000)
Dim EventsArray(1000)
Dim EventsDescriptionArray(1000)
Dim EventsImageArray(1000)
Dim EventsCatIDArray2(1000)
Dim CatNameArray(1000)
Dim EventsPriceArray(1000)
Dim EventsDateArray(1000)
Dim EventsTimeArray(1000)

Dim EventsDateMonthArray(1000)
Dim 	  EventsDateDayArray(1000)
Dim 	  EventsDateYearArray(1000)
Dim	  EventsDateWeekdayArray(1000)

Dim EventsEndDateMonthArray(1000)
Dim 	  EventsEndDateDayArray(1000)
Dim 	  EventsEndDateYearArray(1000)
Dim	  EventsEndDateWeekdayArray(1000)
%>

</tr>
  <tr>
		<td class = "body" colspan = "4">
		<H2>Edit Events Information<br>
			<img src = "images/underline.jpg" width = "700" height = "2"></H2>
		</td>
	</tr>

<%


						 
 sql = "select * from Events order by EventsDateYear, EventsDateMonth, EventsDateDay"

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
		<th  >Events</th>
</tr>
<%
 While  Not rs.eof         
  'CatNameArray(rowcount) =   rs("CategoryName")

EventsIDArray(rowcount) =   rs("EventsID")
EventsTitleArray(rowcount) =   rs("EventsTitle")
EventsPriceArray(rowcount) =   rs("EventsPrice")
EventsDateMonthArray(rowcount) =   rs("EventsDateMonth")
EventsDateDayArray(rowcount) =   rs("EventsDateDay")
EventsDateYearArray(rowcount) =   rs("EventsDateYear")
EventsDateWeekdayArray(rowcount) =   rs("EventsDateWeekday")
EventsEndDateMonthArray(rowcount) =   rs("EventsEndDateMonth")
EventsEndDateDayArray(rowcount) =   rs("EventsEndDateDay")
EventsEndDateYearArray(rowcount) =   rs("EventsEndDateYear")
EventsEndDateWeekdayArray(rowcount) =   rs("EventsEndDateWeekday")
EventsTimeArray(rowcount) =   rs("EventsTime")
 EventsdescriptionArray(rowcount) =   rs("EventsDescription")
'EventsCatIDArray2(rowcount) =   rs("Eventscategories.EventsCatID")
EventsImageArray(rowcount) =   rs("EventsImage")
EventsID2(rowcount) =   rs("EventsID")
EventsImage2(rowcount) =   rs("EventsImage")
%>

	
	<tr >
	 <td class = "body" valign = "top">
	 <% If Len(EventsImageArray(rowcount)) < 2 Then
	         EventsImageArray(rowcount) = "ImageNotAvailable.jpg"
		End If %>

			<img src = "../../uploads/Events/<%= EventsImageArray(rowcount)%>" width = "65"><br>
		   <a href = "AdminEventsPhotos.asp?EventsID=<%= EventsIDArray(rowcount)%>" class = "body" >Edit Photo</a>

		<form action= 'Eventshandleform.asp' method = "post">
		<input type = "hidden" name="EventsID(<%=rowcount%>)" value= "<%= EventsIDArray( rowcount)%>" >
		 </td>
		 

		<td nowrap>
		    <table>
			    <tr>
				    <td colspan = "2" valign = "top" class= "body">
				Start Date:
					<select size="1" name="EventsDateWeekDay(<%=rowcount%>)">
					<option value="<%= EventsDateWeekdayArray( rowcount)%>" selected><%= EventsDateWeekdayArray( rowcount)%></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>	

				<select size="1" name="EventsDateMonth(<%=rowcount%>)">
					<option value="<%= EventsDateMonthArray( rowcount)%>" selected><%= EventsDateMonthArray( rowcount)%></option>
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
				</select>
				<select size="1" name="EventsDateDay(<%=rowcount%>)">
					<option value="<%= EventsDateDayArray( rowcount)%>" selected><%= EventsDateDayArray( rowcount)%></option>
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
		<select size="1" name="EventsDateYear(<%=rowcount%>)">
					<option value="<%= EventsDateYearArray( rowcount)%>" selected><%= EventsDateYearArray( rowcount)%></option>
					
				
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
					<select size="1" name="EventsEndDateWeekDay(<%=rowcount%>)">
					<option value="<%= EventsEndDateWeekdayArray( rowcount)%>" selected><%= EventsEndDateWeekdayArray( rowcount)%></option>
					<option value="Sunday">Sunday</option>
					<option  value="Monday">Monday</option>
					<option  value="Tuesday">Tuesday</option>
					<option  value="Wednesday">Wednesday</option>
					<option  value="Thursday">Thursday</option>
					<option  value="Friday">Friday</option>
					<option  value="Saturday">Saturday</option>
					</select>	

				<select size="1" name="EventsEndDateMonth(<%=rowcount%>)">
					<option value="<%= EventsEndDateMonthArray( rowcount)%>" selected><%= EventsEndDateMonthArray( rowcount)%></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
				</select>
				<select size="1" name="EventsEndDateDay(<%=rowcount%>)">
					<option value="<%= EventsEndDateDayArray( rowcount)%>" selected><%= EventsEndDateDayArray( rowcount)%></option>
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
		<select size="1" name="EventsEndDateYear(<%=rowcount%>)">
					<option value="<%= EventsEndDateYearArray( rowcount)%>" selected><%= EventsEndDateYearArray( rowcount)%></option>
					
				
			<% currentEndyear = year(date) 
						response.write(currentyear)
					For yearv=(year(date) -1) To currentyear +1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>


					
			
		</td>

				</tr>
				 <tr>
				    <td colspan = "2" class= "body">Time: <input type = "Text" name="EventsTime(<%=rowcount%>)" value= "<%= EventsTimeArray( rowcount)%>" size = "56">
					</td>
				</tr>
				 <tr>
				    <td colspan = "2" class= "body">Price: <input type = "Text" name="EventsPrice(<%=rowcount%>)" value= "<%= EventsPriceArray( rowcount)%>" size = "56">
					</td>
				</tr>
				  <tr>
				    <td colspan = "2" class= "body">Title: <input type = "Text" name="EventsTitle(<%=rowcount%>)" value= "<%= EventsTitleArray( rowcount)%>" size = "56">
					</td>
				</tr>
				<tr>
					<td>
						<textarea name="EventsDescription(<%=rowcount%>)"  cols="75" rows="20"   class = "body"  ><%= EventsDescriptionArray( rowcount)%></textarea>
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
  
%>

<tr>
		<td colspan = "8" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes"  size = "110" >
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
				dim aEventsTitle(40000)
				dim aEventsMonth(40000)
					dim aEventsYear(40000)

				
				
						 
				sql2 =  "select * from Events order by EventsDateYear, EventsDateMonth, EventsDateDay"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("EventsID")
				aEventsTitle(acounter) = rs2("EventsTitle")
				aEventsMonth(acounter) = rs2("EventsDateMonth")
				aEventsYear(acounter) = rs2("EventsDateYear")

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
			<H2>Delete a Events<br>
			<img src = "images/underline.jpg" width = "300" height = "2"></H2>
			<form action= 'EventsDeletehandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
				 
					<b>Events's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aEventsMonth(count)%>/<%=aEventsYear(count)%>&nbsp;<%=aEventsTitle(count)%> 
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete Events"  size = "110"  >
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