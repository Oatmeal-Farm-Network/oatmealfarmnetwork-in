<%
   Current2="AlpacasHome"
   Current3="AlpacaEdit" 
%>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 

  <% 
   Current2="AlpacasHome"
   Current3="AlpacaEdit" %>
<%  if mobiledevice = False and screenwidth > 600 then %>
   
<%
end if
%>
<% 
if ShowLOA = True then

sql2 = "select * from AutoTransfers where ReceivingwebsiteName = 'Livestock Of America'" 
'response.write(sql2)
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if Not rs2.eof then 
AutoTransfer= rs2("AutoTransfer")
'response.write("AutoTransfer=" & AutoTransfer )
end if
rs2.close%>

<!--#Include virtual="/Administration/Transfers/Dimensions.asp"-->
<% else
AutoTransfer =False
end if
if AutoTransfer = True then %>
<!--#Include virtual="/Administration/Transfers/adminDetailDBInclude.asp"--> 

<% 
If Len(ID) > 0 then
		
%>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
	
   
<%  if mobiledevice = False and screenwidth > 600 then %>

<%
end if
%>
<!--#Include virtual="/Conn.asp"-->
<%	
 sql2 = "select * from Photos where ID = " &  ID & ";" 
'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
Conn.Close
Set Conn = Nothing 
End If 
End if

	
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close



else
if rs.state = 0 then
else
rs.close
end if
end if ' end transfer	
								
sql2 = "select * from People where PeopleID = 667;" 

'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

AIEmail = rs2("AIEmail")
AIPassword = rs2("AIPassword")
End If %>

<%
if screenwidth > 1000 then
screenwidth = 989
end if
 if mobiledevice = False  or screenwidth < 801 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = <%=screenwidth %> ><tr><td class = "roundedtop" align = "left">
<H1> <%=Name%></H1></td></tr>
<tr><td class = "roundedBottom" align = "center">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr>
<td class = "body" valign = "top">

<%else %>
<H1> <%=FullName%></H1>

<% end if %>

<% if mobiledevice = False and (AdministrationID = 1 or AdministrationID = 3) and ShowLOA = True then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" height = "40"><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Log Into Livestock Of America</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" class = "body" height = "57">
<form action= "http://www.LivestockOfAmerica.com/handleLogin.asp" method = "post" target = "_blank">
				<table>
				<tr>
						<td Class = "body" align = "right">
							Email:
						</td>
						<td class = "body" align = "left">	
							<input type=text  name=UID value = "<%=AIEmail%>" SIZE = "36" >
						</td>
						<td rowspan= "2">
						<input type=submit value = "Login"  size = "170" class = "regsubmit2"  <%=Disablebutton %> >
						</td>
					</tr>
					<tr>
						<td Class = "body" align = "right">
							Password:
						</td>
						<td class = "body" align = "left">	
							<input type= password name=password value = "<%=AIPassword%>" SIZE = "12">
						</td>
					</tr>
				</table>
			</form>
</td>
  </tr>
</table>
</td>
<% if screenwidth < 600 then %>
</tr><tr>
<% else %>
<td width = "10"></td>
<% end if %>

<td class = "body" align = "center" >
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" height = "40" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H3><div align = "center">Auto-Transfer to <br />Livestock of America</div></H3>
</td></tr>
<tr><td class = "roundedBottom" align = "center" class = "body" height = "57">
<form  action="/Administration/Transfers/setautoupdate.asp" method = "post" name="myform">
	<center><a class="tooltip" href="#"><b>Auto-Transfer:</b><span class="custom info">If the auto-transfer is set on then your animal information will automatically be updated to Livestock of America every time you make changes. <br /><br />
<em>Remember to Publish</em>After you transfer your animals to Livestock of America log into your Livestock of America  account to confirm your animals and products are published.</span></a>
	<% if AutoTransfer = "Yes" Or AutoTransfer = True Then %>
			On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" checked>
			Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" >
		<% Else %>
			On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" >
			Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" checked>
		<% End If %>	<input type=hidden name= "SendingPage" value = "/administration/AdminAnimalEdit.asp?ID=<%=ID %>"  >
	<input type=submit value = "Set Auto-Transfer"  size = "310" class = "regsubmit2"  <%=Disablebutton %> ></center>
			</form>
