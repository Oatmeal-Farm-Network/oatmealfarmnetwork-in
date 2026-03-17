<!DOCTYPE HTML>
<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="MembersSecurityInclude.asp"--> 
<!--#Include file="MembersGlobalVariables.asp"--> 
<!--#Include file="MembersHeader.asp"-->
<% 
  if screenwidth > 987 then
    fieldlength = 80
     fieldlength2 = 60
end if 
if screenwidth < 987 then
    fieldlength = 70
      fieldlength2 = 60
end if
if screenwidth < 769 then
    fieldlength = 60
      fieldlength2 = 50
end if
 if screenwidth < 601 then
    fieldlength = 50
      fieldlength2 = 40
end if

ShowComingAttractions = False		
sql2 = "select * from Pagelayout where  PageAvailable = True and PageName = 'Coming Attractions'"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then		
ShowComingAttractions = True	
    end if
rs2.close
			



str1 = PageTitle
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, " ")
End If 

str1 = PageTitle
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "'")
End If 
end if
rs2.close		

if ShowComingAttractions = True then
sql2 = "select * from Pagelayout2 where pagelayoutId=" & CurrentPagelayoutID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
if not rs2.eof then		
PageText = rs2("PageText")
str1 = PageText
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1, str2 , vbCrLf)
End If  


str1 = PageText
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, " ")
End If 

str1 = PageText
str2 = "''"
If InStr(str1,str2) > 0 Then
	PageText= Replace(str1,  str2, "'")
End If 
end if			
end if		

if len(PagegroupID) > 0 then
sql2 = "select * from Pagegroups where  pagegroupid = " & PageGroupID	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then		
PageGroupTitle = rs2("PageGroupTitle")	
    end if
rs2.close
end if
%>
<% Current3 = "BreedingRecord" %> 
<% if mobiledevice = False then %>

 <% end if %>

 <%
 if mobiledevice = False then %>
	<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %><tr><td class = "roundedtop" align = "left">
	<H2><div align = "left">Female Breeding Records
		<% if ShowComingAttractions = True then	%>					
					/Coming Attractions
<% end if %>
</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" height = "300" valign = "top" >

<% else %>	
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=pagewidth %>"><tr><td align = "left">
	<H2><div align = "left">Female Breeding Records
		<% if ShowComingAttractions = True then	%>					
					<br />/Coming Attractions
<% end if %>
</div></H2>
</td></tr>
<tr><td  body" align = "center"  valign = "top" >
<% end if %>
		
<% if ShowComingAttractions = True then	%>	
 <% if mobiledevice = False then %>
<br />			
The following text appears at the top of your Coming Attractions page:<br />
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
       <tr><td class = "roundedtop" align = "left">
<H1><div align = "left">Basic Facts</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" >

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" >
	<tr>
		<td valign = "top">
<% str1 = PageTitle
str2 = "'"
If InStr(str1,str2) > 0 Then
	PageTitle= Replace(str1,  str2, "&#39")
End If 
 %>
 <a name = "Top"></a>
<form action= 'MembersPageHandleForm.asp' method = "post">
<input name="TextBlock"  size = "60" value = "Heading" type = "hidden">
<input name="PageLayoutID"  value = "<%=CurrentPagelayoutID %>" type = "hidden">
<input name="ReturnTextBlock"  value = "Top" type = "hidden">
<input name="Returnpage"  value = "MembersFemaleData.asp" type = "hidden">

<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="5" marginheight="0"  cellpadding=5 cellspacing=0 width = "100%" align = "left">
<tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Name:*</b></div>
		</td><td  align = "left" class = "body">
					<input name="PageName" value= '<%=PageName%>' size = "30">
		</td>
</tr>
<tr>	
		<td  align = "right" class = "body">
		    <div align = "right"><b>Menu Title:*</b></div>
		</td>
		<td  align = "left" class = "body">
		    <input name="LinkName" value= '<%=CurrentLinkName%>' size = "20" maxsize = "20">
		   <font color = "gray">Max. length = 20 charecters</font>
		</td>
