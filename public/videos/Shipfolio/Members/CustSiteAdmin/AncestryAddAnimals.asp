<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Ancestry Select Animal Data Results Page</title>
             <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

	
	dim ID
	dim FullName
	dim DamName
	dim DamDamName
	dim DamSireName
	dim SireName
	dim SireDamName
	dim SireSireName
	
	
	ID=Request.Form("ID") 
	DamID=Request.Form("DamID") 
	DamDamID=Request.Form("DamDamID") 
	DamSireID=Request.Form("DamSireID") 
	SireID=Request.Form("SireID") 
	SireDamID=Request.Form("SireDamID") 
	SireSireID=Request.Form("SireSireID") 
	OSDamSireID=Request.Form("OSDamSireID") 
	OSSireID=Request.Form("OSSireID") 
	OSSireSireID=Request.Form("OSSireSireID") 


If OSDamSireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud where ExternalStudID =  " & OSDamSireID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		OSDamSireName=rs("AlpacaName")
		OSDamSireColor=rs("ServiceSireColor")
		OSDamSireLink=rs("ServiceSireLink")

	rs.close
	set rs=nothing

	if OSDamSireName ="0" then
		OSDamSireName = ""
	end if

	str1 = OSDamSireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		OSDamSireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set MaternalGrandsire = '" +  OSDamSireName + "', " 
	Query =  Query + " MaternalGrandsiresColor = '" +  OSDamSireColor + "',"
	Query =  Query + " MaternalGrandsiresLink = '" +  OSDamSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if


If OSSireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud where ExternalStudID =  " & OSSireID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		OSSireName=rs("AlpacaName")
		OSSireColor=rs("ServiceSireColor")
		OSSireLink=rs("ServiceSireLink")

	rs.close
	set rs=nothing

	if OSSireName ="0" then
		OSSireName = ""
	end if

	str1 = OSSireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		OSSireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set Sire = '" +  OSSireName + "', " 
	Query =  Query + " SireColor = '" +  OSSireColor + "',"
	Query =  Query + " SireLink = '" +  OSSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if

If OSSireSireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud where ExternalStudID =  " & OSSireSireID

response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		OSSireSireName=rs("AlpacaName")
		OSSireSireColor=rs("ServiceSireColor")
		OSSireSireLink=rs("ServiceSireLink")

	rs.close
	set rs=nothing

	if OSSireSireName ="0" then
		OSSireSireName = ""
	end if

	str1 = OSSireSireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		OSSireSireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set PaternalGrandsire = '" +  OSSireSireName + "', " 
	Query =  Query + " PaternalGrandsiresColor = '" +  OSSireSireColor + "',"
	Query =  Query + " PaternalGrandsiresLink = '" +  OSSireSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if


If DamID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & DamID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		DamName=rs("FullName")
		DamColor=rs("Color")
		DamARI=rs("ARI")
		DamLink="0"
				

	rs.close
	set rs=nothing

	if DamName ="0" then
		DamName = ""
	end if

	str1 = DamName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DamName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set DamName = '" +  DamName + "', " 
	Query =  Query + " DamColor = '" +  DamColor + "',"
	Query =  Query + " DamARI = '" +  DamARI + "'," 
	Query =  Query + " DamLink = '" +  DamLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if

If DamDamID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & DamDamID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		DamDamName=rs("FullName")
		DamDamColor=rs("Color")
		DamDamARI=rs("ARI")
		DamDamLink="0"
				

	rs.close
	set rs=nothing

	if DamDamName ="0" then
		DamDamName = ""
	end if

	str1 = DamDamName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DamDamName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set MaternalGranddam = '" +  DamDamName + "', " 
	Query =  Query + " MaternalGranddamsColor = '" +  DamDamColor + "',"
	Query =  Query + " MaternalGranddamsARI = '" +  DamDamARI + "'," 
	Query =  Query + " MaternalGranddamsLink = '" +  DamDamLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if

If DamSireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & DamSireID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		DamSireName=rs("FullName")
		DamSireColor=rs("Color")
		DamSireARI=rs("ARI")
		DamSireLink="0"
				

	rs.close
	set rs=nothing

	if DamSireName ="0" then
		DamSireName = ""
	end if

	str1 = DamSireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		DamSireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set MaternalGrandsire = '" +  DamSireName + "', " 
	Query =  Query + " MaternalGrandsiresColor = '" +  DamSireColor + "',"
	Query =  Query + " MaternalGrandsiresARI = '" +  DamSireARI + "'," 
	Query =  Query + " MaternalGrandsiresLink = '" +  DamSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if



If SireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & SireID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		SireName=rs("FullName")
		SireColor=rs("Color")
		SireARI=rs("ARI")
		SireLink="0"
				

	rs.close
	set rs=nothing

	if SireName ="0" then
		SireName = ""
	end if

	str1 = SireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		SireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set sire = '" +  SireName + "', " 
	Query =  Query + " SireColor = '" +  SireColor + "',"
	Query =  Query + " SireARI = '" +  SireARI + "'," 
	Query =  Query + " SireLink = '" +  SireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if

If SireDamID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & SireDamID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		SireDamName=rs("FullName")
		SireDamColor=rs("Color")
		SireDamARI=rs("ARI")
		SireDamLink="0"
				

	rs.close
	set rs=nothing

	if SireDamName ="0" then
		SireDamName = ""
	end if

	str1 = SireDamName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		SireDamName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set PaternalGranddam = '" +  SireDamName + "', " 
	Query =  Query + " PaternalGranddamColor = '" +  SireDamColor + "',"
	Query =  Query + " PaternalGranddamARI = '" +  SireDamARI + "'," 
	Query =  Query + " PaternalGranddamLink = '" +  SireDamLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if

If SireSireID > 0 then

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.* from Animals where Animals.ID =  " & SireSireID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

		SireSireName=rs("FullName")
		SireSireColor=rs("Color")
		SireSireARI=rs("ARI")
		SireSireLink="0"
				

	rs.close
	set rs=nothing

	if SireSireName ="0" then
		SireSireName = ""
	end if

	str1 = SireSireName
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		SireSireName= Replace(str1, "'", "''")
	End If

	Query =  " UPDATE Ancestors Set PaternalGrandsire = '" +  SireSireName + "', " 
	Query =  Query + " PaternalGrandsiresColor = '" +  SireSireColor + "',"
	Query =  Query + " PaternalGrandsiresARI = '" +  SireSireARI + "'," 
	Query =  Query + " PaternalGrandsiresLink = '" +  SireSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

end if



Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>

<%  
dim aID(400)
dim aName(400)

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

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing




%>
<% dim TID
	TID=Request.Form("ID" ) 
	 %>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Edit Ancestry Data<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>
<%  


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

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

				
dim damsID(400)
dim damsName(400)

damscounter = 1
	sqldams = "select Animals.ID, Animals.FullName from Animals where category  = 'Maiden' or category  = 'Dam'  or category  = 'Unowned Animal'  order by Fullname"
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

dim siresID(400)
dim siresName(400)

sirescounter = 1
	sqlsires = "select Animals.ID, Animals.FullName from Animals where category  = 'Jr. Herdsire' or category  = 'Herdsire' or category  = 'External Stud' or category  = 'Unowned Animal' order by Fullname"
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

dim OSID(400)
dim OSName(400)

	OSsql =  "select ExternalStud.ExternalStudID,  ExternalStud.alpacaName from ExternalStud"

		OScounter = 1
		Set OSrs = Server.CreateObject("ADODB.Recordset")
		OSrs.Open OSsql, conn, 3, 3 
	
		While Not OSrs.eof  
		  OSID(OScounter) = OSrs("ExternalStudID")
		  OSName(OScounter) = OSrs("alpacaName")
		  OScounter = OScounter +1
		  OSrs.movenext
		Wend		
	
		OSrs.close
		set OSrs=nothing
		set conn = nothing
