 <% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" 
sql = "select Ancestors.*, Animals.*, Pricing.*, colors.*,  Ancestrypercents.*, Awards.*, AnimalRegistration.*  from AnimalRegistration, Animals, Pricing, Ancestors, colors,  Ancestrypercents, Awards where animals.AnimalRegistrationID = AnimalRegistration.AnimalRegistrationID and animals.id = Ancestrypercents.id and animals.ID = Pricing.ID and animals.ID = Awards.ID and animals.ID = Ancestors.ID and animals.ID = colors.ID and Animals.ID=" & ID
gender = "non-breeder"
'rs.Open sql, conn, 3, 3 
if mobiledevice = True or screenwidth < 800 then %>			
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
     <tr>
        <td class = "roundedtop" align = "left"><H2><div align = "left">Basic Facts<a name="BasicFacts"></a></div></H2></td>
     </tr>
     <tr>
        <td class = "roundedBottom" align = "center">
           <form action= 'AdminGeneralStatsHandle.asp' method = "post" name = "g1">
                <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "100%" >
			<tr>
				<td  class = "body2" align = "right">	
				<b>Full Name:</b>&nbsp;
				</td>
				<td align = "left">
<input name="Name" size = "30" value = "<%=name%>" class = "regsubmit2 body" height = "30">
				</td>
		</tr>
		<tr>
				<td  class = "body2" align = "right">
<b>D.O.B.:</b>&nbsp;
				</td>
<td align = "left">
<select size="1" name="DOBMonth" class = "regsubmit2 body">
<% if not DOBMonth = "0" then %>
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<% else %>
<option value="0" selected></option>
<% end if %>
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
<select size="1" name="DOBDay" class = "regsubmit2 body">
<% if not DOBDay = "0" then %>
<option value="<%=DOBDay%>" selected><%=DOBDay%></option>
<% else %>
<option value="0" selected></option>
<% end if %>
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
<select size="1" name="DOBYear" class = "regsubmit2 body">
<% if not DOBYear = "0" then %>
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% else %>
<option value="0" selected></option>
<% end if %>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
		</td>
	</tr>
		<tr>
		<td  class = "body2" align = "right">
<b>ARI#:</b>&nbsp;
		</td>
		<td align = "left">
<input name="ARI" size = "20" value = "<%=ARI%>" class = "regsubmit2 body">
	<input name="AnimalRegistrationID" type="hidden" value = "<%=websiteAnimalRegistrationID%>">
</td>
	</tr>
		<tr>
			<td  class = "body2" align = "right">
<b>CLAA#:</b>&nbsp;
				</td>
				<td align = "left">
<input name="CLAA" size = "20" value = "<%=CLAA%>" class = "regsubmit2 body">
				</td>
	<tr>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
			<b>Category:</b>&nbsp;
		</td>
		<td align = "left">
<select size="1" name="Category" class = "regsubmit2 body">
<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
<option name = "Category12" value="Experienced Male">Experienced Male</option>
<option name = "Category12" value="Inexperienced Male">Inexperienced Male</option>
<option name = "Category14" value="Experienced Female">Experienced Female</option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female</option>
<option name = "Category15" value="Non-Breeder">Fiber/Companion</option>
<option name = "Category13" value="Unowned Animal">Unowned Animal</option>
</select>
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>Breed:</b>&nbsp;
		</td>
		<td align = "left">

<% sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedLookupID 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
Breed = rs2("Breed")
end if %>
<select size="1" name="Breed" class = "regsubmit2 body">
<% if len(Breed) > 0 then %>
<option value="<%=Breed %>" selected><%=Breed %></option>

<%
end if
 sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
while not(rs2.eof)  %>
<% if not rs2("Breed")  = PreferedSpeciesBreed then %>
<option value="<%=rs2("Breed")%>" class = "regsubmit2 body"><%=rs2("Breed")%></option>

<%
end if
 rs2.movenext
wend 
end if
rs2.close %>
		</td>
	</tr>
	<tr>
		<td  class = "body2" align = "right">
	<b>Color 1:</b>&nbsp;
		</td>
		<td class = "body">
			<select size="1" name="Color1" class = "regsubmit2 body">
