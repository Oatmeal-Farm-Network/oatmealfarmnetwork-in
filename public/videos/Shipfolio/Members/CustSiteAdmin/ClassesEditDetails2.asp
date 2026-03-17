<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
 </head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if  %>

<% Current = "admin" %>
<!--#Include file="AdminHeader.asp"-->
<% Current = "Classes"
Current3 = "Edit Classes"  %>
<!--#Include File ="ClassesHeader.asp"--> 
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>"align = "center" class = "roundedtopandbottom"><tr><td >
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
<script type="text/javascript" src="jquery.numeric.js"></script>

<%
ClassInfoID = request.querystring("ClassInfoID")
if len(ClassInfoID) > 0 then
else
ClassInfoID = request.form("ClassInfoID")
end if



Set rst = Server.CreateObject("ADODB.Recordset")

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



'*******************************************************************************************
'WYSIWYG Scripts
'*******************************************************************************************
%>   
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg.js"></script> 
<script language="JavaScript" type="text/javascript" src="/cgi-bin/wysiwyg-settings.js"></script>
<br>
<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" >
<tr>
 <td class = "body2" colspan  "2"><big><b>Edit Classes</b></big><br>
</td>
 </tr>
</table>

<% Message = "" %>
<%Message = request.querystring("Message")%>
<%if len(Message) > 1 then %>
	<table border = "0" bordercolor = "#DBF5F3" cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" >
	<tr>
	 <td class = "body2" ><font color = "red"><%=Message%></font>
	 </td>
	 </tr>
	</table>
<% end if %>

<% 
	'response.write("EventID = " & EventID & "<br>")
  	sql = "select * from Classinfo " 
	'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql, conn, 3, 3   
	if rs.eof then 
%>

	<table border = "0" bordercolor = "#DBF5F3" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" >
	<tr>
 <td class = "body2" colspan  "2">Currently there are no classes listed. To add classes please <a href ="ClassesAdd.asp?EventID=<%=EventID%>" class = "body">click here</a>.<br>
</td>
 	</tr>
	</table>

<% 
	else
'publish= rs("publish")
ClassInfoID = rs("ClassInfoID")
ClassInfoTitle = rs("ClassInfoTitle")
ClassInfoDescription = rs("ClassInfoDescription")
ClassHomework= rs("ClassHomework")
ClassInforoomRequirements= rs("ClassInforoomRequirements")
ClassInfoMaterialsSupplied= rs("ClassInfoMaterialsSupplied")
ClassInfoTeacherFee= rs("ClassInfoTeacherFee")
ClassInfoMaterialFee= rs("ClassInfoMaterialFee")
ClassInfoStudentFee= rs("ClassInfoStudentFee")
ClassInfoMaterialFee= rs("ClassInfoMaterialFee")
ClassInfoOrganizationFee= rs("ClassInfoOrganizationFee")
ClassInfoMinimumStudents= rs("ClassInfoMinimumStudents")
ClassInfoRoomDesignation= rs("ClassInfoRoomDesignation")
ClassInfoAdditionalSession= rs("ClassInfoAdditionalSession")

AddressID1 = rs("AddressID1")
ClassDateDayOfWeek1 = rs("ClassDateDayOfWeek1")
ClassStartTime1 = rs("ClassStartTime1")
ClassEndTime1 =  rs("ClassEndTime1")


	
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
<SCRIPT LANGUAGE="JavaScript"  type="text/javascript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.AddForm.ClassInfoTitle.value=="") {
themessage = themessage + " - Class Title \r";
}
if (document.AddForm.ClassInfoStudentFee.value=="") {
themessage = themessage + " - Class Price \r";
}


//alert if fields are empty and cancel form submit
if (themessage == "Please fill out the following fields: \r") {
document.AddForm.submit();
}
else {
alert(themessage);
return false;
   }
}
//  End -->
</script>

<a name="Edit">
<% 
	row = "odd"
	rowcount = 1
 	sql = "select * from ClassInfo " 
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	if not rs.eof then 
%>

	<table border = "0" bordercolor = "#DBF5F3"  cellpadding=0 cellspacing=0 width = "<%=screenwidth%>" align = "center" >
	<tr>
 <td class = "body2" width = "200">* = required field<br>
</td>
</tr>

<form action= 'ClassesEditHandleForm.asp#Edit' method = "post">
<input name="Action"  size = "60" value = "Update" type = "hidden">
<input name="EventID"  size = "60" value = "<%=EventID%>" type = "hidden">
<% 	
rowcount = 1
While Not rs.eof %>
	
<script language="javascript1.2">
  // attach the editor to the textarea with the identifier 'textarea1'.
   WYSIWYG.attach(<%=rowcount%>);
</script>
<script language="javascript1.2">
  // attach the editor to the textarea with the identifier 'textarea1'.
   WYSIWYG.attach("A<%=rowcount%>");