</td>
  </tr>
</table>

</td>
<td width = "13"></td>
  </tr>
  <% end if %>
<% if mobiledevice = False then %>
  <tr><td colspan = "3" height = "16"></td></tr>

<tr><td class = "body" width = "300" valign = 'top'>
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Edit Your Information</div></H3>
</td></tr>
<tr><td class = "roundedBottom" height = "180" valign = "top" class = "body" >
Scroll down to edit your information by topic or click on the links below to jump to the section that you need:<br><br>

<ul>
<li><a href = "#BasicFacts" class = "body">Basic Facts</a>
<li><a href = "#Pricing" class = "body">Pricing</a>
<% If category = "Unexperienced Female" Or Category = "Experienced Female" Then %>
<li><a href = "#BreedingRecord" class = "body">Breeding Record</a>
<% End If %>
<li><a href = "#Description" class = "body">Description</a>
<li><a href = "#Awards" class = "body">Awards</a>
<li><a href = "#Fiber" class = "body">Fiber</a>
<li><a href = "#Ancestry" class = "body">Ancestry</a>
</ul>
  </td></tr></table>
<% if screenwidth < 600 then %>
</tr><tr>
<% else %>
<td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
<% end if %>
		
<td class = "body"   width = "300" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Images</div></H3>
</td></tr>
<tr><td class = "roundedBottom"  class = "body" height = "180" valign = "top">
Click on the links below to upload:
<ul>
<li><a href = "AdminPhotos.asp?ID=<%=ID%>#ARI" class = "body">Registration</a>
<li><a href = "AdminPhotos.asp?ID=<%=ID%>#Histogram" class = "body">Histogram</a>
<li><a href = "AdminPhotos.asp?ID=<%=ID%>#Photos" class = "body">Photos</a>
<li><a href = "AdminPhotos.asp?ID=<%=ID%>#Video" class = "body">Video</a>
</ul>
</td>
</tr>
</table>
</td>

<td width = "15"><img src = "images/px.gif" height="0" width = "0"></td>
<% else %>
<tr><td colspan = "3" height = "16"></td></tr>
<tr>
<td class = "body" width = "100%">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" >
<tr><td class = "roundedtop" align = "left">
<H3><div align = "left">Edit Your Information</div></H3>
</td></tr>
<tr><td class = "roundedBottom"  class = "body" >
<a href = "#BasicFacts" class = "body">Basic Facts</a> | 
<a href = "#Pricing" class = "body">Pricing</a> | 
<% If category = "Unexperienced Female" Or Category = "Experienced Female" Then %>
<a href = "#BreedingRecord" class = "body">Breeding Record</a> | 
<% End If %>
<a href = "#Description" class = "body">Description</a> | 
<a href = "#Awards" class = "body">Awards</a> | 
<a href = "#Fiber" class = "body">Fiber</a> | 
<a href = "#Ancestry" class = "body">Ancestry</a> | 
<a href = "AdminPhotos.asp?ID=<%=ID%>#Photos" class = "body">Photos</a>
</td>
</tr>
</table>
</td>
</tr><tr>
<% end if %>
<% if screenwidth > 800 then
if mobiledevice = False then %>
<td class = "body"  width = "300" valign = "top">
<%else %>
<td class = "body" >
<% end if %>
<% sql2 = "select * from Animals, People  where animals.PeopleID = people.PeopleID order by Fullname ;"
'response.write(sql2)

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	If Not rs2.eof then

End If 

	While Not rs2.eof 
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
	
	sql2 = "select * from Animals  order by Fullname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close


	set rs2=nothing