<option name = "color1a" value= "<%=Color1%>" selected><%=Color1%></option>
		<option name = "color1aa" value="">N/A</option>
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
		<td  class = "body2" align = "right">
<b>Color 2:</b>&nbsp;
		</td>
		<td class = "body">
				<select size="1" name="Color2" class = "regsubmit2 body">
<option name = "color2a" value= "<%=Color2%>" selected><%=Color2%></option>
		<option name = "color2aa" value="">N/A</option>
<option name = "color2b" value="White">White</option>
<option name = "color2c" value="Beige">Beige</option>
<option name = "color2d" value="Light Fawn">Light Fawn</option>
<option name = "color2e" value="Medium Fawn">Medium Fawn</option>
<option name = "color2f" value="Dark Fawn">Dark Fawn</option>
<option name = "color2g" value="Light Brown">Light Brown</option>
<option name = "color2h" value="Medium Brown">Medium Brown</option>
<option name = "color2i" value="Dark Brown">Dark Brown</option>
<option name = "color2j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color2k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color2l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color2m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color2n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color2o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color2p" value="Bay Black">Bay Black</option>
<option name = "color2q" value="True Black">True Black</option>
</select>
		</td>
</tr>
<tr>
		<td  class = "body2" align = "right">
			<b>Color 3:</b>&nbsp;
		</td>
		<td class="body">
			<select size="1" name="Color3" class = "regsubmit2 body">
<option name = "color3a" value= "<%=Color3%>" selected><%=Color3%></option>
		<option name = "color3aa" value="">N/A</option>
<option name = "color3b" value="White">White</option>
<option name = "color3c" value="Beige">Beige</option>
<option name = "color3d" value="Light Fawn">Light Fawn</option>
<option name = "color3e" value="Medium Fawn">Medium Fawn</option>
<option name = "color3f" value="Dark Fawn">Dark Fawn</option>
<option name = "color3g" value="Light Brown">Light Brown</option>
<option name = "color3h" value="Medium Brown">Medium Brown</option>
<option name = "color3i" value="Dark Brown">Dark Brown</option>
<option name = "color3j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color3k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color3l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color3m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color3n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color3o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color3p" value="Bay Black">Bay Black</option>
<option name = "color3q" value="True Black">True Black</option>
</select>
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>Color 4:</b>&nbsp;
		</td>
		<td class="body">
			<select size="1" name="Color4" class = "regsubmit2 body">
<option name = "color4a" value= "<%=Color4%>" selected><%=Color4%></option>
<option name = "color4aa" value="">N/A</option>
<option name = "color4b" value="White">White</option>
<option name = "color4c" value="Beige">Beige</option>
<option name = "color4d" value="Light Fawn">Light Fawn</option>
<option name = "color4e" value="Medium Fawn">Medium Fawn</option>
<option name = "color4f" value="Dark Fawn">Dark Fawn</option>
<option name = "color4g" value="Light Brown">Light Brown</option>
<option name = "color4h" value="Medium Brown">Medium Brown</option>
<option name = "color4i" value="Dark Brown">Dark Brown</option>
<option name = "color4j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color4k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color4l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color4m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color4n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color4o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color4p" value="Bay Black">Bay Black</option>
<option name = "color4q" value="True Black">True Black</option>
</select>
		</td>
		</tr>
		<tr>
			<td  class = "body2" align = "right">
			<b>Color 5:</b>&nbsp;
		</td>
		<td class="body">
			<select size="1" name="Color5" class = "regsubmit2 body">
