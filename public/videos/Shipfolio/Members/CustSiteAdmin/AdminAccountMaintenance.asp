<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
 <link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"-->

</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminGlobalVariables.asp"-->
<base target="_parent"> 
<!--#Include file="AdminHeader.asp"-->

    <%    Current3="AccountHome" %> 
<% if mobiledevice = False  then %> 
<!--#Include file="AdminAccountTabsInclude.asp"-->

<table width = "100%"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "body" valign = "top">
<% 
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(databasepath) & ";" & _
		"User Id=;Password=;" 
	Set rs = Server.CreateObject("ADODB.Recordset")
OwnerPeopleID = 667

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Contact Information</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr ><td align = "center">


<% 

 sql = "select distinct People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = 667"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

if  Not rs.eof then   
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
 AddressStreet = rs("AddressStreet")
 PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Owners= rs("Owners")
 rs.close
  end if
  
  
   sql = "select * from SiteDesign where PeopleID=667 "
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
logo = rs("Logo")
rs.close

 sql = "select distinct BusinessName, BusinessLogo, Business.BusinessID from People, Business where People.BusinessID = Business.BusinessID and  people.PeopleID = 667" 

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
 BusinessName = rs("BusinessName")
 BusinessLogo = rs("BusinessLogo")
 BusinessID = rs("BusinessID")
end if

%>

<table border = "0"  cellpadding=0 cellspacing=0 width = "<%=pagewidth %>" align = "right" >
<tr>
<% if mobiledevice = True  then 
Fieldwidth = 20 %>
<td  valign = "top" width ="100%">
<% else 
Fieldwidth = 33%>
<td  valign = "top" width ="50%">
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Name & Address</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
        <form  name=form method="post" action="AdminContactsUpdateAccount.asp?PeopleID=<%=PeopleID%>">
