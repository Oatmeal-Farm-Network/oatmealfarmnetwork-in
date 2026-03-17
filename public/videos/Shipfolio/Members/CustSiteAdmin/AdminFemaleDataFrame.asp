<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminGlobalVariables.asp"-->
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

<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if
%>
 <!--#Include virtual="/administration/adminDetailDBInclude.asp"-->
<% If Len(ID) > 0 then %>
	<!--#Include virtual="/Administration/Transfers/GatherAnimalData.asp"-->
	<!--#Include virtual="/Administration/Transfers/TransferMovedata.asp"-->
<% end if %>
</head>
<body>
<% 
DIM SSID(200) 
Dim SSName(200)
dim SSXID(200) 
dim SSXName(200)
dim rpID(200)
dim rpName(200)

if mobiledevice = False then %>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr>
    <td class = "roundedtop" align = "left">
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" >
    <% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Breeding Record Changes Have Been Made.</b></font></div>
<% end if %>


 <!--#Include virtual="/conn.asp"-->

<% Set rs = Server.CreateObject("ADODB.Recordset")		
 sql = "SELECT DISTINCT animals.Fullname, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"
rs.Open sql, conn, 3, 3

if rs.recordcount = 0 then %>
<!--#Include virtual="/Conn.asp"-->  
<% Query =  "INSERT INTO FemaleData (ID)" 
Query =  Query & " Values (" &  ID & ")"
response.write("Query =" & Query)
Conn.Execute(Query) 

rs.close
 sql = "SELECT DISTINCT animals.Fullname, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"
rs.Open sql, conn, 3, 3
end if
   
rowcount = 1

Recordcount = rs.RecordCount +1
%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "left" width = "90%">
	
<%
	conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql2 = "select Animals.ID, Animals.FullName from Animals where Category = 'Experienced Male' or Category = 'Inexperienced Male' order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn2, 3, 3 
	
	While Not rs2.eof  
		SSID(studcounter) = rs2("ID")
		SSName(studcounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		studcounter = studcounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn2 = nothing

	conn4 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn4, 3, 3 
	Xstudcounter = 1
	While Not rs4.eof  
		SSXID(xstudcounter) = rs4("ExternalStudID")
		SSXName(xstudcounter) = rs4("ExternalStudName")

		Xstudcounter = Xstudcounter +1
		rs4.movenext
	Wend		
	
	rs4.close
	set rs4=nothing
	set conn4 = nothing


	conn8 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql8 = "select distinct  ID, FullName from Animals order by Animals.FullName"

	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, conn8, 3, 3 
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

sql8 = "select distinct  * from Femaledata where ID = " & ID
rs8.Open sql8, conn8, 3, 3 
if not rs8.eof then
 Bred = rs8("Bred")
ServiceSireID = rs8("ServiceSireID")
 ExternalStudID = rs8("ExternalStudID")
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
	set conn8 = nothing
%>
<form action= 'AdmineditFemaleHandleform.asp' method = "post">
<tr >
<td  class = "body"  nowrap>
<input type = "hidden" name="ID" value= "<%=ID%>" >
<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  animalFullName%>">
<% Comingattractionspage = false
if Comingattractionspage = true then
if ShowOnCriasPage = "True" then %>
		Show on Breeding Program Page?: 
			Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" checked>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "False" >
		
		<% else %>
			Show on Coming Attractions? Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" >
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)"Value = "False" checked>
	<%end if%>
	<br>
<% if LatestCria = "True" then %>
		Show Latest Cria? 
			Yes<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "True" checked>
			No<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "False" >
		<% else %>
			Show Latest Cria? 
			Yes<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)" Value = "True" >
			No<input TYPE="RADIO" name="LatestCria(<%=rowcount%>)"Value = "False" checked>
		
	<%end if%>
<%end if%>
		<% if Bred = "True" then %>
			Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" checked>
			No<input TYPE="RADIO" name="Bred" Value = "False" >
		<% else %>
			Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" >
			No<input TYPE="RADIO" name="Bred"Value = "False" checked>
	
	<%end if%>
			&nbsp;&nbsp;&nbsp;&nbsp; Due Date (MM/YY):
		<select size="1" name="DueDateMonth">
					<option value="<%=DueDateMonth%>" selected><%=DueDateMonthName%></option>
					<option value="0">N/A</option>
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
				</select>
			
		<select size="1" name="DueDateYear">
				<option value="<%=DueDateYear%>" selected><%=DueDateYear%></option>
				<option value="0">N/A</option>
				<% currentyear = year(date) 
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	&nbsp;&nbsp;&nbsp;&nbsp; <br>	
	<b>Bred to:</b><br>	
	<img src = "images/px.gif" width = "20" height = "1" /><b>Your Studs:</b>