<option name = "color5a" value= "<%=Color5%>" selected><%=Color5%></option>
<option name = "color5aa" value="">N/A</option>
<option name = "color5b" value="White">White</option>
<option name = "color5c" value="Beige">Beige</option>
<option name = "color5d" value="Light Fawn">Light Fawn</option>
<option name = "color5e" value="Medium Fawn">Medium Fawn</option>
<option name = "color5f" value="Dark Fawn">Dark Fawn</option>
<option name = "color5g" value="Light Brown">Light Brown</option>
<option name = "color5h" value="Medium Brown">Medium Brown</option>
<option name = "color5i" value="Dark Brown">Dark Brown</option>
<option name = "color5j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color5k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color5l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color5m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color5n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color5o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color5p" value="Bay Black">Bay Black</option>
<option name = "color5q" value="True Black">True Black</option>
</select>
		</td>
	</tr>

	<tr>
		<td  class = "body2" align = "right">
			<b>% US:</b>&nbsp;
		</td>
	<td class="body">
		<select size="1" name="PercentUSA" class = "regsubmit2 body">
<option name = "PercentUSA" value= "<%=PercentUSA%>" selected><%=PercentUSA%></option>
<option name = "PercentUSA2" value="0">0%</option>
<option name = "PercentUSA3" value="1/8">1/8</option>
				     <option name = "PercentUSA4" value="1/4">1/4</option>
				     <option name = "PercentUSA5" value="3/8">3/8</option>
				     <option name = "PercentUSA6" value="1/2">1/2</option>
				     <option name = "PercentUSA7" value="5/8">5/8</option>
				     <option name = "PercentUSA8" value="3/4">3/4</option>
				     <option name = "PercentUSA9" value="7/8">7/8</option>
  <option name = "PercentUSA" value="Full US">Full USA</option>
			 </select>
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>% Canadian:</b>&nbsp;
		</td>
			<td class="body">
		<select size="1" name="PercentCanadian" class = "regsubmit2 body">
<option name = "PercentCanadian" value= "<%=PercentCanadian%>" selected><%=PercentCanadian%></option>
<option name = "PercentCanadian2" value="0">0%</option>
<option name = "PercentCanadian3" value="1/8">1/8</option>
				     <option name = "PercentCanadian4" value="1/4">1/4</option>
				     <option name = "PercentCanadian5" value="3/8">3/8</option>
				     <option name = "PercentCanadian6" value="1/2">1/2</option>
				     <option name = "PercentCanadian7" value="5/8">5/8</option>
				     <option name = "PercentCanadian8" value="3/4">3/4</option>
				     <option name = "PercentCanadian9" value="7/8">7/8</option>
  <option name = "PercentCanadian" value="Full Canadian">Full Canadian</option>
			 </select>
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>% Peruvian:</b>&nbsp;
		</td>
		<td class="body">
		<select size="1" name="PercentPeruvian" class = "regsubmit2 body">
<option name = "PercentPeruvian" value= "<%=PercentPeruvian%>" selected><%=PercentPeruvian%></option>
<option name = "PercentPeruvian2" value="0">0%</option>
<option name = "PercentPeruvian3" value="1/8">1/8</option>
				     <option name = "PercentPeruvian4" value="1/4">1/4</option>
				     <option name = "PercentPeruvian5" value="3/8">3/8</option>
				     <option name = "PercentPeruvian6" value="1/2">1/2</option>
				     <option name = "PercentPeruvian7" value="5/8">5/8</option>
				     <option name = "PercentPeruvian8" value="3/4">3/4</option>
				     <option name = "PercentPeruvian9" value="7/8">7/8</option>
  <option name = "PercentPeruvian10" value="Full Peruvian">Full Peruvian</option>
			 </select>
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>% Chilean:</b>&nbsp;
		</td>
		<td class="body">
				<select size="1" name="PercentChilean" class = "regsubmit2 body">
<option name = "PercentChilean1" value= "<%=PercentChilean%>" selected><%=PercentChilean%></option>
<option name = "PercentChilean2" value="0">0%</option>
<option name = "PercentChilean3" value="1/8">1/8</option>
				     <option name = "PercentChilean4" value="1/4">1/4</option>
				     <option name = "PercentChilean5" value="3/8">3/8</option>
				     <option name = "PercentChilean6" value="1/2">1/2</option>
				     <option name = "PercentChilean7" value="5/8">5/8</option>
				     <option name = "PercentChilean8" value="3/4">3/4</option>
				     <option name = "PercentChilean9" value="7/8">7/8</option>
  <option name = "PercentChilean10" value="Full Chilean">Full Chilean</option>
			 </select>
			
		</td>
		</tr>
		<tr>
		<td  class = "body2" align = "right">
			<b>% Bolivian:</b>&nbsp;
		</td>
		<td class="body">
			<select size="1" name="PercentBolivian" class = "regsubmit2 body">
