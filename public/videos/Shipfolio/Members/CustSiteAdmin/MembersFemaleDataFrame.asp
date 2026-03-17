<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
<!--#Include virtual="/MobileWidthInclude.asp"-->
<link rel="stylesheet" type="text/css" href="/administration/style.css">
</head>
<body>
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>


<SCRIPT LANGUAGE="JavaScript">
<!-- Original:  Nannette Thacker -->
<!-- http://www.shiningstar.net -->
<!-- Begin
function checkNumeric(objName,minval, maxval,comma,period,hyphen)
{
	var numberfield = objName;
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
var checkOK = "0123456789" + comma + period + hyphen;
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
alertsay = "Please enter a value greater than or "
alertsay = alertsay + "equal to \"" + minval + "\" and less than or "
alertsay = alertsay + "equal to \"" + maxval + "\" in the \"" + checkStr.name + "\" field."
alert(alertsay);
return (false);
}
}
//  End -->
</script>
<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
AnimalID = ID

DIM SSID(200) 
Dim SSName(200)
dim SSXID(200) 
dim SSXName(200)
dim rpID(200)
dim rpName(200)

tempscreenwidth = request.querystring("screenwidth")
if len(tempscreenwidth) > 1 then
screenwidth = tempscreenwidth
end if

if screenwidth > 1000 then
screenwidth = screenwidth -230
end if