<% 
		
		if len(ServiceSireID) < 1 or ServiceSireID = "0" then
 
			CurrentStudID = 0
			CurrentStudName = "N/A"
			else		
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID
'response.write("sql3=" & sql3 )
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 
    if not rs3.eof then
			CurrentStudID = rs3("ID")
			CurrentStudName = rs3("FullName")
			end if
			rs3.close
			set rs3=nothing
			set conn3 = nothing
end if
%>
<select size="1" name="ServiceSireID" width = "100">
<% if len(CurrentStudName) > 1 then %>
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
<option value= "" >N/A</option>
<% else %>
<option value= "" >N/A</option>
<% end if %>
		<% count = 1
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
&nbsp;&nbsp;&nbsp;&nbsp; 
		<b>Other People's Studs:</b>
<% if len(ExternalStudID) > 1  and not ExternalStudID = "" or  ExternalStudID > 0 then
conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 

sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 
if not rs6.eof then
			CurrentXStudID = ExternalStudID
			CurrentXStudName = rs6("ExternalStudName")
end if			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="ExternalStudID" width = "100">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<option value= "" >N/A</option>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=SSXID(count)%>"><%=SSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>
To add studs from other ranches <a href = "AdminOutsideStud.asp" target="top" class = body>click here.</a>
		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
<tr>
		<td colspan = "17" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
<input type="Submit" class = "regsubmit2 body" value="Submit Breeding Record Changes"  >
			</form>
		</td>
</tr>
</table>

<% else %>
<tr>
    <td class = "roundedtop" align = "left">
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" >
<table cellpadding = "0" cellspacing = "0" border = "0" width = "90%">
<%
	
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" '& _ 
 sql = "SELECT DISTINCT animals.Fullname, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1

	conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql2 = "select Animals.ID, Animals.FullName from Animals where Category = 'Experienced Male' or Category = 'Inexperienced Male' order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn2, 3, 3 
	
	While Not rs2.eof  
		SSID(studcounter) = rs2("ID")
		SSName(studcounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		studcounter = studcounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn2 = nothing

	conn4 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn4, 3, 3 
	Xstudcounter = 1
	While Not rs4.eof  
		SSXID(xstudcounter) = rs4("ExternalStudID")
		SSXName(xstudcounter) = rs4("ExternalStudName")

		Xstudcounter = Xstudcounter +1
		rs4.movenext
	Wend		
	
	rs4.close
	set rs4=nothing
	set conn4 = nothing


	conn8 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql8 = "select distinct  ID, FullName from Animals order by Animals.FullName"

	Set rs8 = Server.CreateObject("ADODB.Recordset")
	rs8.Open sql8, conn8, 3, 3 
	rpcounter = 1
	While Not rs8.eof  
		rpID(rpcounter) = rs8("ID")
		rpName(rpcounter) = rs8("FullName")

		rpcounter = rpcounter +1
		rs8.movenext
	Wend		
	
	rs8.close
	set rs8=nothing
	set conn8 = nothing


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

	<form action= 'AdmineditFemaleHandleform.asp' method = "post">
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
						response.write(currentyear)
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	</td></tr>
	<tr><td class = "body"><b>Bred to:</b><br>	
	<b>Your Studs:</b>
<% 
		
		if len(ServiceSireID) > 0 or not ServiceSireID = "" then
			
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID

			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 
'response.write(sql3)
			CurrentStudID = rs3("ID")
			CurrentStudName = rs3("FullName")
			
			rs3.close
			set rs3=nothing
			set conn3 = nothing

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
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
	</td></tr>
	<tr><td class = "body"><b>Other People's Studs:</b>
		<% 
			if len(ExternalStudID) > 1  and not ExternalStudID = "" or  ExternalStudID > 0 then
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID
'response.write(sql6)
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = ExternalStudID
			CurrentXStudName = rs6("ExternalStudName")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="XServiceSireID" width = "100" class = "regsubmit2 body">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<% if len(CurrentXStudName) > 3 then %>
			<option value= "" >N/A</option>
			<% end if %>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=SSXID(count)%>"><%=SSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>
            To add studs from other ranches <a href = "AdminOutsideStud.asp" class = body>click here.</a>
		</td>
	</tr>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
<tr>
		<td colspan = "17" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<input type="Submit" class = "regsubmit2 body" value="Submit Breeding Record Changes"  >
			</form>
		</td>
</tr>
</table>
<% end if %>
</body>
</html>