%>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			Or you can edit another animal's data by selecting an animal below and push the edit button:
			<form action= 'AncestorData3.asp' method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td>
					<b>Alpaca's Name</b><br>
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
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Ancestors.* from Animals, Ancestors where Animals.ID = Ancestors.ID and Animals.ID =  " & TID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
Recordcount = rs.RecordCount +1


     ID =   rs("ID")
	 FullName =   rs("FullName")
	 DamName =   rs("DamName")
	 DamComment = rs("DamComment")
	 DamColor =   rs("DamColor")
	 DamAri =   rs("DamAri")
 	 DamLink =   rs("DamLink")
	DamDamLink =   rs("MaternalGranddamsLink")

	 DamDamName =   rs("MaternalGranddam")
	 DamDamColor =  rs("MaternalGranddamsColor")
 	 DamDamAri =  rs("MaternalGranddamsAri")
	DamSireLink =   rs("MaternalGrandsiresLink")

	 DamSireName =   rs("MaternalGrandsire")
	 DamSireColor =  rs("MaternalGrandsiresColor")
	 DamSireAri =  rs("MaternalGrandsiresAri")
	 SireLink =   rs("SireLink")

	 SireName =   rs("Sire")
	 SireComment =   rs("SireComment")
	 SireColor =   rs("SireColor")
	 SireAri =   rs("SireAri")
	SireDamLink =   rs("PaternalGranddamLink")


	 SireDamName =   rs("PaternalGranddam")
	 SireDamColor =  rs("PaternalGranddamColor")
	 SireDamAri =  rs("PaternalGranddamAri")
	 
	 SireSireName =   rs("PaternalGrandsire")
	 SireSireColor =  rs("PaternalGrandsiresColor")
	 SireSireAri =  rs("PaternalGrandsiresAri")
	SireSireLink =   rs("PaternalGrandsiresLink")


	 if DamName ="0" then
		DamName = ""
	end if
	 if DamColor="0" then
		DamColor= ""
	end if
	 if DamDamName ="0" then
		DamDamName= ""
	end if
	 if DamDamColor ="0" then
		DamDamColor= ""
	end if
	 if DamSireName="0" then
		DamSireName= ""
	end if
	 if DamSireColor="0" then
		DamSireColor= ""
	end if
	 if SireName="0" then
		SireName= ""
	end if
	 if SireColor="0" then
		SireColor= ""
	end if
	 if SireDamName="0" then
		SireDamName= ""
	end if
	 if SireDamColor ="0" then
		SireDamColor= ""
	end if
	 if SireSireName ="0" then
		SireSireName= ""
	end if
	 if SireSireColor="0" then
		SireSireColor= ""
	end if
%>


<table>
	<tr>
		<td>
			<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<form action= 'Ancestryhandleform2.asp' method = "post">
	<tr >
	<td align = "right" class = "body" valign = "top">Alpaca's Name:</td>
		
		<td colspan = "2">
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type = "hidden" name="FullName" value= "<%=  FullName%>">
			<b><%=  FullName%></b></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>&nbsp;</td>
</tr>
<tr>
	<td align = "right"  width = "300" class = "body">Dam's Name:</td>
				<td width = "150" class = "body"><b>Enter info:</b><br><input name="DamName" value= "<%= DamName%>" size = "40"></td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Dam's Color:</td>
		<td  class = "body"><input name="DamColor" value= "<%= DamColor%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Dam's ARI:</td>
		<td  class = "body"><input name="DamAri" value= "<%= DamAri%>" size = "40"></td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Dam's Link:</td>
		<td  class = "body"><input name="DamLink" value= "<%= DamLink%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Dam's Comments:</td>
		<td  class = "body"><textarea name="DamComment" cols="32" rows="8" wrap="VIRTUAL" ><%= DamComment%></textarea></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>


