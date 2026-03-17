<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add an Alpaca</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 
<%

TotalCount= Request.Form("TotalCount")
'TotalCount = CInt(TotalCount)
'rowcount = CInt
rowcount = 1



ID=Request.Form("ID") 
'response.write(ID)
'response.write("ID=")
	Dam=Request.Form("Dam")
	'response.write("dam=" & Dam)
DamColor=Request.Form("DamColor") 
DamAri=Request.Form("DamAri") 
DamLink=Request.Form("DamLink") 
DamCLAA=Request.Form("DamCLAA") 

DamDam=Request.Form("DamDam") 
DamDamColor=Request.Form("DamDamColor") 
DamDamAri=Request.Form("DamDamAri") 
DamDamLink=Request.Form("DamDamLink") 
DamDamCLAA=Request.Form("DamDamCLAA") 


DamDamDam=Request.Form("DamDamDam") 
DamDamDamColor=Request.Form("DamDamDamColor") 
DamDamDamAri=Request.Form("DamDamDamAri") 
DamDamDamLink=Request.Form("DamDamDamLink") 
DamDamDamCLAA=Request.Form("DamDamDamCLAA") 

DamDamSire=Request.Form("DamDamSire") 
DamDamSireColor=Request.Form("DamDamSireColor") 
DamDamSireAri=Request.Form("DamDamSireAri") 
DamDamSireLink=Request.Form("DamDamSireLink") 
DamDamSireCLAA=Request.Form("DamDamSireCLAA") 


	DamSire=Request.Form("DamSire") 
	DamSireColor=Request.Form("DamSireColor") 
	DamSireAri=Request.Form("DamSireAri") 
	DamSireLink=Request.Form("DamSireLink") 
	DamSireCLAA=Request.Form("DamSireCLAA") 

	DamSireDam=Request.Form("DamSireDam") 
	DamSireDamColor=Request.Form("DamSireDamColor") 
	DamSireDamAri=Request.Form("DamSireDamAri") 
	DamSireDamLink=Request.Form("DamSireDamLink") 
	DamSireDamCLAA=Request.Form("DamSireDamCLAA") 

	DamSireSire=Request.Form("DamSireSire") 
	DamSireSireColor=Request.Form("DamSireSireColor") 
	DamSireSireAri=Request.Form("DamSireSireAri") 
	DamSireSireLink=Request.Form("DamSireSireLink") 
	DamSireSireCLAA=Request.Form("DamSireSireCLAA") 


	Sire=Request.Form("Sire")
	SireColor=Request.Form("SireColor")
	SireAri=Request.Form("SireAri")
	SireLink=Request.Form("SireLink")
	SireComment=Request.Form("SireComment")
	SireCLAA=Request.Form("SireCLAA")

	SireDam=Request.Form("SireDam")
	SireDamColor=Request.Form("SireDamColor")
	SireDamAri=Request.Form("SireDamAri")
	SireDamLink=Request.Form("SireDamLink")
	SireDamCLAA=Request.Form("SireDamCLAA")

SireDamDam=Request.Form("SireDamDam") 
SireDamDamColor=Request.Form("SireDamDamColor") 
SireDamDamAri=Request.Form("SireDamDamAri") 
SireDamDamLink=Request.Form("SireDamDamLink") 
SireDamDamCLAA=Request.Form("SireDamDamCLAA") 

SireDamSire=Request.Form("SireDamSire") 
SireDamSireColor=Request.Form("SireDamSireColor") 
SireDamSireAri=Request.Form("SireDamSireAri") 
SireDamSireLink=Request.Form("SireDamSireLink") 
SireDamSireCLAA=Request.Form("SireDamSireCLAA") 


	SireSire=Request.Form("SireSire")
	SireSireColor=Request.Form("SireSireColor")
	SireSireAri=Request.Form("SireSireAri")
	SireSireLink=Request.Form("SireSireLink")
	SireSireCLAA=Request.Form("SireSireCLAA")

	SireSireDam=Request.Form("SireSireDam") 
	

SireSireDamColor=Request.Form("SireSireDamColor") 
SireSireDamAri=Request.Form("SireSireDamAri") 
SireSireDamLink=Request.Form("SireSireDamLink") 
SireSireDamCLAA=Request.Form("SireSireDamCLAA") 

SireSireSire=Request.Form("SireSireSire") 
SireSireSireColor=Request.Form("SireSireSireColor") 
SireSireSireAri=Request.Form("SireSireSireAri") 
SireSireSireLink=Request.Form("SireSireSireLink") 
SireSireSireCLAA=Request.Form("SireSireSireCLAA") 