<table  border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
				<td class = "body2" align = "right" WIDTH = "150"><input name="ReturnPage" Value ="AccountContactsEdit.asp?PeopleID=<%=PeopleID%>" type="hidden">
					First Name:* &nbsp;
				</td>
				<td class = "body2" align = "left" WIDTH = "300">
					<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">
					Last Name:* &nbsp;
				</td>
				<td class = "body2" align = "left">
					<input name="PeopleLastName" Value ="<%=PeopleLastName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">
					Business Name:* &nbsp;
				</td>
				<td class = "body2" align = "left">
					<input name="BusinessName" Value ="<%=BusinessName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>	
		<tr>
				<td class = "body2" align = "right">
					<a class="tooltip" href="#">Owners:&nbsp;<span class="custom info body"><div align = "left"><em>Owners:</em>List the whole team (i.e. Joe and Sally Smith, our son Luigi, and Joe)</div></b></span></a>&nbsp;
				</td>
				<td class = "body2" align = "left">
					<input name="Owners" Value ="<%=Owners%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>		
	<tr>
		<td   class = "body2" align = "right">
			Email:* &nbsp;
		</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="PeopleEmail"  size = "30" value = "<%=PeopleEmail%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			Mailing Address: &nbsp;
		</td>
        <td  align = "left" valign = "top" class = "body2">
			<input name="AddressStreet"  size = "30" value = "<%=AddressStreet%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
		<td   class = "body2"  align = "right">
				Apartment / Suite: &nbsp;
		</td>
						<td  valign = "top" class = "body2" align = "left">
								<input name="AddressApt"  size = "30" value = "<%=AddressApt%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								City: &nbsp;
							</td>
							<td  valign = "top" class = "body2" align = "left">
								<input name="AddressCity"  size = "30" value = "<%=AddressCity%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2">
								State/ Provence: &nbsp;
							</td>
							<td  align = "left" valign = "top" class = "body2">
					
							<select size="1" name="AddressState" class="regsubmit2 body">
							<% If Len(AddressState) > 0 then%>
								<option value="<%=AddressState%>" selected><%=AddressState%></option>
							<% Else %>
								<option value="" selected>-----</option>
							<% End If %>
					<option value="AL">AL</option>
					<option  value="AK">AK</option>
					<option  value="AZ">AZ</option>
					<option  value="AR">AR</option>
					<option  value="CA">CA</option>
					<option  value="CO">CO</option>
					<option  value="CT">CT</option>
					<option  value="DE">DE</option>
					<option  value="DC">DC</option>
					<option  value="FL">FL</option>
					<option  value="GA">GA</option>
					<option  value="HI">HI</option>
					<option  value="ID">ID</option>
					<option  value="IL">IL</option>
					<option  value="IN">IN</option>
					<option  value="IA">IA</option>
					<option  value="KS">KS</option>
					<option  value="KY">KY</option>
					<option  value="LA">LA</option>
					<option  value="ME">ME</option>
					<option  value="MD">MD</option>
					<option  value="MA">MA</option>
					<option  value="MI">MI</option>
					<option  value="MN">MN</option>
					<option  value="MS">MS</option>
					<option  value="MO">MO</option>
					<option  value="MT">MT</option>
					<option  value="NE">NE</option>
					<option  value="NV">NV</option>
					<option  value="NH">NH</option>
					<option  value="NJ">NJ</option>
					<option  value="NM">NM</option>
					<option  value="NY">NY</option>
					<option  value="NC">NC</option>
					<option  value="ND">ND</option>
					<option  value="OH">OH</option>
					<option  value="OK">OK</option>
					<option  value="OR">OR</option>
					<option  value="PA">PA</option>
					<option  value="RI">RI</option>
					<option  value="SC">SC</option>
					<option  value="SD">SD</option>
					<option  value="TN">TN</option>
					<option  value="TX">TX</option>
					<option  value="UT">UT</option>
					<option  value="VT">VT</option>
					<option  value="VA">VA</option>
					<option  value="WA">WA</option>
					<option  value="WV">WV</option>
					<option  value="WI">WI</option>
					<option  value="WY">WY</option>
					<option  value=""></option>
					<option  value="ON">ON</option>
					<option  value="QC">QC</option>
					<option  value="BC">BC</option>
					<option  value="AB">AB</option>
					<option  value="MB">MB</option>
					<option  value="SK">SK</option>
					<option  value="NS">NS</option>
					<option  value="NB">NB</option>
					<option  value="NL">NL</option>
					<option  value="PE">PE</option>
					<option  value="NT">NT</option>
					<option  value="YK">YK</option>
					<option  value="NU">NU</option>

				</select>
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Postal Code: &nbsp;
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="AddressZip"  size = "8" value = "<%=AddressZip%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body2">
				<small>Country: </small>	
			</td>
			<td  align = "left" valign = "top" class = "body2">
					
				<select size="1" name="AddressCountry" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				<% if AddressCountry = "Canada" then %>
					<option value="USA" >USA</option>
					<option value="Canada" selected>Canada</option>
				<% else %>
					<option value="USA"  selected>USA</option>
					<option value="Canada">Canada</option>
				<% end if %>
				</select>
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Phone: &nbsp;
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeoplePhone"  size = "30" value = "<%=PeoplePhone%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Cell: &nbsp;
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeopleCell"  size = "30" value = "<%=PeopleCell%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Fax: &nbsp;
			</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeopleFax"  size = "30" value = "<%=PeopleFax%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr><td  align = "center" colspan = "2">
        <input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
         <input name="EventID" type = "hidden"  value = "<%=EventID%>">
		<center><input type=submit value="Submit" class = "regsubmit2" ></center></form>
</td></tr></table></td></tr></table>
</td>
<% if mobiledevice = True  then %>
</tr><tr>
<td valign = "top" class = "body" width = "100%">
<% else %>
<td valign = "top" class = "body" width = "50%">
<% end if %>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" valign = "top" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Logo</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center">

