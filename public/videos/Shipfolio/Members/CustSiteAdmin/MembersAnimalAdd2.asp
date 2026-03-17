<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalvariables.asp"--> 
<title><%=Sitenamelong %> Membersistration</title>
<meta name="Title" content="<%=Sitenamelong %> Membersistration"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Animals" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	
Current3="AddAnimal"  %> 
 <!--#Include file="MembersAnimalsTabsInclude.asp"-->
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />

<%
SpeciesID= request.querystring("SpeciesID")
sql2 = "select * from SpeciesAvailable where  SpeciesID = " & SpeciesID 

Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
SireTerm = rs2("SireTerm")
DamTerm = rs2("DamTerm")
rs2.close

ID= request.querystring("ID")
sql = "select * from Ancestors where ID = " & ID & "" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
Dam 	= rs("Dam")
DamColor 	= rs("DamColor")
DamLink 	= rs("DamLink")
DamARI 	= rs("DamARI")
DamCLAA 	= rs("DamCLAA")

DamDam 	= rs("DamDam")
DamDamColor 	= rs("DamDamColor")
DamDamLink 	= rs("DamDamLink")
DamDamARI 	= rs("DamDamARI")
DamDamCLAA 	= rs("DamDamCLAA")

DamDamDam 	= rs("DamDamDam")
DamDamDamColor 	= rs("DamDamDamColor")
DamDamDamLink 	= rs("DamDamDamLink")
DamDamDamARI 	= rs("DamDamDamARI")
DamDamDamCLAA 	= rs("DamDamDamCLAA")

DamDamSire 	= rs("DamDamSire")
DamDamSireColor 	= rs("DamDamSireColor")
DamDamSireLink 	= rs("DamDamSireLink")
DamDamSireARI 	= rs("DamDamSireARI")
DamDamSireCLAA 	= rs("DamDamSireCLAA")

DamSire 	= rs("DamSire")
DamSireColor 	= rs("DamSireColor")
DamSireLink 	= rs("DamSireLink")
DamSireARI 	= rs("DamSireARI")
DamSireCLAA	= rs("DamSireCLAA")

DamSireDam 	= rs("DamSireDam")
DamSireDamColor 	= rs("DamSireDamColor")
DamSireDamLink 	= rs("DamSireDamLink")
DamSireDamARI 	= rs("DamSireDamARI")
DamSireDamCLAA 	= rs("DamSireDamCLAA")

DamSireSire 	= rs("DamSireSire")
DamSireSireColor 	= rs("DamSireSireColor")
DamSireSireLink 	= rs("DamSireSireLink")
DamSireSireARI 	= rs("DamSireSireARI")
DamSireSireCLAA 	= rs("DamSireSireCLAA")



Sire 	= rs("Sire")
SireColor 	= rs("SireColor")
SireLink 	= rs("SireLink")
SireARI 	= rs("SireARI")
SireCLAA 	= rs("SireCLAA")

SireDam 	= rs("SireDam")
SireDamColor 	= rs("SireDamColor")
SireDamLink 	= rs("SireDamLink")
SireDamARI 	= rs("SireDamARI")
SireDamCLAA 	= rs("SireDamCLAA")

SireDamDam 	= rs("SireDamDam")
SireDamDamColor 	= rs("SireDamDamColor")
SireDamDamLink 	= rs("SireDamDamLink")
SireDamDamARI 	= rs("SireDamDamARI")
SireDamDamCLAA 	= rs("SireDamDamCLAA")

SireDamSire 	= rs("SireDamSire")
SireDamSireColor 	= rs("SireDamSireColor")
SireDamSireLink 	= rs("SireDamSireLink")
SireDamSireARI 	= rs("SireDamSireARI")
SireDamSireCLAA 	= rs("SireDamSireCLAA")

SireSire 	= rs("SireSire")
SireSireColor 	= rs("SireSireColor")
SireSireLink 	= rs("SireSireLink")
SireSireARI 	= rs("SireSireARI")
SireSireCLAA 	= rs("SireSireCLAA")
	