<option name = "PercentBolivian1" value= "<%=PercentBolivian%>" selected><%=PercentBolivian%></option>
<option name = "PercentBolivian2" value="0">0%</option>
<option name = "PercentBolivian3" value="1/8">1/8</option>
				     <option name = "PercentBolivian4" value="1/4">1/4</option>
				     <option name = "PercentBolivian5" value="3/8">3/8</option>
				     <option name = "PercentBolivian6" value="1/2">1/2</option>
				     <option name = "PercentBolivian7" value="5/8">5/8</option>
				     <option name = "PercentBolivian8" value="3/4">3/4</option>
				     <option name = "PercentBolivian9" value="7/8">7/8</option>
  <option name = "PercentBolivian10" value="Full Bolivian">Full Bolivian</option>
			 </select>
		</td>
	</tr>
	<td  class = "body2" align = "right">
			<b>% Other:</b>&nbsp;
		</td>
	
	<td class="body">
			<select size="1" name="PercentUnknownOther" class = "regsubmit2 body">
<option name = "PercentUnknownOther1" value= "<%=PercentUnknownOther%>" selected><%=PercentUnknownOther%></option>
<option name = "PercentUnknownOther2" value="0">0%</option>
<option name = "PercentUnknownOther3" value="1/8">1/8</option>
				     <option name = "PercentUnknownOther4" value="1/4">1/4</option>
				     <option name = "PercentUnknownOther5" value="3/8">3/8</option>
				     <option name = "PercentUnknownOther6" value="1/2">1/2</option>
				     <option name = "PercentUnknownOther7" value="5/8">5/8</option>
				     <option name = "PercentUnknownOther8" value="3/4">3/4</option>
				     <option name = "PercentUnknownOther9" value="7/8">7/8</option>
  <option name = "PercentUnknownOther10" value="100% Unknown">100% Unknown or Other</option>
			 </select>
		</td>
		</tr>
		<tr>
			<td  class = "body2" align = "right">
			<b>% Accoyo:</b>&nbsp;
		</td>
		<td class="body">
			<select size="1" name="PercentAccoyo" class = "regsubmit2 body">
<option name = "PercentAccoyo1" value= "<%=PercentAccoyo%>" selected><%=PercentAccoyo%></option>
<option name = "PercentAccoyo2" value="0">0%</option>
<option name = "PercentAccoyo3" value="1/8">1/8</option>
				     <option name = "PercentAccoyo4" value="1/4">1/4</option>
				     <option name = "PercentAccoyo5" value="3/8">3/8</option>
				     <option name = "PercentAccoyo6" value="1/2">1/2</option>
				     <option name = "PercentAccoyo7" value="5/8">5/8</option>
				     <option name = "PercentAccoyo8" value="3/4">3/4</option>
				     <option name = "PercentAccoyo9" value="7/8">7/8</option>
  <option name = "PercentAccoyo10" value="Full Accoyo">Full Accoyo</option>
			 </select>
		</td>
	</tr>
	<tr>
	<td  align = "center" colspan = "2">
	<input type = "hidden" name="FormID" value= "GeneralStats">	
		<input type = "hidden" name="ID" value= "<%=  ID%>">	
	<div align = "center">
			<input type="submit" class = "regsubmit2 body" value="Submit"  >
	</div>
		</td>
</tr>
</table>
</form>	
       </td>
