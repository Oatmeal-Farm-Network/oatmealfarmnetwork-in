<br />
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "<%=screenwidth -42%>"><tr><td class = "body" align = "left">
<%
sql2 = "select * from People where PeopleID = " & session("AIID")

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3   
If Not rs2.eof Then
PaypalEmail = rs2("PaypalEmail")
PaymentMethodFowl = rs2("PaymentMethodFowl")
End If 

 str1 = name
str2 = "''"
If InStr(str1,str2) > 0 Then
name= Replace(str1,  str2, "'")
End If  

sql = "select * from SpeciesAvailable where SpeciesID =  " & SpeciesID 

rs.Open sql, connLOA, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType") 
end if
%>

<H2><div align = "left"><font color = "grey">Complete Information for </font><%=name %></div></H2><br />
<% FirstTime= request.querystring("FirstTime")
If FirstTime then %>
<h2>Add More Information</h2>
Now that you have added your animal listing, use this page to add a  lot more information. <br /><br />
<h2>Publish Your Animal</h2>
Before your animals will show up on the website - for sale or stud - you need to select the publish buttons below.
<% end if %>
<br />

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "<%=screenwidth -42%>" align = "center">
<tr><td><a name = "top"></a></td></tr>
<tr><td >	
 <%  Dim listalpacaName(100000)
sql2 = "select * from Animals where PeopleID = " & Session("AIID") & " order by Fullname ;"
'response.write(sql2)
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3 
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
<table border = "0" width = "<%=screenwidth -62 %>" class = "formbox" align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" align = "left">
   <font class = "body">
	<form  action="MembersEditAnimal.asp" method = "post">
	<b>Select Another Animal:</b>
	<select size="1" name="ID" onchange="submit();" class = "formbox">
	<option name = "AID0" value= "" selected></option>
	<% count = 1
		while count < acounter
			response.write(count)%>
			<option name = "AID1" value="<%=IDArray(count)%>">
			<%=listalpacaName(count)%>
			</option>
			<% 	count = count + 1
		wend %>
	</select><br />
</form>
</font>
</td></tr></table>
<a name="Add"></a>
<%
JustAdded= request.querystring("JustAdded")
if JustAdded =true then %>
  <b><Font color = "brown">Animal Added! Now take a moment to review your information below, or <a href = "MembersPhotos.asp?ID=<%=ID %>" class = "body">add photos</a>. Note, that your animal will not show up until you select the publish button below.</Font></b>
<% end if %>

<br /><br />


<% if speciesid = 13 or speciesid = 14 or speciesid = 15 or speciesid = 19 then %>
<table width = 100% cellpadding = 5 cellspacing = 5 border = 0 class = roundedtopandbottom bgcolor = "#404040">
<tr>
<td width = 50% valign = Top >
<iframe src="/members/MembersAnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "100%" height = "100" scrolling = "no" bgcolor ="white" align = "center" ></iframe>

</td>
<td width = 50% class = body bgcolor = "#e6e6e6">
 <form action= 'membersFowlAccountHandleForm.asp?ID=<%=ID %>' method = "post">
<H2>Payment Method</H2>
<i>Note: The information below applies to all of the fowl that you list for sale.</i><br />
<b>How can people pay for your fowl? </b><br>
	<select size="1" name="PaymentMethodFowl" class = "formbox" style="width:300px">
			<option value="<%=PaymentMethodFowl %>" selected><%=PaymentMethodFowl %></option>
			<option value="Contact Me">Contact Me</option>
			<option value="PayPal">PayPal</option>
        <% anotherwbsiteoption = false
        if anotherwbsiteoption = True then %>
			<option value="Send Users to Another Website">Send Users to Another Website</option>
        <% end if %>
		</select>
<br>
<b>Email used if your paypal account (if applicable)</b><br>
<input name="PaypalEmail"  size = "60" value = "<%=PaypalEmail %>" class = "formbox">
<br /><br />
<center><input type=submit value = "Submit Changes" class = "regsubmit2" ></center>
</td>
</tr></table>
<% else %>