<table border = "0"  cellpadding=0 cellspacing=0 width = "100%" height = "200" align = "center" >
<tr><td width = "420" valign = "top" class = "body"><bfr><br /></br>
	<% If Len(Logo) > 2 Then %>
							<center><img src = "<%=Logo%>" width = "220"></center>
					<% Else %>
							<b>No Image</b>
					<% End If %>

<td>
</tr>
<tr>
<td class=  "body" width = "100%">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLogouploadImageUser.asp?BusinessID=<%=BusinessID%>&PeopleID=<%=PeopleID%>" >
<h2>Upload Logo:</h2> <br>must be JPG, JPEG, GIF, or PNG format<br />& < 500KB.<br />
<% if mobiledevice = True  then %>
<input name="attach1" type="file" size=25 class = "regsubmit2 body" >
<% else %>
		<input name="attach1" type="file" size=45 class = "regsubmit2 body" >						
<% end if %>
<center><input  type=submit value="Submit" class = "regsubmit2 body" ></center>
</form>
							
						<td>
						</tr>
						<% If Len(Logo) > 2 Then %>
						<tr>
					    <td class = "body">
		<form action= 'AdminLogoRemoveImage.asp' method = "post">
		<input type = "hidden" name="BusinessID" value= "<%=BusinessID%>" >
		<input type = "hidden" name="PeopleID" value= "<%=PeopleID%>" >
		<input name="ReturnPage" Value ="AccountContactsEdit.asp?PeopleID=<%=PeopleID%>" type="hidden">
		<center><input type=submit class = "regsubmit2 body"  value="Remove This Image"></center>
		</form>
	</td>
</tr>

<% End If %>
</table>

</td></tr></table>
</td>
</tr>
</table>

 </td></tr></table>
 </td></tr></table>
 </td></tr></table>
 <% else %>
 
 
<table width = "<%=pagewidth %>"   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr><td class = "body" valign = "top">
<a href = "/Administration/AdminPasswordChange.asp" class = "body"><b>Reset Password</b></a><br /><br />

<% 
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(databasepath) & ";" & _
		"User Id=;Password=;" 
	Set rs = Server.CreateObject("ADODB.Recordset")
OwnerPeopleID = 667

%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td  align = "left">
		<H1><div align = "left">Contact Information</div></H1>
        </td></tr>
        <tr><td  align = "center" width = "100%">
<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr ><td align = "center">


<% 

 sql = "select distinct People.*, address.*  from People, Address where People.AddressID = Address.AddressID and People.AddressID = Address.AddressID and people.PeopleID = 667"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

if  Not rs.eof then   
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeopleLastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
AddressApt = rs("AddressApt")
AddressCity= rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")
 AddressStreet = rs("AddressStreet")
 PeopleCell = rs("PeopleCell")
 PeopleFax= rs("Peoplefax")
Owners= rs("Owners")
 rs.close
  end if
  
  
   sql = "select * from SiteDesign where PeopleID=667 "
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
logo = rs("Logo")
rs.close

 sql = "select distinct BusinessName, BusinessLogo, Business.BusinessID from People, Business where People.BusinessID = Business.BusinessID and  people.PeopleID = 667" 

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 if  Not rs.eof then 
 BusinessName = rs("BusinessName")
 BusinessLogo = rs("BusinessLogo")
 BusinessID = rs("BusinessID")
end if

%>

<table border = "0"  cellpadding=0 cellspacing=0 width = "100%"  align = "right" >
<tr>
<td  valign = "top" width ="100%">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td  align = "left">
		<H2><div align = "left">Name & Address</div></H2>
        </td></tr>
        <tr><td align = "center">
        <form  name=form method="post" action="AdminContactsUpdateAccount.asp?PeopleID=<%=PeopleID%>">