Ancestor = Dam  
Ancestorcolor = Damcolor
AncestorARI = DamARI
AncestorCLAA = DamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
Dam   = Ancestor
 Damcolor = Ancestorcolor
DamARI  = AncestorARI
 DamCLAA = AncestorCLAA

Ancestor = DamDam  
Ancestorcolor = DamDamcolor
AncestorARI = DamDamARI
AncestorCLAA = DamDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamDam   = Ancestor
 DamDamcolor = Ancestorcolor
DamDamARI  = AncestorARI
 DamDamCLAA = AncestorCLAA


 Ancestor = DamDamDam  
Ancestorcolor = DamDamDamcolor
AncestorARI = DamDamDamARI
AncestorCLAA = DamDamDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamDamDam   = Ancestor
 DamDamDamcolor = Ancestorcolor
DamDamDamARI  = AncestorARI
 DamDamDamCLAA = AncestorCLAA


 Ancestor = DamDamSire  
Ancestorcolor = DamDamSirecolor
AncestorARI = DamDamSireARI
AncestorCLAA = DamDamSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamDamSire   = Ancestor
 DamDamSirecolor = Ancestorcolor
DamDamSireARI  = AncestorARI
 DamDamSireCLAA = AncestorCLAA


 Ancestor = DamSire  
Ancestorcolor = DamSirecolor
AncestorARI = DamSireARI
AncestorCLAA = DamSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamSire   = Ancestor
 DamSirecolor = Ancestorcolor
DamSireARI  = AncestorARI
 DamSireCLAA = AncestorCLAA


 Ancestor = DamSireDam  
Ancestorcolor = DamSireDamcolor
AncestorARI = DamSireDamARI
AncestorCLAA = DamSireDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamSireDam   = Ancestor
 DamSireDamcolor = Ancestorcolor
DamSireDamARI  = AncestorARI
 DamSireDamCLAA = AncestorCLAA


 Ancestor = DamSireSire  
Ancestorcolor = DamSireSirecolor
AncestorARI = DamSireSireARI
AncestorCLAA = DamSireSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
DamSireSire   = Ancestor
 DamSireSirecolor = Ancestorcolor
DamSireSireARI  = AncestorARI
 DamSireSireCLAA = AncestorCLAA


 Ancestor = Sire  
Ancestorcolor = Sirecolor
AncestorARI = SireARI
AncestorCLAA = SireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
Sire   = Ancestor
Sirecolor = Ancestorcolor
SireARI  = AncestorARI
SireCLAA = AncestorCLAA


 Ancestor = SireDam  
Ancestorcolor =SireDamcolor
AncestorARI = SireDamARI
AncestorCLAA = SireDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireDam   = Ancestor
 SireDamcolor = Ancestorcolor
SireDamARI  = AncestorARI
 SireDamCLAA = AncestorCLAA


 Ancestor = SireDamDam  
Ancestorcolor = SireDamDamcolor
AncestorARI = SireDamDamARI
AncestorCLAA = SireDamDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireDamDam   = Ancestor
 SireDamDamcolor = Ancestorcolor
SireDamDamARI  = AncestorARI
 SireDamDamCLAA = AncestorCLAA


 Ancestor = SireDamSire  
Ancestorcolor = SireDamSirecolor
AncestorARI = SireDamSireARI
AncestorCLAA = SireDamSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireDamSire   = Ancestor
SireDamSirecolor = Ancestorcolor
SireDamSireARI  = AncestorARI
SireDamSireCLAA = AncestorCLAA

 Ancestor = SireSire  
Ancestorcolor = SireSirecolor
AncestorARI = SireSireARI
AncestorCLAA = SireSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireSire   = Ancestor
SireSirecolor = Ancestorcolor
SireSireARI  = AncestorARI
SireSireCLAA = AncestorCLAA


 Ancestor = SireSireDam  
Ancestorcolor =SireSireDamcolor
AncestorARI = SireSireDamARI
AncestorCLAA = SireSireDamCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireSireDam   = Ancestor
SireSireDamcolor = Ancestorcolor
SireSireDamARI  = AncestorARI
SireSireDamCLAA = AncestorCLAA


 Ancestor = SireSireSire  
