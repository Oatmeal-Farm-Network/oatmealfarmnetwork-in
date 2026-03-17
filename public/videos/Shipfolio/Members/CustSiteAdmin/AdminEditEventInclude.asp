<table width = "<%=screenwidth %>" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr><td class = "body" valign = "top">

<table width = "100%" align = "center" class = "roundedtopandbottom">
<tr><td class = "body" colspan = "4" valign = "top" height = "500">
<H1>Edit Calendar of Events</H1>
<%
sql = "select * from Event where eventID = " & EventID
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
Recordcount = rs.RecordCount +1
%>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>">

<%
if rs.eof then %>
<tr>
<td class = "body" >Currently you do not have any events listed. To add an event to your calendar select the <a href ="EventsAdd.asp" class = "body">Add Events</a> subtab.</td>
</tr>
<% else %> 
<tr>
<th width = "300" >Images</th>
<th width = "<%=screenwidth -300 %>" >Events</th>
</tr>
<% end if 
if  Not rs.eof  then     
  'CatName =   rs("CategoryName")
eventID =   rs("EventID")
eventURL =   rs("eventURL")
EventName =   rs("EventName")
eventPrice =   rs("EventPrice")
EventStartMonth=   rs("EventStartMonth")
EventStartDay =   rs("EventStartDay")
EventStartYear =   rs("EventStartYear")
EventEndMonth =   rs("EventEndMonth")
EventEndDay =   rs("EventEndDay")
EventEndYear =   rs("EventEndYear")
eventTime =   rs("eventTime")
 eventdescription =   rs("eventDescription")
'EventCatID2 =   rs("Eventcategories.EventCatID")
eventImage =   rs("eventImage")
eventID2 =   rs("eventID")
eventImage2 =   rs("eventImage")
BlockImage = eventImage


if len(EventStartMonth) > 0 then
else
EventStartMonth  = ""
end if

if len(EventStartDay) > 0 then
else
EventStartDay = ""
end if

if len(EventStartYear) > 0 then
else
EventStartYear = ""
end if


if len(EventEndMonth) > 0 then
else
EventEndMonth = ""
end if


if len(EventEndDay) > 0 then
else
EventEndDay  = ""
end if

if len(EventEndYear) > 0 then
else
EventEndYear = ""
end if
%>
<tr ><td valign="top" width = "300" class = "roundedtopandbottom">
<table cellpadding = "0" cellspacing = "0" width = "300">
<tr>
<td class = "body"><a name = "Block<%=eventID %>"></a>
<div align = "left"><b>Images must be in .JPG, .JPEG, .GIF, or .PNG format<br /> and less than 300KB in size.</b></div><br> 
<% If Len(BlockImage) > 2 Then %>
<img src = "<%=BlockImage%>" height = "100"><br>
<% Else %>
<h2>No Image</h2>
<% End If %>
<form  method="POST" enctype="multipart/form-data" action="EventsuploadImage.asp?EventID=<%=eventID%>" >
Upload Photo: <br>
<input name="attach1" type="file" size=20 class = "regsubmit2"  <%=Disablebutton %>>
<input  type=submit value="Upload" class = "regsubmit2"  <%=Disablebutton %>>
</form>
<td>
</tr>
<tr>
<td class = "body">
<form action= 'EventsRemoveImage.asp?EventID=<%=eventID%>' method = "post">
<input type = "hidden" name="PageLayout2ID" value= "<%=TempPageLayout2ID %>" >
<input type=submit value="Remove This Image" class = "regsubmit2"  <%=Disablebutton %>>
</form>
</td>
</tr>
</table>
</td>
<td nowrap class = "roundedtopandbottom">
<form action= 'Eventshandleform.asp' method = "post">
<table>
  <tr>
    <td colspan = "2" class= "body">Title: <input type = "Text" name="EventName" value= "<%= EventName%>" size = "56">
	</td>
</tr>

<tr>
<td colspan = "2" valign = "top" class= "body">
<% if EventStartDay= 0 then
EventStartDay = ""
end if 

if EventStartMonth=0 then
EventStartMonth = ""
end if

if EventStartYear=0 then
EventStartYear = ""
end if

if EventEndDay=0 then
EventEndDay = ""
end if 

if EventEndMonth=0 then
EventEndMonth = ""
end if

if EventEndYear=0 then
EventEndYear = ""
end if

%>


Start Date:
<select size="1" name="EventStartMonth">
<option value="<%= EventStartMonth%>" selected><%= EventStartMonth%></option>
<option value="0">-</option>
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
/
<select size="1" name="EventStartDay">
<option value="<%= EventStartDay%>" selected><%= EventStartDay%></option>
<option value="0">-</option>
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
/<select size="1" name="EventStartYear">
<option value="<%= EventStartYear%>" selected><%=EventStartYear%></option>
 <option value="0">-</option>
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
<select size="1" name="EventEndMonth">
	<option value="<%= EventEndMonth%>" selected><%= EventEndMonth%></option>
    <option value="0">-</option>
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
/
<select size="1" name="EventEndDay">
	<option value="<%= EventEndDay%>" selected><%= EventEndDay%></option>
    <option value="0">-</option>
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
/
<select size="1" name="EventEndYear">
	<option value="<%= EventEndYear%>" selected><%= EventEndYear%></option>
	<option value="0">-</option>

	<% currentEndyear = year(date) 
response.write(currentyear)
	For yearv=(year(date) -1) To currentyear +1 %>
	<option value="<%=yearv%>"><%=yearv%></option>
	<% Next %></select>


    <i>If this is a one-day event, do not enter an end date.</i>
	</td>
</tr>
 <tr>
    <td colspan = "2" class= "body">Time: <input type = "Text" name="eventTime" value= "<%= eventTime%>" size = "56">
	</td>
</tr>
 <tr>
    <td colspan = "2" class= "body">Price: <input type = "Text" name="eventPrice" value= "<%= eventPrice%>" size = "56">
	</td>
</tr>

 <tr>
<td class = "body" align = "right" valign = "top">
Website: <small>http://</small><input name="eventURL" class = "body" value= "<%= eventURL%>" size = "40">
</td>
</tr>
<tr>
<td>
<script type="text/javascript">
    var mysettings = new WYSIWYG.Settings();
    mysettings.Width = "100%";
    mysettings.Height = "300px";
    mysettings.ImagePopupWidth = 600;
    mysettings.ImagePopupHeight = 245;
    WYSIWYG.attach("textarea1<%=rowcount%>", mysettings);
</script>
<TEXTAREA NAME="eventDescription" cols="85" rows="18" wrap="file" class = "body" id = "textarea1<%=rowcount%>"><%= eventDescription%></textarea><br>

	</td>
</tr>
<tr><td><Input type = "hidden" name='EventID' value = <%=EventID%> >
<center><input type=submit value = "Submit Changes" class = "regsubmit2"  <%=Disablebutton %> ></center>
	</form>
</td></tr>
</table>
</td>
</tr>
<%
	end if
TotalCount=rowcount 
	rs.close
  set rs=nothing
  
%>
</table>
 <br><br>
   </td>
</tr>
</table>
	</td>
	</tr>
</table>