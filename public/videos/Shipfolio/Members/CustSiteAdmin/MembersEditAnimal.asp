<!DOCTYPE html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Edit Your Animal Listing</title>
 <!--#Include file="AdminGlobalVariables.asp"-->
<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
if len(ID) > 0 then
Response.redirect("memberseditanimal.asp?ID=" & ID)
end if

end if
%>
</head>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&ID=<%=ID %>);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<% Current1="Animals"
Current2 = "EditAnimals"  %> 
<!--#Include file="AdminHeader.asp"-->
<% Current3 = "AnimalEdit"  %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table width = 100% cellpadding = 0 cellspacing = 0 class = roundedtopandbottom>
<tr><td>

<!--#Include file="membersGlobalVariables.asp"-->

<% 
Set rs2 = Server.CreateObject("ADODB.Recordset")

ID = request.querystring("ID")
if len(ID) > 0 then
else
ID = request.form("ID")
end if

If Len(ID) > 0 then
sql2 = "select * from Photos where ID = " &  ID & ";" 

rs2.Open sql2, connLOA, 3, 3   
If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
connLOA.Execute(Query) 
End If 
End if

sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID = " & session("AIID") & " order by Fullname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3 
	if rs2.eof then 
   'NumberofAnimals = rs2("NumberofAnimals")  
    %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  ><tr><td class = "body" align = "left">
		<H2><div align = "left">Edit a Listing</div></H2>
        Currently you do not have any animals entered. To add animals please select the <a href = "MembersAnimalAdd1.asp" class = "body">Add Animals</a> tab.<br /><br />
        </td>
        </tr>
        </table>
        
<%	else
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

str1 = alpacaName(acounter)
str2 = "''"
If InStr(str1,str2) > 0 Then
alpacaName(acounter)= Replace(str1,  str2, "'")
End If  
		acounter = acounter +1
		rs2.movenext
	Wend		


 If Len(ID) = 0 Then %>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -80%>" height = "300" ><tr><td  align = "left" valign = "top">
<H1>Edit an Animal's Listing</H1>
<form  action="memberseditanimal.asp" method = "post" name = "edit1">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
<tr><td colspan ="30">
					&nbsp;
				</td>
	<td class = "body" valign = "top">
					<br>Select one of your animals:
					<select size="1" name="ID" class = formbox>
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
 </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
<tr><td></td></tr>
</table>
<% else
sql2 = "select Animals.ID, Animals.FullName, NumberofAnimals, SpeciesID, Category from Animals where ID = " & ID & " order by Fullname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3 
NumberofAnimals = rs2("NumberofAnimals")
name = rs2("FullName")
SpeciesID = rs2("SpeciesID")
Category = rs2("Category")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
%>

 <!--#Include file="membersEditPagecontentInclude.asp"--> 

<% End if %>
<% End if %>
</td></tr></table>
<!--#Include file="adminFooter.asp"-->

 </Body>
</HTML>
