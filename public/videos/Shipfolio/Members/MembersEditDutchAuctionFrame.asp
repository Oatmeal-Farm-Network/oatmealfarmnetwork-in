<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>Livestock Of America Membersistration</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="framestyle.css" />

<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{var numberfield = objName;
	if (chkNumeric(objName,minval,maxval,comma,period,hyphen) == false)
	{
numberfield.select();
numberfield.focus();
return false;
	}
else
	{
return true;
	}
}


function chkNumeric(objName,minval,maxval,comma,period,hyphen)
{
// only allow 0-9 be entered, plus any values passed
// (can be in any order, and don't have to be comma, period, or hyphen)
// if all numbers allow commas, periods, hyphens or whatever,
// just hard code it here and take out the passed parameters
var checkOK = "0123456789." + comma ;
var checkStr = objName;
var allValid = true;
var decPoints = 0;
var allNum = "";

for (i = 0;  i < checkStr.value.length;  i++)
{
ch = checkStr.value.charAt(i);
for (j = 0;  j < checkOK.length;  j++)
if (ch == checkOK.charAt(j))
break;
if (j == checkOK.length)
{
allValid = false;
break;
}
if (ch != ",")
allNum += ch;
}
if (!allValid)
{	
alertsay = "Please enter only these values \""
alertsay = alertsay + checkOK + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}

// set the minimum and maximum
var chkVal = allNum;
var prsVal = parseInt(allNum);
if (chkVal != "" && !(prsVal >= minval && prsVal <= maxval))
{
}
}
//  End -->
</script>
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="MembersGlobalVariablesNoBackground.asp"-->
<% 
Current2="Auctions"
Current3 = "AddAuction"

AuctionDutchID = request.Form("AuctionDutchID")
if len(AuctionDutchID) < 1 then
AuctionDutchID = request.QueryString("AuctionDutchID")
end if
    
Update = Request.Querystring("Update")
AuctionName=Request.Form("AuctionName")
Price=Request.Form("Price")
Value=Request.Form("Value")
AuctionLevel=Request.Form("AuctionLevel")
AuctionDescription=Request.Form("AuctionDescription")
PercentDecrementAmount=Request.Form("PercentDecrementAmount")
DecrementType=Request.Form("DecrementType")
PercentDecreasingPercent = Request.Form("PercentDecreasingPercent")
PercentDecreasingDollars = Request.Form("PercentDecreasingDollars")
AnimalID1= Request.Form("AnimalID1")
AnimalID2= Request.Form("AnimalID2")
AnimalID3= Request.Form("AnimalID3")
AnimalID4= Request.Form("AnimalID4")
AnimalID5= Request.Form("AnimalID5")
AnimalID6= Request.Form("AnimalID6")
Animal1ceiling= Request.Form("Animal1ceiling")
Animal2ceiling= Request.Form("Animal2ceiling")
Animal3ceiling= Request.Form("Animal3ceiling")
Animal4ceiling= Request.Form("Animal4ceiling")
Animal5ceiling= Request.Form("Animal5ceiling")
Animal6ceiling= Request.Form("Animal6ceiling")
Animal1Floor= Request.Form("Animal1Floor")
Animal2Floor= Request.Form("Animal2Floor")
Animal3Floor= Request.Form("Animal3Floor")
Animal4Floor= Request.Form("Animal4Floor")
Animal5Floor= Request.Form("Animal5Floor")
Animal6Floor= Request.Form("Animal6Floor")
AuctionStartDateDay= Request.Form("AuctionStartDateDay")
AuctionStartDateMonth= Request.Form("AuctionStartDateMonth")
AuctionStartDateYear= Request.Form("AuctionStartDateYear")

if len(AnimalID1) > 0 then
else
  AnimalID1 = 0
end if
if len(AnimalID2) > 0 then
else
  AnimalID2 = 0
end if
if len(AnimalID3) > 0 then
else
  AnimalID3 = 0
end if
if len(AnimalID4) > 0 then
else
  AnimalID4 = 0
end if
if len(AnimalID5) > 0 then
else
  AnimalID5 = 0
end if
if len(AnimalID6) > 0 then
else
  AnimalID6 = 0
end if

if Update = "True" then

str1 = AuctionDescription
str2 = "'"
If InStr(str1,str2) > 0 Then
	AuctionDescription= Replace(str1,  str2, "''")
End If  

str1 = AuctionName
str2 = "'"
If InStr(str1,str2) > 0 Then
	AuctionName= Replace(str1,  str2, "''")
