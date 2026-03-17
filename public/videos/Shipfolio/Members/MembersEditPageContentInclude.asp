
<%
sql2 = "select * from People where PeopleID = " & PeopleID

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If Not rs2.eof Then
PaypalEmail = rs2("PaypalEmail")
PaymentMethodFowl = rs2("PaymentMethodFowl")
End If 

 str1 = name
str2 = "''"
If InStr(str1,str2) > 0 Then
name= Replace(str1,  str2, "'")
End If  


if len(SpeciesID) >0 then
else
SpeciesID = 2
end if
sql = "select * from SpeciesAvailable where SpeciesID =  " & SpeciesID 
rs.Open sql, conn, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType") 
end if

%>
 <div class = "row" >
   <div class="col-12">
    <H2><div align = "left"><font color = "grey">Complete Information for </font><%=name %></div></H2><br />
    <% FirstTime= request.querystring("FirstTime")
        If FirstTime then %>
            <h2>Add More Information</h2>
            Now that you have added your animal listing, use this page to add a  lot more information. 
            <h2>Publish Your Animal</h2>
            Before your animals will show up on the website - for sale or stud - you need to select the publish buttons below.
            <br /><br />
        <% end if %>
    <br />
   </div>
</div>


 <%  Dim listalpacaName(100000)
sql2 = "select * from Animals where PeopleID = " & Session("PeopleID") & " order by trim(Fullname) ;"
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
 <div class = "row" >
   <div class="col-12 body">
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
</div>
</div>
<a name="Add"></a>
<%
JustAdded= request.querystring("JustAdded")
if JustAdded =true then %>
  <b><Font color = "brown">Animal Added! Now take a moment to review your information below, or <a href = "MembersPhotos.asp?ID=<%=ID %>" class = "body">add photos</a>. Note, that your animal will not show up until you select the publish button below.</Font></b>
<% end if %>

<br /><br />


<% if speciesid = 13 or speciesid = 14 or speciesid = 15 or speciesid = 19 then %>
 <div class = "row">
    <div class = "col-6" valign = Top >
        <iframe src="/members/MembersAnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "100%" height = "100" scrolling = "no"  align = "center" ></iframe>
    </div>
    <div class = "col-6" width = 50% >
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
    </div>
</div>
<% else %>

<div class = "row">
    <div class = "col-12">
        <center><iframe src="/members/MembersAnimalPublishFrame.asp?ID=<%=ID%>&speciesID=<%=speciesID %>" frameborder =0 width = "100%" height = "100" scrolling = "no"  align = "center" ></iframe></center>
    </div>
</div>
<% end if%>



<div class = "row">
    <div class = "col-6" align = "left">
    <h2>Photos</h2>
    To upload photos select the <a href = "MembersPhotos.asp?ID=<%=ID %>#Photos" class = "body">Photos tab</a>.
    </div>
   <div class = "col-6" align = "left">
    <h2>Delete</h2>
    To delete an animal select the <a href = "membersdeleteAnimal.asp?ID=<%=ID %>#Photos" class = "body">Delete animals tab</a>.
    </div>
</div>

<% if AutoTransfer = True then 
If Len(ID) > 0 then %>
<!--#Include virtual="/Conn.asp"-->
<%	sql2 = "select * from Photos where ID = " &  ID & ";" 

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
								


sql = "select Lastupdated from Animals where ID = " & ID
rs.Open sql, conn, 3, 3   
rowcount = 1
Lastupdated = rs("Lastupdated")
rs.close

%>

<div class = "row">
    <div class = "col-12">
        <a name='BasicFacts'></a>
        <!--#Include File="MembersJumpLinks.asp"-->
    </div>
</div>	
<div>
    <div class="col-12" >
    <% if speciesid = 5 or speciesid = 10 or speciesid = 8 then
        generalframeheight = 1150
      else
        generalframeheight = 920
      end if

      if speciesid = 22 or speciesid = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13 then 
        generalframeheight = 650
    end if  %>
        <div class="embed-responsive embed-responsive-16by9">
        <iframe class="embed-responsive-item" src="MembersGeneralStatsFrame.asp?ID=<%=ID %>" height = '<%=generalframeheight %>' allowfullscreenheight = '<%=generalframeheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = auto></iframe>
    </div>
    </div>
 </div>
    <% if trim(category) = "Unowned Animal" then 
    else%>
 <div class = "row">
   <div class = "col-12" >
        <a name='Pricing'></a>
        <!--#Include File="MembersJumpLinks.asp"-->
   </div>
</div>
<div class = "row">
   <div class = "col-12">
    <%  if speciesid = 5 or  speciesid = 8 then
        pricingframeheight = 760
        else
        pricingframeheight = 760
        end if
        if SpeciesID = 22 or SpeciesID = 19 or SpeciesID = 15 or SpeciesID = 14 or SpeciesID = 13 then 
            if numberofanimals = 1 then
                pricingframeheight = 870
            else
                pricingframeheight = 870
            end if
        end if %>

        <iframe src="MembersPricingFrame.asp?ID=<%=ID %>&Category=<%=Category %>&SpeciesID=<%=SpeciesID %>" height = '<%=pricingframeheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>

    </div>
 </div>
<% end if %>

 
<% If (category = "Inexperienced Female" Or Category = "Experienced Female") and (not SpeciesSalesType = "Fowl") Then %>
    <div class = "row">
       <div class = "col-12"  align = "center" colspan = "6" valign = "top">
            <!--#Include File="MembersJumpLinks.asp"-->
        </div>
    </div>
    <div class = "row">
        <div class = "col-12"  align = "center"  valign = "top">
            <iframe src="MembersFemaleDataFrame.asp?ID=<%=ID %>" height = '460' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
    </div>
   </div>
