<!DOCTYPE html>
<%@ Language=VBScript %>

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Upload Animal Photos</title>
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="adminGlobalVariables.asp"-->
<% Current1="Animals"
Current2 = "AnimalPhotos" %> 
<!--#Include file="AdminHeader.asp"-->
<% 
Current3 = "Photos" %> 
<!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table cellpadding = 0 cellspacing = 0 class = "roundedtopandbottom">
<tr><td>

<% conn.close
set conn = nothing  %>
<!--#Include virtual="/connloa.asp"-->
<% ID = Request.QueryString("ID")
if len (ID) < 1 then
   ID = Request.Form("ID")
end if

sql = "select SubscriptionLevel from People where peopleID = " & session("AIID")
rs.Open sql, connLOA, 3, 3
If not rs.eof  Then
SubscriptionLevel = rs("SubscriptionLevel")
End if


dim IDArray2(1000) 
Dim ListAnimalName2(1000)

		
ID= Request.QueryString("ID") 
If Len(ID) < 1 then
ID= Request.Form("ID") 
End If 

if ID > 0 then
Session("AnimalID") = ID
Set rs = Server.CreateObject("ADODB.Recordset")
				
sql = "select FullName, SpeciesID from Animals where ID = " & ID
rs.Open sql, connLOA, 3, 3
 'response.write(rs.recordcount)
If not rs.eof  Then
name = rs("FullName")
SpeciesID = rs("SpeciesID")
End if

end if

'response.write("ID=")
'response.write(ID)

 If Len(ID) = 0 Then 
	sql2 = "select Animals.ID, Animals.FullName, speciesID from Animals where PeopleID = " & session("AIID") & " order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connLOA, 3, 3 
if rs2.eof then %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -22 %>"  ><tr><td  align = "left">
		<H2><div align = "left">Animal Photos</div></H2>
        </td></tr>
        <tr><td class = "body" align = "center" valign = "top" height = "300">
        Currently you do not have any animals entered. To add animals please select the <a href = "membersAnimalAdd1.asp" class = "body">Add Animal</a> tab.
        </td>
        </tr>
        </table>
        
<%	else
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ID")
		ListAnimalName2(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))
str1 = ListAnimalName2(acounter)
str2 = "''"
If InStr(str1,str2) > 0 Then
ListAnimalName2(acounter)= Replace(str1,  str2, "'")
End If 

		acounter = acounter +1
		rs2.movenext
	Wend		
	



rs2.close
set rs2=nothing
set connLOA = nothing
%>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -22%>"><tr><td  align = "left">
		<H1><div align = "left">Animal Photos & Other Uploads</div></H1>
        </td></tr>
        <tr><td align = "center" valign = "top" height = "300">	 

<form action="membersPhotos.asp" method = "post" name = "edit2">
			  <table border = "0" width = "<%=screenwidth -22%>"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				
				 <td class = "body">
					<br>Select one of your animals:
					<select size="1" name="ID" class = "formbox">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ListAnimalName2(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
		  		</td>
			  </tr>
		    </table>
		     <% End if %>
<% Else %>
 <center><!-- #include file="membersPhotoFormInclude.asp" --></center>
 <% End if %>
 </td></tr></table>
<!--#Include file="adminFooter.asp"--> 
 </Body>
</HTML>
