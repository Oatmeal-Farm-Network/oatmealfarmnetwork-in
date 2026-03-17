<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title><%=Sitenamelong %> Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="never"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<!--#Include file="MembersGlobalVariables.asp"-->
    <% 
   Current2="Auctions"
   Current3="AuctionsHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% 
Current2="Auctions"
Current3 = "AddAuction"
Dim AnimalID1Array(1000)
Dim Animal1ceilingArray(1000)
Dim Animal1FloorArray(1000)
Dim AuctionStartDateDayArray(1000)
Dim AuctionStartDateMonthArray(1000)
Dim AuctionStartDateYearArray(1000)
dim AuctionDutchIDArray(1000)
Update = Request.querystring("Update")
if Update = "True" then
TotalCount = Request.form("TotalCount")
count = 0
while cint(count) < cint(TotalCount)
count = count + 1
AuctionDutchID = request.Form("AuctionDutchID")
if len(AuctionDutchID) < 1 then
AuctionDutchID = request.form("AuctionDutchID")
end if

AuctionDutchIDcount = "AuctionDutchID(" & count & ")"
AuctionDutchIDArray(count)=Request.Form(AuctionDutchIDcount) 

AnimalID1count = "AnimalID1(" & count & ")"
AnimalID1Array(count)=Request.Form(AnimalID1count) 

Animal1ceilingcount = "Animal1ceiling(" & count & ")"
Animal1ceilingArray(count)=Request.Form(Animal1ceilingcount) 

Animal1Floorcount = "Animal1Floor(" & count & ")"
Animal1FloorArray(count)=Request.Form(Animal1Floorcount) 

AuctionStartDateDaycount = "AuctionStartDateDay(" & count & ")"
AuctionStartDateDayArray(count)=Request.Form(AuctionStartDateDaycount) 

AuctionStartDateMonthcount = "AuctionStartDateMonth(" & count & ")"
AuctionStartDateMonthArray(count)=Request.Form(AuctionStartDateMonthcount) 

AuctionStartDateYearcount = "AuctionStartDateYear(" & count & ")"
AuctionStartDateYearArray(count)=Request.Form(AuctionStartDateYearcount) 

if len(AnimalID1Array(count)) > 0 then
else
AnimalID1Array(count) = 0
AuctionStartDateDayArray(count) =0
AuctionStartDateMonthArray(count) = 0
AuctionStartDateYearArray(count) = 0
Animal1CeilingArray(count) = 0
Animal1FloorArray(count) = 0
end if

if len(AuctionDutchIDArray(count)) > 0 then
  Query =  " UPDATE AuctionDutch Set "
  if len(Animal1ceilingArray(count)) > 0 then  
  Query =  Query & " Animal1Ceiling = " & Animal1ceilingArray(count)  & ", "
  end if
    
    if len(Animal1FloorArray(count)) > 0 then  
  Query =  Query & " Animal1Floor = " & Animal1FloorArray(count)  & ", "
  end if
    
  if len(AnimalID1Array(count)) > 0 then 
 Query =  Query & " AnimalID1 = " & AnimalID1Array(count)  & ", "  
 end if
 
 if len(trim(AuctionStartDateDayArray(count))) > 0 then
Query =  Query & " AuctionStartDateDay = " &  AuctionStartDateDayArray(count)  & ", " 
end if
if len(trim(AuctionStartDateMonthArray(count))) > 0 then
Query =  Query & " AuctionStartDateMonth = " &  AuctionStartDateMonthArray(count)  & ", " 
end if
if len(trim(AuctionStartDateYearArray(count))) > 0 then
Query =  Query & " AuctionStartDateYear = " &  AuctionStartDateYearArray(count)  & ", " 
end if
Query =  Query & " AuctionDutchTitle = '' "
Query =  Query & " where AuctionDutchID = " & AuctionDutchIDArray(count) & ";" 
Conn.Execute(Query) 
'response.write("Quer=" & Query )
  end if
 wend 
end if 
If not rs.State = adStateClosed Then
rs.close
End If   

if Session("PeopleID")  = "1016" then
sql2 = "select ID, FullName  from Animals where PeopleID = 1802  order by Fullname ;"
	
else
sql2 = "select ID, FullName  from Animals where PeopleID = " & Session("PeopleID") & " order by Fullname ;"
end if
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
While Not rs2.eof  
IDArray(acounter) = rs2("ID")
alpacaName(acounter) = rs2("FullName")
acounter = acounter +1
rs2.movenext
Wend		
rs2.close