</tr>
<% if (MenuDropdowns  = "Yes" or MenuDropdowns = True)  and AddPages = True  then %>
<tr>
<td  align = "right" class = "body">
			<div align = "right"><b>Page Group:*</b></div>
		</td>
		<td  align = "left" class = "body">
			<select size="1" name="PagegroupID">
			<% if len(PageGroupTitle) > 2 then %>
<option name = "AID1" value="<%=PageGroupID %>">
	<%=PageGroupTitle %>
</option>
<% else %>
<option name = "AID1" value="">--</option>
<% end if %>
<% count = 1
	sqlg = "select * from PageGroups order by PageGroupOrder"

	acounter = 1
	Set rsg = Server.CreateObject("ADODB.Recordset")
	rsg.Open sqlg, conn, 3, 3 
					
while not rsg.eof	%>
<option name = "AID1" value="<%=rsg("PagegroupID") %>">
	<%=rsg("PageGroupTitle") %>
</option>
<% 	rsg.movenext
wend %>
</select>
</td>
</tr>
<% end if %>
<tr>
	<td  align = "right" class = "body">
			<div align = "right"><b>Page Heading:</b></div>
		</td>
		<td  align = "left" class = "body">
					<input name="PageTitle" value= '<%=PageTitle%>' size = "60">
		</td>
</tr>

<tr><td  class = "body" ><div align = "right">
			<b>Display:</b>&nbsp;</div>
		</td>
		<td class = "body">
			<% if ShowPage = "Yes" Or  ShowPage = True Then %>
						Yes<input TYPE="RADIO" name="ShowPage" Value = True checked>
						No<input TYPE="RADIO" name="ShowPage" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="ShowPage" Value = True >
						No<input TYPE="RADIO" name="ShowPage" Value = False checked>
				<% End if%>
		</td>
	</tr>


<tr><td  class = "body" valign = "top" colspan = 2>
<b>Page Text:</b><br />
 <% if mobiledevice = False then %>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.

WYSIWYG.attach("PageText", mysettings);
mysettings.Width = "<%=screenwidth  %>"
mysettings.Height = "100px"
 </script>
 <% end if %>
<TEXTAREA NAME="PageText" ID="PageText" cols="<%= fieldlength%>" rows="35" wrap="file" Class = "body"><%=PageText%></textarea>
			</td>
		</tr>
	<tr>
<td  colspan = "2" align = "center" valign = "middle" class = "body2" >
			<input type=submit value = "Update" class = "regsubmit2" >
<br>
	</td>
</tr>
</table>
</form>

	</td>
</tr>
</table>
<br />


<br />
<% end if %>
<% sql = "SELECT DISTINCT animals.Fullname, animals.category, FemaleData.* FROM animals, femaledata WHERE animals.id=femaledata.id and (animals.category='Experienced Female' Or category='Inexperienced Female') ORDER BY animals.FullName;"
'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(9999)
    dim Category(9999)
	dim FullName(9999)
	dim Bred(9999)
	dim BredTo(9999)
	dim ServiceSireID(9999)
	dim RecentProgenyID(9999)
	dim DueDateMonth(9999)
	dim DueDateYear(9999)
	dim SSName(9999)
	dim SSID(9999)
	dim ExternalStudID(9999)
	dim SSXName(9999)
	dim SSXID(9999)
	dim rpName(9999)
	dim rpID(9999)
	Dim ShowRecentCria(9999)
	Dim ShowOnCriasPage(9999)

Recordcount = rs.RecordCount +1
%>
 <% if mobiledevice = False then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center" class= "roundedtopandbottom">
	<tr bgcolor = "#dddddd">
		<th width = "370" height = "25" class = "body"><center><b>Name</b></center></th>
		<th width = "250" class = "body"><center><b>Bred</b></center></th>
		<th class = "body"><center><b>Studs</b></center></th>
	</tr>

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
	set rs8=nothing
	set conn8 = nothing

order = "odd"
%>
<form action= 'MembersFemaleHandleForm.asp' method = "post">
 <% While  Not rs.eof 
 Category(rowcount) = rs("Category")
