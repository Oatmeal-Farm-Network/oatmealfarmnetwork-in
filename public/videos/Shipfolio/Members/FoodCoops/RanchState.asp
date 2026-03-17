<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<!--#Include virtual="/GlobalVariables.asp"-->
<% SetLocale("en-us") 
PeopleID = 2 
State=Request.QueryString("State")
if len(state) < 1 then
State=Request.Form("State")
end if
if len(state) < 1 then
	response.redirect("AllStates.asp")
end if
sql = "SELECT * from States where StateAbbreviation =  '" & State & "'"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
StateName = trim(rs("StateName"))
StateAbbreviation = rs("StateAbbreviation")
Nicknames = rs("Nicknames") 
Moto = rs("Moto")
 StateDescription = rs("StateDescription")
%>
<title><%=StateName %> Livestock Breeders</title>
<meta name="Title" content="<%=StateName %> Livestock Breeders"/>
<meta name="description" content="<%=StateName %> livestock breeders (Alpacas, Cattle, Donkeys, Goats, Horses, Llamas, Pigs, Sheep) sales <%=StateName %> ranches/ farms." />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="14 days"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subjects" content="<%=StateName %> livestock for Sale" />
<link rel="stylesheet" type="text/css" href="/style.css">
<%
StateHeaderImage = rs("StateHeaderImage")
StateFlag = rs("StateFlag")
Statebird = rs("Statebird")
StateSeal = rs("StateSeal")
Weatherlink = rs("Weatherlink")
str1 = StateDescription
str2 = vblf
If InStr(str1,str2) > 0 Then
StateDescription= Replace(str1, str2 , "</br>")
End If  
str1 = StateDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
StateDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If 
If not rs.State = adStateClosed Then
rs.close
End If   	
%> 
</head>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center"><!--#Include virtual="/Header.asp"-->
<% Current = "Ranches" %>
<% Current2 = "RanchHome" %>
<!--#Include file="RanchHeader2.asp"--> 
<table width = "<%=screenwidth %>"><tr><td width = "200" valign = "top" >
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtopandbottom" align = "left" height = "1100">
<H2><div align = "left">Find States by Region</div></H2>
<table   border="0" cellspacing="7" cellpadding="0" leftmargin="9" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  width = "250"><tr><td align = "left" class = "body">
<h2>Ranches by State:<h2>
<h3>Northeastern</h3>
<ul>
<li><a href="RanchState.asp?State=CT" class = "body">Connecticut </a></li>
<li><a href="RanchState.asp?State=MA" class = "body">Massachusetts</a></li>
<li><a href="RanchState.asp?State=ME" class = "body">Maine</a></li>
<li><a href="RanchState.asp?State=NH" class = "body">New Hampshire</a></li>
<li><a href="RanchState.asp?State=NJ" class = "body">New Jersey</a></li>
<li><a href="RanchState.asp?State=NY" class = "body">New York</a></li>
<li><a href="RanchState.asp?State=PA" class = "body">Pennsylvania</a></li>
<li><a href="RanchState.asp?State=RI" class = "body">Rhode Island</a></li>
<li><a href="RanchState.asp?State=VT" class = "body">Vermont</a></li>
</ul>
<h3>Midwest</h3>
<ul>
<li><a href="RanchState.asp?State=IL" class = "body">Illinois</a></li>
<li><a href="RanchState.asp?State=IN" class = "body">Indiana</a></li>
<li><a href="RanchState.asp?State=IA" class = "body">Iowa</a></li> 
<li><a href="RanchState.asp?State=KS" class = "body">Kansas</a></li>
<li><a href="RanchState.asp?State=MN" class = "body">Minnesota</a></li>
<li><a href="RanchState.asp?State=MI" class = "body">Michigan</a></li>
<li><a href="RanchState.asp?State=MS"class = "body" >Missouri</a></li>
<li><a href="RanchState.asp?State=NE" class = "body">Nebraska</a></li>
<li><a href="RanchState.asp?State=ND" class = "body">North Dakota</a></li>
<li><a href="RanchState.asp?State=OH" class = "body">Ohio</a></li>
<li><a href="RanchState.asp?State=SD" class = "body">South Dakota</a></li>
<li><a href="RanchState.asp?State=WI" class = "body">Wisconsin</a></li>
</ul>
<H3>Southern</H3>
<ul>
<li><a href="RanchState.asp?State=AL" class = "body">Alabama</a></li>
<li><a href="RanchState.asp?State=AR" class = "body">Arkansas</a></li>
<li><a href="RanchState.asp?State=DE" class = "body">Delaware</a></li>
<li><a href="RanchState.asp?State=FL" class = "body">Florida</a></li> 
<li><a href="RanchState.asp?State=GA" class = "body">Georgia</a></li>
<li><a href="RanchState.asp?State=KS" class = "body">Kentucky</a></li>
<li><a href="RanchState.asp?State=LA" class = "body">Louisiana </a></li>
<li><a href="RanchState.asp?State=MD" class = "body">Maryland</a></li>
<li><a href="RanchState.asp?State=MS" class = "body">Mississippi</a></li>
<li><a href="RanchState.asp?State=NC" class = "body">North Carolina</a></li>
<li><a href="RanchState.asp?State=OK" class = "body">Oklahoma</a></li>   
<li><a href="RanchState.asp?State=SC" class = "body">South Carolina</a></li>
<li><a href="RanchState.asp?State=TN" class = "body">Tennessee</a></li>
<li><a href="RanchState.asp?State=TX" class = "body">Texas</a></li>
<li><a href="RanchState.asp?State=VA" class = "body">Virginia</a></li>
<li><a href="RanchState.asp?State=WV" class = "body">West Virginia</a></li>
</ul>
<h3>Western</h3>
<ul> 
<li><a href="RanchState.asp?State=AK" class = "body">Alaska</a></li>
<li><a href="RanchState.asp?State=AZ" class = "body">Arizona</a></li>
<li><a href="RanchState.asp?State=CA" class = "body">California</a></li>
<li><a href="RanchState.asp?State=CO" class = "body">Colorado</a></li>	
<li><a href="RanchState.asp?State=HI" class = "body">Hawaii</a></li> 
<li><a href="RanchState.asp?State=ID" class = "body">Idaho</a></li>
<li><a href="RanchState.asp?State=MT" class = "body">Montana</a></li>
<li><a href="RanchState.asp?State=NV" class = "body">Nevada</a></li>
<li><a href="RanchState.asp?State=NM" class = "body">New Mexico</a></li> 
<li><a href="RanchState.asp?State=OR" class = "body">Oregon</a></li>
<li><a href="RanchState.asp?State=UT" class = "body">Utah</a></li>
<li><a href="RanchState.asp?State=WA" class = "body">Washington</a></li>
<li><a href="RanchState.asp?State=WY" class = "body">Wyoming</a></li>
</ul>
<br>
</td></tr></table>
</td></tr></table>
</td>
<td width= "12"></td>
<td valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "750"><tr><td class = "roundedtopandbottom" height = "1100" align = "left" valign = "top">
<H1><div align = "left"><%=StateName %> Livestock Ranches</div></H1>
<table border = "0" width = "100%"  align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
  <tr>
   <td valign = "top" class = "body" align = "left">The ranches below are all located in <%=Trim(StateName) %>, listed in alphabetical order:
<%
sql = "SELECT people.*, address.* , Business.*  from People, Address, Business where People.AddressID = Address.AddressID and People.BusinessID = Business.BusinessID and accesslevel > 0 and People.AISubscription = True and people.AIPublish = true and AddressState =  '" & State & "' order by BusinessName"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
 
If rs.eof Then %><br/><br/>
	<center><b>Currently there are no <%=StateName %> ranches <br />registered with Livestock of America.  </b><br/></center>
			

<%  End if

While Not rs.eof 
    PeopleID = rs("PeopleID")
	Logo = rs("Logo")
	Weblink = rs("Weblink")
	PeopleFirstName = rs("PeopleFirstName")
	PeopleLastName = rs("PeopleLastName")
	Owners = rs("Owners")
	if len(Owners) < 1 then
	    Owners = PeopleFirstName & " " & PeopleLastName
	end if
	PeopleMiddleInitial = rs("PeopleMiddleInitial")
	PeopleLastName = rs("PeopleLastName")
	BusinessName = rs("BusinessName")
	AddressStreet = rs("AddressStreet")
	AddressApt = rs("AddressApt")
	AddressCity = rs("AddressCity")
	AddressState = rs("AddressState")
	AddressZip = rs("AddressZip")
	AddressCountry = rs("AddressCountry")
	PeoplePhone = rs("PeoplePhone")
	PeopleCell = rs("PeopleCell")
	PeopleFax = rs("PeopleFax")
	PeopleID = rs("PeopleID")
	'custRanchdescription = rs("custRanchdescription")