End If  

  Query =  " UPDATE AuctionDutch Set AuctionDutchDescription = '" & AuctionDescription & "', " 
  Query =  Query & " AuctionLevel = '" & AuctionLevel  & "', "
  if len(Animal1Ceiling) > 0 then  
  Query =  Query & " Animal1Ceiling = " & Animal1Ceiling  & ", "
  end if
    if len(Animal2Ceiling) > 0 then  
  Query =  Query & " Animal2Ceiling = " & Animal2Ceiling  & ", "
  end if
    if len(Animal3Ceiling) > 0 then  
  Query =  Query & " Animal3Ceiling = " & Animal3Ceiling  & ", "
  end if
    if len(Animal4Ceiling) > 0 then  
  Query =  Query & " Animal4Ceiling = " & Animal4Ceiling  & ", "
  end if
    if len(Animal5Ceiling) > 0 then  
  Query =  Query & " Animal5Ceiling = " & Animal5Ceiling  & ", "
  end if
  if len(Animal6ceiling) > 0 then  
  Query =  Query & " Animal6ceiling = " & Animal6ceiling  & ", "
 end if
  
    if len(Animal1Floor) > 0 then  
  Query =  Query & " Animal1Floor = " & Animal1Floor  & ", "
  end if
    if len(Animal2Floor) > 0 then  
  Query =  Query & " Animal2Floor = " & Animal2Floor  & ", "
  end if
    if len(Animal3Floor) > 0 then  
  Query =  Query & " Animal3Floor = " & Animal3Floor  & ", "
  end if
    if len(Animal4Floor) > 0 then  
  Query =  Query & " Animal4Floor = " & Animal4Floor  & ", "
  end if
    if len(Animal5Floor) > 0 then  
  Query =  Query & " Animal5Floor = " & Animal5Floor  & ", "
  end if
    if len(Animal6Floor) > 0 then  
  Query =  Query & " Animal6Floor = " & Animal6Floor  & ", "
  end if
  
  if len(AnimalID1) > 0 then 
 Query =  Query & " AnimalID1 = " & AnimalID1  & ", "  
 end if
   if len(AnimalID2) > 0 then 
 Query =  Query & " AnimalID2 = " & AnimalID2  & ", "  
 end if
    if len(AnimalID3) > 0 then 
 Query =  Query & " AnimalID3 = " & AnimalID3  & ", "  
 end if
    if len(AnimalID4) > 0 then 
 Query =  Query & " AnimalID4 = " & AnimalID4  & ", "  
 end if
    if len(AnimalID5) > 0 then 
 Query =  Query & " AnimalID5 = " & AnimalID5  & ", "  
 end if
    if len(AnimalID6) > 0 then 
 Query =  Query & " AnimalID6 = " & AnimalID6  & ", "  
 end if
 

if len(AuctionStartDateDay) > 0 then
 Query =  Query & " AuctionStartDateDay = " &  AuctionStartDateDay  & ", " 
end if
if len(AuctionStartDateDay) > 0 then
 Query =  Query & " AuctionStartDateMonth = " &  AuctionStartDateMonth  & ", " 
end if
if len(AuctionStartDateDay) > 0 then
 Query =  Query & " AuctionStartDateYear = " &  AuctionStartDateYear  & ", " 
end if
    Query =  Query & " AuctionDutchTitle = '" & AuctionName  & "' "
 Query =  Query & " where AuctionDutchID = " & AuctionDutchID & ";" 
 
Conn.Execute(Query) 
  
end if

sql = "select * from AuctionDutch where AuctionDutchID= " & AuctionDutchID & ""
Set rs = Server.CreateObject("ADODB.Recordset")
 rs.Open sql, conn, 3, 3 
if not rs.eof then 
AuctionName = rs("AuctionDutchTitle")
AuctionDescription = rs("AuctionDutchDescription")
AuctionLevel = rs("AuctionLevel")
Animal1ceiling= rs("Animal1ceiling")
Animal2ceiling= rs("Animal2ceiling")
Animal3ceiling= rs("Animal3ceiling")
Animal4ceiling= rs("Animal4ceiling")
Animal5ceiling= rs("Animal5ceiling")
Animal6ceiling= rs("Animal6ceiling")
Animal1Floor= rs("Animal1Floor")
Animal2Floor= rs("Animal2Floor")
Animal3Floor= rs("Animal3Floor")
Animal4Floor= rs("Animal4Floor")
Animal5Floor= rs("Animal5Floor")
Animal6Floor= rs("Animal6Floor")
AnimalID1 = rs("AnimalID1")
AnimalID2 = rs("AnimalID2")
 AnimalID3 = rs("AnimalID3")
 AnimalID4 = rs("AnimalID4")
AnimalID5 = rs("AnimalID5")
AnimalID6 = rs("AnimalID6")
AuctionStartDateday = rs("AuctionStartDateDay")
AuctionStartDateMonth = rs("AuctionStartDateMonth")
AuctionStartDateYear = rs("AuctionStartDateYear")
end if

if len(AnimalID1) > 0 then
else
AnimalID1 = 0
end if
if len(AnimalID2) > 0 then
else
AnimalID2 = 0
end if
if len(AnimalID3) > 0 then
else
AnimalID3 = 0
end if
if len(AnimalID4) > 0 then
else
AnimalID4 = 0
end if
if len(AnimalID5) > 0 then
else
AnimalID5 = 0
end if
if len(AnimalID6) > 0 then
else
AnimalID6 = 0
End if

if len(PercentDecrementAmount) > 0  then
else
  PercentDecrementAmount = 0
end if

if len(PercentDecreasingPercent) > 0  then
else
  PercentDecreasingPercent = 0
end if