' sql2 = "select * from AuctionDutch, animals where  AuctionDutch.AnimalID1 = animals.ID and AuctionDutch.PeopleId= '" & PeopleID & "' order by Fullname, AuctionDutchID"

  sql2 = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionDutchID"
'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if rs2.eof then 
numauctions = 0 
else
numauctions = rs2.recordcount
end if

if (SubscriptionLevel = 2 or SubscriptionLevel = 3 or SubscriptionLevel = 4) and numauctions = 0  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if (SubscriptionLevel = 3 or SubscriptionLevel = 4) and numauctions = 1  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if (SubscriptionLevel = 3 or SubscriptionLevel = 4) and numauctions = 2  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

if (SubscriptionLevel = 3 or SubscriptionLevel = 4) and numauctions = 3  then
Query =  "INSERT INTO AuctionDutch (PeopleID)" 
Query =  Query & " Values ('" &  Session("PeopleID") &  "')"
Conn.Execute(Query) 
numauctions = numauctions +1
end if

Set rs2 = Server.CreateObject("ADODB.Recordset")	
%><!--#Include file="MembersAuctionsTabsInclude.asp"--><table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Auctions</div></H1>
 </td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top">
<form action= 'AuctionsHome.asp?Update=True&AuctionDutchID=<%= AuctionDutchID%>' method = "post" name="DutchAuctionForm" >
<table border = "0" width = "<%=screenwidth %>"  bgcolor = "white" cellpadding=0 cellspacing=0  align = "center" >
<tr><td valign = "top" class = "body">
<br />
<%   sql = "select * from AuctionDutch where PeopleId= '" & PeopleID & "' order by AuctionLevel"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
if rs.eof then %>
Currently you do not have any auctions listed. To sign up for auctions please select <a href = "MembersAdvertisingAdd.asp" class = "body"><b>Additional Services</b></a>
<% else     
rowcount = 1
dim AuctionDutchID(40000) 
dim AuctionLevel(40000)
dim AnimalID1(40000)
dim Animal1Ceiling(40000)
dim Animal1Floor(40000)
dim AuctionStartDateMonth(40000)
dim AuctionStartDateday(40000)
dim AuctionStartDateYear(40000)
%>
<table  border = "0" width = "<%=screenwidth %>" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr><td>
<table   border = "0" width = "<%=screenwidth %>" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr  bgcolor = "antiquewhite">
<td class = "body" align = "center" ><b>Animal</b></td>
<td class = "body2" align = "center" ><b>Start Date</b></td>
<td class = "body2" align = "center" ><b>Ceiling Price</b></td>
<td class = "body2" align = "center" ><b>Floor Price</b></td>
</tr>
<%
row = "odd"
While  Not rs.eof  
If row = "even" Then
row = "odd"
Else
row = "even"
End if
AuctionDutchID(rowcount) =   rs("AuctionDutchID")
AnimalID1(rowcount) =   rs("AnimalID1")
Animal1Ceiling(rowcount) =   rs("Animal1Ceiling")
Animal1Floor(rowcount) =   rs("Animal1Floor")
AuctionStartDateMonth(rowcount) =   rs("AuctionStartDateMonth")
AuctionStartDateday(rowcount) =   rs("AuctionStartDateday")
AuctionStartDateYear(rowcount) =   rs("AuctionStartDateYear")

if Animal1Ceiling(rowcount) =   0 then
Animal1Ceiling(rowcount) = ""
end if
if Animal1Floor(rowcount) =   0 then
Animal1Floor(rowcount) = ""
end if

if AuctionStartDateDay(rowcount) =  0 then
AuctionStartDateDay(rowcount) = ""
end if

if AuctionStartDateMonth(rowcount) = 0 then
AuctionStartDateMonth(rowcount) = ""
end if
if AuctionStartDateYear(rowcount) = 0 then
AuctionStartDateYear(rowcount) = ""
end if

if len(AnimalID1(rowcount)) > 0 then
sql2 = "select * from animals where Id= " & AnimalID1(rowcount) 
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
FullName = rs2("FullName")
else
FullName = ""
end if
rs2.close
end if

showstats = True
 If row = "even" Then %>
<tr>
<% Else %>
<tr bgcolor = "antiquewhite" >
<%	End If %>
<td class = "body" align = "center">
<% if len(FullName) > 0 then%>
<select size="1" name="AnimalID1(<%=rowcount%>)" >
<% if len(FullName) > 0   then%>
 <option name = "AID0" value= "<%=AnimalID1(rowcount) %>" selected><%=FullName%></option>
 <% else %>