Ancestorcolor = SireSireSirecolor
AncestorARI = SireSireSireARI
AncestorCLAA = SireSireSireCLAA
%>
<!--#Include virtual="/Administration/CheckAncestorDataInclude.asp"-->
<%
SireSireSire   = Ancestor
SireSireSirecolor = Ancestorcolor
SireSireSireARI  = AncestorARI
SireSireSireCLAA = AncestorCLAA



	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql2 = "select * from Ancestors where ID = " &  ID & ";" 
			'response.write(sql2)
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If rs2.eof then

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
		Query =  "INSERT INTO Ancestors (ID)" 
		Query =  Query & " Values (" &  ID & ")" 
		'response.write (Query)
		DataConnection.Execute(Query) 
  End if



	Query =  " UPDATE Ancestors Set Dam = '" &  Dam & "', " 
    Query =  Query & " DamColor = '" &  DamColor & "'," 
    Query =  Query & " DamAri = '" &  DamAri & "'," 
	Query =  Query & " DamCLAA = '" &  DamCLAA & "'," 
    Query =  Query & " DamLink = '" &  DamLink & "'," 

    Query =  Query & " DamDam = '" &   DamDam & "'," 
    Query =  Query & " DamDamColor  = '" &  DamDamColor & "'," 
    Query =  Query & " DamDamAri = '" &  DamDamAri & "'," 
	Query =  Query & " DamDamCLAA = '" &  DamDamCLAA & "'," 
    Query =  Query & " DamDamLink = '" &  DamDamLink & "'," 

    Query =  Query & " DamDamDam = '" &   DamDamDam & "'," 
    Query =  Query & " DamDamDamColor  = '" &  DamDamDamColor & "'," 
    Query =  Query & " DamDamDamAri = '" &  DamDamDamAri & "'," 
	Query =  Query & " DamDamDamCLAA = '" &  DamDamDamCLAA & "'," 
    Query =  Query & " DamDamDamLink = '" &  DamDamDamLink & "'," 

    Query =  Query & " DamDamSire = '" &   DamDamSire & "'," 
    Query =  Query & " DamDamSireColor  = '" &  DamDamSireColor & "'," 
    Query =  Query & " DamDamSireAri = '" &  DamDamSireAri & "'," 
	Query =  Query & " DamDamSireCLAA = '" &  DamDamSireCLAA & "'," 
    Query =  Query & " DamDamSireLink = '" &  DamDamSireLink & "'," 

	 Query =  Query & " DamSire = '" &   DamSire & "'," 
    Query =  Query & " DamSireColor  = '" &  DamSireColor & "'," 
    Query =  Query & " DamSireAri = '" &  DamSireAri & "'," 
	Query =  Query & " DamSireCLAA = '" &  DamSireCLAA & "'," 
    Query =  Query & " DamSireLink = '" &  DamSireLink  & "'," 

    Query =  Query & " DamSireDam = '" &   DamSireDam & "'," 
    Query =  Query & " DamSireDamColor  = '" &  DamSireDamColor & "'," 
    Query =  Query & " DamSireDamAri = '" &  DamSireDamAri & "'," 
	Query =  Query & " DamSireDamCLAA = '" &  DamSireDamCLAA & "'," 
    Query =  Query & " DamSireDamLink = '" &  DamSireDamLink & "'," 

    Query =  Query & " DamSireSire = '" &   DamSireSire & "'," 
    Query =  Query & " DamSireSireColor  = '" &  DamSireSireColor  & "'," 
    Query =  Query & " DamSireSireAri = '" &  DamSireSireAri & "'," 
	Query =  Query & " DamSireSireCLAA = '" &  DamSireSireCLAA & "'," 
    Query =  Query & " DamSireSireLink = '" &  DamSireSireLink & "'," 



	Query =  Query & " Sire = '" &  Sire & "'," 
	Query =  Query & " SireColor = '" &  SireColor & "'," 
	Query =  Query & " SireAri = '" &  SireAri & "'," 
	Query =  Query & " SireCLAA = '" &  SireCLAA & "'," 
	Query =  Query & " SireLink = '" &  SireLink & "'," 

	Query =  Query & " SireDam = '" &  SireDam & "',"
	Query =  Query & " SireDamColor = '" &  SireDamColor & "',"
	Query =  Query & " SireDamAri  = '" &  SireDamAri & "',"
	Query =  Query & " SireDamCLAA = '" &  SireDamCLAA & "',"
	Query =  Query & " SireDamLink = '" &  SireDamLink & "',"

	Query =  Query & " SireDamDam = '" &  SireDamDam & "',"
	Query =  Query & " SireDamDamColor = '" &  SireDamDamColor & "',"
	Query =  Query & " SireDamDamAri  = '" &  SireDamDamAri & "',"
	Query =  Query & " SireDamDamCLAA = '" &  SireDamDamCLAA & "',"
	Query =  Query & " SireDamDamLink = '" &  SireDamDamLink & "',"

	Query =  Query & " SireDamSire = '" &  SireDamSire & "',"
	Query =  Query & " SireDamSireColor = '" &  SireDamSireColor & "',"
	Query =  Query & " SireDamSireAri  = '" &  SireDamSireAri & "',"
	Query =  Query & " SireDamSireCLAA = '" &  SireDamSireCLAA & "',"
	Query =  Query & " SireDamSireLink = '" &  SireDamSireLink & "',"


	Query =  Query & " SireSire = '" &  SireSire & "',"
	Query =  Query & " SireSireColor = '" &  SireSireColor & "'," 
	Query =  Query & " SireSireAri = '" &  SireSireAri & "'," 
	Query =  Query & " SireSireCLAA = '" &  SireSireCLAA & "'," 
	Query =  Query & " SireSireLink = '" &  SireSireLink & "'," 

	Query =  Query & " SireSireDam = '" &  SireSireDam & "',"
	Query =  Query & " SireSireDamColor = '" &  SireSireDamColor & "'," 
	Query =  Query & " SireSireDamAri = '" &  SireSireDamAri & "'," 
	Query =  Query & " SireSireDamCLAA = '" &  SireSireDamCLAA & "'," 
	Query =  Query & " SireSireDamLink = '" &  SireSireDamLink & "'," 

	Query =  Query & " SireSireSire = '" &  SireSireSire  & "',"
	Query =  Query & " SireSireSireColor = '" &  SireSireSireColor & "'," 
	Query =  Query & " SireSireSireAri = '" &  SireSireSireAri & "'," 
	Query =  Query & " SireSireSireCLAA = '" &  SireSireSireCLAA & "'," 
	Query =  Query & " SireSireSireLink = '" &  SireSireSireLink & "'" 


    Query =  Query & " where ID = " & ID & ";" 

	'response.write(Query)


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 