</script>

<%	
AddressID1 = ""
AddressID2 = ""
AddressID3 = ""
AddressID4 = ""
AddressID5 = ""
AddressID6 = ""
AddressID7 = ""
AddressTitle1 = ""
AddressTitle2 = ""
AddressTitle3 = ""
AddressTitle4 = ""
AddressTitle5 = ""
AddressTitle6 = ""
AddressTitle7 = ""

ClassInfoTitle = rs("ClassInfoTitle")
instructorPeopleID= rs("instructorPeopleID")
ClassInfoStudentFee = rs("ClassInfoStudentFee")
ClassDateMonth = rs("ClassDateMonth")
ClassDateDay = rs("ClassDateDay")
ClassDateYear = rs("ClassDateYear")
ClassStartTime = rs("ClassStartTime")
ClassEndTime = rs("ClassEndTime")
ClassInfoRoomDesignation = rs("ClassInfoRoomDesignation")
ClassInfoMaximumStudents = rs("ClassInfoMaximumStudents")
ClassInfoMinimumStudents = rs("ClassInfoMinimumStudents")
ClassInfoDescription = rs("ClassInfoDescription")
ClassHomework = rs("ClassHomework")
ClassInfoID = rs("ClassInfoID")

AddressID1 = rs("AddressID1")
if len(AddressID1) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID1
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle1 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek1 = rs("ClassDateDayOfWeek1")
ClassStartTime1 = rs("ClassStartTime1")
ClassEndTime1 =  rs("ClassEndTime1")

AddressID2 = rs("AddressID2")
response.write("AddressID2 =" & AddressID2  )
if len(AddressID2) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID2
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle2 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek2 = rs("ClassDateDayOfWeek2")
ClassStartTime2 = rs("ClassStartTime2")
ClassEndTime2 =  rs("ClassEndTime2")

AddressID3 = rs("AddressID3")
if len(AddressID3) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID3
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle3 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek3 = rs("ClassDateDayOfWeek3")
ClassStartTime3 = rs("ClassStartTime3")
ClassEndTime3 =  rs("ClassEndTime3")

AddressID4 = rs("AddressID4")
if len(AddressID4) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID4
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle4 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek4 = rs("ClassDateDayOfWeek4")
ClassStartTime4 = rs("ClassStartTime4")
ClassEndTime4 =  rs("ClassEndTime4")

AddressID5 = rs("AddressID5")
if len(AddressID5) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID5
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle5 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek5 = rs("ClassDateDayOfWeek5")
ClassStartTime5 = rs("ClassStartTime5")
ClassEndTime5 =  rs("ClassEndTime5")

AddressID6 = rs("AddressID6")
if len(AddressID6) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID6
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle6 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek6 = rs("ClassDateDayOfWeek6")
ClassStartTime6 = rs("ClassStartTime6")


ClassEndTime6 =  rs("ClassEndTime6")

AddressID7 = rs("AddressID7")
if len(AddressID7) > 0 then
sqlt = "select AddressTitle from Address where addressID = " & AddressID7
rst.Open sqlt, conn, 3, 3   
if not rst.eof then 
AddressTitle7 = rst("AddressTitle")
end if
rst.close
end if
ClassDateDayOfWeek7 = rs("ClassDateDayOfWeek7")
ClassStartTime7 = rs("ClassStartTime7")
ClassEndTime7 =  rs("ClassEndTime7")


If row = "even" Then
	row = "odd"
Else
	row = "even"
End if %>
<%If row = "even" Then %>
	<table border = "0"  width = "<%=screenwidth%>"  cellpadding=0 cellspacing=0 align = "center" bgcolor = "#dddddd">
<% Else %>
	<table border = "0" width = "<%=screenwidth%>"  cellpadding=0 cellspacing=0 align = "center" bgcolor = "white">
<% End If %>
 
<tr >
  	<td class = "body2" valign = "top" >
  	<table>
  	<tr>
  <td class = "body2"  align = "right" valign = "top"><small>Class Title: *</small></td>
  <td>
  	<input name="ClassInfoID(<%=rowcount%>)"  size = "60" value = "<%=ClassInfoID%>" type = "hidden">
  	<input NAME="ClassInfoTitle(<%=rowcount%>)" size="30" value="<%=ClassInfoTitle%>" /></textarea>
  	
  </td>
   	</tr>
  
    <tr>
  	<td class = "body2" align = "right" width = "70"><small>Price: *</small></td>
  	<td class = "body"> $<input class="positive" type="text" name = "ClassInfoStudentFee(<%=rowcount%>)" size = 7 maxsize = 9 value = "<%=ClassInfoStudentFee%>">
  	<br><small><i>For free classes please enter "0" for the price.</i></small>

	
	<script type="text/javascript">
	$(".positive").numeric({ negative: false }, function() { alert("No negative values"); this.value = ""; this.focus(); });
	</script>