<option name = "AID0" value= "" selected>Select</option>
<% end if %>
<% count = 1
Animalsfound1 = False
while count < acounter
if not (cint(AnimalID1(rowcount)) = cint(IDArray(count))) and not (cint(AnimalID2) = cint(IDArray(count))) and not (cint(AnimalID3) = cint(IDArray(count))) and not (cint(AnimalID4) = cint(IDArray(count))) and not (cint(AnimalID5) = cint(IDArray(count))) and not (cint(AnimalID6) = cint(IDArray(count))) then
Animalsfound1 = True %>
<option name = "AID1" value="<%=IDArray(count)%>">
<%=alpacaName(count)%>
</option>
<% end if
count = count + 1 
 wend 
if Animalsfound1 = False and AnimalID1(rowcount) = 0 then %>
<option value = "" >None Available.</option>
<% end if %>
<option value = ""  ><center> -- </center></option>			
</select>
<% else %>
<select size="1" name="AnimalID1(<%=rowcount%>)" >
<option name = "AID0" value= "" selected>Select</option>
<% count = 1
Animalsfound1 = False
while count < acounter
%>
<option name = "AID1" value="<%=IDArray(count)%>">
<%=IDArray(count)%>-<%=alpacaName(count)%>
</option>
<%
count = count + 1 
 wend 
if Animalsfound1 = False  then %>
<option value = "" >None Available.</option>
<% end if %>
<option value = ""  ><center> -- </center></option>			
</select>




 <% end if %>
</td>
<td class = "body" align = "center">
<select size="1" name="AuctionStartDateMonth(<%=rowcount%>)" >
	<% if len(AuctionStartDateMonth(rowcount) ) > 0 then %>
		<option value="<%=AuctionStartDateMonth(rowcount)  %>" selected><%=AuctionStartDateMonth(rowcount) %></option>
	<% else %>
		<option value="" selected></option>
	<% end if  %>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
</select>/ 

<select size="1" name="AuctionStartDateDay(<%=rowcount%>)" >
<% if len(AuctionStartDateDay(rowcount)) > 0 then %>
<option value="<%=AuctionStartDateDay(rowcount) %>" selected><%=AuctionStartDateDay(rowcount) %></option>
<% else %>
<option value="" selected></option>
<% end if  %>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select> / 

 	<select size="1" name="AuctionStartDateYear(<%=rowcount%>)" >
<% if len(AuctionStartDateYear(rowcount)) > 0 then %>
		<option value="<%=AuctionStartDateYear(rowcount) %>" selected><%=AuctionStartDateYear(rowcount) %></option>
	<% else %>
		<option value="" selected></option>
	<% end if  %>
			/		
<% currentyear = year(date) 
For yearv=currentyear To (year(date) + 2)  %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td>
<td class = "body2" align = "center">
<% if len(Animal1Ceiling(rowcount)) > 0 then%>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Ceiling(<%=rowcount%>)' size=10 maxlength=10 Value= "<%= Animal1Ceiling(rowcount)%>">
<% else %>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Ceiling(<%=rowcount%>)' size=10 maxlength=10 Value= "">
<% end if %>
</td>
<td class = "body2" align = "center">
<% if len(Animal1Floor(rowcount)) > 0 then%>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Floor(<%=rowcount%>)' size=10 maxlength=10 Value= "<%=Animal1floor(rowcount)%>">
<% else %>
$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Floor(<%=rowcount%>)' size=10 maxlength=10 Value= "">
<% end if %>
<input type="hidden" Name="AuctionDutchID(<%=rowcount%>)"  value = "<%=AuctionDutchID(rowcount)%>" >

</td>
</tr>
<% rowcount = rowcount + 1
 rs.movenext
Wend
TotalCount=rowcount 
rs.close
set rs=nothing
set conn = nothing
 %>
</table>
<br>
</td></tr></table>
<% end if %>
</td></tr>
<tr><td colspan = "2" align = "center">
<input type="hidden" Name="TotalCount"  value = "<%= TotalCount %>" >
<input type=submit Name="Submit Auction"  value = "Submit" class=  "regsubmit2">
</form>
</td>
</tr>
</table>
<br>
 <!--#Include virtual="/Footer.asp"--> 
 </BODY>
</HTML>