<table width = 100% align = center cellpadding = 0 cellspacing = 0 height = 180  bgcolor = "#e6e6e6">
<tr><td align = center >
<center><iframe src="MembersAnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "100%" height = "180" scrolling = "no" bgcolor ="white" align = "center" ></iframe></center>
</td></tr></table>
<% end if%>

<br /><br />

 <table border = "0" width = "<%=screenwidth -62%>" class = "formbox" align = "center" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr><td class = "body" align = "left">
<h2>Photos</h2>
To upload photos select the <a href = "MembersPhotos.asp?ID=<%=ID %>#Photos" class = "body">Photos tab</a>.
</td>
<td class = "body" align = "left">
<h2>Delete</h2>
To delete an animal select the <a href = "membersdeleteAnimal.asp?ID=<%=ID %>#Photos" class = "body">Delete animals tab</a>.
</td></tr></table>

<% if AutoTransfer = True then 
If Len(ID) > 0 then %>
<!--#Include virtual="/connLOA.asp"-->
<%	sql2 = "select * from Photos where ID = " &  ID & ";" 

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3   
If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
connLOA.Execute(Query) 

End If 
End if

sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connLOA, 3, 3 
	
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
								


sql = "select Lastupdated from Animals where ID = " & ID
'response.write("sql=" & sql)
rs.Open sql, connLOA, 3, 3   
rowcount = 1
Lastupdated = rs("Lastupdated")
rs.close

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = <%=screenwidth-62 %> >
<tr><td align = "center">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = <%=screenwidth-62 %>><tr>
<td class = "body" valign = "top">

<% if screenwidth > 800 then
if mobiledevice = False then %>
<td class = "body"  width = "300" valign = "top">
<%else %>
<td class = "body" >
<% end if %>

</td>
<% end if %>
</tr>
<% show =true
if show = true then %>
 <% 
end if
show =true
if show = true then %> 


<tr><td  valign = 'absbottom' align = "center" colspan = "6">


<a name='BasicFacts'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>	
<tr><td align = "left" colspan = "6" align = "abstop" >
<%
if speciesid = 5 or  speciesid = 8 then
generalframeheight = 1150
else
generalframeheight = 700
end if

if speciesid = 22 or speciesid = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13 then 
generalframeheight = 650
end if
 %>
<iframe src="MembersGeneralStatsFrame.asp?ID=<%=ID %>&screenwidth=<%=screenwidth -62%>" height = '<%=generalframeheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>
</td></tr>
<% if trim(category) = "Unowned Animal" then 
else%>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Pricing'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">


<%
if speciesid = 5 or  speciesid = 8 then
pricingframeheight = 700
else
pricingframeheight = 650
end if
'response.write("speciesID=" & speciesID )
'response.write("numberofanimals=" & numberofanimals )
if SpeciesID = 22 or SpeciesID = 19 or SpeciesID = 15 or SpeciesID = 14 or SpeciesID = 13 then 
if numberofanimals = 1 then
pricingframeheight = 650
else
pricingframeheight = 780
end if
end if

%>

<iframe src="MembersPricingFrame.asp?ID=<%=ID %>&Category=<%=Category %>&SpeciesID=<%=SpeciesID %>" height = '<%=pricingframeheight %>' width = '<%=screenwidth-42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>


</td></tr>

<% end if %>

 
<% If category = "Inexperienced Female" Or Category = "Experienced Female" Then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="MembersFemaleDataFrame.asp?ID=<%=ID %>" height = '360' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
</td></tr>
<% End If %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Description'></a>
		<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<%

if speciesID = 22 or speciesID= 19 or speciesID = 15 or speciesID = 14 or speciesID = 13 then 
Descriptionframeheight = 600
else
Descriptionframeheight = 600
end if



 If category = "Experienced Male" Or category = "Inexperienced Male" then %>
<iframe src="MembersDescriptionFrame.asp?ID=<%=ID %>&category=<%=category %>&screenwidth=<%=screenwidth-42 %>" height = '<%=Descriptionframeheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<% else %>

<iframe src="MembersDescriptionFrame.asp?ID=<%=ID %>&category=<%=category %>&screenwidth=<%=screenwidth-42 %>" height = '<%=Descriptionframeheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<% end if %>