<% End If %>
    <div col="row">
      <div class = "col-12"  align = "center" valign = "top">
        <a name='Description'></a>
		<!--#Include File="MembersJumpLinks.asp"-->
      </div>
   </div>
   <div col="row">
     <div class = "col-12"  align = "center" valign = "top">
     <% if speciesID = 22 or speciesID= 19 or speciesID = 15 or speciesID = 14 or speciesID = 13 then 
            Descriptionframeheight = 600
        else
            Descriptionframeheight = 600
        end if

        If category = "Experienced Male" Or category = "Inexperienced Male" then %>
            <iframe src="MembersDescriptionFrame.asp?ID=<%=ID %>&category=<%=category %>&screenwidth=100%" height = '<%=Descriptionframeheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = no ></iframe>
        <% else %>
            <iframe src="MembersDescriptionFrame.asp?ID=<%=ID %>&category=<%=category %>&screenwidth=100%" height = '<%=Descriptionframeheight %>' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
        <% end if %>
    </div>
   </div>
<% if speciesID = 22 or speciesID = 19 or speciesID = 15 or speciesID = 14 or speciesID = 13 then
else %>
<div class = "row">
  <div class = "col-12"  align = "center" valign = "top">
       <a name='Awards'></a>
        <!--#Include File="MembersJumpLinks.asp"-->
  </div>
</div>
<div class = "row>
   <div class = "col-12"  align = "center" valign = "top">
    <% sql = "select Count(*) as count from awards where ID = " & ID & " and (not(len(Placing)< 1) or not(len(Class)< 1) or not(len(AwardYear)< 2)  or not(len(Awardcomments)< 1)  or not(len(Showname)< 1)  or not(len(Judge)< 1) )  "
    rs.Open sql, conn, 3, 3  
        FilledRecordcount = rs("count")
    rs.close  
 
    sql = "select Count(*) as count from awards where ID = " & ID 
    rs.Open sql, conn, 3, 3  
    Recordcount = rs("count")
    rs.close

    if cLng(Recordcount) < cLng(FilledRecordcount) + 6 then
    Query =  "INSERT INTO Awards (ID)" 
    Query =  Query & " Values ('" &  ID & "')"
    Conn.Execute(Query) 

    Query =  "INSERT INTO Awards (ID)" 
    Query =  Query & " Values ('" &  ID & "')"
    Conn.Execute(Query) 

    Query =  "INSERT INTO Awards (ID)" 
    Query =  Query & " Values ('" &  ID & "')"
    Conn.Execute(Query) 
    end if

    sql = "select Count(*) as count from Animals, awards where Animals.ID = awards.ID and animals.ID = " & ID 
    rs.Open sql, conn, 3, 3  
    recordcount =  clng(rs("count"))
    rs.close
    frameheight = 180 + (38*(recordcount +1))
    %>

    <iframe src="MembersAwardsFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
    </div>
 </div>
 <% end if %>


<% if  (speciesID = 2 and  NumberofAnimals = "1") and not(Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby" or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='Fiber'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<%
sql = "select  Count(*) as count from Animals, Fiber where (len(fiber.SampleDateDay) > 0 or len(fiber.Average) > 1 or len(fiber.StandardDev) > 1 or len(fiber.GreaterThan30) > 1) and Animals.ID = Fiber.ID and animals.ID = " & ID
rs.Open sql, conn, 3, 3   
rowcount = 1
filledRecordcount = cLng(rs("count"))
rs.close

sql = "select Count(*) as count from Animals, Fiber where Animals.ID = Fiber.ID and animals.ID = " & ID 
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = cLng(rs("count"))
if Recordcount >  filledrecordcount + 5  then
Query =  "delete from Fiber where ID=" & ID & " and (Len(fiber.SampleDateDay) < 1  and  Len(fiber.Average) < 1 and Len(fiber.StandardDev) < 1 and Len(fiber.GreaterThan30) < 1)  ; "
'response.write("Query=" & Query )
Conn.Execute(Query)
recordcount = filledRecordcount + 5
end if

if recordcount  = filledRecordcount then
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query & " Values ('" &  ID & "')"
Conn.Execute(Query) 
end if
If RecordCount  < 11 Then
NeedToAdd = 12 - RecordCount
rs.close
i = 1
While i < NeedToAdd
Query =  "INSERT INTO Fiber (ID)" 
Query =  Query + " Values ('" &  ID & "')"
Conn.Execute(Query) 
NeedToAdd = NeedToAdd - 1
wend
End If 

if rs.state = 0 then
else
rs.close
end if
frameheight = 135 + (105*recordcount)%>
<iframe src="MembersFiberFrame.asp?ID=<%=ID %>" height = '<%=frameheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">
<a name='EPD'></a>
<!--#Include File="MembersJumpLinks.asp"-->
</td></tr>
<tr><td class = "body"  align = "center" colspan = "6" valign = "top">

<% frameheight = 590%>
<iframe src="MembersAlpacaEPDFrame.asp?ID=<%=ID %>&Recordcount=<%=recordcount %>" height = '<%=frameheight %>' width = '100%' frameborder= '0' valign='abstop' seamless = Yes scrolling = AUTO></iframe>
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
<iframe src="MembersAncestryFrame.asp?ID=<%=ID %>&speciesID=<%=speciesID %>" height = '1540' width = '<%=screenwidth -42%>' frameborder= '0' valign='abstop' seamless = Yes scrolling = no></iframe>
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

<%set rs2=nothing
set conn = nothing %>