<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="MembersGlobalVariables.asp"-->
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
</head>
<body>

<%
Set rs = Server.CreateObject("ADODB.Recordset")
ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if

SpeciesID = request.QueryString("SpeciesID")
if len(SpeciesID) < 1 then
SpeciesID = Request.Form("SpeciesID")
end if
'response.write("speciesid = " & speciesid )
sql2 = "select SireTerm, DamTerm from SpeciesAvailable where SpeciesID = " & SpeciesID 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, connLOA, 3, 3 
SireTerm = rs2("SireTerm")
DamTerm = rs2("DamTerm")
rs2.close

dim aID(60)
dim aName(60)

	sql2 = "select Animals.ID, Animals.FullName from Animals where speciesid =" & speciesID & " and PeopleID =" & PeopleID & " order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, connLOA, 3, 3 
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
	sqldams = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Female' or category  = 'Inexperienced Female' ) and PeopleID = " & PeopleID & " and speciesid =" & speciesID & "  order by Fullname"
	Set rsdams = Server.CreateObject("ADODB.Recordset")
	rsdams.Open sqldams, connLOA, 3, 3 

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
	sqlsires = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Male' or category  = 'Inexperienced Male')  and PeopleID = " & PeopleID & " and speciesid =" & speciesID & " order by Fullname"
	Set rssires = Server.CreateObject("ADODB.Recordset")
	rssires.Open sqlsires, connLOA, 3, 3 
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

