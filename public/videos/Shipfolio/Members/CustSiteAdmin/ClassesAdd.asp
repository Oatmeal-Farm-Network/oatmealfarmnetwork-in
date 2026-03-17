<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current3 = "Add Classes" %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>"align = "center" class = "roundedtopandbottom"><tr><td >
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="jquery.numeric.js"></script>

<% 
dim AddressIDArray(5000) 
dim AddressTitleArray(5000) 
dim PeopleFirstNameArray(5000) 
dim PeopleLastNameArray(5000) 
sql2 = "select * from Address where not(addressID = 420) and not(addressID = 419) and not(addressID = 418) order by AddressTitle"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
While Not rs2.eof  
AddressIDArray(acounter) = rs2("AddressID")
AddressTitleArray(acounter) = rs2("AddressTitle")
acounter = acounter +1
rs2.movenext
Wend 


 EventID = request.querystring("EventID") 
 sql = "select * from Classinfo "

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then

'publish= rs("publish")
MissingTitle = Request.querystring("MissingTitle")
InstructorsName= Request.querystring("InstructorsName")
	InstructorsWebsite= Request.querystring("InstructorsWebsite")
	InstructorsBio= Request.querystring("InstructorsBio")
	ClassInfoStudentFee = Request.querystring("ClassInfoStudentFee")
	ClassDateMonth = Request.querystring("ClassDateMonth")
    	ClassDateYear = Request.querystring("ClassDateYear")
	ClassStartTime = Request.querystring("ClassStartTime")
	ClassEndTime = Request.querystring("ClassEndTime")
	ClassInfoRoomDesignation = Request.querystring("ClassInfoRoomDesignation")
	ClassInfoMinimumStudents = Request.querystring("ClassInfoMinimumStudents")
	ClassInfoMaximumStudents = Request.querystring("ClassInfoMaximumStudents")
	ClassInfoDescription = Request.querystring("ClassInfoDescription")
AddressID1 = Request.querystring("AddressID1")
ClassDateDayOfWeek1 = Request.querystring("ClassDateDayOfWeek1")
ClassStartTime1 = Request.querystring("ClassStartTime1")
ClassEndTime1 = Request.querystring("ClassEndTime1")

AddressID2 = Request.querystring("AddressID2")
ClassDateDayOfWeek2 = Request.querystring("ClassDateDayOfWeek2")
ClassStartTime2 = Request.querystring("ClassStartTime2")
ClassEndTime2 = Request.querystring("ClassEndTime2")

AddressID3 = Request.querystring("AddressID3")
ClassDateDayOfWeek3 = Request.querystring("ClassDateDayOfWeek3")
ClassStartTime3 = Request.querystring("ClassStartTime3")
ClassEndTime3 = Request.querystring("ClassEndTime3")

AddressID4 = Request.querystring("AddressID4")
ClassDateDayOfWeek4 = Request.querystring("ClassDateDayOfWeek4")
ClassStartTime4 = Request.querystring("ClassStartTime4")
ClassEndTime4 = Request.querystring("ClassEndTime4")

AddressID5 = Request.querystring("AddressID5")
ClassDateDayOfWeek5 = Request.querystring("ClassDateDayOfWeek5")
ClassStartTime5 = Request.querystring("ClassStartTime5")
ClassEndTime5 = Request.querystring("ClassEndTime5")

AddressID6 = Request.querystring("AddressID6")
ClassDateDayOfWeek6 = Request.querystring("ClassDateDayOfWeek6")
ClassStartTime6 = Request.querystring("ClassStartTime6")
ClassEndTime6 = Request.querystring("ClassEndTime6")


AddressID7 = Request.querystring("AddressID7")
ClassDateDayOfWeek7 = Request.querystring("ClassDateDayOfWeek7")
ClassStartTime7 = Request.querystring("ClassStartTime7")
ClassEndTime7 = Request.querystring("ClassEndTime7")


str1 = ClassInfoTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	ClassInfoTitle= Replace(str1,  str2, " ")
End If 

str1 = ClassInfoTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	ClassInfoTitle= Replace(str1,  str2, "'")
End If 

end if 
%>

<a name="Top"></a>

 <% PageTitleText = "Add a Class - Step 1: Enter Information"  %>

<br />

<form name = "AddForm" action= 'ClassesAddHandleForm.asp?EventID=<%=EventID%>' method = "post">
<input name="Action"  size = "60" value = "Add" type = "hidden">
<input name="EventID"  size = "60" value = "<%=EventID%>" type = "hidden">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" ><tr><td class = "body2" colspan  "2"> * = required field<br>
<% if len(MissingTitle) > 0 then%>
<font Color = "brown"><b>Your class was not added. Please enter a title and resubmit the form.</b></font>
<% end if %>
</td>
 </tr>
  
<% Message = ""
Message = request.querystring("Message")
if len(Message) > 1 then
%>

<tr>
 <td class = "menu2" ><font color = "red"><%=Message%></font><br>
 To add another class please use the form below, or to edit your classes please <a href ="ClassesEdit.asp?EventID=<%=EventID%>" class = "menu2">click here</a>.<br><br><br>
 </td>
 </tr>

<%
end if 

row = "odd"
%>

 <tr>
 <td >
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" >
<tr >
  <td class = "body2" valign = "top" >
  <table>
  <tr>
  	<td class = "body"   valign = "top"><% if len(MissingTitle) > 0 then%>