ID(rowcount) =   rs("ID")
FullName(rowcount) =   rs("FullName")
Bred(rowcount) =   rs("Bred")
ExternalStudID(rowcount) =   rs("ExternalStudID")
ServiceSireID(rowcount) =   rs("ServiceSireID")
DueDateMonth(rowcount) =   rs("DueDateMonth")
DueDateYear(rowcount) =   rs("DueDateYear")
ShowRecentCria(rowcount) =   rs("ShowRecentCria")
ShowOnCriasPage(rowcount) =   rs("ShowOnCriasPage")
str1 = ServiceSireID(rowcount) 
If  str1= "0"  Then
ServiceSireID(rowcount) = ""
End If
str2 = RecentProgenyID(rowcount) 
If  str2= "0"  Then
RecentProgenyID(rowcount) = ""
End If
If len(DueDateMonth(rowcount))  = 0 Then
DueDateMonth(rowcount)  = ""
End If 
If len(DueDateYear(rowcount))  = 0 Then
	DueDateYear(rowcount)  = ""
End If 

if order = "odd" then
   order = "even" %>
   	<tr >
<% else
   order = "odd" %>
   	<tr bgcolor = "#dddddd">
 <%  end if
%>
<td  class = "body" nowrap=True >
<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName(rowcount)%>">
<b><a href="MembersAnimalEdit.asp?ID=<%=  ID( rowcount)%>" class = "body"><%=  FullName( rowcount)%></a></b><br>
<%
	If ShowComingattractionspage = True then

	if ShowOnCriasPage(rowcount) = "True" then %>
		Show on Coming Attractions?: 
			Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" checked>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "False" >
		
		<% else %>
			Show on Coming Attractions? Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" >
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)"Value = "False" checked>
	<%end if%>
	<br>
<%
if lcase(category(rowcount)) = "experienced female" then
		    DBname= FullName(rowcount) 
			str1 =DBname
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBname= Replace(str1, "'", "''")
				DBname = trim(DBName)
			End If

	sqlCria = "select Ancestors.ID, Animals.*, Photos.ListPageImage from Animals, Ancestors, Photos where animals.ID = Ancestors.ID and animals.ID = Photos.ID  and (trim(Dam) = '"  & DBname & "'  or trim(sire) = '"  & DBname & "')"
Set rsp = Server.CreateObject("ADODB.Recordset")
rsp.Open sqlCria, conn, 3, 3   
if not rsp.eof then

 if ShowRecentCria(rowcount) = "True" then %>
		Show Latest Cria? 
			Yes<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "True" checked>
			No<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "False" >
		<% else %>
			Show Latest Cria? 
			Yes<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "True" >
			No<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)"Value = "False" checked>
<%end if%>
<%end if%>
<%end if%>
<%end if%>
</td>
	<td class = "body"  >
		<% if Bred(rowcount) = "True" then %>
			Bred? Yes<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" checked>
			No<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "False" >
		<% else %>
			Bred? Yes<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" >
			No<input TYPE="RADIO" name="Bred(<%=rowcount%>)"Value = "False" checked>
	
	<%end if%>
		<br>	Due Date:
		<select size="1" name="DueDateMonth(<%=rowcount%>)">
					<option value="<%=DueDateMonth(rowcount)%>" selected><%=DueDateMonth(rowcount)%></option>
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
			
		<select size="1" name="DueDateYear(<%=rowcount%>)">
				<option value="<%=DueDateYear(rowcount)%>" selected><%=DueDateYear(rowcount)%></option>
				<option value="0">N/A</option>
				<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	
	</td>
	<td class = "body">
	<b>Your Studs:</b>
<% 
		
		if len(ServiceSireID(rowcount)) > 0 or not ServiceSireID(rowcount) = "" then
			
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID( rowcount)
'response.write(sql3)
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 

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
		<br>

		<select size="1" name="ServiceSireID(<%=rowcount%>)" width = "100">
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
		<option value= "" >N/A</option>
		<% count = 1
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>

		<br>
		<b>Other People's Studs:</b><br>
		<% 
			if len(ExternalStudID(rowcount)) > 1  and not ExternalStudID(rowcount) = "" or  ExternalStudID(rowcount) > 0 then
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID(rowcount)
'response.write(sql6)
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = ExternalStudID(rowcount)
			CurrentXStudName = rs6("ExternalStudName")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="XServiceSireID(<%=rowcount%>)" width = "100">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<option value= "" >N/A</option>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=SSXID(count)%>"><%=SSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>

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
			<input type=submit value = "Submit Changes"  class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
 