</td></tr>
<% if speciesID = 22 or speciesID = 19 or speciesID = 15 or speciesID = 14 or speciesID = 13 then

else %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Awards'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<% 

sql = "select Count(*) as count from awards where ID = " & ID & " and (not(len(Placing)< 1) or not(len(Class)< 1) or not(len(AwardYear)< 2)  or not(len(Awardcomments)< 1)  or not(len(Showname)< 1)  or not(len(Judge)< 1) )  "
rs.Open sql, connLOA, 3, 3  
FilledRecordcount = rs("count")
rs.close  
 
sql = "select Count(*) as count from awards where ID = " & ID 
rs.Open sql, connLOA, 3, 3  
Recordcount = rs("count")
rs.close

'response.write("Recordcount=" & Recordcount  )
'response.write("FilledRecordcount=" & FilledRecordcount  )

if cLng(Recordcount) < cLng(FilledRecordcount) + 6 then
Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"
'response.write("Query=" & Query )
connLOA.Execute(Query) 

Query =  "INSERT INTO Awards (ID)" 
Query =  Query & " Values ('" &  ID & "')"
'response.write("Query=" & Query )
connLOA.Execute(Query) 
end if

sql = "select Count(*) as count from Animals, awards where Animals.ID = awards.ID and animals.ID = " & ID 
rs.Open sql, connLOA, 3, 3  
recordcount =  clng(rs("count"))
rs.close
frameheight = 130 + (37*(recordcount +1))

%>

<iframe src="MembersAwardsFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
</td></tr>

<% show = false
if show = True then %>	 
<% End If %>
</TABLE>	
<% end if %>
<% end if %>

<% if  (speciesID = 2 and  NumberofAnimals = "1") and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Fiber'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<%
sql = "select  Count(*) as count from Animals, Fiber where (len(fiber.SampleDateDay) > 0 or len(fiber.Average) > 1 or len(fiber.StandardDev) > 1 or len(fiber.GreaterThan30) > 1) and Animals.ID = Fiber.ID and animals.ID = " & ID
rs.Open sql, connLOA, 3, 3   
rowcount = 1
filledRecordcount = cLng(rs("count"))
rs.close

sql = "select Count(*) as count from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID 
rs.Open sql, connLOA, 3, 3   
rowcount = 1
Recordcount = cLng(rs("count"))
if Recordcount >  filledrecordcount + 5  then
Query =  "delete from Fiber where ID=" & ID & " and (len(fiber.SampleDateDay) < 1  and  len(fiber.Average) < 1 and len(fiber.StandardDev) < 1 and len(fiber.GreaterThan30) < 1) ; "
connLOA.Execute(Query)
recordcount = filledRecordcount + 5
end if

if recordcount  = filledRecordcount then
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query & " Values ('" &  ID & "')"
connLOA.Execute(Query) 
end if
If RecordCount  < 11 Then
NeedToAdd = 12 - RecordCount
rs.close
i = 1
While i < NeedToAdd
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query + " Values ('" &  ID & "')"
connLOA.Execute(Query) 
NeedToAdd = NeedToAdd - 1
wend
End If 

if rs.state = 0 then
else
rs.close
end if
frameheight = 55 + (85*recordcount)%>
<iframe src="MembersFiberFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='EPD'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">

<% frameheight = 590%>
<iframe src="MembersAlpacaEPDFrame.asp?ID=<%=ID %>&Recordcount=<%=recordcount %>" height = '<%=frameheight %>' width = '<%=screenwidth-42 %>' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
</td></tr>
<% end if %>


<% If SpeciesSalesType = "Fowl" then
else %>
<% if  NumberofAnimals = "1" and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Ancestry'></a> 
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<iframe src="MembersAncestryFrame.asp?ID=<%=ID %>&speciesID=<%=speciesID %>" height = '1580' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
<br><br>
</TD></TR>
<% end if %>
<% end if %>


<br><br>
</TD></TR>
<tr><td><a href = "#Top" class = "body"><center>Go To Top</center></a></td></tr>
</TABLE>	
</TD></TR></TABLE>	
</TD></TR></TABLE>	

