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
<meta name="author" content="Oatmeal Farm Network"/>
</head>
<body border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center">
<% Current2="Animals"
Current3 = "AddAnimals"
Current1 = "MembersHome"
BladeSection = "accounts" 
pagename = BusinessName
	Hidelinks = True%> 
<!--#Include file="MembersHeader.asp"-->


<%
BusinessID= request.querystring("BusinessID")
SpeciesID= request.querystring("SpeciesID")
Name=Request.querystring("Name" ) 
ARI=Request.querystring("ARI" ) 
CLAA=Request.querystring("CLAA" ) 
DOBMonth=Request.querystring( "DOBMonth" ) 
DOBDay=Request.querystring( "DOBDay" ) 
DOBYear=Request.querystring( "DOBYear" ) 
Category=Request.querystring("Category")
Breed=Request.querystring("Breed")
BreedLookupID=Request.querystring("BreedLookupID")
NumberofAnimals=Request.querystring("NumberofAnimals") 
if len(SpeciesID) > 0 then
else
speciesID=Request.Form("speciesID")
end if


Color1=Request.querystring("Color1") 
Color2=Request.querystring("Color2") 
Color3=Request.querystring("Color3") 
Color4=Request.querystring("Color4") 
Color5=Request.querystring("Color5") 
AnimalID= request.querystring("AnimalID") 

sql2 = "select * from SpeciesAvailable where  SpeciesID = " & SpeciesID 
'response.write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
SireTerm = rs2("SireTerm")
DamTerm = rs2("DamTerm")
rs2.close

sql = "select * from Ancestors where AnimalID = " & AnimalID & "" 
rs2.Open sql2, conn, 3, 3 
if rs2.eof then
  rs2.close
 
Query =  "INSERT INTO Ancestors (AnimalID)" 
Query =  Query & " Values (" &  AnimalID & ")" 
'response.write(Query)
Conn.Execute(Query) 
end if

sql = "select * from Ancestors where AnimalID = " & AnimalID & "" 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if not rs.eof then
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

end if

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

 
dim aAnimalID(99999)
dim aName(99999)

	sql2 = "select Animals.AnimalID, Animals.FullName from Animals where PeopleID = " & Session("PeopleID") & "  and SpeciesID = " & SpeciesID & " order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

	While Not rs2.eof  
		aAnimalID(acounter) = rs2("AnimalID")
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
	sqldams = "select Animals.AnimalID, Animals.FullName from Animals where (category  = 'Experienced Female' or category  = 'Inexperienced Female' ) and PeopleID = " & Session("PeopleID") & "  and SpeciesID = " & SpeciesID & " order by Fullname"
	Set rsdams = Server.CreateObject("ADODB.Recordset")
	rsdams.Open sqldams, conn, 3, 3 

While Not rsdams.eof  
		damsID(damscounter) = rsdams("AnimalID")
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
	sqlsires = "select Animals.AnimalID, Animals.FullName from Animals where (category  = 'Experienced Male' or category  = 'Inexperienced Male') and PeopleID = " & Session("PeopleID") & " and SpeciesID = " & SpeciesID & " order by Fullname"
	Set rssires = Server.CreateObject("ADODB.Recordset")
	rssires.Open sqlsires, conn, 3, 3 

	While Not rssires.eof  
siresID(sirescounter) = rssires("AnimalID")
siresName(sirescounter) = rssires("FullName")

sirescounter = sirescounter +1
rssires.movenext
Wend		
	
rssires.close
set rssires=nothing

if speciesID = 23 or speciesID = 18 or speciesID = 13 or speciesID = 21 or speciesID = 19 or speciesID = 26 or speciesID = 33 or speciesID = 30 or speciesID = 28 or NumberofAnimals > 1 then 
	response.redirect("MembersAncestryAddStep2.asp?SpeciesID=" & speciesID & "&AnimalID=" & AnimalID & "&Name=" & Name & "&NumberofAnimals=" & NumberofAnimals )
end if
%>

<% If not rs.State = adStateClosed Then
  rs.close
End If   	
Current3="AddAnimal"  %> 
<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

<div class ="container roundedtopandbottom"	>


	<form action= 'MembersAncestryAddStep2.asp?AnimalID=<%=AnimalID %>&Name=<%=Name %>&NumberofAnimals=<%=NumberofAnimals %>&SpeciesID=<%=SpeciesID%>&BusinessID=<%=BusinessID%>' method = "post">
	<div class="row">
        <div class="col-sm-12">
            <H3>Ancestry</H3><a name="Top"></a>
        </div>
	</div>
	<div class="row">
          <div class = "col-12 body">
           Ancestry Percents
        </div>
	</div>
	<div class="row">
          <div class = "col-12 body">
             <textarea name="AncestryDescription"  cols="50" rows="1"  class = "roundedtopandbottom" ><%=AncestryDescription%></textarea><br />
			  <i><small>Animal ancestry percentages (i.e. 50% American, 50% Australian, etc.)</small></i>
        </div>
	</div>

<table   border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" >
	

<tr><td rowspan="4" nowrap class = "body" >
	
	
<br /><br /><br /><br /><br /><br />	
	
	<b><%=SireTerm %></b><%
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
%>
	<!--#Include File="MembersAncestorEditDetailsInclude.asp"-->

</td>
    <td rowspan="2" nowrap class="d-none d-md-table-cell body">
		
		<br /><br /><br />
		<b><%=SireTerm %></b>

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
    <td nowrap class="d-none d-lg-table-cell body"><b><%=SireTerm %></b>
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
    <td class="d-none d-lg-table-cell body"><b><%=DamTerm %></b>
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
    <td rowspan="2" class="d-none d-md-table-cell body">
		
		<br /><br /><br /><br />	
		
		<b><%=DamTerm %></b>

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
    <td class="d-none d-lg-table-cell body" ><b><%=SireTerm %></b>

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
    <td class="d-none d-lg-table-cell body"><b><%=DamTerm %></b>

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
    <td rowspan="4" class = "list body" >
		
	<br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
		<b><%=DamTerm %></b>
  
	  		

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
    <td rowspan="2" class="d-none d-md-table-cell body">
		
		<br /><br /><br /><br /><br /><br />	
		<b><%=SireTerm %></b>

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
    <td class="d-none d-lg-table-cell body">
		<br /><br /><br />
		<b><%=SireTerm %></b>

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
    <td class="d-none d-lg-table-cell body"><b><%=DamTerm %></b>

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
    <td rowspan="2" class="d-none d-md-table-cell body">
		
		<br /><br /><br />
		
		<b><%=DamTerm %></b>

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
    <td class="d-none d-lg-table-cell body"><b><%=SireTerm %></b>

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
    <td class="d-none d-lg-table-cell body"><b><%=DamTerm %></b>

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
<table  border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" >
<tr><td  align = "center"><br />
<Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
<Input type=Hidden name='AnimalID' value = <%=AnimalID%> >
<Input type=Hidden name='Name' value = <%=Name%> >
<input type=submit name = "bsubmit" value = "Next" size = "110" class = "regsubmit2" >
</td></tr></table>

<br>
</div>
<% showCharlie = False %>
<!--#Include file="MembersFooter.asp"-->   </body>
</HTML>