</td>
</tr>
</table>

<% else %>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">

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
	set rs8=nothing
	set conn8 = nothing

order = "odd"
%>
<form action= 'MembersFemaleHandleForm.asp' method = "post">
 <% While  Not rs.eof 
Category(rowcount) = rs("Category")
	 ID(rowcount) =   rs("ID")
	 FullName(rowcount) =   rs("FullName")
	 Bred(rowcount) =   rs("Bred")
	 ExternalStudID(rowcount) =   rs("ExternalStudID")
	 ServiceSireID(rowcount) =   rs("ServiceSireID")
	 DueDateMonth(rowcount) =   rs("DueDateMonth")
	 DueDateYear(rowcount) =   rs("DueDateYear")
     ShowRecentCria(rowcount) =   rs("ShowRecentCria")
	ShowOnCriasPage(rowcount) =   rs("ShowOnCriasPage")

	str1 = ServiceSireID(rowcount) 
	If  str1= "0"  Then
		ServiceSireID(rowcount) = ""
	End If

	str2 = RecentProgenyID(rowcount) 
	If  str2= "0"  Then
		RecentProgenyID(rowcount) = ""
	End If

If len(DueDateMonth(rowcount))  = 0 Then
	DueDateMonth(rowcount)  = ""
End If 


If len(DueDateYear(rowcount))  = 0 Then
	DueDateYear(rowcount)  = ""
End If 

if order = "odd" then
   order = "even" %>
   	<tr >
<% else
   order = "odd" %>
   	<tr bgcolor = "#dddddd">
 <%  end if
%>
<td  class = "body" nowrap=True >
<table cellpadding=0 cellspacing = 0 border = 0>
<tr><td class = "body">
<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName(rowcount)%>">
<h2><a href="MembersAnimalEdit.asp?ID=<%=  ID( rowcount)%>" class = "body"><%=  FullName( rowcount)%></a></h2>
</td></tr>
<% 
	If ShowComingattractionspage = "True" then
	if ShowOnCriasPage(rowcount) = "True" then %>
	<tr><td class = "body">	
		<div class="button-holder">	
		<b>Show on Coming Attractions?</b><br />
			Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" checked id="radio-1-1" class="regular-radio big-radio"><label for="radio-1-1"></label>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "False" id="radio-1-2"   class="regular-radio big-radio"><label for="radio-1-2"></label>
		</div><br /><br /></td></tr>
		<% else %>
		<tr><td class = "body">	
		<div class="button-holder">	
			Show on the Coming Attractions Page?<br />
			 Yes<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)" Value = "True" id="radio-1-1"   class="regular-radio big-radio"><label for="radio-1-1"></label>
			No<input TYPE="RADIO" name="ShowOnCriasPage(<%=rowcount%>)"Value = "False" checked id="radio-1-2"  checked class="regular-radio big-radio"><label for="radio-1-2"></label>
			</div><br /><br /></td><tr>
	<%end if %>
<tr><td class = "body" height = "15"></td><tr>
	
 
<%     if ShowRecentCria(rowcount) = "True" then %>
	
		<tr><td class = "body">

<div class="button-holder">  category = <%=category(rowcount) %>
		<b>Show Latest Cria1?</b> <br />
			Yes<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "True" id="radio-2-1"  checked class="regular-radio big-radio"><label for="radio-2-1"></label>
			No<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "False"  id="radio-2-2"  class="regular-radio big-radio"><label for="radio-2-2"></label>
			</div><br /><br /></td><tr>
		<% else %>
			<tr><td class = "body">
		<div class="button-holder">
		 
        	Show Latest Cria2? <br />
			Yes<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)" Value = "True"  id="radio-2-1"  class="regular-radio big-radio"><label for="radio-2-1"></label>
			No<input TYPE="RADIO" name="ShowRecentCria(<%=rowcount%>)"Value = "False" checked  id="radio-2-2"  checked class="regular-radio big-radio"><label for="radio-2-2"></label>
		</div><br /><br />	</td><tr>
	<%end if%>