<table  border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
				<td class = "body2" align = "right" WIDTH = "150"><input name="ReturnPage" Value ="AccountContactsEdit.asp?PeopleID=<%=PeopleID%>" type="hidden">
					First Name:*</td>
				<td class = "body2" align = "left" WIDTH = "300">
					<input name="PeopleFirstName" Value ="<%=PeopleFirstName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">
					Last Name:*</td>
				<td class = "body2" align = "left">
					<input name="PeopleLastName" Value ="<%=PeopleLastName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>
			<tr>
				<td class = "body2" align = "right">
					Business Name:*</td>
				<td class = "body2" align = "left">
					<input name="BusinessName" Value ="<%=BusinessName%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>	
		<tr>
				<td class = "body2" align = "right">
					Owners:</td>
				<td class = "body2" align = "left">
					<input name="Owners" Value ="<%=Owners%>"  size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				</td>
			</tr>		
	<tr>
		<td   class = "body2" align = "right">
			Email:*</td>
		<td  align = "left" valign = "top" class = "body2">
			<input name="PeopleEmail"  value = "<%=PeopleEmail%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			Mailing Address:</td>
        <td  align = "left" valign = "top" class = "body2">
			<input name="AddressStreet"  value = "<%=AddressStreet%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
		</td>
	</tr>
	<tr>
		<td   class = "body2"  align = "right">
				Apartment / Suite:</td>
<td  valign = "top" class = "body2" align = "left">
<input name="AddressApt"   value = "<%=AddressApt%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
							</td>
						</tr>
						<tr>
							<td   class = "body2" align = "right">
								City:</td>
							<td  valign = "top" class = "body2" align = "left">
								<input name="AddressCity" value = "<%=AddressCity%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
							</td>
						</tr>
						<tr>
							<td  align = "right" class = "body2">
								State/ Provence:</td>
							<td  align = "left" valign = "top" class = "body2">
					
							<select size="1" name="AddressState" class = "regsubmit2 body">
							<% If Len(AddressState) > 0 then%>
								<option value="<%=AddressState%>" selected><%=AddressState%></option>
							<% Else %>
								<option value="" selected>-----</option>
							<% End If %>
					<option value="AL">AL</option>
					<option  value="AK">AK</option>
					<option  value="AZ">AZ</option>
					<option  value="AR">AR</option>
					<option  value="CA">CA</option>
					<option  value="CO">CO</option>
					<option  value="CT">CT</option>
					<option  value="DE">DE</option>
					<option  value="DC">DC</option>
					<option  value="FL">FL</option>
					<option  value="GA">GA</option>
					<option  value="HI">HI</option>
					<option  value="ID">ID</option>
					<option  value="IL">IL</option>
					<option  value="IN">IN</option>
					<option  value="IA">IA</option>
					<option  value="KS">KS</option>
					<option  value="KY">KY</option>
					<option  value="LA">LA</option>
					<option  value="ME">ME</option>
					<option  value="MD">MD</option>
					<option  value="MA">MA</option>
					<option  value="MI">MI</option>
					<option  value="MN">MN</option>
					<option  value="MS">MS</option>
					<option  value="MO">MO</option>
					<option  value="MT">MT</option>
					<option  value="NE">NE</option>
					<option  value="NV">NV</option>
					<option  value="NH">NH</option>
					<option  value="NJ">NJ</option>
					<option  value="NM">NM</option>
					<option  value="NY">NY</option>
					<option  value="NC">NC</option>
					<option  value="ND">ND</option>
					<option  value="OH">OH</option>
					<option  value="OK">OK</option>
					<option  value="OR">OR</option>
					<option  value="PA">PA</option>
					<option  value="RI">RI</option>
					<option  value="SC">SC</option>
					<option  value="SD">SD</option>
					<option  value="TN">TN</option>
					<option  value="TX">TX</option>
					<option  value="UT">UT</option>
					<option  value="VT">VT</option>
					<option  value="VA">VA</option>
					<option  value="WA">WA</option>
					<option  value="WV">WV</option>
					<option  value="WI">WI</option>
					<option  value="WY">WY</option>
					<option  value=""></option>
					<option  value="ON">ON</option>
					<option  value="QC">QC</option>
					<option  value="BC">BC</option>
					<option  value="AB">AB</option>
					<option  value="MB">MB</option>
					<option  value="SK">SK</option>
					<option  value="NS">NS</option>
					<option  value="NB">NB</option>
					<option  value="NL">NL</option>
					<option  value="PE">PE</option>
					<option  value="NT">NT</option>
					<option  value="YK">YK</option>
					<option  value="NU">NU</option>

				</select>
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Postal Code:</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="AddressZip"  size = "8" value = "<%=AddressZip%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td  align = "right" class = "body2">
				Country:</td>
			<td  align = "left" valign = "top" class = "body2">
					
				<select size="1" name="AddressCountry" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
				<% if AddressCountry = "Canada" then %>
					<option value="USA" >USA</option>
					<option value="Canada" selected>Canada</option>
				<% else %>
					<option value="USA"  selected>USA</option>
					<option value="Canada">Canada</option>
				<% end if %>
				</select>
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Phone:</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeoplePhone"  value = "<%=PeoplePhone%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Cell:</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeopleCell"  value = "<%=PeopleCell%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr>
			<td   class = "body2" align = "right">
				Fax:</td>
			<td  align = "left" valign = "top" class = "body2">
				<input name="PeopleFax"  value = "<%=PeopleFax%>" size = "<%=Fieldwidth %>" maxlength = "61" class = "regsubmit2 body">
			</td>
		</tr>
		<tr><td  align = "center" colspan = "2">
        <input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
         <input name="EventID" type = "hidden"  value = "<%=EventID%>">
		<center><input type=submit value="Submit" class = "regsubmit2 body" ></center></form>
