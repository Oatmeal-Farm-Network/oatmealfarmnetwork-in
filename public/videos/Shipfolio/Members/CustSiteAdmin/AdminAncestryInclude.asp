<%  
dim aID(60)
dim aName(60)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close

   
    			
dim damsID(60)
dim damsName(60)

damscounter = 1
	sqldams = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Female' or category  = 'Inexperienced Female' )   order by Fullname"
	Set rsdams = Server.CreateObject("ADODB.Recordset")
	rsdams.Open sqldams, conn, 3, 3 

While Not rsdams.eof  
		damsID(damscounter) = rsdams("ID")
		damsName(damscounter) = rsdams("FullName")
		'response.write (SSName(studcounter))

		damscounter = damscounter +1
		rsdams.movenext
	Wend		
	
		rsdams.close
		set rsdams=nothing

dim siresID(60)
dim siresName(60)

sirescounter = 1
	sqlsires = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Male' or category  = 'Inexperienced Male') order by Fullname"
	Set rssires = Server.CreateObject("ADODB.Recordset")
	rssires.Open sqlsires, conn, 3, 3 
'response.write(sqlsires)
	While Not rssires.eof  
			siresID(sirescounter) = rssires("ID")
			siresName(sirescounter) = rssires("FullName")

			sirescounter = sirescounter +1
			rssires.movenext
		Wend		
	
		rssires.close
		set rssires=nothing

dim OSID(60)
dim OSName(60)

	OSsql =  "select ExternalStud.ExternalStudID, ExternalStud.ExternalStudName from ExternalStud"

		OScounter = 1
		Set OSrs = Server.CreateObject("ADODB.Recordset")
		OSrs.Open OSsql, conn, 3, 3 
	
		While Not OSrs.eof  
		  OSID(OScounter) = OSrs("ExternalStudID")
		  OSName(OScounter) = OSrs("ExternalStudName")

		  OScounter = OScounter +1
		  OSrs.movenext
		Wend		
	
		OSrs.close
		set OSrs=nothing
		
 if mobiledevice = true or screenwidth < 800 then
 
 	 if mobiledevice = true	then
%>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<% screenwidth %>">
<tr><td align = "left">
<% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 50 %>"><tr><td class = "roundedtop" align = "left">
<% end if %>
<H2><div align = "left"><a name="Ancestry"></a>Ancestry</div></H2>
</td></tr>
<tr><td class=body >Show on Progeny page for:<br />
Sire: <%=ShowwithSire %><br />
Dam: <%=ShowwithDam %><br />
</td></tr>
<tr><td  align = "center" width = "100%">
<form action= 'AdminAncestryhandleform2.asp' method = "post">
<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
<tr><td nowrap class = "body" ><b>Sire</b><%
Ancestorname = Sire
AncestorColor = SireColor
AncestorARI = SireARI
AncestorCLAA = SireCLAA
AncestorLink = SireLink

AncestornameField = "Sire"
AncestorColorField = "SireColor"
AncestorARIField = "SireARI"
AncestorCLAAField = "SireCLAA"
AncestorLinkField = "SireLink"

gender = "male"



%><!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->

</td>
</tr>
<tr>
  		<td nowrap class = "body"><b>Paternal Grandsire</b>

				<%
Ancestorname = SireSire
AncestorColor = SireSireColor
AncestorARI = SireSireARI
AncestorCLAA = SireSireCLAA
AncestorLink = SireSireLink

AncestornameField = "SireSire"
AncestorColorField = "SireSireColor"
AncestorARIField = "SireSireARI"
AncestorCLAAField = "SireSireCLAA"
AncestorLinkField = "SireSireLink"
gender = "male"
%>
				
	<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->

			</td>
</tr>
<tr> 
  <td nowrapclass = "body"><b>Paternal Great Grandsire</b>
				<%