<tr><td class = "body" height = "15"></td><tr>
<%end if%>
	<tr><td class = "body">
		<% if Bred(rowcount) = "True" then %>
		<div class="button-holder">
			<b>Bred?</b> <br />Yes<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True" checked  id="radio-3-1"  checked class="regular-radio big-radio"><label for="radio-3-1"></label>
			No<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "False" id="radio-3-2"   class="regular-radio big-radio"><label for="radio-3-2"></label>  </div><br /><br />
		<% else %>
		<div class="button-holder">
			Bred? <br />Yes<input TYPE="RADIO" name="Bred(<%=rowcount%>)" Value = "True"  id="radio-3-1"   class="regular-radio big-radio"><label for="radio-3-1"></label>
			No<input TYPE="RADIO" name="Bred(<%=rowcount%>)"Value = "False" checked id="radio-3-2"  checked class="regular-radio big-radio"><label for="radio-3-2"></label>
	  </div><br /><br />
	<%end if%>
	</td></tr>	
	<tr><td class = "body" height = "15"></td><tr>
	<tr><td class = "body">
	<b>Due Date:</b><br />
		<select size="1" name="DueDateMonth(<%=rowcount%>)" class = "regsubmit2 body" >
					<option value="<%=DueDateMonth(rowcount)%>" selected><%=DueDateMonth(rowcount)%></option>
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
			
		<select size="1" name="DueDateYear(<%=rowcount%>)" class = "regsubmit2 body">
				<option value="<%=DueDateYear(rowcount)%>" selected><%=DueDateYear(rowcount)%></option>
				<option value="0">N/A</option>
				<% currentyear = year(date) 
						response.write(currentyear)
					For yearv=currentyear To currentyear + 2 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
	<br /><br />
	</td></tr>	
	<tr><td class = "body" height = "15"></td><tr>
	<tr><td class = "body">
	<b>Your Studs:</b><br />
<% 
		
		if len(ServiceSireID(rowcount)) > 0 or not ServiceSireID(rowcount) = "" then
			
			conn3 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql3 = "select Animals.ID, Animals.FullName from Animals where  Animals.ID =" & ServiceSireID( rowcount)
'response.write(sql3)
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			rs3.Open sql3, conn3, 3, 3 

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
		<br>

		<select size="1" name="ServiceSireID(<%=rowcount%>)" width = "100" class = "regsubmit2 body">
		<option value= "<%=CurrentStudID%>" selected><%= CurrentStudName%></option>
		<option value= "" >N/A</option>
		<% count = 1
			while count < studcounter
			response.write(count)
		%>
			<option value="<%=SSID(count)%>" ><%=SSName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>
<br /><br />
	</td></tr>	
	<tr><td class = "body">
		<b>Other People's Studs:</b><br>
		<% 
			if len(ExternalStudID(rowcount)) > 1  and not ExternalStudID(rowcount) = "" or  ExternalStudID(rowcount) > 0 then
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID(rowcount)
'response.write(sql6)
			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = ExternalStudID(rowcount)
			CurrentXStudName = rs6("ExternalStudName")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing

		else CurrentXStudID = ""
			CurrentXStudName = "N/A"
		end if
		%>


       		<select size="1" name="XServiceSireID(<%=rowcount%>)" width = "100" class = "regsubmit2 body">
			<option value= "<%=CurrentXStudID%>" selected><%= CurrentXStudName%></option>
			<option value= "" >N/A</option>
			<% count = 1
				while count < xstudcounter
			%> 
				<option value="<%=SSXID(count)%>"><%=SSXName(count)%></option>
			<% 	count = count + 1
				wend %>
			</select>
</td>
	</tr>
	</table>
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
		<td align = "center" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes"  class = "regsubmit2 body" >
			</form>
		</td>
</tr>
</table>
 
</td>
</tr>
</table>
 <br> <br>
 <br> <br>
<% end if %>
 <br>
 <!--#Include virtual="/Membersistration/MembersFooter.asp"--> 
 
</BODY>
</HTML>