<!DOCTYPE HTML>
<HTML>
<HEAD>
<title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
    <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
    <!--#Include file="AdminHeader.asp"--> 
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
Recordcount = rs.RecordCount +1

Current3="OustideAlpacaStuds" 

AvailableSpecies = "Alpaca"
%> 

 <!--#Include file="AdminAnimalsTabsInclude.asp"-->

<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth -35 %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -35 %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Other People's Studs</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "left" height = "300" valign = "top">

<table border = "0" cellpadding = "0" cellspacing = "0" width = "100%" align = "left">
   <tr>
     <td colspan = "3" align = "left">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "100%">
		<tr>
		<td class = "body">
			When you breed your alpacas to someone elses stud, you can maintain their information here.<br><br>
		</td>
	</tr>
</table>
	 </td>
	</tr>
	<tr>
	  <td align = "left" >

	<form action= 'AdminOutsideStudAddHandleForm.asp' method = "post">
<% if screenwidth < 800 then %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -50 %>">
<% else %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "500">
<% end if %>	
	<tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Add an Outside Stud</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "150" valign = "top">


<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500" align = "left">
	<tr>
		<td width = "120" class = "body" align = "right">
			<div align = "right">Stud's Full Name:</div>
		</td>
		<td align = "left">
			<input name="ExternalStudName" class = "body">
		</td>
	</tr>
		<tr>
		<td class = "body" align = "right">
			<div align = "right">ARI#:</div>
		</td>
	<td align = "left" class = "body">
			<input name="ExternalStudARI">
		</td>
	</tr>
	<% if  AvailableSpecies = "Alpaca" then %>
	<input name="ExternalStudRegistrationType1" Value="ARI" type = "hidden">
		<tr>
		<td class = "body" align = "right">
			<div align = "right">Breed:</div>
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudBreed">
					<option  value="Huacaya">Huacaya</option>
					<option  value="Suri">Suri</option>
					</select>
		</td>
	</tr>
	<% end if %>
	<tr>
		<td class = "body" align = "right">
			<div align = "right">Owner:</div>
		</td>
		<td align = "left" class = "body">
			<input name="ExternalStudOwner" size = "40">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			<div align = "right">Owner Business:</div>
		</td>
		<td align = "left" class = "body">
			<input name="ExternalStudOwnerBusiness" size = "40">
		</td>
	</tr>
	
	<tr>
		<td class = "body" align = "right">
			<div align = "right">Website Address:</div>
		</td>
		<td align = "left" class = "body">
			http://<input name="ExternalStudLink" size = "40">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			<div align = "right">Color 1:
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudColor1">
			  <option  value="">Select color</option>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
			
		</td>
	</tr>
		<tr>
		<td class = "body" align = "right">
			<div align = "right">Color 2:
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudColor2">
			  <option  value="">Select color</option>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
			
		</td>
	</tr>
		<tr>
		<td class = "body" align = "right">
			<div align = "right">Color 3:
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudColor3">
			        <option  value="">Select color</option>
					<option  value="White">White</option>
					<option  value="Beige">Beige</option>
					<option  value="Light Fawn">Light Fawn</option>
					<option  value="Medium Fawn">Medium Fawn</option>
					<option  value="Dark Fawn">Dark Fawn</option>
					<option  value="Light Brown">Light Brown</option>
					<option  value="Medium Brown">Medium Brown</option>
					<option  value="Dark Brown">Dark Brown</option>
					<option value="Light Silver Grey">Light Silver Grey</option>
					<option value="Medium Silver Grey">Medium Silver Grey</option>
					<option value="Dark Silver Grey">Dark Silver Grey</option>
					<option value="Light Rose Grey">Light Rose Grey</option>
					<option value="Medium Rose Grey">Medium Rose Grey</option>
					<option value="Dark Rose Grey">Dark Rose Grey</option>
					<option value="Bay Black">Bay Black</option>
					<option value="True Black">True Black</option>
					</select>
			
		</td>
	</tr>
		<tr>
		<td class = "body" align = "right">
			<div align = "right">Color 4:
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudColor4">
			        <option  value="">Select color</option>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
		</td>
	</tr>
		<tr>
		<td class = "body" align = "right">
			<div align = "right">Color 5:
		</td>
		<td align = "left" class = "body">
			<select size="1" name="ExternalStudColor5">
			  <option  value="">Select color</option>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
			
		</td>
	</tr>

	<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Stud" class = "regsubmit2" >
			
		</td>
</tr>
</table>
	</td>
</tr>
</table></form>
  </td>
   <% if screenwidth < 800 then %>

  <tr></tr>
  <% else %>
    <td>
  </td>
  <% end if %>

  <td width = "300" class = "body" valign = "top">
<%    