Ancestorname = SireSireSire
AncestorColor = SireSireSireColor
AncestorARI = SireSireSireARI
AncestorCLAA = SireSireSireCLAA
AncestorLink = SireSireSireLink

AncestornameField = "SireSireSire"
AncestorColorField = "SireSireSireColor"
AncestorARIField = "SireSireSireARI"
AncestorCLAAField = "SireSireSireCLAA"
AncestorLinkField = "SireSireSireLink"
gender = "male"
%>
				
		<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->

</td>
</tr>
<tr> 
<td class = "body"><b>Paternal Great Granddam</b>
				<%
Ancestorname = SireSireDam
AncestorColor = SireSireDamColor
AncestorARI = SireSireDamARI
AncestorCLAA = SireSireDamCLAA
AncestorLink = SireSireDamLink

AncestornameField = "SireSireDam"
AncestorColorField = "SireSireDamColor"
AncestorARIField = "SireSireDamARI"
AncestorCLAAField = "SireSireDamCLAA"
AncestorLinkField = "SireSireDamLink"
gender = "female"
%>
				
		<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Paternal Granddam</b>
<%
Ancestorname = SireDam
AncestorColor = SireDamColor
AncestorARI = SireDamARI
AncestorCLAA = SireDamCLAA
AncestorLink = SireDamLink

AncestornameField = "SireDam"
AncestorColorField = "SireDamColor"
AncestorARIField = "SireDamARI"
AncestorCLAAField = "SireDamCLAA"
AncestorLinkField = "SireDamLink"
gender = "female"
%>
				
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body" ><b>Paternal Grandsire</b>
<%
Ancestorname = SireDamSire
AncestorColor = SireDamSireColor
AncestorARI = SireDamSireARI
AncestorCLAA = SireDamSireCLAA
AncestorLink = SireDamSireLink

AncestornameField = "SireDamSire"
AncestorColorField = "SireDamSireColor"
AncestorARIField = "SireDamSireARI"
AncestorCLAAField = "SireDamSireCLAA"
AncestorLinkField = "SireDamSireLink"
gender = "male"
%>
				
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->

</td>
</tr>
<tr> 
<td class = "body"><b>Paternal Great Granddam</b>

				<%
Ancestorname = SireDamDam
AncestorColor = SireDamDamColor
AncestorARI = SireDamDamARI
AncestorCLAA = SireDamDamCLAA
AncestorLink = SireDamDamLink

AncestornameField = "SireDamDam"
AncestorColorField = "SireDamDamColor"
AncestorARIField = "SireDamDamARI"
AncestorCLAAField = "SireDamDamCLAA"
AncestorLinkField = "SireDamDamLink"
gender = "female"
%>
				
	<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td class = "body" ><b>Dam</b>
<%
Ancestorname = dam
AncestorColor = DamColor
AncestorARI = DamARI
AncestorCLAA = DamCLAA
AncestorLink = DamLink

AncestornameField = "dam"
AncestorColorField = "DamColor"
AncestorARIField = "DamARI"
AncestorCLAAField = "DamCLAA"
AncestorLinkField = "DamLink"
gender = "female"
%>
				
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Grandsire</b>

				<%
Ancestorname = DamSire
AncestorColor =DamSireColor
AncestorARI = DamSireARI
AncestorCLAA = DamSireCLAA
AncestorLink = DamSireLink

AncestornameField = "DamSire"
AncestorColorField = "DamSireColor"
AncestorARIField = "DamSireARI"
AncestorCLAAField = "DamSireCLAA"
AncestorLinkField = "DamSireLink"
gender = "male"
%>
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Great Grandsire</b>
<%
Ancestorname = DamSireSire
AncestorColor = DamSireSireColor
AncestorARI = DamSireSireARI
AncestorCLAA = DamSireSireCLAA
AncestorLink = DamSireSireLink

AncestornameField = "DamSireSire"
AncestorColorField = "DamSireSireColor"
AncestorARIField = "DamSireSireARI"
AncestorCLAAField = "DamSireSireCLAA"
AncestorLinkField = "DamSireSireLink"