if mobiledevice = False then %>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -30 %>">
 <tr>
    <td class = "body roundedtopandbottom" align = "left">
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Breeding Changes Have Been Made.</b></font></div>
<% end if %>
 <blockquote>Select below one of the studs that you have already entered, or an un-entered stud (could be your or someone else's stud). If you enter a stud of each type, then the website will default to your stud.
</blockquote>
<%
 sql = "SELECT DISTINCT animals.Fullname, animals.speciesid, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
rowcount = 1
if not rs.eof then
FullName=rs("FullName")
SpeciesID  = rs("SpeciesID") 
Bred=rs("Bred")
BredTo=rs("BredTo") 
XServiceSireID=rs("ExternalStudID") 
ServiceSireID=rs("ServiceSireID") 
RecentProgenyID=rs("RecentProgenyID") 
DueDateMonth=rs("DueDateMonth")
DueDateYear=rs("DueDateYear")
ShowRecentCria=rs("ShowRecentCria")
ShowCurrentStud=rs("ShowCurrentStud")
ExternalStudLink=rs("ExternalStudLink")
ExternalStudColor=rs("ExternalStudColor")
ExternalStudPhoto=rs("ExternalStudPhoto")
DueDateMonth=rs("DueDateMonth") 
Externalstudname = rs("Externalstudname")
else
	Query =  "INSERT INTO FemaleData (ID)" 
		Query =  Query + " Values (" &  ID  & ")"
connLOA.Execute(Query) 

end if
%>
<a name="Femaledata"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "left" width = "100%">
	
<%
tempscreenwidth = request.querystring("screenwidth")
if len(tempscreenwidth) > 1 then
screenwidth = tempscreenwidth
end if

if screenwidth > 1000 then
screenwidth = screenwidth -399
end if


sql2 = "select Animals.ID, Animals.FullName from Animals where (Category = 'Experienced Male' or Category = 'Inexperienced Male') and animals.PeopleID=" & PeopleID & " and SpeciesID  = " & speciesid & " order by Animals.FullName"
'response.write("sql2=" & sql2)
studcounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3 
While Not rs2.eof  
SSID(studcounter) = rs2("ID")
SSName(studcounter) = rs2("FullName")
studcounter = studcounter +1
rs2.movenext
Wend		
rs2.close
set rs2=nothing
set connLOA2 = nothing

'sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

'Set rs4 = Server.CreateObject("ADODB.Recordset")
	'rs4.Open sql4, connLOA, 3, 3 
	'Xstudcounter = 1
	'While Not rs4.eof  
	'	SSXID(xstudcounter) = rs4("ExternalStudID")
	'SSXName(xstudcounter) = rs4("ExternalStudName")
    '
		Xstudcounter = Xstudcounter +1
		'rs4.movenext
	'Wend		
	
	'rs4.close
	'set rs4=nothing
	'set connLOA4 = nothing


	sql8 = "select distinct  ID, FullName from Animals where peopleId=" & PeopleId & " order by Animals.FullName"
   
	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, connLOA, 3, 3 
	rpcounter = 1
	While Not rs8.eof  
		rpID(rpcounter) = rs8("ID")
		rpName(rpcounter) = rs8("FullName")

		rpcounter = rpcounter +1
		rs8.movenext
	Wend		
	
	rs8.close
 While  Not rs.eof 
	 ID =   rs("ID")
	 animalFullName =   rs("FullName")
	 Bred =   rs("Bred")
	 ExternalStudID =   rs("ExternalStudID")
	 ServiceSireID =   rs("ServiceSireID")
	 DueDateMonth =   rs("DueDateMonth")
	 DueDateYear =   rs("DueDateYear")
     LatestCria =   rs("LatestCria")
     If DueDateYear  = "0" Then
	DueDateYear  = ""
End If

ShowOnCriasPage =   rs("ShowOnCriasPage")
str1 = ServiceSireID
If  str1= "0"  Then
ServiceSireID = ""
End If

str2 = RecentProgenyID 
If  str2= "0"  Then
RecentProgenyID = ""
End If

If DueDateMonth  = "0" Then
	DueDateMonth  = ""
End If 

sql8 = "select distinct  * from Femaledata where ID = " & AnimalID
rs8.Open sql8, connLOA, 3, 3 
if not rs8.eof then
 Bred = rs8("Bred")

ServiceSireID = rs8("ServiceSireID")
 ExternalStudID = rs8("ExternalStudID")
 Externalstudname= rs8("Externalstudname")

 ExternalStudLink= rs8("ExternalStudLink")
 ExternalStudColor= rs8("ExternalStudColor")
 ExternalStudPhoto= rs8("ExternalStudPhoto")
DueDateMonth = rs8("DueDateMonth") 
if DueDateMonth  = 1 then DueDateMonthName = "Jan" end if
	if DueDateMonth  = 2 then DueDateMonthName = "Feb" end if
	if DueDateMonth  = 3 then DueDateMonthName = "Mar" end if
	if DueDateMonth  = 4 then DueDateMonthName = "Apr" end if
	if DueDateMonth  = 5 then DueDateMonthName = "May" end if
	if DueDateMonth  = 6 then DueDateMonthName = "Jun" end if
	if DueDateMonth  = 7 then DueDateMonthName = "Jul" end if
	if DueDateMonth  = 8 then DueDateMonthName = "Aug" end if
	if DueDateMonth  = 9 then DueDateMonthName = "Sep" end if
	if DueDateMonth  = 10 then DueDateMonthName = "Oct" end if
	if DueDateMonth  = 11 then DueDateMonthName = "Nov" end if
	if DueDateMonth  = 12 then DueDateMonthName = "Dec" end if

 DueDateYear =rs8("DueDateYear")
end if
	set rs8=nothing
%>
<form action= 'MemberseditFemaleHandleform.asp' method = "post">
<tr >
<td  class = "body"  nowrap>
<input type = "hidden" name="ID" value= "<%=AnimalID%>" >
<input type = "hidden" name="ExternalStudPhoto" value= "<%=ExternalStudPhoto%>" >
 
<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  animalFullName%>">
<% if Bred = 1 then %>
Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" checked class = "formbox">
No<input TYPE="RADIO" name="Bred" Value = "False" class = "formbox">
<% else %>
Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" class = "formbox">
No<input TYPE="RADIO" name="Bred"Value = "False" checked class = "formbox">
<%end if%>
&nbsp;&nbsp;&nbsp;&nbsp; Due Date:
<select size="1" name="DueDateMonth" class = "formbox">
<option value="<%=DueDateMonth%>" selected><%=DueDateMonthName%></option>
<option value="0">N/A</option>
<option value="1">Jan (1)</option>
<option  value="2">Feb (2)</option>
<option  value="3">Mar (3)</option>
<option  value="4">Apr (4)</option>
<option  value="5">May (5)</option>
<option  value="6">Jun (6)</option>
<option  value="7">Jul (7)</option>
<option  value="8">Aug (8)</option>
<option  value="9">Sep (9)</option>
<option  value="10">Oct (10)</option>
<option  value="11">Nov (11)</option>
<option  value="12">Dec (12)</option>
</select>
			
<select size="1" name="DueDateYear" class = "formbox">
<option value="<%=DueDateYear%>" selected><%=DueDateYear%></option>
<option value="0">N/A</option>
<% currentyear = year(date) 
For yearv=currentyear To currentyear + 2 %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
&nbsp;&nbsp;&nbsp;&nbsp; <br>	
<b>Bred to:</b><br>	
<img src = "images/px.gif" width = "20" height = "1" /><b>One of the studs you have already entered:</b>
<% 
if len(ServiceSireID) > 0 then
else
ServiceSireID = 0
end if

if len(ServiceSireID) < 1 or ServiceSireID = 0 then
CurrentStudID = 0
CurrentStudName = "N/A"
else		
sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID
Set rs3 = Server.CreateObject("ADODB.Recordset")
rs3.Open sql3, connLOA, 3, 3 
if not rs3.eof then
CurrentStudID = rs3("ID")
CurrentStudName = rs3("FullName")
end if
rs3.close
set rs3=nothing
set connLOA3 = nothing
end if
%>
<select size="1" name="ServiceSireID" width = "100" class = "formbox">
<% if len(CurrentStudName) > 1 then %>
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
<option value= "" >N/A</option>
<% else %>
<option value= "" >N/A</option>
<% end if %>
		<% count = 1
			while count < studcounter%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
&nbsp;&nbsp;&nbsp;&nbsp; 
	

		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing

str1 = Externalstudname 
str2 = """"
If InStr(str1,str2) > 0 Then
Externalstudname = Replace(str1, """", "'" )
End If
%>
<tr><td class = "body">	<img src = "images/px.gif" width = "20" height = "1" /><b>Or an Un-entered Stud:</b></td></tr>
<tr><td class = "body">
<img src = "images/px.gif" width = "20" height = "1" />
Stud's Name:<Input type = "Text" name='Externalstudname' value = "<%=Externalstudname%>" class = "formbox">
Color: <Input type = "Text" name='ExternalStudColor' value = '<%=ExternalStudColor%>'  class = "formbox">
Link: http://<Input type = "Text" name='ExternalStudLink' value ='<%=ExternalStudLink%>' class = "formbox">

</td>
</tr>
<tr>
<td colspan = "17" align = "center" valign = "middle"><br>
<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
<input type="submit" class = "regsubmit2 body" value="SUBMIT BREEDING CHANGES">
<br>
</form>
</td>
</tr>
<% if len(Externalstudname) > 0 or len(ExternalStudColor) > 0 or len(ExternalStudLink) > 0 then %>
<tr><td class = "body"><br /><br />
<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersExternalstudUpload.asp?ID=<%=ID %>" >
<% if len(ExternalStudPhoto) > 1 then %>
<img src = "<%=ExternalStudPhoto %>" width = "80" />
<% end if %>
Upload Stud Photo: <input name="attach1" type="file" class="formbox" size=45 >
<input  type=submit value="UPLOAD" class="regsubmit2" >
</form>
</td></tr>
<% end if %>
</table>

<% else %>
<tr>
    <td class = "roundedtop" align = "left">
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" >
<table cellpadding = "0" cellspacing = "0" border = "0" width = "<%=screenwidth - 22 %>">
<%

 sql = "SELECT DISTINCT animals.Fullname, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, connLOA, 3, 3   
rowcount = 1

Recordcount = 1

	sql2 = "select Animals.ID, Animals.FullName from Animals where Category = 'Experienced Male' or Category = 'Inexperienced Male' order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connLOA2, 3, 3 
	
	While Not rs2.eof  
		SSID(studcounter) = rs2("ID")
		SSName(studcounter) = rs2("FullName")
		studcounter = studcounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set connLOA2 = nothing

	sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql, connLOA4, 3, 3 
	Xstudcounter = 1
	While Not rs4.eof  
		SSXID(xstudcounter) = rs4("ExternalStudID")
		SSXName(xstudcounter) = rs4("ExternalStudName")

		Xstudcounter = Xstudcounter +1
		rs4.movenext
	Wend		
	
	rs4.close
	set rs4=nothing
	set connLOA4 = nothing


	sql8 = "select distinct  ID, FullName from Animals order by Animals.FullName"

	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, connLOA, 3, 3 
	rpcounter = 1
	While Not rs8.eof  
		rpID(rpcounter) = rs8("ID")
		rpName(rpcounter) = rs8("FullName")

		rpcounter = rpcounter +1
		rs8.movenext
	Wend		
	
	rs8.close
	set rs8=nothing
	set connLOA8 = nothing


 While  Not rs.eof 
	 ID =   rs("ID")
	 animalFullName =   rs("FullName")
	 Bred =   rs("Bred")
	 ExternalStudID =   rs("ExternalStudID")
	 ServiceSireID =   rs("ServiceSireID")
	 DueDateMonth =   rs("DueDateMonth")
	 DueDateYear =   rs("DueDateYear")
     LatestCria =   rs("LatestCria")
     
     	if DueDateMonth  = 1 then DueDateMonthName = "Jan" end if
	if DueDateMonth  = 2 then DueDateMonthName = "Feb" end if
	if DueDateMonth  = 3 then DueDateMonthName = "Mar" end if
	if DueDateMonth  = 4 then DueDateMonthName = "Apr" end if
	if DueDateMonth  = 5 then DueDateMonthName = "May" end if
	if DueDateMonth  = 6 then DueDateMonthName = "Jun" end if
	if DueDateMonth  = 7 then DueDateMonthName = "Jul" end if
	if DueDateMonth  = 8 then DueDateMonthName = "Aug" end if
	if DueDateMonth  = 9 then DueDateMonthName = "Sep" end if
	if DueDateMonth  = 10 then DueDateMonthName = "Oct" end if
	if DueDateMonth  = 11 then DueDateMonthName = "Nov" end if
	if DueDateMonth  = 12 then DueDateMonthName = "Dec" end if
     
If DueDateYear  = "0" Then
	DueDateYear  = ""
End If
	ShowOnCriasPage =   rs("ShowOnCriasPage")

	str1 = ServiceSireID
	If  str1= "0"  Then
		ServiceSireID = ""
	End If

	str2 = RecentProgenyID 
	If  str2= "0"  Then
		RecentProgenyID = ""
	End If

If DueDateMonth  = "0" Then
	DueDateMonth  = ""
End If 


%>

	<form action= 'MemberseditFemaleHandleform.asp' method = "post">
	<tr >
		<td  class = "body" valign = "top" nowrap>
			<input type = "hidden" name="ID" value= "<%=ID%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  animalFullName%>">

	<% 
	Comingattractionspage = false
	if Comingattractionspage = true then

	if ShowOnCriasPage = "True" then %>
		Show on Breeding Program Page?: 
			Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" checked id="radio-10-1" class="regular-radio big-radio"><label for="radio-10-1"></label>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "False" id="radio-10-2" class="regular-radio big-radio"><label for="radio-10-2"></label>
		
		<% else %>
			Show on Coming Attractions? Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" id="radio-11-1" class="regular-radio big-radio"><label for="radio-11-1"></label>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)"Value = "False" checked id="radio-11-2" class="regular-radio big-radio"><label for="radio-11-2"></label>
	<%end if%>
	</td></tr>
	<tr><td class = "body">
<% if LatestCria = "True" then %>
		Show Latest Cria? 
			Yes<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "True" checked id="radio-12-1" class="regular-radio big-radio"><label for="radio-12-1"></label>
			No<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "False" id="radio-11-2" class="regular-radio big-radio"><label for="radio-11-2"></label>
		<% else %>
			Show Latest Cria? 
			Yes<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "True" id="radio-12-1" class="regular-radio big-radio"><label for="radio-12-1"></label>
			No<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)"Value = "False" checked id="radio-13-1" class="regular-radio big-radio"><label for="radio-13-1"></label>
		
	<%end if%>
