<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
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

 %>	


<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Breedings" %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersJumpLinks.asp"-->


<div class ="container roundedtopandbottom" >
 <div class ="row">
    <div class = "col" >
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
			<% changesmade = request.querystring("changesmade")
			if changesmade = "True" then %>
			<div align = "left"><font class="blink_text"><b>Your Breeding Changes Have Been Made.</b></font></div>
			<% end if %>
			 <blockquote>Select below one of the studs that you have already entered, or an un-entered stud (could be your or someone else's stud). If you enter a stud of each type, then the website will default to your stud.
			</blockquote>
			<%
			 sql = "SELECT DISTINCT animals.Fullname, animals.speciesid, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and animals.id= " & ID & " ORDER BY animals.FullName;"
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3   
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
			Conn.Execute(Query) 

			end if
			%>
			<a name="Femaledata"></a>
		</div>
	 </div>
   <div class ="row">
     <div class = "col" >
	
		<%
		if len(speciesid) > 0 and len(peopleID)> 0 then

		sql2 = "select Animals.ID, Animals.FullName from Animals where (Category = 'Experienced Male' or Category = 'Inexperienced Male') and animals.PeopleID=" & PeopleID & " and SpeciesID  = " & speciesid & " order by Animals.FullName"
		'response.write("sql2=" & sql2)
		studcounter = 1
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		rs2.Open sql2, conn, 3, 3 

		While Not rs2.eof  
		SSID(studcounter) = rs2("ID")
		SSName(studcounter) = rs2("FullName")
		studcounter = studcounter +1
		rs2.movenext
		Wend		
		rs2.close
		set rs2=nothing
		set conn2 = nothing

		'sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

		'Set rs4 = Server.CreateObject("ADODB.Recordset")
			'rs4.Open sql4, conn, 3, 3 
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
			'set conn4 = nothing


			sql8 = "select distinct  ID, FullName from Animals where peopleId=" & PeopleId & " order by Animals.FullName"
   
			Set rs8 = Server.CreateObject("ADODB.Recordset")
			rs8.Open sql8, conn, 3, 3 
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
		rs8.Open sql8, conn, 3, 3 
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

			<input type = "hidden" name="ID" value= "<%=AnimalID%>" >
			<input type = "hidden" name="ExternalStudPhoto" value= "<%=ExternalStudPhoto%>" >
 
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  animalFullName%>">
			<% if Bred = 1 then %>
			Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" checked >
			No<input TYPE="RADIO" name="Bred" Value = "False" >
			<% else %>
			Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" >
			No<input TYPE="RADIO" name="Bred"Value = "False" checked >
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
			&nbsp;&nbsp;&nbsp;&nbsp; <br><br />
			Bred to:<br>	
			<img src = "images/px.gif" width = "20" height = "1" />One of the studs you have already entered:
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
			rs3.Open sql3, conn, 3, 3 
			if not rs3.eof then
			CurrentStudID = rs3("ID")
			CurrentStudName = rs3("FullName")
			end if
			rs3.close
			set rs3=nothing
			set conn3 = nothing
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
	

		</div>
	</div>
	

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
	<div>
		<div class = "body">	<img src = "images/px.gif" width = "20" height = "1" />Or an Un-entered Stud:<br /><br />
		</div>
	</div>
	<div>
		<div>
			<img src = "images/px.gif" width = "25" height = "1" />Stud's Name <Input type = "Text" name='Externalstudname' value = "<%=Externalstudname%>" class = "formbox"><br /><br />
			<img src = "images/px.gif" width = "75" height = "1" />Color <Input type = "Text" name='ExternalStudColor' value = '<%=ExternalStudColor%>'  class = "formbox"><br /><br />
			<img src = "images/px.gif" width = "85" height = "1" />Link <Input type = "Text" name='ExternalStudLink' value ='<%=ExternalStudLink%>' class = "formbox"><br /><br />
		</div>
	</div>
	<div>
		<div align = "center" valign = "middle" style="max-width:300px">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type="submit" class = "submitbutton" value="Submit">
			<br><br>
			</form>
		</div>
	</div>
	<% if len(Externalstudname) > 0 or len(ExternalStudColor) > 0 or len(ExternalStudLink) > 0 then %>
	<% if len(ExternalStudPhoto) > 1 then %>
		<div>
		  <div class = "col">
			<img src = "<%=ExternalStudPhoto %>" width = "80" />
		</div>
	</div>
	<% end if %>
	
	
	<div>
		<div class = "col-6">
			<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersExternalstudUpload.asp?ID=<%=ID %>" >

				
				Upload Stud Photo <input name="attach1" type="file" class="formbox" size=45 style="min-height: 43px">
				<input  type=submit value="Upload" class="submitbutton" >
				</form>
		</div>
		<div class = "col-6">
				<% if len(ExternalStudPhoto) > 1 then %>
				<form action= 'membersExternalstudImageRemove.asp' method = "post">
				<input type = "hidden" name="ID" value= "<%= AnimalID %>" >
				<center><input type=submit value="Remove" class="submitbutton"></center>
				</form>
				<% End If %>

			<br /><br /><br /><br />
		</div>
	</div>
	<% end if %>
</div>


<%
	end if
conn.close
set Conn = nothing %>

<!--#Include file="MembersFooter.asp"-->
</body></html>