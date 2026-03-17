<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<% animalID = request.querystring("animalID") %>

</head>
<body >

<!--#Include file="MembersGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalDelete" 
Current3 = "Delete"
Current1 = "MembersHome"
BladeSection = "accounts" 
pagename = BusinessName%> 
<!--#Include file="MembersHeader.asp"-->
<br />
<div class ="container roundedtopandbottom">
<div class ="row">
<div class ="col">
<H1><div align = "left">Delete an Animal Listing</div></H1>
<%  
dim animalIDarray(40000)
dim aName(40000)

Set rs2 = Server.CreateObject("ADODB.Recordset")


If len(AnimalID) > 0 then
	sql2 = "select ID, FullName from Animals where animalID= " & animalID 
	'response.write("sql2=" & sql2)
	acounter = 1
	rs2.Open sql2, conn, 3, 3 
			if not rs2.eof then
				tempanimalID = rs2("animalID")
				tempname = rs2("FullName")
			end if
	rs2.close
end if
acounter = 0

If len(AnimalID) > 0 then
	sql2 = "select Animals.animalID, Animals.FullName from Animals where AnimalID= " & AnimalID & " order by Fullname"
	acounter = 1
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then %>
		Currently you do not have any animals entered. To add animals please <a href = "MembersAnimalAdd1.asp" class = "body"><b>click here</b></a>.<br /><br />
<%	else
	While Not rs2.eof  
		animalIDarray(acounter) = rs2("animalID")
		aName(acounter) = rs2("FullName")
		acounter = acounter +1
		rs2.movenext
	Wend
	end if	

	rs2.close
	set rs2=nothing
	set conn = nothing
end if		
response.write("acounter=" & acounter)
%>

<% if acounter = 0 then %>
This account does not have any animals.


<% else %>

				<table width = "90%" align = "center" >
					<tr><td width = "60" align = "center" valign ="top"><img src = "/icons/Important_Triangle.png" align = "left">
				</td>
				<td class = "body" align = "left">To delete an listing select the listing's name below and select the "Delete" button.<br> <b><big>Careful. Once an animal listing is deleted, it's gone!</big></b>
				<br /><br />
					<br />
				<form action= 'membersDeleteAnimalhandleform1.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
				<b>Animal's Name</b>
				<select size="1" name="AnimalID" class = "formbox">
					<% if len(tempname) > 0 then %>
						<option value = "<%=tempID %>" selected><%=tempname %></option>
						<option name = "AID0" value= "" ></option>
					<% else %>
						<option name = "AID0" value= "" selected></option>
					<% end if %>
				<% count = 1
				while count < acounter %>
					<option name = "AID1" value="<%=animalIDarray(count)%>">
					<%=aName(count)%>
					</option>
					<% count = count + 1
				wend %>
				</select>
				<input type=submit value = "Delete"  class = "regsubmit2" >
				</form>

				</td>
				</tr>
				</table><br>
				<center><form action= 'MembersDeleteCancel.asp' method = "post">
				     <input type = "hidden" name="ID" value= "<%=ID %>">
					<input type=submit value = "Cancel"  class = "regsubmit2" >
                  </form></center>
<br>
<% end if %>
<br><br>
</div>
</div>

<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>