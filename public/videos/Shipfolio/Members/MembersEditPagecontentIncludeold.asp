 <% current = "AnimalFacts" %>
 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "<%=screenwidth %>"><tr><td class = "roundedtop body" align = "left">
<% str1 = name
str2 = "''"
If InStr(str1,str2) > 0 Then
name= Replace(str1,  str2, "'")
End If  
%>
<H2><div align = "left"><font color = "grey">Edit Information for </font><%=name %></div></H2>
<% FirstTime= request.querystring("FirstTime")
If FirstTime then %>
<h2>Add More Information</h2>
Now that you have added your animal listing, use this page to add more information. 
<h2>Publish Your Animal</h2>
Before your animals will show up on the website - for sale or stud - you need to select the publish buttons below.
<% end if %>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth %>" align = "center">
	<tr>
	  <td >	
 <%  Dim listalpacaName(100000)
	sql2 = "select * from Animals where PeopleID = " & Session("PeopleID") & " order by Fullname ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		listalpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
%>
  <table border = "0" width = "<%=screenwidth %>" class = "roundedtopandbottom" align = "left" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td class = "body" align = "left">
                 	<font class = "body">
		<form  action="EditAnimal.asp" method = "post">
					<b>Select Another Animal:</b>
					<select size="1" name="ID" onchange="submit();">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=listalpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
</form>
</font>
</td></tr></table>
 <br /><br />
<a name="Add"></a>
<%
JustAdded= request.querystring("JustAdded")
if JustAdded =true then %>
  <b><Font color = "brown">Animal Added! Now take a moment to review your information below, or <a href = "MembersPhotos.asp?ID=<%=ID %>" class = "body">add photos</a>. Note, that your animal will not show up until you select the publish button below.</Font></b>
<% end if %>
<% if speciesID = 8 then%>
<center><iframe src="/Membersistration/AnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "900" height = "170" scrolling = "no" bgcolor ="white" align = "center"></iframe></center>
<% else %>
<center><iframe src="/Membersistration/AnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "800" height = "170" scrolling = "no" bgcolor ="white" align = "center"></iframe></center>
<% end if %>

 <table border = "0" width = "<%=screenwidth %>" class = "roundedtopandbottom" align = "left" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" align = "left">
<h2>Photos</h2>
To upload photos select the <a href = "MembersPhotos.asp?ID=<%=ID %>#Photos" class = "body">Photos tab</a>.
</td>
<td class = "body" align = "left">
<h2>Delete</h2>
To delete an animal select the <a href = "deleteAnimal.asp?ID=<%=ID %>#Photos" class = "body">Delete animals tab</a>.
</td></tr></table>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  height = "300" width = "900">
<tr>
 <td class = "body" valign = "top" align = "right" width = "900">
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersGeneralStatsInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Conn.asp"-->
<!--#Include virtual="/Membersistration/MembersPricingInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<% 
showfemaledata = true
if (category = "Experienced Female" or category = "Experienced Female") and showfemaledata  = True then%>
<!--#Include File="MembersFemaleDataInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<% end if %>
<!--#Include virtual="/Membersistration/MembersDescriptionInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAwardsInclude.asp"-->
<% 



if  (speciesID = 2 and  NumberofAnimals = "1") and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersFiberInclude.asp"-->
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAlpacaEPDInclude.asp"-->
<% end if %>
<% if  NumberofAnimals = "1" and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
<!--#Include File="MembersJumpLinks.asp"-->
<!--#Include virtual="/Membersistration/MembersAncestryInclude.asp"--> 
<% end if %>
<br><br>
</TD></TR></TABLE>	
</TD></TR></TABLE>	
</TD></TR></TABLE>	