DataConnection.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
    
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<%  
dim aID(40000)
dim aName(40000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter + 1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "775">
	<tr>
		<td class = "body"><img src = "images/WizardHeader.jpg">
			<blockquote><a name="Add"></a>
			<H1>Step 3: Fiber Facts</H1>
			Enter up to 20 years worth of fiber results.<br></blockquote>
		</td>
	</tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "775">
	<tr>
		<td class = "body">
			<h2><font color = "brown">Step 3: Fiber Facts</font> <small></small></h2><br>
		</td>
	</tr>
	<tr>
		<td>
		<div align = "right">
						
				
	</div>
	</td>
</tr>
	</table>
<form action= 'AddanAlpaca4.asp' method = "post" name = "myform">
<input type = "hidden" name="ID" value= "<%= ID%>" >


	<% For count = 1 To 20 %>

<% If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor = "antiquewhite">
<% Else %>
	<table border = "0" width = "100%"  align = "center" bgcolor = "burlywood">
<% End If %>
			<tr >
		<td width = "100" class = "body">Sample Date:<input name="SampleDate(<%=count%>)"   size = "10" >
		</td>
		<td class = "body">
			AFD:<br>
		    SD:
		</td>
		<td class = "body">
			<input name="Average(<%=count%>)"  size = "5" ><br>
		   <input name="StandardDev(<%=count%>)"  size = "5" >
		</td>
		<td class = "body">
			COV: <br>
			% > 30:
		</td>
		<td class = "body">
			<input name="COV(<%=count%>)"  size = "5"><br>
			<input name="GreaterThan30(<%=count%>)"  size = "5" >
		</td>
		<td class = "body">
			Blanket Wt:<br>
			Shear Wt:
		</td>
		<td class = "body">
			<input name="BlanketWeight(<%=count%>)"   size = "5"><br>
			<input name="ShearWeight(<%=count%>)"   size = "5">
		</td>
		<td class = "body">
			CF:<br>
			Curve:
		</td>
		<td class = "body">
			<input name="CF(<%=count%>)"   size = "5"><br>
			<input name="Curve(<%=count%>)"  size = "5">
		</td>
		<td class = "body">
			Crimps / Inch:<br>
			Staple Length:
		</td>
		<td class = "body">
			<input name="CrimpPerInch(<%=count%>)"    size = "5"><br>
			<input name="Length(<%=count%>)"  size = "5">
		</td>
	</tr>
	
	</table>
	<% Next %>

		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			<tr>
				<td  valign = "middle">
					<img src = "images/underline.jpg">
					<div align = "center">
					<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
					<div align = "right">
						
				<input type=submit Value = "Next ->" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
	</div>
			</form>
		</td>
</tr>


</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