<%end if%>
	</td></tr>
	<tr><td class = "body">
		<% if Bred = "True" then %>
			<b>Bred?</b> Yes<input TYPE="RADIO" name="Bred" Value = "True" checked id="radio-14-1" class="regular-radio big-radio"><label for="radio-14-1"></label>
			No<input TYPE="RADIO" name="Bred" Value = "False"  id="radio-14-2" class="regular-radio big-radio"><label for="radio-14-2"></label>
		<% else %>
			<b>Bred?</b> Yes<input TYPE="RADIO" name="Bred" Value = "True"  id="radio-15-1" class="regular-radio big-radio"><label for="radio-15-1"></label>
			No<input TYPE="RADIO" name="Bred"Value = "False" checked  id="radio-15-2" class="regular-radio big-radio"><label for="radio-15-2"></label>
	
	<%end if%>
	</td></tr>
	<tr><td class = "body"><b>Due Date:</b>
		<select size="1" name="DueDateMonth" class = "regsubmit2 body">
					<option value="<%=DueDateMonth%>" selected><%=DueDateMonthName%></option>
					<option value="0">N/A</option>
					<option value="1">Jan</option>
					<option  value="2">Feb</option>
					<option  value="3">Mar</option>
					<option  value="4">Apr</option>
					<option  value="5">May</option>
					<option  value="6">Jun</option>
					<option  value="7">Jul</option>
					<option  value="8">Aug</option>
					<option  value="9">Sep</option>
					<option  value="10">Oct</option>
					<option  value="11">Nov</option>
					<option  value="12">Dec</option>
				</select>
			
		<select size="1" name="DueDateYear" class = "regsubmit2 body">
				<option value="<%=DueDateYear%>" selected><%=DueDateYear%></option>
				<option value="0">N/A</option>
				<% currentyear = year(date) 
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	</td></tr>
	<tr><td class = "body"><b>Bred to:</b><br>	
	<b>One of Your Studs:</b>
<% 
		
		if len(ServiceSireID) > 0 or not ServiceSireID = "" then
		sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID

			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, connLOA, 3, 3 
			CurrentStudID = rs3("ID")
			CurrentStudName = rs3("FullName")
			
			rs3.close
			set rs3=nothing
			set connLOA3 = nothing

		else 
			CurrentStudID = 0
			CurrentStudName = "N/A"
		end if
		%>
	

		<select size="1" name="ServiceSireID" width = "100" class = "regsubmit2 body">
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
			<% if len(CurrentStudName) > 3 then %>
			<option value= "" >N/A</option><% end if %>
		<% count = 1
			while count < studcounter %>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
</td></tr>

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set connLOA = nothing
%>
<tr><td class = "body"><b>Someone Else's Stud:</b></td></tr>
<tr><td class = "body">
  Stud's name:<Input type = "Text" name='TotalCount' value = <%=TotalCount%> >
</td></tr>


<tr><td colspan = "17" align = "center" valign = "middle"><br />
<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
<input type="Submit Breeding Changes" class = "regsubmit2 body" value="Submit"  >
<br />
</form>
</td></tr></table>
<% end if %>
</td></tr></table>
<%connLOA.close
set connLOA = nothing %>
</body></html>