gender = "male"
%>
				
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Great Granddam</b>
<%
Ancestorname = DamSireDam
AncestorColor = DamSireDamColor
AncestorARI = DamSireDamARI
AncestorCLAA = DamSireDamCLAA
AncestorLink = DamSireDamLink

AncestornameField = "DamSireDam"
AncestorColorField = "DamSireDamColor"
AncestorARIField = "DamSireDamARI"
AncestorCLAAField = "DamSireDamCLAA"
AncestorLinkField = "DamSireDamLink"
gender = "female"

%>
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Granddam</b>
<%
Ancestorname = DamDam
AncestorColor = DamDamColor
AncestorARI = DamDamARI
AncestorCLAA = DamDamCLAA
AncestorLink = DamDamLink

AncestornameField = "DamDam"
AncestorColorField = "DamDamColor"
AncestorARIField = "DamDamARI"
AncestorCLAAField = "DamDamCLAA"
AncestorLinkField = "DamDamLink"
gender = "female"
%>
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Great Grandsire</b>
<%
Ancestorname = DamDamSire
AncestorColor = DamDamSireColor
AncestorARI = DamDamSireARI
AncestorCLAA = DamDamSireCLAA
AncestorLink = DamDamSireLink

AncestornameField = "DamDamSire"
AncestorColorField = "DamDamSireColor"
AncestorARIField = "DamDamSireARI"
AncestorCLAAField = "DamDamSireCLAA"
AncestorLinkField = "DamDamSireLink"
gender = "male"
%>
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td>
</tr>
<tr> 
<td class = "body"><b>Maternal Great Granddam</b>
<%
Ancestorname = DamDamDam
AncestorColor = DamDamDamColor
AncestorARI = DamDamDamARI
AncestorCLAA = DamDamDamCLAA
AncestorLink = DamDamDamLink

AncestornameField = "DamDamDam"
AncestorColorField = "DamDamDamColor"
AncestorARIField = "DamDamDamARI"
AncestorCLAAField = "DamDamDamCLAA"
AncestorLinkField = "DamDamDamLink"
gender = "female"
%>
<!--#Include File="AdminMobileAncestorEditDetailsInclude.asp"-->
</td></tr>
<tr><td  align = "center">
<Input type = Hidden name='ID' value = <%=ID%> >
<div align = "center">
<input type="submit" class = "regsubmit2 body" value="Submit"  ></div>
</td></tr></table></form>
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left"><a name="Ancestry"></a>Ancestry</div></H2>
</td></tr><form action= 'AdminAncestryhandleform2.asp' method = "post">
<tr><td class = "roundedBottom" align = "center" width = "920">
<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
<tr><td class=body >Show on Progeny page for: &nbsp;<br>
Sire: <% if ShowwithSire= "Yes" Or ShowwithSire = True Then %>
Yes<input TYPE="RADIO" name="ShowwithSire" Value = "Yes" checked>
No<input TYPE="RADIO" name="ShowwithSire" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="ShowwithSire" Value = "Yes" >
No<input TYPE="RADIO" name="ShowwithSire" Value = "No" checked>
<% End If %>
&nbsp;&nbsp;
Dam: <% if ShowwithDam= "Yes" Or ShowwithDam = True Then %>
Yes<input TYPE="RADIO" name="ShowwithDam" Value = "Yes" checked>
No<input TYPE="RADIO" name="ShowwithDam" Value = "No" >
<% Else %>
Yes<input TYPE="RADIO" name="ShowwithDam" Value = "Yes" >
No<input TYPE="RADIO" name="ShowwithDam" Value = "No" checked>
<% End If %>
</td></tr>

<tr><td rowspan="4" nowrap class = "list" ><b>Sire</b><%
Ancestorname = Sire
AncestorColor = SireColor
AncestorARI = SireARI
AncestorCLAA = SireCLAA
AncestorLink = SireLink