%>


<table border = "0" width = "400" height ="50" align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >
	<tr>
		<td width = "83" align = "center" >
			<% if Len(Logo) > 2 Then 
            str1 = lcase(Logo) 
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
            
            %>
				<a href = "ranchhome.asp?CurrentPeopleID=<%=PeopleID%>" class = "body"><img src = "<%=Logo %>" border = "0" width = "80" alt = "<%=AddressState%> Livestock for Sale at <%=BusinessName%> ranches."/></a>
			<% End If %>
		</td>
		<td class = "body"  align = "left">	<% If Len(BusinessName) > 2 Then %>
				<b><%=BusinessName%></b><br/>
			<% End If %>
			<% If Len(Owners) > 2 Then %>
				<%=Owners%>  <br/>
			<% End If %>
			<% If Len(AddressCity) > 2 Then %>
				<%=AddressCity%>, <%=AddressState%> <br/>
			<% End If %>

			<center><a href = "/ranches/Ranchhome.asp?CurrentPeopleID=<%=PeopleID%>" class = "body" align = "center">Learn More About <%=trim(BusinessName)%>.</a></center><br />
		</td>
	</tr>
</table>
</div><% 
   rs.movenext
	wend

 %></td>
<td class = "body" width = "200" valign = "top">
<table border = "0" width = "195" height = "400" align = "center" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center">
	<tr>
		<td width = "195" align = "left" valign = "top">
<% if len(StateSeal) > 3 then %>
<center><img src = "/uploads/states/<%=StateSeal %>" border = "0" align = "center" width = "100" alt = "<%=AddressState%> State Seal"/></center><br/>
<% end if %>
<center><big><%=Trim(StateName) %></big></center><br/>
Abbreviation: <%=StateAbbreviation %><br/>
Nicknames:<br/>
<center><i><%=Nicknames%></i></center><br/>
Motto: <center><i><%=Moto%></i></center><br/><br/>
<% if len(StateFlag) > 3 then %>
<center><img src = "/uploads/states/<%=StateFlag %>" border = "0" align = "center" width = "100" alt = "<%=AddressState%> State Flag"/></center>
<% end if %>
</td>
</tr>
</table>
<div class="container"> 
<b class="rtop"> 
  <b class="rs1"></b> <b class="rs2"></b> 
</b> 

	</td>
	</tr>
</table>

 <table width = "100%" >
   <tr>
     <td class = "body" >
<%  sql = "SELECT * from Sponsors where State =  '" & State & "'"
'response.write (sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   

If  Not rs.eof Then %>
	<b><%=StateName %> Sponsored Links</b><br/>

<% While Not rs.eof %>
<a href = "http://<%=rs("URL")%>" target = "blank" class = "body"><b><%=rs("custname") %></b></a><br/>
<%=rs("SponsorDescription")%><br/>
<br/>
<% 
rs.movenext
Wend

End If %>


	 </td>
	</tr>
	<tr>
	 <td class = "body"  align = "left">
<% if len(StateDescription)> 1 Then %>
	<b>About <%=StateName %></b><br/>
	<%=StateDescription%><br/><br/>
<% End If 
	rs.close
	Set Conn = Nothing
%>
	 </td>
	</tr>
</table>
</td></tr></table> 
</td></tr></table> 
 <!--#Include virtual="/Footer.asp"--> 
</body>
</html>

