<%conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rsa = Server.CreateObject("ADODB.Recordset")
			
			sql = "select AncestryPercents.* from AncestryPercents where id = " & ID
				'response.write(sql)
				rsa.Open sql, conn, 3, 3
PercentPeruvian = rsa("PercentPeruvian")
PercentBolivian  = rsa("PercentBolivian")
PercentChilean = rsa("PercentChilean")
PercentUnknownOther = rsa("PercentUnknownOther")
PercentAccoyo = rsa("PercentAccoyo")
PercentUSA = rsa("PercentUSA")
				rsA.close

%>

<table border="0" cellspacing="2" width = "<%=TextWidth%>" align = "center" >
<tr>
					<td align= "center" class = "body"><h2>Ancestry</h2>	</td>
				</tr>
				<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1" colspan = "3"><img src = "images/px.gif" height = "1"></td>
			</tr>
		<tr>
			<td   valign = "top" height = "2" valign = "bottom" ><img src = "images/px.gif" height = "2" border = "0"></td>
		</tr>
</table>
<table border="0" cellspacing="2" width = "<%=TextWidth%>" align = "center" >
<tr>
					<td align= "center" class = "body">


					<% If PercentAccoyo = "Full Accoyo" then %>
							<b>Full Accoyo</b>
					
					<%else If Len(PercentAccoyo) > 1 And  Len(PercentAccoyo) < 5  then %>
							<b><%=PercentAccoyo%> Accoyo</b>
					<% End If %>
					&nbsp;
				<% End If %>

					<% If PercentPeruvian = "FullPeruvian" Or PercentPeruvian = "Full Peruvian" then %>
							<b>Full Peruvian</b>
					
					<%else If Len(PercentPeruvian) > 1 And  Len(PercentPeruvian) < 5  then %>
							<b><%=PercentPeruvian%> Peruvian</b>
					<% End If %>
					&nbsp;
				<% End If %>

			<% 
			
			If PercentUSA = "Full USA" then %>
							<b>Full USA</b>
					
					<%else If Len(PercentUSA) > 1 And  Len(PercentUSA) < 5  then %>
							<b><%=PercentUSA%> USA</b>
					<% End If %>
					&nbsp;
				<% End If %>

				<% If PercentBolivian = "Full Bolivian" then %>
							<b>Full Bolivian</b>
					
					<%else If Len(PercentBolivian) > 1 And  Len(PercentBolivian) < 5  then %>
							<b><%=PercentBolivian%> Bolivian</b>
					<% End If %>
					&nbsp;
				<% End If %>

				<% If PercentChilean = "Full Chilean" then %>
							<b>Full Chilean</b>
					
					<%else If Len(PercentChilean) > 1 And  Len(PercentChilean) < 5  then %>
							<b><%=PercentChilean%> Chilean</b>
					<% End If %>
					&nbsp;
				<% End If %>

				<% If PercentUnknownOther = "100% Unknown" then %>
							<b>Ancestry Origins Unknown / Other</b>
					
					<%else If Len(PercentUnknownOther) > 1 And  Len(PercentUnknownOther) < 5  then %>
							<b><%=PercentUnknownOther%> Unknown/Other</b>
					<% End If %>
					&nbsp;
				<% End If %>


</td>
				</tr>
		<tr>
			<td   valign = "top" height = "2" valign = "bottom" ><img src = "images/px.gif" height = "2" border = "0"></td>
		</tr>
</table>
<table border="0" cellspacing="2" width = "<%=TextWidth%>" align = "center" >
  		<tr> 
    	
    			<td rowspan="4" class = "small">Sire<br>
				<%
Ancestorname = Sire
AncestorColor = SireColor
AncestorARI = SireARI
AncestorCLAA = SireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" nowrap>
				<br>
				<%
Ancestorname = SireSire
AncestorColor = SireSireColor
AncestorARI = SireSireARI
AncestorCLAA = SireSireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td nowrap>
				<br>
				<%
Ancestorname = SireSireSire
AncestorColor = SireSireSireColor
AncestorARI = SireSireSireARI
AncestorCLAA = SireSireSireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = SireSireDam
AncestorColor = SireSireDamColor
AncestorARI = SireSireDamARI
AncestorCLAA = SireSireDamCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
		</tr>
		<tr> 
    			<td rowspan="2"><br>
				<%
Ancestorname = SireDam
AncestorColor = SireDamColor
AncestorARI = SireDamARI
AncestorCLAA = SireDamCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = SireDamSire
AncestorColor = SireDamSireColor
AncestorARI = SireDamSireARI
AncestorCLAA = SireDamSireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = SireDamDam
AncestorColor = SireDamDamColor
AncestorARI = SireDamDamARI
AncestorCLAA = SireDamDamCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="4" class = "small">Dam<br>
				<%
Ancestorname = dam
AncestorColor = DamColor
AncestorARI = DamARI
AncestorCLAA = DamCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td rowspan="2"><br>
				<%
Ancestorname = DamSire
AncestorColor =DamSireColor
AncestorARI = DamSireARI
AncestorCLAA = DamSireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = DamSireSire
AncestorColor = DamSireSireColor
AncestorARI =DamSireSireARI
AncestorCLAA = SireSireSireCLAA
%>
				
				<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = DamSireDam
AncestorColor = DamSireDamColor
AncestorARI = DamSireDamARI
AncestorCLAA = DamSireDamCLAA
%>
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="2"><br>
				<%
Ancestorname = DamDam
AncestorColor = DamDamColor
AncestorARI = DamDamARI
AncestorCLAA = DamDamCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
    			<td><br>
				<%
Ancestorname = DamDamSire
AncestorColor = DamDamSireColor
AncestorARI = DamDamSireARI
AncestorCLAA = DamDamSireCLAA
%>
				
					<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td><br>
				<%
Ancestorname = DamDamDam
AncestorColor = DamDamDamColor
AncestorARI = DamDamDamARI
AncestorCLAA = DamDamDamCLAA
%>
				
				<!--#Include file = "AncestorDetailsInclude.asp"-->

			</td>
  		</tr>
	</table>



