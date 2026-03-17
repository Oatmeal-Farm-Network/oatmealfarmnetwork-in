<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Alpaca Infinity Membersistration</title>
<meta name="Title" content="Alpaca Infinity Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariables.asp"-->
<% 
   Current2="AlpacasHome"
   Current3="DeleteAlpacas" %> 
<!--#Include file="MembersHeader.asp"-->
<br />
<!--#Include file="MembersAnimalsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Delete an Alpaca</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" valign = "top" height = "300">


<%  
dim aID(40000)
dim aName(40000)
	sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID= " & peopleID & " order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if rs2.eof then %>
Currently you do not have any alpacas entered. To add alpacas please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.
<%	else
While Not rs2.eof  
aID(acounter) = rs2("ID")
aName(acounter) = rs2("FullName")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing
set conn = nothing
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width =  "920">
	<tr>
		<td class = "body" valign = "top" align = "center">
				<table width = "650 align = "center"><tr><td width = "60" align = "center"><img src = "images/Important_Triangle.png" align = "left">
				</td>
				<td class = "body" align = "left">To delete an alpaca's data simply select the animals name below and select the  "Delete" button.<br> <b><big>But careful. Once an animal is deleted from your database, it's gone!</big></b>
				</td>
				</tr>
				</table><br>

			<form action= 'DeleteAlpacaHandleForm.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			 		<b>Alpaca's Name</b>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Delete"  class = "regsubmit2" >

		  </form>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<% end if %>
<br>

 <!--#Include virtual="/Footer.asp"-->  </Body>
</HTML>