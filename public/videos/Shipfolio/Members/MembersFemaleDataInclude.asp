<%  
showx=True
end if
if showx = True then
DIM SSID(200) 
Dim SSName(200)
dim SSXID(200) 
dim SSXName(200)
dim rpID(200)
dim rpName(200)

if mobiledevice = False then %>	
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
 <tr>
    <td class = "roundedtop" align = "left">
		 <a name="BreedingRecord"></a><H2><div align = "left">Breeding Record</div></H2>
 Select below one of your studs that your female is bred to, or to someone else's stud. If you enter a stud of each type, then the website will default to your stud.
    </td>
 </tr>
 <tr>
    <td class = "roundedBottom" >
<%
 sql = "SELECT DISTINCT animals.Fullname, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') and animals.id= " & ID & " ORDER BY animals.FullName;"
 'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1

Recordcount = rs.RecordCount +1
if Recordcount = 1 then
	Query =  "INSERT INTO FemaleData (ID)" 
		Query =  Query + " Values (" &  ID  & ")"
Conn.Execute(Query) 

end if
%>
<a name="Femaledata"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "left" width = "100%">
	
<%
sql2 = "select Animals.ID, Animals.FullName from Animals where (Category = 'Experienced Male' or Category = 'Inexperienced Male') and animals.PeopleID=" & PeopleID & " order by Animals.FullName"

	studcounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

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

sql8 = "select distinct  * from Femaledata where ID = " & ID
 
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
<tr >
<td  class = "body"  nowrap>
<input type = "hidden" name="ID" value= "<%=ID%>" >
<input type = "hidden" name="ExternalStudPhoto" value= "<%=ExternalStudPhoto%>" >
 
<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  animalFullName%>">
<% if Bred = "True" then %>
Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" checked>
No<input TYPE="RADIO" name="Bred" Value = "False" >
<% else %>
Bred? Yes<input TYPE="RADIO" name="Bred" Value = "True" >
No<input TYPE="RADIO" name="Bred"Value = "False" checked>
<%end if%>
&nbsp;&nbsp;&nbsp;&nbsp; Due Date:
<select size="1" name="DueDateMonth">
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
			
		<select size="1" name="DueDateYear">
				<option value="<%=DueDateYear%>" selected><%=DueDateYear%></option>
				<option value="0">N/A</option>
				<% currentyear = year(date) 
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	&nbsp;&nbsp;&nbsp;&nbsp; <br>	
	<b>Bred to:</b><br>	
	<img src = "images/px.gif" width = "20" height = "1" /><b>One of Your Studs:</b>
<% 
		
		if len(ServiceSireID) < 1 or ServiceSireID = "0" then
 
			CurrentStudID = 0
			CurrentStudName = "N/A"
			else		
			sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID
'response.write("sql3=" & sql3 )
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
	

		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing

%>
<tr><td class = "body">	<img src = "images/px.gif" width = "20" height = "1" /><b>Or Someone Else's Stud:</b></td></tr>
<tr><td class = "body">
<img src = "images/px.gif" width = "20" height = "1" />
Stud's Name:<Input type = "Text" name='Externalstudname' value = '<%=Externalstudname%>' >
Color: <Input type = "Text" name='ExternalStudColor' value = '<%=ExternalStudColor%>'  >
Link: http://<Input type = "Text" name='ExternalStudLink' value ='<%=ExternalStudLink%>' >

</td>
</tr>
<tr>
		<td colspan = "17" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<input type="submit" class = "regsubmit2 body" value="Submit"  >
			</form>
		</td>
</tr>
<% if len(Externalstudname) > 0 or len(ExternalStudColor) > 0 or len(ExternalStudLink) > 0 then %>
<tr><td>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="MembersExternalstudUpload.asp?ID=<%=ID %>" >
<% if len(ExternalStudPhoto) > 1 then %>
<img src = "<%=ExternalStudPhoto %>" width = "80" />
<% end if %>
Upload Stud Photo: <input name="attach1" type="file" class="regsubmit2" size=45 >
<input  type=submit value="Upload" class="regsubmit2">
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
<table cellpadding = "0" cellspacing = "0" border = "0" width = "100%">
<%

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

	sql4 = "select ExternalStudID, ExternalStudName from ExternalStud order by ExternalStudName"

	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql, conn4, 3, 3 
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


	sql8 = "select distinct  ID, FullName from Animals order by Animals.FullName"

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
						response.write(currentyear)
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
			rs3.Open sql3, conn, 3, 3 
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

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
<tr><td class = "body"><b>Someone Else's Stud:</b></td></tr>
<tr><td class = "body">
  Stud's name:<Input type = "Text" name='TotalCount' value = <%=TotalCount%> >
</td></tr>


<tr><td colspan = "17" align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<input type="submit" class = "regsubmit2 body" value="Submit"  >
			</form>
</td></tr></table>
<% end if %>
</td></tr></table>