sql2 = "select * from Ancestors where ID =" & ID
acounter = 1
rs.Open sql2, connLOA, 3, 3 
Dam	= rs("Dam")
DamColor = rs("DamColor")
DamLink = rs("DamLink")
DamARI = rs("DamARI")
DamCLAA = rs("DamCLAA")
DamDam = rs("DamDam")
DamDamColor = rs("DamDamColor")
DamDamLink = rs("DamDamLink")
DamDamARI = rs("DamDamARI")
DamDamCLAA = rs("DamDamCLAA")
DamDamDam = rs("DamDamDam")
DamDamDamColor = rs("DamDamDamColor")
DamDamDamLink = rs("DamDamDamLink")
DamDamDamARI = rs("DamDamDamARI")
DamDamDamCLAA = rs("DamDamDamCLAA")
DamDamSire = rs("DamDamSire")
DamDamSireColor = rs("DamDamSireColor")
DamDamSireLink = rs("DamDamSireLink")
DamDamSireARI = rs("DamDamSireARI")
DamDamSireCLAA = rs("DamDamSireCLAA")
DamSire = rs("DamSire")
DamSireColor = rs("DamSireColor")
DamSireLink = rs("DamSireLink")
DamSireARI = rs("DamSireARI")
DamSireCLAA	= rs("DamSireCLAA")
DamSireDam = rs("DamSireDam")
DamSireDamColor = rs("DamSireDamColor")
DamSireDamLink = rs("DamSireDamLink")
DamSireDamARI = rs("DamSireDamARI")
DamSireDamCLAA = rs("DamSireDamCLAA")
DamSireSire = rs("DamSireSire")
DamSireSireColor = rs("DamSireSireColor")
DamSireSireLink = rs("DamSireSireLink")
DamSireSireARI = rs("DamSireSireARI")
DamSireSireCLAA = rs("DamSireSireCLAA")
Sire = rs("Sire")
SireColor = rs("SireColor")
SireLink = rs("SireLink")
SireARI = rs("SireARI")
SireCLAA = rs("SireCLAA")
SireDam = rs("SireDam")
SireDamColor = rs("SireDamColor")
SireDamLink = rs("SireDamLink")
SireDamARI = rs("SireDamARI")
SireDamCLAA = rs("SireDamCLAA")
SireDamDam = rs("SireDamDam")
SireDamDamColor = rs("SireDamDamColor")
SireDamDamLink = rs("SireDamDamLink")
SireDamDamARI = rs("SireDamDamARI")
SireDamDamCLAA = rs("SireDamDamCLAA")
SireDamSire = rs("SireDamSire")
SireDamSireColor = rs("SireDamSireColor")
SireDamSireLink = rs("SireDamSireLink")
SireDamSireARI = rs("SireDamSireARI")
SireDamSireCLAA = rs("SireDamSireCLAA")
SireSire = rs("SireSire")
SireSireColor = rs("SireSireColor")
SireSireLink = rs("SireSireLink")
SireSireARI = rs("SireSireARI")
SireSireCLAA = rs("SireSireCLAA")
SireSireDam = rs("SireSireDam")
SireSireDamColor = rs("SireSireDamColor")
SireSireDamLink = rs("SireSireDamLink")
SireSireDamARI = rs("SireSireDamARI")
SireSireDamCLAA = rs("SireSireDamCLAA")
SireSireSire = rs("SireSireSire")
SireSireSireColor = rs("SireSireSireColor")
SireSireSireLink = rs("SireSireSireLink")
SireSireSireARI = rs("SireSireSireARI")
SireSireSireCLAA = rs("SireSireSireCLAA")
if DamLink= "0" or IsEmpty(DamLink) or len(DamLink) < 5 then
DamLinkDescription = "Not Available"
DamLink = "NoLink.asp"
else
DamLinkDescription = "Click Here"
end if 
if DamDamLink = "0"  or IsEmpty(DamDamLink) or len(DamDamLink) < 5then
DamDamLinkDescription = "Not Available"
DamDamLink  = "NoLink.asp"
else
DamDamLinkDescription = "Click Here"
end if 
if DamSireLink= "0" or IsEmpty(DamSireLink) or len(DamSireLink) < 5 then
DamSireLinkDescription = "Not Available"
DamSireLink = "NoLink.asp"
else
DamSireLinkDescription = "Click Here"
end if 
if SireLink= "0" or IsEmpty(SireLink) or len(SireLink) < 5 then
SireLinkDescription = "Not Available"
SireLink = "NoLink.asp"
else
SireLinkDescription = "Click Here"
end if 
if SiredamLink= "0" or IsEmpty(SiredamLink) or len(SiredamLink) < 5 then
SiredamLinkDescription = "Not Available"
SiredamLink = "NoLink.asp"
else
SiredamLinkDescription = "Click Here"
end if 
if SireSireLink= "0" or IsEmpty(SireSireLink) or len(SireSireLink) < 5 then
SireSireLinkDescription = "Not Available"
SireSireLink = "NoLink.asp"
else
SireSireLinkDescription = "Click Here"
end if 
if SireColor= "0" or IsEmpty(SireColor) or len(SireColor) < 2 then
SireColor ="Not Available"
end if
if SiredamColor= "0" or IsEmpty(SiredamColor) or len(SiredamColor) < 2 then
SiredamColor ="Not Available"
end if
if SireSireColor= "0" or IsEmpty(SireSireColor) or len(SireSireColor) < 2 then
SireSireColor ="Not Available"
end if
if DamColor= "0" or IsEmpty(DamColor) or len(DamColor) < 2 then
DamColor ="Not Available"
end if
if DamDamColor= "0" or IsEmpty(DamDamColor) or len(DamDamColor) < 2 then
DamDamColor ="Not Available"
end if
if DamSireColor= "0" or IsEmpty(DamSireColor) or len(DamSireColor) < 2 then
DamSireColor ="Not Available"
end If
rs.close
%>
<a name="Ancestry"></a>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width= "100%"><tr><td class = "roundedtopandbottom" align = "left">
<H2><div align = "left">Ancestry</div></H2>
<% changesmade = request.querystring("changesmade")
if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Ancestry Changes Have Been Made.</b></font></div>
<% end if %>

<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "100%">
<form action= 'MembersAncestryHandleForm2.asp?SpeciesID=<%=SpeciesID %>' method = "post">

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


<table width = "100%" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>
	<td  align = "center">
<% if changesmade = "True" then %>
<div align = "left"><font class="blink_text"><b>Your Ancestry Changes Have Been Made.</b></font></div>
<% end if %>
			<Input type = Hidden name='ID' value = <%=ID%> >
			<input type=submit value = "Submit Ancestry Changes" class = "regsubmit2" >
			<br><br />
		</td>
</tr>
</table></form>

	</td>
</tr>
</table>
<%connLOA.close
set connLOA = nothing %>
</body>
</html>