</td></tr></table></td></tr></table>
</td>
</tr><tr>
<td valign = "top" class = "body" width = "100%">


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td  align = "left">
		<H2><div align = "left">Logo</div></H2>
        </td></tr>
        <tr><td  align = "center">

<table border = "0"  cellpadding=0 cellspacing=0 width = "100%" height = "200" align = "center" >
<tr><td width = "420" valign = "top" class = "body"><br><br /></br>
	<% If Len(Logo) > 2 Then %>
							<center><img src = "<%=Logo%>" width = "220"></center>
					<% Else %>
							<b>No Image</b>
					<% End If %>

<td>
</tr>
<tr>
<td class=  "body" width = "100%">
<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLogouploadImageUser.asp?BusinessID=<%=BusinessID%>&PeopleID=<%=PeopleID%>" >
Upload Logo: <br>JPG, JPEG, GIF, or PNG format<br />& < 500KB.<br />
<% if mobiledevice = True  then %>
<input name="attach1" type="file" size=25 class = "regsubmit2 body" >
<% else %>
		<input name="attach1" type="file" size=45 class = "regsubmit2 body" >						
<% end if %>
<center><input  type=submit value="Upload" class = "regsubmit2 body" ></center><br />
</form>
							
<td>
</tr>
<% If Len(Logo) > 2 Then %>
<tr>
<td class = "body"><br />
		<form action= 'AdminLogoRemoveImage.asp' method = "post">
		<input type = "hidden" name="BusinessID" value= "<%=BusinessID%>" >
		<input type = "hidden" name="PeopleID" value= "<%=PeopleID%>" >
		<input name="ReturnPage" Value ="AccountContactsEdit.asp?PeopleID=<%=PeopleID%>" type="hidden">
		<center><input type=submit class = "regsubmit2 body"  value="Remove This Image"></center>
		</form>
	</td>
</tr>

<% End If %>
</table>

</td></tr></table>
</td>
</tr>
</table>

 </td></tr></table>
 </td></tr></table>
 </td></tr></table>
  <br /> <br /> <br />
 
 <% end if %>
 <br />
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>