%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Select Another Animal</div></H3>
</td></tr>
<tr><td class = "roundedBottom" height = "180" valign = "top" class = "body" >
		<form  action="AdminAnimalEdit.asp" method = "post">
			<% if mobiledevice = False then %>Select an animal below and push the edit button to update an animals information:<br><% end if %>
			  
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<% if mobiledevice = False then %><td colspan ="30">
					&nbsp;
				</td><% end if %>
				 <td class = "body"  valign = "top"><br>
				Select one of your animals:<br />
					<select size="1" name="ID" class = "regsubmit2 body">
					<option name = "AID0" value= "" selected class = "body"></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>" class = "body">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" class = "regsubmit2 body" >
				</td>
			  </tr>
</table>
<h2>Add a New Animal</h2>
<a href = "AdminAnimalAdd1.asp" class = "body">Click here</a> to add a new animal listing.
</form>
</td></tr></table>
</td>
<% end if %>
</tr>
<% show =true
if show = true then %>
 <% 
end if
show =true
screenwidth = screenwidth - 13
if show = true then %> 
<tr><td  valign = 'absbottom' align = "center" colspan = "6">
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>	
<tr><td align = "center" colspan = "6" align = "abstop" >
<a name = "BasicFacts"></a>
<% 
If speciesid = 2 then
frameheight = 400
end if

If speciesid = 3 then
frameheight = 370
end if

If speciesid = 4 then
frameheight = 350
end if

if speciesid = 5 then
frameheight = 690
end if

If speciesid = 6 then
frameheight = 500
end if

If speciesid = 7 then
frameheight = 430
end if

If speciesid = 8 then
frameheight = 500
end if

If speciesid = 9 then
frameheight = 500
end if

If speciesid = 10 then
frameheight = 600
end if


If speciesid = 11 then
frameheight = 500
end if

If speciesid = 12 then
frameheight = 400
end if

If speciesid = 13 then
frameheight = 500
end if

If speciesid = 14 then
frameheight = 500
end if

If speciesid = 15 then
frameheight = 500
end if

If speciesid = 16 then
frameheight = 500
end if

If len(frameheight) < 2 then
frameheight = 500
end if %>
<iframe src="AdminGeneralStatsFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>
<% if trim(category) = "Unowned Animal" then 
else%>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name = "Pricing"></a>
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="AdminPricingFrame.asp?ID=<%=ID %>" height = '490' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>
<% end if %>
 
<% If category = "Inexperienced Female" Or Category = "Experienced Female" Then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="AdminFemaleDataFrame.asp?ID=<%=ID %>" height = '260' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>
<% End If %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name = "Description"></a>
		<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<% If category = "Experienced Male" Or category = "Inexperienced Male" then %>
<iframe src="AdminDescriptionFrame.asp?ID=<%=ID %>&category=<%=category %>" height = '1000' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<% else %>

<iframe src="AdminDescriptionFrame.asp?ID=<%=ID %>" height = '510' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<% end if %>
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name = "Awards"></a>
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<% sql = "select Animals.FullName, awards.* from Animals, awards where Animals.ID = awards.ID and animals.ID = " & ID & " order by Awardyear DESC, Placing"
rs.Open sql, conn, 3, 3  
recordcount =rs.recordcount
rs.close
frameheight = 70 + (28*recordcount)
%>

<iframe src="AdminAwardsFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>

<% if speciesID = 2 then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name = "Fiber"></a>
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<%sql = "select Animals.FullName, Fiber.* from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID & " Order by SampleDateYear desc,  SampleDateMonth desc,  SampleDateYear desc, Average"
rs.Open sql, conn, 3, 3  
recordcount =rs.recordcount
rs.close
frameheight = 100 + (65*recordcount)%>
<iframe src="AdminFiberFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>

</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="AdminAlpacaEPDFrame.asp?ID=<%=ID %>" height = '400' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>
<% end if %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name = "Ancestry"></a> 
<!--#Include File="AdminJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="AdminAncestryFrame.asp?ID=<%=ID %>" height = '1780' width = '<%=screenwidth %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<br><br>
</TD>
</TR>
<% show = false
if show = True then %>	 
<% End If %>
</TABLE>	
<% end if %>
</TD>
</TR>
</TABLE>
<% set rs2=nothing
set conn = nothing %>