</td>
</tr>
<tr><td >




</td></tr>
</table>

</td>
<% 'response.write("rowcount = " & rowcount & "ClassInfoDescription" & ClassInfoDescription & "<br>")%>
 <td class = "body2"><small>Description:</small><br><TEXTAREA NAME="ClassInfoDescription(<%=rowcount%>)" cols="70" rows="11" wrap="file" ID="<%=rowcount%>" ><%=ClassInfoDescription%></textarea><br>
</td>
</tr>
<tr><td colspan ="2">
<h2>Schedule:</h2>
<table><tr>
<td class = "body"><b>Address</b></td>
<td class = "body"><b>Day of Week</b></td>
<td class = "body"><b>Start Time</b></td>
<td class = "body"><b>End Time</b></td>
</tr>
<tr>
<td class = "body">
<select size="1" name="AddressID1(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID1%>" selected><%=AddressTitle1%></option>
<option value="">------</option>
<% count = 1
while count < acounter %>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek1(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek1) > 0 then %>
<option value="<%=ClassDateDayOfWeek1%>" selected><%=ClassDateDayOfWeek1%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime1(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime1%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime1(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime1%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID2(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID2%>" selected><%=AddressTitle2%></option>
<option value="">------</option>
<% count = 1
while count < acounter %>
<option name = "AID1" value="<%=AddressIDArray(count)%>">
<%=AddressTitleArray(count)%>
</option>
<% 	count = count + 1
wend %>
</select>
</td>
<td class = "body">
<select size="1" name="ClassDateDayOfWeek2(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek2) > 0 then %>
<option value="<%=ClassDateDayOfWeek2%>" selected><%=ClassDateDayOfWeek2%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime2(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime2%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime2(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime2%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID3(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID3%>" selected><%=AddressTitle3%></option>
<option value="">------</option>
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
<select size="1" name="ClassDateDayOfWeek3(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek3) > 0 then %>
<option value="<%=ClassDateDayOfWeek3%>" selected><%=ClassDateDayOfWeek3%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime3(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime3%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime3(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime3%>"></td>
</tr>



<tr>
<td class = "body">
<select size="1" name="AddressID4(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID4%>" selected><%=AddressTitle4%></option>
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
<select size="1" name="ClassDateDayOfWeek4(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek4) > 0 then %>
<option value="<%=ClassDateDayOfWeek4%>" selected><%=ClassDateDayOfWeek4%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime4(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime4%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime4(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime4%>"></td>
</tr>



<tr>
<td class = "body">
<select size="1" name="AddressID5(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID5%>" selected><%=AddressTitle5%></option>
<option value="">------</option>
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
<select size="1" name="ClassDateDayOfWeek5(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek5) > 0 then %>
<option value="<%=ClassDateDayOfWeek5%>" selected><%=ClassDateDayOfWeek5%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime5(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime5%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime5(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime5%>"></td>
</tr>


<tr>
<td class = "body">
<select size="1" name="AddressID6(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID6%>" selected><%=AddressTitle6%></option>
<option value="">------</option>
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
<select size="1" name="ClassDateDayOfWeek6(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek6) > 0 then %>
<option value="<%=ClassDateDayOfWeek6%>" selected><%=ClassDateDayOfWeek6%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime6(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime6%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime6(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime6%>"></td>
</tr>




<tr>
<td class = "body">
<select size="1" name="AddressID7(<%=rowcount%>)">
<option name = "AID0" value= "<%=AddressID7%>" selected><%=AddressTitle7%></option>
<option value="">------</option>
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
<select size="1" name="ClassDateDayOfWeek7(<%=rowcount%>)">
<% if len(ClassDateDayOfWeek7) > 0 then %>
<option value="<%=ClassDateDayOfWeek7%>" selected><%=ClassDateDayOfWeek7%></option>
<option value="">------</option>
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
<td class = "body"><input type="text" name = "ClassStartTime7(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassStartTime7%>"></td>
<td class = "body"><input type="text" name = "ClassEndTime7(<%=rowcount%>)" size = 9 maxsize = 9 value = "<%=ClassEndTime7%>"></td>
</tr>
</table>
<br /><br />

</td></tr>
</table>


<% rowcount = rowcount + 1
rs.movenext
Wend
%>
</td></tr>
<tr>








<td colspan = "4" align = "center"><input type = "hidden" name="TotalCount" value= "<%= rowcount - 1 %>" >
<center>
<br>
<input type="submit" value="Update Classes"  class = "regsubmit2" >
</center>
</td></tr></table>
</form>
<% end if %>
</td></tr></table>
<!--#Include file="adminFooter.asp"-->
</Body>
</HTML>