<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<meta name="robots" content="nofollow"/>
<% ID = request.querystring("ID") %>

<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>

</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ID=<%=ID %>'  );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<!--#Include file="adminGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalDelete"   %> 
<!--#Include file="AdminHeader.asp"--> 
<% Current3 = "DeleteAnimals"  %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>" class = "roundedtopandbottom">
<tr><td  align = "left">
<H1><div align = "left"><font class="blink_text"><b>Delete an Animal</b></font></div></H1>
<% conn.close
set conn = nothing %>
<!--#Include virtual="/ConnLOA.asp"-->
<%  
dim aID(40000)
dim aName(40000)

Set rs2 = Server.CreateObject("ADODB.Recordset")

deletedone = request.querystring("deletedone")
if deletedone = true then %>
<h2>Your Animal Listing has Been Deleted.</h2>
<% end if

if len(ID) > 0 then

sql2 = "select ID, FullName from Animals where ID= " & ID 
'response.write("sql2=" & sql2)
acounter = 1
rs2.Open sql2, connLOA, 3, 3 
if not rs2.eof then
tempID = rs2("ID")
tempname = rs2("FullName")
end if
rs2.close

end if

sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID= " & session("AIID") & " order by Fullname"
acounter = 1
rs2.Open sql2, connLOA, 3, 3 
if rs2.eof then %>
Currently you do not have any animals entered. To add animals please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.
<%	else
While Not rs2.eof  
aID(acounter) = rs2("ID")
aName(acounter) = rs2("FullName")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing
set connLOA = nothing
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width =  "<%=screenwidth - 32 %>">
	<tr>
		<td class = "body" valign = "top" align = "center">
				<table width = "<%=screenwidth - 100 %>" align = "center"><tr><td width = "60" align = "center"><img src = "images/Important_Triangle.png" align = "left">
				</td>
				<td class = "body" align = "left">To delete an animal's data simply select the animals name below and select the  "Delete" button.<br> <b><big>But careful. Once an animal is deleted from your database, it's gone!</big></b>
				</td>
				</tr>
				</table><br>


<form action= 'membersDeleteAnimalhandleform1.asp' method = "post">
<input type = "hidden" name="PhotoType" value= "ListPage">
<b>Animal's Name</b>
<select size="1" name="ID" class = "formbox">
<% if len(tempname) > 0 then %>
<option value = "<%=tempID %>" selected><%=tempname %></option>
<option name = "AID0" value= "" ></option>
<% else %>
<option name = "AID0" value= "" selected></option>
<% end if %>
<% count = 1
while count < acounter
%>
<option name = "AID1" value="<%=aID(count)%>">
<%=aName(count)%>
</option>
<% count = count + 1
wend %>
</select>
<input type=submit value = "Delete"  class = "regsubmit2" >
</form>
</td></tr></table>
</td></tr></table>
<% end if %>
<br>
<!--#Include file="adminFooter.asp"-->  </Body>
</HTML>