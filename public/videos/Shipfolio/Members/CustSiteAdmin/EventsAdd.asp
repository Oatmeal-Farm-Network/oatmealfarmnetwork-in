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
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminGlobalVariables.asp"-->
<% Current2="AdminHome" %> 
<!--#Include file="adminHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If   
%>
<table width = "<%=screenwidth %>" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr><td class = "body" valign = "top">
 <%  Current4 = "EventsAdmin" 
 Current3 = "AddEvents"  %> 
<!--#Include file="EventsTabsInclude.asp"-->
<table width = "<%=screenwidth -50 %>" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td class = "body roundedtopandbottom" valign = "top" >
<table width = "<%=screenwidth %>" align = "center">
<tr><td>
<% sql = "select * from Events order by EventsDateYear, EventsDateMonth, EventsDateDay"

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

<form action= 'EventsAddhandleform.asp' method = "post">
<table border = "0"  bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700" align = "left">
    <tr>
<td class = "body" colspan = "2">
<H1>Add a New Event Entry</H1>
</td>
</tr>
<tr>
<td class = "body" align = "right">
Title:</td>
<td>
<input name="EventsTitle" class = "body" size = "80">
</td>
</tr>
<tr>
<td class = "body" align = "right">Start Date:</td>
<td colspan = "" class= "body">
<select size="1" name="EventsStartDateWeekDay">
<option value="" selected></option>
<option value="Sunday">Sunday</option>
<option  value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select>

<select size="1" name="EventsStartDateMonth">
<option value="" selected></option>
<option value="1">Jan (1)</option>
<option  value="2">Feb (2)</option>
<option  value="3">Mar (3)</option>
<option  value="4">Apr (4)</option>
<option  value="5">May (5)</option>
<option  value="6">Jun (6)</option>
<option  value="7">Jul (7)</option>
<option  value="8">Aug (8)</option>
<option  value="9">Sep (9)</option>
<option  value="10">Oct (10)</option>
<option  value="11">Nov (11)</option>
<option  value="12">Dec (12)</option>
</select>
  /
<select size="1" name="EventsStartDateDay">
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
  /
<select size="1" name="EventsStartDateYear">
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
<option value="1">Jan (1)</option>
<option  value="2">Feb (2)</option>
<option  value="3">Mar (3)</option>
<option  value="4">Apr (4)</option>
<option  value="5">May (5)</option>
<option  value="6">Jun (6)</option>
<option  value="7">Jul (7)</option>
<option  value="8">Aug (8)</option>
<option  value="9">Sep (9)</option>
<option  value="10">Oct (10)</option>
<option  value="11">Nov (11)</option>
<option  value="12">Dec (12)</option>
</select>
  /
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
  /
<select size="1" name="EventsEndDateYear">
<option value="" selected></option>


<% currentyear = year(date) 
response.write(currentyear)
For yearv=(year(date) -1) To currentyear +1 %>
<option value="<%=yearv%>"><%=yearv%></option>
<% Next %></select>

</td>
</tr>
</tr>
<tr>
<td class = "body" align = "right" valign = "top">
Time: </td>
<td>
<input name="EventsTime" class = "body" size = "80">
</td>
</tr>
<tr>
<td class = "body" align = "right" valign = "top">
Cost: </td>
<td>
<input name="EventsPrice" class = "body" size = "80">
</td>
</tr>

 <tr>
<td class = "body" align = "right" valign = "top">
Website: </td>
<td>
<small>http://</small><input name="EventsURL" class = "body" size = "40">
</td>
</tr>
<tr>
<td class = "body" align = "right" valign = "top">
Description:
</td>
<td>
<script type="text/javascript">
 var mysettings = new WYSIWYG.Settings();
 mysettings.Width = "100%";
 mysettings.Height = "300px";
 mysettings.ImagePopupWidth = 600;
 mysettings.ImagePopupHeight = 245;
 WYSIWYG.attach("EventsDescription", mysettings);
</script>
<TEXTAREA NAME="EventsDescription" cols="85" rows="18" wrap="file" class = "body" id = "EventsDescription"></textarea><br>
</td>
</tr>

<tr>
<td  align = "center" valign = "middle" colspan = "2">
<input type=submit value = "Add Event"  class = "Regsubmit2" >
</form>
</td>
</tr>
</table>

  </td>

</tr>
</table>
</td>
</tr>
</table>

<!--#Include file="adminfooter.asp"--> 
</Body>
</HTML>