<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Name:</td>
		<td  class = "body"><input name="DamDamName" value="<%= DamDamName%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Color:</td>
		<td wrap><input name="DamDamColor" value="<%= DamDamColor%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's ARI:</td>
		<td wrap><input name="DamDamARI" value="<%= DamDamARI%>"  size = "40">
		</td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Link:</td>
		<td wrap><input name="DamDamLink" value="<%= DamDamLink%>"  size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Name:</td>

		<td  class = "body"><input name="DamSireName" value="<%= DamSireName%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Color:</td>
		<td  class = "body"><input name="DamSireColor" value="<%=  DamSireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's ARI:</td>
		<td  class = "body"><input name="DamSireARI" value="<%=  DamSireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Link:</td>
		<td  class = "body"><input name="DamSireLink" value="<%=  DamSireLink%>" size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" >Sire's Name:</td>
		<td  class = "body"><input name="SireName" value="<%= SireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Color:</td>
		<td  class = "body"><input name="SireColor" value="<%=SireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's ARI:</td>
		<td  class = "body"><input name="SireARI" value="<%=SireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Link:</td>
		<td  class = "body"><input name="SireLink" value="<%=SireLink%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Comments:</td>
		<td  class = "body"><textarea name="SireComment" cols="32" rows="8" wrap="VIRTUAL" ><%= SireComment%></textarea></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Name:</td>
		<td  class = "body"><input name="SireDamName" value="<%=SireDamName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Color:</td>
		<td  class = "body"><input name="SireDamColor" value="<%=SireDamColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's ARI:</td>
		<td  class = "body"><input name="SireDamARI" value="<%=SireDamARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Link:</td>
		<td  class = "body"><input name="SireDamLink" value="<%=SireDamLink%>" size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Name:</td>
		<td  class = "body"><input name="SireSireName" value="<%=SireSireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Color:</td>

		<td  class = "body"><input name="SireSireColor" value="<%=SireSireColor%>" size = "40">
		</td>
	</tr>
	<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's ARI:</td>

		<td  class = "body"><input name="SireSireARI" value="<%=SireSireARI%>" size = "40">
		</td>
	</tr>
	<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Link:</td>

		<td  class = "body"><input name="SireSireLink" value="<%=SireSireLink%>" size = "40">
		</td>
	</tr>

<%

TotalCount=1
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td  align = "center" colspan ="2">
			
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
		</td>
		<td valign = "top">
			<table>
				<tr>
				<td  valign = "top" class = "body" height ="170"><br><br><br>
					<form action= 'AncestryAddAnimals.asp' method = "post">
						<input type = "hidden" name="ID" value= "<%= ID%>" >
				  		or select one of your Dams:<br>
						<select size="1" name="DamID">
						<option name = "AID0" value= "" selected></option>
						<% count = 1
							while count < damscounter
						%>
							<option name = "AID1" value="<%=DamsID(count)%>">
								<%=DamsName(count)%>
							</option>
						<% 	count = count + 1
							wend %>
						</select>
						<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				<br><br><br><br><br><br><br><br><br><br><br><br>
				</td>
				</tr>
				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Dams:<br>
					<select size="1" name="DamDamID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < damscounter
					%>
						<option name = "AID1" value="<%=damsID(count)%>">
							<%=damsName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				</td>
				</tr>

							<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="DamSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>


				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSDamSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>


				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="SireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
						<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				<br><br><br><br><br><br><br>

				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Dams:<br>
					<select size="1" name="SireDamID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Damscounter
					%>
						<option name = "AID1" value="<%=DamsID(count)%>">
							<%=DamsName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="SireSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
					<form action= 'AncestryAddAnimals.asp' method = "post" border = "0">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSSireSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px"  class = "menu" >
				</form>
				</td>
				</tr>
			</table>
		</td>
	</tr>
</table>





 <% 		set conn = nothing%>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>