AncestornameField = "Sire"
AncestorColorField = "SireColor"
AncestorARIField = "SireARI"
AncestorCLAAField = "SireCLAA"
AncestorLinkField = "SireLink"
gender = "male"
%><!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" nowrap class = "list"><b>Paternal Grandsire</b>

				<%
Ancestorname = SireSire
AncestorColor = SireSireColor
AncestorARI = SireSireARI
AncestorCLAA = SireSireCLAA
AncestorLink = SireSireLink

AncestornameField = "SireSire"
AncestorColorField = "SireSireColor"
AncestorARIField = "SireSireARI"
AncestorCLAAField = "SireSireCLAA"
AncestorLinkField = "SireSireLink"
gender = "male"
%>
				
	<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
    			<td nowrap class = "list"><b>Paternal Great Grandsire</b>
				<%
Ancestorname = SireSireSire
AncestorColor = SireSireSireColor
AncestorARI = SireSireSireARI
AncestorCLAA = SireSireSireCLAA
AncestorLink = SireSireSireLink

AncestornameField = "SireSireSire"
AncestorColorField = "SireSireSireColor"
AncestorARIField = "SireSireSireARI"
AncestorCLAAField = "SireSireSireCLAA"
AncestorLinkField = "SireSireSireLink"
gender = "male"
%>
				
		<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
		</tr>
  		<tr> 
    			<td class = "list"><b>Paternal Great Granddam</b>
				<%
Ancestorname = SireSireDam
AncestorColor = SireSireDamColor
AncestorARI = SireSireDamARI
AncestorCLAA = SireSireDamCLAA
AncestorLink = SireSireDamLink

AncestornameField = "SireSireDam"
AncestorColorField = "SireSireDamColor"
AncestorARIField = "SireSireDamARI"
AncestorCLAAField = "SireSireDamCLAA"
AncestorLinkField = "SireSireDamLink"
gender = "female"
%>
				
		<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
		</tr>
		<tr> 
    			<td rowspan="2" class = "list"><b>Paternal Granddam</b>

				<%
Ancestorname = SireDam
AncestorColor = SireDamColor
AncestorARI = SireDamARI
AncestorCLAA = SireDamCLAA
AncestorLink = SireDamLink

AncestornameField = "SireDam"
AncestorColorField = "SireDamColor"
AncestorARIField = "SireDamARI"
AncestorCLAAField = "SireDamCLAA"
AncestorLinkField = "SireDamLink"
gender = "female"
%>
				
<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
    			<td class = "list" ><b>Paternal Grandsire</b>

				<%
Ancestorname = SireDamSire
AncestorColor = SireDamSireColor
AncestorARI = SireDamSireARI
AncestorCLAA = SireDamSireCLAA
AncestorLink = SireDamSireLink

AncestornameField = "SireDamSire"
AncestorColorField = "SireDamSireColor"
AncestorARIField = "SireDamSireARI"
AncestorCLAAField = "SireDamSireCLAA"
AncestorLinkField = "SireDamSireLink"
gender = "male"
%>
				
<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td class = "list"><b>Paternal Great Granddam</b>

				<%
Ancestorname = SireDamDam
AncestorColor = SireDamDamColor
AncestorARI = SireDamDamARI
AncestorCLAA = SireDamDamCLAA
AncestorLink = SireDamDamLink

AncestornameField = "SireDamDam"
AncestorColorField = "SireDamDamColor"
AncestorARIField = "SireDamDamARI"
AncestorCLAAField = "SireDamDamCLAA"
AncestorLinkField = "SireDamDamLink"
gender = "female"
%>
				
	<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="4" class = "list" ><b>Dam</b>
  
				  		

				<%
Ancestorname = dam
AncestorColor = DamColor
AncestorARI = DamARI
AncestorCLAA = DamCLAA
AncestorLink = DamLink