SireSireDam 	= rs("SireSireDam")
SireSireDamColor 	= rs("SireSireDamColor")
SireSireDamLink 	= rs("SireSireDamLink")
SireSireDamARI 	= rs("SireSireDamARI")
SireSireDamCLAA 	= rs("SireSireDamCLAA")

SireSireSire 	= rs("SireSireSire")
SireSireSireColor 	= rs("SireSireSireColor")
SireSireSireLink 	= rs("SireSireSireLink")
SireSireSireARI 	= rs("SireSireSireARI")
SireSireSireCLAA 	= rs("SireSireSireCLAA")


if DamLink = "0" then
   Damlink = ""
end if

if DamDamLink = "0" then
   DamDamlink = ""
end if


if DamSireLink = "0" then
   DamSirelink = ""
end if

if DamDamDamLink = "0" then
   DamDamDamlink = ""
end if

if DamDamSireLink = "0" then
   DamDamSirelink = ""
end if
 
if DamSireDamLink = "0" then
   DamSireDamlink = ""
end if

if DamSireSireLink = "0" then
   DamSireSirelink = ""
end if

if SireLink = "0" then
   Sirelink = ""
end if

if SireDamLink = "0" then
   SireDamlink = ""
end if

if SireDamDamLink = "0" then
   SireDamDamlink = ""
end if

if SireDamSireLink = "0" then
   SireDamSirelink = ""
end if

if SireSireLink = "0" then
   SireSirelink = ""
end if

if SireSireDamLink = "0" then
   SireSireDamlink = ""
end if

if SireSireSireLink = "0" then
   SireSireSirelink = ""
end if

%>


<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900"  align = "center">
	<tr>
		<td class = "body">
<h2><font color = "black">Ancestry</font></h2><br>
		
		</td>
	</tr>
</table>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900"   align = "center">

<%  
dim aID(99999)
dim aName(99999)

	sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID = " & Session("PeopleID") & "  and SpeciesID = " & SpeciesID & " order by Fullname"

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
		set rs2=nothing

	
dim damsID(99999)
dim damsName(99999)

damscounter = 1
	sqldams = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Female' or category  = 'Inexperienced Female' ) and PeopleID = " & Session("PeopleID") & "  and SpeciesID = " & SpeciesID & " order by Fullname"
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

dim siresID(99999)
dim siresName(99999)

sirescounter = 1
	sqlsires = "select Animals.ID, Animals.FullName from Animals where (category  = 'Experienced Male' or category  = 'Inexperienced Male') and PeopleID = " & Session("PeopleID") & " and SpeciesID = " & SpeciesID & " order by Fullname"
	Set rssires = Server.CreateObject("ADODB.Recordset")
	rssires.Open sqlsires, conn, 3, 3 

	While Not rssires.eof  
siresID(sirescounter) = rssires("ID")
siresName(sirescounter) = rssires("FullName")

sirescounter = sirescounter +1
rssires.movenext
		Wend		
	
		rssires.close
		set rssires=nothing


%>


<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "900">
	<form action= 'MembersAncestryAddStep2.asp?SpeciesID=<%=speciesID%>&ID=<%=ID %>' method = "post">

<tr><td rowspan="4" nowrap class = "list" ><b><%=SireTerm %></b><%
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
    <td rowspan="2" nowrap class = "list">

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
    <td nowrap class = "list">
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
    <td class = "list">
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
    <td rowspan="2" class = "list">

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
    <td class = "list" >

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
    <td class = "list">

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
    <td rowspan="4" class = "list" ><b><%=DamTerm %></b>
  
	  		

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
    <td rowspan="2" class = "list">

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
    <td class = "list">

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
    <td class = "list">

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
    <td rowspan="2" class = "list">

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
    <td class = "list">

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
    <td class = "list">

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
<table width = "900" border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
<tr><td  align = "right"><br />
<Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
<Input type=Hidden name='ID' value = <%=ID%> >
<input type=submit name = "bsubmit" value = "Save & Proceed To Next Page" size = "110" class = "regsubmit2" >
</td></tr></table>
<% 
rs.close
%>
<br>
 </td>
</tr>
</table>
 </td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->  </Body>
</HTML>