</tr>
</table>


	
  <% else %>
  
  
  
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>">
     <tr>
        <td class = "roundedtop" align = "left"><H2><div align = "left">Basic Facts<a name="BasicFacts"></a></div></H2></td>
     </tr>
     <tr>
        <td class = "roundedBottom" align = "center">
 <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
     <tr>
		<td>
	        <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
	<tr>
		<td width = "10">&nbsp;</td>
		<td>
			<form action= 'AdminGeneralStatsHandle.asp' method = "post" name = "g1">

            <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "100%">
			<tr>
				<td width = "300"  class = "body" align = "left">	
<br><b>Full Name:</b>
				</td>
				<td class = "body" width = "200" align = "left">
<br><b>Date of Birth:</b>
				</td>
				
			</tr>
			<tr>
				<td align = "left">
<input name="Name" size = "40" value = "<%=name%>">
				</td>
<td align = "left">
<select size="1" name="DOBMonth">
<% if not DOBMonth = "0" then %>
<option value="<%=DOBMonth%>" selected><%=DOBMonth%></option>
<% else %>
<option value="0"></option>
<% end if %>
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
<select size="1" name="DOBDay">
<% if not DOBday = "0" then %>
<option value="<%=DOBDay%>" selected><%=DOBDay%></option>
<% else %>
<option value="0"></option>
<% end if %>
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
<select size="1" name="DOBYear">
<% if not DOBYear = "0" then %>
<option value="<%=DOBYear%>" selected><%=DOBYear%></option>
<% else %>
<option value="0"></option>
<% end if %>
<% currentyear = year(date) 
For yearv=1983 To currentyear %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
		</td>
	</tr>
		</table>
		<br />
		
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

<%

dim RegistrationType(100)
dim RegistrationNumber(100)
x = 0

if len(SpeciesID) > 0 then 
 sql2 = "select * from AnimalRegistration where AnimalID=" & ID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
while not(rs2.eof)  
x = x + 1%>
<% if x = 1  or  x = 5 or  x = 13 or  x = 17  then %>
<tr>
<% end if %>
<td width = "200"  class = "body" align = "left">
<b><%=rs2("RegType")%></b><br />
<input name="RegNumber(<%=x%>)" size = "20" value="<%=rs2("RegNumber") %>">
<input name="AnimalRegistrationID(<%=x%>)" type = "hidden" value="<%=rs2("AnimalRegistrationID") %>">
</td>
<% if x = 4  or  x = 8 or  x = 12 or  x = 16 or x = (rs2.recordcount + 1) then %>
</tr>
<% end if %>
<% rs2.movenext
wend 
rs2.close 	
end if%>	

<input type = 'hidden' name="totalregistrations"  value="<%=x%>">

</table>

		
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "100%">
	<tr>

		<td class = "body" width = "400" align = "left">
			<br><b>Category:</b>
		</td>
		<td class = "body"  align = "left">
			<br><b>Breed:</b>
		</td>
	</tr>
	<tr>
<td align = "left">
<select size="1" name="Category">
<option name = "Category2" value= "<%=Category%>" selected><%=Category%></option>
<option name = "Category12" value="Experienced Male">Experienced Male<small>(gotten at least one Dam pregnant)</small></option>
<option name = "Category12" value="Inexperienced Male">Inexperienced Male<small>(never gotten a Dam pregnant)</small></option>
<option name = "Category14" value="Experienced Female">Experienced Female<small>(has been pregnant at least once.)</small></option>
<option name = "Category13" value="Inexperienced Female">Inexperienced Female<small>(has never been pregnant)</small></option>
<option name = "Category15" value="Non-Breeder">Fiber/Companion</option>
</select>
</td>
<td align = "left">
<% sql2 = "select PreferedspeciesID from SpeciesAvailable where SpeciesID= " & SpeciesID & " "
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then
 PreferedspeciesID = rs2("PreferedspeciesID")
end if
rs2.close

 sql2 = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedLookupID 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
Breed = rs2("Breed")
end if %>

