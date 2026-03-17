<!DOCTYPE html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
<!--#Include file="AdminGlobalVariables.asp"-->
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include virtual="/administration/adminHeader.asp"--> 
<%
dim IDArray(2000) 
dim listalpacaName(2000)
ID = Request.QueryString("ID")
if len (ID) < 1 then
   ID = Request.Form("ID")
end if
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
rs.Open sql, conn, 3, 3
If not rs.eof  Then
SpeciesID = rs("SpeciesID")
animalname = rs("FullName")
End if
end if
current = "Photos"
 %>
  <% 
   Current2="AlpacasHome"
Current3 = "Photos" %>
<%  if mobiledevice = False and screenwidth > 600 then %>
   <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<%
end if
  
'response.write("ID=")
'response.write(ID)

 If Len(ID) = 0 Then 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
if rs2.eof then %>

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% end if %>


<tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Photos</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" valign = "top" height = "300">
Currently you do not have any animals entered. To add animals please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add Animals</a> tab.
</td>
</tr>
</table>

<%	else
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ID")
		ListAnimalName2(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<% if mobiledevice = true  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "100%">
<% else 
if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth %>">
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<% end if %>
<% end if %>
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Animal Photos & Other Uploads</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top" height = "300">	 

<form action="AdminPhotos.asp" method = "post" name = "edit2">
			  <table border = "0" width = ""  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				
				 <td class = "body">
					<br>Select one of your animals:
					<select size="1" name="ID">
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
							<center><input type=submit Value = "Submit" class = "regsubmit2"  <%=Disablebutton %> ></center>
				</td>
			  </tr>
		    </table>
		  </form>
		  		</td>
			  </tr>
		    </table>
		     <% End if %>
<% Else %>
	
 <center><!-- #include file="AdminPhotoFormInclude.asp" --></center>
 <% End if %>
	</td>
			  </tr>
		    </table>
		    <br /><br />
  <!-- #include virtual="/administration/adminFooter.asp" -->
 </Body>
</HTML>