AncestornameField = "dam"
AncestorColorField = "DamColor"
AncestorARIField = "DamARI"
AncestorCLAAField = "DamCLAA"
AncestorLinkField = "DamLink"
gender = "female"
%>
				
										<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" class = "list"><b>Maternal Grandsire</b>

				<%
Ancestorname = DamSire
AncestorColor =DamSireColor
AncestorARI = DamSireARI
AncestorCLAA = DamSireCLAA
AncestorLink = DamSireLink

AncestornameField = "DamSire"
AncestorColorField = "DamSireColor"
AncestorARIField = "DamSireARI"
AncestorCLAAField = "DamSireCLAA"
AncestorLinkField = "DamSireLink"
gender = "male"
%>
				
											<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->
			</td>
    			<td class = "list"><b>Maternal Great Grandsire</b>

				<%
Ancestorname = DamSireSire
AncestorColor = DamSireSireColor
AncestorARI = DamSireSireARI
AncestorCLAA = DamSireSireCLAA
AncestorLink = DamSireSireLink

AncestornameField = "DamSireSire"
AncestorColorField = "DamSireSireColor"
AncestorARIField = "DamSireSireARI"
AncestorCLAAField = "DamSireSireCLAA"
AncestorLinkField = "DamSireSireLink"

gender = "male"
%>
				
										<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->
			</td>
  		</tr>
  		<tr> 
    			<td class = "list"><b>Maternal Great Granddam</b>

				<%
Ancestorname = DamSireDam
AncestorColor = DamSireDamColor
AncestorARI = DamSireDamARI
AncestorCLAA = DamSireDamCLAA
AncestorLink = DamSireDamLink

AncestornameField = "DamSireDam"
AncestorColorField = "DamSireDamColor"
AncestorARIField = "DamSireDamARI"
AncestorCLAAField = "DamSireDamCLAA"
AncestorLinkField = "DamSireDamLink"
gender = "female"

%>
											<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="2" class = "list"><b>Maternal Granddam</b>

				<%
Ancestorname = DamDam
AncestorColor = DamDamColor
AncestorARI = DamDamARI
AncestorCLAA = DamDamCLAA
AncestorLink = DamDamLink

AncestornameField = "DamDam"
AncestorColorField = "DamDamColor"
AncestorARIField = "DamDamARI"
AncestorCLAAField = "DamDamCLAA"
AncestorLinkField = "DamDamLink"
gender = "female"
%>
				
											<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->
			</td>
    			<td class = "list"><b>Maternal Great Grandsire</b>

				<%
Ancestorname = DamDamSire
AncestorColor = DamDamSireColor
AncestorARI = DamDamSireARI
AncestorCLAA = DamDamSireCLAA
AncestorLink = DamDamSireLink

AncestornameField = "DamDamSire"
AncestorColorField = "DamDamSireColor"
AncestorARIField = "DamDamSireARI"
AncestorCLAAField = "DamDamSireCLAA"
AncestorLinkField = "DamDamSireLink"
gender = "male"
%>
				
											<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->
			</td>
  		</tr>
  		<tr> 
    			<td class = "list"><b>Maternal Great Granddam</b>

				<%
Ancestorname = DamDamDam
AncestorColor = DamDamDamColor
AncestorARI = DamDamDamARI
AncestorCLAA = DamDamDamCLAA
AncestorLink = DamDamDamLink

AncestornameField = "DamDamDam"
AncestorColorField = "DamDamDamColor"
AncestorARIField = "DamDamDamARI"
AncestorCLAAField = "DamDamDamCLAA"
AncestorLinkField = "DamDamDamLink"
gender = "female"
%>
				
										<!--#Include File="AdminAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
	</table>


<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<tr>
	<td  align = "center">
			<Input type = Hidden name='ID' value = <%=ID%> >
<div align = "center">

			<input type="submit" class = "regsubmit2" value="Submit"  ></div>
			
		</td>
</tr>
</table></form>
		</td>
</tr>
</table>





<% end if %>