<select size="1" name="Breed">	
<%if len(Breed) > 0 then %>
<option value="<%=Breed %>" selected><%=Breed %></option>
<%
end if
 sql2 = "select * from SpeciesBreedLookupTable where SpeciesID=" & speciesID
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not rs2.eof then 
while not(rs2.eof)  %>
<option value="<%=rs2("Breed")%>" class="body"><%=rs2("Breed")%></option>
<%
rs2.movenext
wend 
end if
rs2.close %>
</Select>
</td></tr></table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%">
<tr><td class = "body" width = "160" align = "left">
			<br><b>Color 1:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>Color 2:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>Color 3:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>Color 4:</b>
		</td>
			<td class = "body" width = "160" align = "left">
			<br><b>Color 5:</b>
		</td>
	</tr>
	<tr>
		<td align = "left">
			<select size="1" name="Color1" align = "left">
<option name = "color1a" value= "<%=Color1%>" selected><%=Color1%></option>
		<option name = "color1aa" value="">N/A</option>
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
		<td>
				<select size="1" name="Color2" align = "left">
<option name = "color2a" value= "<%=Color2%>" selected><%=Color2%></option>
		<option name = "color2aa" value="">N/A</option>
<option name = "color2b" value="White">White</option>
<option name = "color2c" value="Beige">Beige</option>
<option name = "color2d" value="Light Fawn">Light Fawn</option>
<option name = "color2e" value="Medium Fawn">Medium Fawn</option>
<option name = "color2f" value="Dark Fawn">Dark Fawn</option>
<option name = "color2g" value="Light Brown">Light Brown</option>
<option name = "color2h" value="Medium Brown">Medium Brown</option>
<option name = "color2i" value="Dark Brown">Dark Brown</option>
<option name = "color2j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color2k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color2l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color2m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color2n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color2o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color2p" value="Bay Black">Bay Black</option>
<option name = "color2q" value="True Black">True Black</option>
</select>
		</td>

		<td>
			<select size="1" name="Color3" align = "left">
<option name = "color3a" value= "<%=Color3%>" selected><%=Color3%></option>
		<option name = "color3aa" value="">N/A</option>
<option name = "color3b" value="White">White</option>
<option name = "color3c" value="Beige">Beige</option>
<option name = "color3d" value="Light Fawn">Light Fawn</option>
<option name = "color3e" value="Medium Fawn">Medium Fawn</option>
<option name = "color3f" value="Dark Fawn">Dark Fawn</option>
<option name = "color3g" value="Light Brown">Light Brown</option>
<option name = "color3h" value="Medium Brown">Medium Brown</option>
<option name = "color3i" value="Dark Brown">Dark Brown</option>
<option name = "color3j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color3k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color3l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color3m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color3n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color3o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color3p" value="Bay Black">Bay Black</option>
<option name = "color3q" value="True Black">True Black</option>
</select>
		</td>
		<td>
			<select size="1" name="Color4" align = "left">
<option name = "color4a" value= "<%=Color4%>" selected><%=Color4%></option>
<option name = "color4aa" value="">N/A</option>
<option name = "color4b" value="White">White</option>
<option name = "color4c" value="Beige">Beige</option>
<option name = "color4d" value="Light Fawn">Light Fawn</option>
<option name = "color4e" value="Medium Fawn">Medium Fawn</option>
<option name = "color4f" value="Dark Fawn">Dark Fawn</option>
<option name = "color4g" value="Light Brown">Light Brown</option>
<option name = "color4h" value="Medium Brown">Medium Brown</option>
<option name = "color4i" value="Dark Brown">Dark Brown</option>
<option name = "color4j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color4k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color4l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color4m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color4n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color4o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color4p" value="Bay Black">Bay Black</option>
<option name = "color4q" value="True Black">True Black</option>
</select>
		</td>
		<td>
			<select size="1" name="Color5" align = "left">