<font Color = "brown"><% end if %><b>Title*:</b><% if len(MissingTitle) > 0 then%>
</font><% end if %></td>
</tr>
<tr>
  	<td  valign = "top">
 	
  	<input NAME="ClassInfoTitle" type = "text" size= "40" value = "<%=ClassInfoTitle %>" ><%=ClassInfoTitle %></textarea>
  	
  	</td>
   </tr>
  
    <tr>
  	<td class = "body"   valign = "top"><b>Price*:</b></td>
  	</tr>
  	<tr>
  	<td class = "body2"> $<input class="positive" type="text" name = "ClassInfoStudentFee" size = 7 maxsize = 9 value = "<%=ClassInfoStudentFee %>"><br>For free classes please enter "0" for the price.
  	
	
	<script type="text/javascript">
	$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
	</script>
</td>
</tr>
</table>
</td>




<%
'*******************************************************************************************
'WYSIWYG Scripts
'*******************************************************************************************
%>   
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 

<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>

	 
<script language="javascript1.2">
  // attach the editor to the textarea with the identifier 'textarea1'.
   WYSIWYG.attach("textarea1");
</script> 


<script language="javascript1.2">
  // attach the editor to the textarea with the identifier 'textarea1'.
   WYSIWYG.attach("textarea3");
</script> 

 <td class = "body2" valign = "top"><b>Class Description:</b><br><TEXTAREA NAME="ClassInfoDescription" cols="70" rows="11" wrap="file" id = "textarea1"><%=ClassInfoDescription %></textarea><br>
 
 </td>
  </tr>
  <tr>
  <td class = "body2" colspan = "2" align = "left"><br>
 <h2>Schedule:</h2>
<table><tr>
<td class = "body"><b>Address</b></td>
<td class = "body"><b>Day of Week</b></td>
<td class = "body"><b>Start Time</b></td>
<td class = "body"><b>End Time</b></td>
</tr>
<tr>
<td class = "body">
<select size="1" name="AddressID1">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek1">
<% if len(ClassDateDayOfWeek1) > 0 then %>
<option value="<%=ClassDateDayOfWeek1%>" selected><%=ClassDateDayOfWeek1%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime1" size = 9 maxsize = 9 value = "<%=ClassStartTime1%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime1" size = 9 maxsize = 9 value = "<%=ClassEndTime1%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID2">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek2">
<% if len(ClassDateDayOfWeek2) > 0 then %>
<option value="<%=ClassDateDayOfWeek2%>" selected><%=ClassDateDayOfWeek2%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime2" size = 9 maxsize = 9 value = "<%=ClassStartTime2%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime2" size = 9 maxsize = 9 value = "<%=ClassEndTime2%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID3">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek3">
<% if len(ClassDateDayOfWeek3) > 0 then %>
<option value="<%=ClassDateDayOfWeek3%>" selected><%=ClassDateDayOfWeek3%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime3" size = 9 maxsize = 9 value = "<%=ClassStartTime3%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime3" size = 9 maxsize = 9 value = "<%=ClassEndTime3%>"></td>
</tr>



<tr>
<td class = "body">
<select size="1" name="AddressID4">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek4">
<% if len(ClassDateDayOfWeek4) > 0 then %>
<option value="<%=ClassDateDayOfWeek4%>" selected><%=ClassDateDayOfWeek4%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime4" size = 9 maxsize = 9 value = "<%=ClassStartTime4%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime4" size = 9 maxsize = 9 value = "<%=ClassEndTime4%>"></td>
</tr>



<tr>
<td class = "body">
<select size="1" name="AddressID5">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek5">
<% if len(ClassDateDayOfWeek5) > 0 then %>
<option value="<%=ClassDateDayOfWeek5%>" selected><%=ClassDateDayOfWeek5%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime5" size = 9 maxsize = 9 value = "<%=ClassStartTime5%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime5" size = 9 maxsize = 9 value = "<%=ClassEndTime5%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID6">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek6">
<% if len(ClassDateDayOfWeek6) > 0 then %>
<option value="<%=ClassDateDayOfWeek6%>" selected><%=ClassDateDayOfWeek6%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime6" size = 9 maxsize = 9 value = "<%=ClassEndStartTime6%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime6" size = 9 maxsize = 9 value = "<%=ClassEndTime6%>"></td>
</tr>




<tr>
<td class = "body">
<select size="1" name="AddressID7">
<option name = "AID0" value= "" selected></option>
<% count = 1
while count < acounter
response.write(count)
%>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek7">
<% if len(ClassDateDayOfWeek7) > 0 then %>
<option value="<%=ClassDateDayOfWeek7%>" selected><%=ClassDateDayOfWeek7%></option>
<% else %>
<option value="" selected>------</option>
<% end if %>
<option value="Sunday">Sunday</option>
<option value="Monday">Monday</option>
<option  value="Tuesday">Tuesday</option>
<option  value="Wednesday">Wednesday</option>
<option  value="Thursday">Thursday</option>
<option  value="Friday">Friday</option>
<option  value="Saturday">Saturday</option>
</select></td>
<td class = "body"><input type="text" name = "ClassStartTime7" size = 9 maxsize = 9 value = "<%=ClassStartTime7%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime7" size = 9 maxsize = 9 value = "<%=ClassEndTime7%>"></td>
</tr>




</table>



    <div  align = "center"><input type=submit value="Add Class"  class = "regsubmit2" ></div>
    <br>
</td>
</tr>
 </table>
</td>
</tr>
 </table>

</form>
</td>
</tr>
 </table>

<!--#Include file="adminFooter.asp"-->

</Body>
</HTML>