if len(PercentDecreasingDollars) >0  then
else
  PercentDecreasingDollars = 0
end if


if not AnimalID1 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID1 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname1 = rs2("Fullname")
	animalPrice1 = rs2("Price")
	rs2.close
   end if 
end if

if AuctionLevel = "Red" or AuctionLevel = "Yellow" then 
if len(animalname1) > 0 then
  AuctionName = animalname1
end if
end if

if not AnimalID2 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID2 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname2 = rs2("Fullname")
	animalPrice2 = rs2("Price")
	rs2.close
   end if 
end if

if not AnimalID3 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID3 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname3 = rs2("Fullname")
	animalPrice3 = rs2("Price")
	rs2.close
   end if 
end if


if not AnimalID4 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID4 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname4 = rs2("Fullname")
	animalPrice4 = rs2("Price")
	rs2.close
   end if 
end if

if not AnimalID5 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID5 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname5 = rs2("Fullname")
	animalPrice5 = rs2("Price")
	rs2.close
   end if 
end if
if not AnimalID6 = 0 then
sql2 = "select FullName, Pricing.Price from Animals, Pricing where Animals.id= Pricing.id and  Animals.id = " & AnimalID6 
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	animalname6 = rs2("Fullname")
	animalPrice6 = rs2("Price")
	rs2.close
   end if 
end if


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
%>
<br />
<table border = "0"  cellpadding=0 cellspacing=0 width = "750">
<form action= 'MembersEditDutchAuctionFrame.asp?Update=True&AuctionDutchID=<%= AuctionDutchID%>' method = "post" name="DutchAuctionForm">
<input name="PeopleID" type = "hidden" value ="<%=PeopleID %>" >

<tr>
<td class = "body2" align = "left" height = "30" valign = "top" colspan = "2">
<table>
<tr>
<td width = '85'>

</td>
<td class = "body2" align = "center">
<b>Name</b>
</td>
<td class = "body2" align = "center">
<b>Ceiling Price</b>
</td>
<td class = "body2" align = "center">
<b>Floor Price</b>
</td>
</tr>
<tr><td Class = "body2" align = "right" height = "30" valign = "top" >
	<b>Animal #1:</b>
</td>
<td class = "body" valign = "top" align = "left" height = "30" valign = "top">
<select size="1" name="AnimalID1" >
<% if not AnimalID1 = 0  then%>
 <option name = "AID0" value= "<%=AnimalID1 %>" selected><%=animalname1%></option>
 <% else %>
<option name = "AID0" value= "" selected>Select</option>
<% end if %>
<% count = 1
			
Animalsfound1 = False
while count < acounter
	if not (cint(AnimalID1) = cint(IDArray(count))) and not (cint(AnimalID2) = cint(IDArray(count))) and not (cint(AnimalID3) = cint(IDArray(count))) and not (cint(AnimalID4) = cint(IDArray(count))) and not (cint(AnimalID5) = cint(IDArray(count))) and not (cint(AnimalID6) = cint(IDArray(count))) then
Animalsfound1 = True %>
<option name = "AID1" value="<%=IDArray(count)%>">
<%=alpacaName(count)%>
</option>
<% end if
					count = count + 1 
                    wend 
					 	if Animalsfound1 = False and AnimalID1 = 0 then %>
					<option value = "" >None Available.</option>
					<% end if %>
				<option value = ""  ><center> -- </center></option>			
			</select>

		</td>
		<td class = "body2" align = "right" valign = "top"> 
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Ceiling' size=10 maxlength=10 Value= "<%= Animal1Ceiling%>">
</td>
<td class = "body2" align = "right" valign = "top"> 
		$<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"  name='Animal1Floor' size=10 maxlength=10 Value= "<%= Animal1Floor%>">
</td>
</tr>




</table>
</td>
</tr>
<tr>
	<td class = "body2" align = "right" valign ="top"><b>Start Date:</b>&nbsp;</td>
	<td class = "body" align = "left" height = "30" valign ="top"><select size="1" name="AuctionStartDateMonth" >
	<% if len(AuctionStartDateMonth) > 0 then %>
		<option value="<%=AuctionStartDateMonth %>" selected><%=AuctionStartDateMonth %></option>
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
				<select size="1" name="AuctionStartDateDay" >
						<% if len(AuctionStartDateDay) > 0 then %>
		<option value="<%=AuctionStartDateDay %>" selected><%=AuctionStartDateDay %></option>
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
				</select>
		<select size="1" name="AuctionStartDateYear" >
					<% if len(AuctionStartDateYear) > 0 then %>
		<option value="<%=AuctionStartDateYear %>" selected><%=AuctionStartDateYear %></option>
	<% else %>
		<option value="" selected></option>
	<% end if  %>
			/		
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=currentyear To (year(date) + 2)  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
</tr>
<tr><td>
</td></tr>
<tr><td colspan = "2" align = "center">
<input type=hidden Name="AuctionLevel"  value = "<%= AuctionLevel %>" >
<input type=submit Name="Submit Auction"  value = "Submit Changes" class=  "regsubmit2">
</form>
<br /><br />
</td></tr></table>
</BODY>
</HTML>