<option name = "color5a" value= "<%=Color5%>" selected><%=Color5%></option>
<option name = "color5aa" value="">N/A</option>
<option name = "color5b" value="White">White</option>
<option name = "color5c" value="Beige">Beige</option>
<option name = "color5d" value="Light Fawn">Light Fawn</option>
<option name = "color5e" value="Medium Fawn">Medium Fawn</option>
<option name = "color5f" value="Dark Fawn">Dark Fawn</option>
<option name = "color5g" value="Light Brown">Light Brown</option>
<option name = "color5h" value="Medium Brown">Medium Brown</option>
<option name = "color5i" value="Dark Brown">Dark Brown</option>
<option name = "color5j" value="Light Silver Grey">Light Silver Grey</option>
<option name = "color5k" value="Medium Silver Grey">Medium Silver Grey</option>
<option name = "color5l" value="Dark Silver Grey">Dark Silver Grey</option>
<option name = "color5m" value="Light Rose Grey">Light Rose Grey</option>
<option name = "color5n" value="Medium Rose Grey">Medium Rose Grey</option>
<option name = "color5o" value="Dark Rose Grey">Dark Rose Grey</option>
<option name = "color5p" value="Bay Black">Bay Black</option>
<option name = "color5q" value="True Black">True Black</option>
</select>
		</td>
	</tr>
</table>
<% if SpeciesID = 2 then %>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%">
	<tr>
		<td class = "body" width = "160" align = "left">
			<br><b>% US:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>% Canadian:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>% Peruvian:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>% Chilean:</b>
		</td>
		<td class = "body" width = "160" align = "left">
			<br><b>% Bolivian:</b>
		</td>

		<td class = "body" width = "160" align = "left">
			<br><b>% Other/Unknown:</b>
		</td>
			<td class = "body" width = "160" align = "left">
			<br><b>% Accoyo:</b>
		</td>
	</tr>
<% end if %>
	
	
	<tr>
	<td align = "left">
		<select size="1" name="PercentUSA">
<option name = "PercentUSA" value= "<%=PercentUSA%>" selected><%=PercentUSA%></option>
<option name = "PercentUSA2" value="0">0%</option>
<option name = "PercentUSA3" value="1/8">1/8</option>
				     <option name = "PercentUSA4" value="1/4">1/4</option>
				     <option name = "PercentUSA5" value="3/8">3/8</option>
				     <option name = "PercentUSA6" value="1/2">1/2</option>
				     <option name = "PercentUSA7" value="5/8">5/8</option>
				     <option name = "PercentUSA8" value="3/4">3/4</option>
				     <option name = "PercentUSA9" value="7/8">7/8</option>
  <option name = "PercentUSA" value="Full US">Full USA</option>
			 </select>
		</td>
			<td align = "left">
		<select size="1" name="PercentCanadian">
<option name = "PercentCanadian" value= "<%=PercentCanadian%>" selected><%=PercentCanadian%></option>
<option name = "PercentCanadian2" value="0">0%</option>
<option name = "PercentCanadian3" value="1/8">1/8</option>
				     <option name = "PercentCanadian4" value="1/4">1/4</option>
				     <option name = "PercentCanadian5" value="3/8">3/8</option>
				     <option name = "PercentCanadian6" value="1/2">1/2</option>
				     <option name = "PercentCanadian7" value="5/8">5/8</option>
				     <option name = "PercentCanadian8" value="3/4">3/4</option>
				     <option name = "PercentCanadian9" value="7/8">7/8</option>
  <option name = "PercentCanadian" value="Full Canadian">Full Canadian</option>
			 </select>
		</td>
		<td align = "left">
		<select size="1" name="PercentPeruvian">
<option name = "PercentPeruvian" value= "<%=PercentPeruvian%>" selected><%=PercentPeruvian%></option>
<option name = "PercentPeruvian2" value="0">0%</option>
<option name = "PercentPeruvian3" value="1/8">1/8</option>
				     <option name = "PercentPeruvian4" value="1/4">1/4</option>
				     <option name = "PercentPeruvian5" value="3/8">3/8</option>
				     <option name = "PercentPeruvian6" value="1/2">1/2</option>
				     <option name = "PercentPeruvian7" value="5/8">5/8</option>
				     <option name = "PercentPeruvian8" value="3/4">3/4</option>
				     <option name = "PercentPeruvian9" value="7/8">7/8</option>
  <option name = "PercentPeruvian10" value="Full Peruvian">Full Peruvian</option>
			 </select>
		</td>
		<td align = "left">
				<select size="1" name="PercentChilean">
