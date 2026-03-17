<%  
sql2 = "select * from SpeciesAvailable where  SpeciesID = " & SpeciesID 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
SireTerm = rs2("SireTerm")
DamTerm = rs2("DamTerm")
rs2.close

dim aID(60)
dim aName(60)

	sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID =" & PeopleID & " order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
   if not rs2.eof then
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
	'	response.write ("acounter=" & acounter)

		acounter = acounter +1
		rs2.movenext
	Wend		
	end if
		rs2.close
		set rs2=nothing

				
dim damsID(60)
dim damsName(60)

damscounter = 1
	sqldams = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Female' or category  = 'Inexperienced Female' ) and PeopleID = " & PeopleID & "  order by Fullname"
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
	sqlsires = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Male' or category  = 'Inexperienced Male')  and PeopleID = " & PeopleID & " order by Fullname"
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

	
%>



<a name="Ancestry"></a>
 
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width= "900"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Ancestry</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "800">
	<form action= 'MembersAncestryHandleForm2.asp' method = "post">

<tr><td rowspan="4" nowrap class = "list" align = "left"><b><%=SireTerm%></b><%
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
%><!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" nowrap class = "list" align = "left"><br />

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
				
	<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
    			<td nowrap class = "list" align = "left"><br />
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
				
		<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
		</tr>
  		<tr> 
    			<td class = "list" align = "left"><br />
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
				
		<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
		</tr>
		<tr> 
    			<td rowspan="2" class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
    			<td class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td class = "list" align = "left"><br />

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
				
	<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="4" class = "list" align = "left"><br /><b><%=DamTerm%></b>
  
				  		

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
				
	<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
    			<td rowspan="2" class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->
			</td>
    			<td class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->
			</td>
  		</tr>
  		<tr> 
    			<td class = "list" align = "left"><br />

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
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
  		<tr> 
    			<td rowspan="2" class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->
			</td>
    			<td class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->
			</td>
  		</tr>
  		<tr> 
    			<td class = "list" align = "left"><br />

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
				
<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

			</td>
  		</tr>
	</table>


<table width = "850" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>
	<td  align = "Right">
			<Input type = Hidden name='ID' value = <%=ID%> >
			<input type=submit value = "Submit" class = "regsubmit2" >
			
		</td>
</tr>
</table></form>

	</td>
</tr>
</table>