Dim IDArray(1000)
Dim animalName(1000)
Dim ExternalStudID(1000)
Dim ExternalStudName(1000)
Dim ExternalStudBreed(1000)
Dim ExternalStudImage(1000)
Dim ExternalStudColor1(1000)
Dim ExternalStudColor2(1000)
Dim ExternalStudColor3(1000)
Dim ExternalStudColor4(1000)
Dim ExternalStudColor5(1000)
Dim ExternalStudRegistrationID1(1000)
Dim ExternalStudRegistrationType1(1000)
Dim ExternalStudOwner(1000)
Dim ExternalStudOwnerBusiness(1000)
Dim ExternalStudOwnerLink(1000)
Dim ExternalStudSpecies(1000)
sql2 = "select * from ExternalStud order by ExternalStudName"
'response.write("'sql2=" & sql2)
	acounter = 1
	 StudsFound = false
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	if not rs2.eof then
	   StudsFound = True
	end if
	While Not rs2.eof  
		IDArray(acounter) = rs2("ExternalStudID")
		ExternalStudName(acounter) = rs2("ExternalStudName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
		
		if StudsFound = True then
%>
<% if screenwidth < 800 then %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -50 %>">
<% else %>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "400">
<% end if %>	<tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Upload Stud Photos</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "150" valign = "top">
<form action="AdminOutsidePhoto.asp" method = "post">
<table  border = "0"cellpadding=0 cellspacing=0 bgcolor = "#dedede" width = "400">
 <tr> <td align = "center">
 <table  border = "0"   cellpadding=0 cellspacing=0 " width = "350" align = "center">
 <tr>
 <td class = "body" >
<br/>To upload photos select below one of the listed outside studs:<br><br>
</td></tr>
<tr> <td class = "body" align = "center">	
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=ExternalStudName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Upload" class="regsubmit2" size = "210"  >
				</td>
			  </tr>
		    </table>
		  
	</td>
			  </tr>
		    </table></form>
  </td>
</tr>
</table>
<% end if %>
 </td>
</tr>
	<%  if StudsFound = True then %>
<td colspan = "3">
<br />

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth- 50%>"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Edit Stud Information</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center"  valign = "top">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "100%">
<tr>
  <td colspan = "2">
 <table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">

<%
order = "even"
 While  Not rs.eof         
	 ExternalStudID(rowcount) =   rs("ExternalStudID")
	 ExternalStudName(rowcount) =   rs("ExternalStudName")
	 ExternalStudBreed(rowcount) =   rs("ExternalStudBreed")
	ExternalStudImage(rowcount) =   rs("ExternalStudImage")
	ExternalStudColor1(rowcount) =   rs("ExternalStudColor1")
	ExternalStudColor2(rowcount) =   rs("ExternalStudColor2")
	 ExternalStudColor3(rowcount) =   rs("ExternalStudColor3")
	ExternalStudColor4(rowcount) =   rs("ExternalStudColor4")
	ExternalStudColor5(rowcount) =   rs("ExternalStudColor5")
	ExternalStudRegistrationID1(rowcount) =   rs("ExternalStudRegistrationID1")
	ExternalStudRegistrationType1(rowcount) =   rs("ExternalStudRegistrationType1")
	ExternalStudOwner(rowcount) =   rs("ExternalStudOwner")
	ExternalStudOwnerBusiness(rowcount) =   rs("ExternalStudOwnerBusiness")
	ExternalStudOwnerLink(rowcount) =   rs("ExternalStudOwnerLink") 
	ExternalStudSpecies(rowcount) =   rs("ExternalStudSpecies") 
%>
<form action= 'AdminOutsideStudHandleForm.asp' method = "post">
<table border = "0" cellpadding=0 cellspacing=0 width = "100%" height = "50">
 <tr >
	  <td class = "body2" align = "left"  >Stud's Name:</td>
	  <td class = "body2" align = "left"  >ARI:</td>
</tr>  
<tr >
	  <td class = "body" width = "500" align = "right"><input type = "hidden" name="ExternalStudID" value= "<%= ExternalStudID( rowcount)%>" ><input type = "text" name="ExternalStudName" value= "<%= ExternalStudName(rowcount)%>" size = "40" ></td>
	  <td nowrap class = "body"><input name="ExternalStudRegistrationID1" value= "<%= ExternalStudRegistrationID1(rowcount)%>"  SIZE =  "12"></td>
</tr>

</table>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr>
<td class = "body">Color 1:</td>
<td class = "body">Color 2:</td>
<td class = "body">Color 3:</td>
<td class = "body">Color 4:</td>
<td class = "body">Color 5:</td>
</tr>
<tr>
<td  class = "body">
<select size="1" name="ExternalStudColor1">
<% if len(ExternalStudColor1(rowcount)) > 1 then%>
<option name = "color1a" value= "<%=ExternalStudColor1(rowcount)%>" selected><%=ExternalStudColor1(rowcount)%></option>
<% else %>
<option name = "color1b" value="" selected>Not Selected</option>
<% end if %>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
</center>
</td>
 <td  class = "body">
<select size="1" name="ExternalStudColor2">
<% if len(ExternalStudColor2(rowcount)) > 1 then%>
<option  value= "<%=ExternalStudColor2(rowcount)%>" selected><%=ExternalStudColor2(rowcount)%></option>
<% else %>
<option  value="" selected>Not Selected</option>
<% end if %>
<option name = "color1b" value="White">White</option>
<option name = "color1c" value="Beige">Beige</option>
<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
		</center>
		</td>
      <td  class = "body">
<select size="1" name="ExternalStudColor3">
<% if len(ExternalStudColor3(rowcount)) > 1 then%>
<option  value= "<%=ExternalStudColor3(rowcount)%>" selected><%=ExternalStudColor3(rowcount)%></option>
<% else %>
<option  value="" selected>Not Selected</option>
<% end if %>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
		</center>
</td>
<td  class = "body">
<select size="1" name="ExternalStudColor4">
<% if len(ExternalStudColor4(rowcount)) > 1 then%>
<option  value= "<%=ExternalStudColor4(rowcount)%>" selected><%=ExternalStudColor4(rowcount)%></option>
<% else %>
<option  value="" selected>Not Selected</option>
<% end if %>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
		</center>
</td>
<td  class = "body">
<select size="1" name="ExternalStudColor5">
<% if len(ExternalStudColor5(rowcount)) > 1 then%>
<option  value= "<%=ExternalStudColor5(rowcount)%>" selected><%=ExternalStudColor5(rowcount)%></option>
<% else %>
<option  value="" selected>Not Selected</option>
<% end if %>
					<option name = "color1b" value="White">White</option>
					<option name = "color1c" value="Beige">Beige</option>
					<option name = "color1d" value="Light Fawn">Light Fawn</option>
					<option name = "color1e" value="Medium Fawn">Medium Fawn</option>
					<option name = "color1f" value="Dark Fawn">Dark Fawn</option>
					<option name = "color1g" value="Light Brown">Light Brown</option>
					<option name = "color1h" value="Medium Brown">Medium Brown</option>
					<option name = "color1i" value="Dark Brown">Dark Brown</option>
					<option name = "color1j" value="Light Silver Grey">Light Silver Grey</option>
					<option name = "color1k" value="Medium Silver Grey">Medium Silver Grey</option>
					<option name = "color1l" value="Dark Silver Grey">Dark Silver Grey</option>
					<option name = "color1m" value="Light Rose Grey">Light Rose Grey</option>
					<option name = "color1n" value="Medium Rose Grey">Medium Rose Grey</option>
					<option name = "color1o" value="Dark Rose Grey">Dark Rose Grey</option>
					<option name = "color1p" value="Bay Black">Bay Black</option>
					<option name = "color1q" value="True Black">True Black</option>
					</select>
		</center>
		</td>
</tr>
</table>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr><td class = "body">Owner:</td>
<td class = "body">Owner Business:</td>
	</tr>
<tr><td class = "body"><input name="ExternalStudOwner" value= "<%=ExternalStudOwner(rowcount) %>" size = "50"></td>
<td class = "body"><input name="ExternalStudOwnerBusiness" value= "<%=ExternalStudOwnerBusiness(rowcount) %>" size = "50"></td>
	</tr>
</table>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr><td class = "body">Website Link: <font color = "#bababa">http://</font><input name="ExternalStudOwnerLink" value= "<%= ExternalStudOwnerLink(rowcount)%>" size = "50"></td>
	</tr>
</table>
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
<tr><td colspan = "8" align = "center" valign = "middle">
<input type="submit" value = "Submit Changes"  class = "regsubmit2" />
</td></tr></table>
</form>
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
 <br><br>
 </td>
</tr>
</table>

  </td>
</tr>
<tr>
  <td colspan = "2">
<br />



				<%  
				dim aID(40000)
				dim aName(40000)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select ExternalStudID,  ExternalStudName from ExternalStud order by ExternalStudName"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ExternalStudID")
				aName(acounter) = rs2("ExternalStudName")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<form action= 'AdminOutsideAnimalDeletehandleform.asp' method = "post">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Delete an Outside Stud</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "50" valign = "top">
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<td valign = "top" >
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
				 
					<b>Animal's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=aID(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Delete" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  
		</td>
	</tr>
</table>
<br><br></td>
	</tr>
</table></form>
<% end if %>
</td>
	</tr>
</table>
</td>
	</tr>
</table><br>
    <!--#Include file="AdminFooter.asp"-->
    
</Body>
</HTML>