<option name = "PercentChilean1" value= "<%=PercentChilean%>" selected><%=PercentChilean%></option>
<option name = "PercentChilean2" value="0">0%</option>
<option name = "PercentChilean3" value="1/8">1/8</option>
				     <option name = "PercentChilean4" value="1/4">1/4</option>
				     <option name = "PercentChilean5" value="3/8">3/8</option>
				     <option name = "PercentChilean6" value="1/2">1/2</option>
				     <option name = "PercentChilean7" value="5/8">5/8</option>
				     <option name = "PercentChilean8" value="3/4">3/4</option>
				     <option name = "PercentChilean9" value="7/8">7/8</option>
  <option name = "PercentChilean10" value="Full Chilean">Full Chilean</option>
			 </select>
			
		</td>
		<td align = "left">
			<select size="1" name="PercentBolivian">
<option name = "PercentBolivian1" value= "<%=PercentBolivian%>" selected><%=PercentBolivian%></option>
<option name = "PercentBolivian2" value="0">0%</option>
<option name = "PercentBolivian3" value="1/8">1/8</option>
				     <option name = "PercentBolivian4" value="1/4">1/4</option>
				     <option name = "PercentBolivian5" value="3/8">3/8</option>
				     <option name = "PercentBolivian6" value="1/2">1/2</option>
				     <option name = "PercentBolivian7" value="5/8">5/8</option>
				     <option name = "PercentBolivian8" value="3/4">3/4</option>
				     <option name = "PercentBolivian9" value="7/8">7/8</option>
  <option name = "PercentBolivian10" value="Full Bolivian">Full Bolivian</option>
			 </select>
		</td>
		
	
	<td align = "left">
			<select size="1" name="PercentUnknownOther">
<option name = "PercentUnknownOther1" value= "<%=PercentUnknownOther%>" selected><%=PercentUnknownOther%></option>
<option name = "PercentUnknownOther2" value="0">0%</option>
<option name = "PercentUnknownOther3" value="1/8">1/8</option>
				     <option name = "PercentUnknownOther4" value="1/4">1/4</option>
				     <option name = "PercentUnknownOther5" value="3/8">3/8</option>
				     <option name = "PercentUnknownOther6" value="1/2">1/2</option>
				     <option name = "PercentUnknownOther7" value="5/8">5/8</option>
				     <option name = "PercentUnknownOther8" value="3/4">3/4</option>
				     <option name = "PercentUnknownOther9" value="7/8">7/8</option>
  <option name = "PercentUnknownOther10" value="100% Unknown">100% Unknown or Other</option>
			 </select>
		</td>
		<td align = "left">
			<select size="1" name="PercentAccoyo">
<option name = "PercentAccoyo1" value= "<%=PercentAccoyo%>" selected><%=PercentAccoyo%></option>
<option name = "PercentAccoyo2" value="0">0%</option>
<option name = "PercentAccoyo3" value="1/8">1/8</option>
				     <option name = "PercentAccoyo4" value="1/4">1/4</option>
				     <option name = "PercentAccoyo5" value="3/8">3/8</option>
				     <option name = "PercentAccoyo6" value="1/2">1/2</option>
				     <option name = "PercentAccoyo7" value="5/8">5/8</option>
				     <option name = "PercentAccoyo8" value="3/4">3/4</option>
				     <option name = "PercentAccoyo9" value="7/8">7/8</option>
  <option name = "PercentAccoyo10" value="Full Accoyo">Full Accoyo</option>
			 </select>
		</td>
	</tr>
</table>


<br></td>
	</tr>
	</table>	
<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
	<td  align = "center">
	<input type = "hidden" name="FormID" value= "GeneralStats">	
		<input type = "hidden" name="ID" value= "<%=  ID%>">	
	<div align = "center">
	
			<input type="submit" class = "regsubmit2" value="Submit"  >
	</div>
		</td>
</tr>
</table></td>
</tr>
</table>
</td>
</tr>
</table>			
</form>	
             		
<% 
end if
'rs.close %>
