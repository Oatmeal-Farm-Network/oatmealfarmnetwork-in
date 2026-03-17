<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

		<!--#Include file="AdminDimensions.asp"-->
		<!--#Include file="AdminHeader.asp"--> 
		<!--#Include file="AdminDetailDBInclude.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(40000)
	dim FullName(40000)
	dim DamName(40000)
	dim DamColor(40000)
	dim DamAri(40000)
	dim DamAKC(40000)
	dim DamUKC(40000)
	dim DamLink(40000)
	dim DamDamName(40000)
	dim DamDamColor(40000)
	dim DamDamARI(40000)
	dim DamDamAKC(40000)
	dim DamDamUKC(40000)
	dim DamDamLink(40000)
	dim DamSireName(40000)
	dim DamSireColor(40000)
	dim DamSireAri(40000)
	dim DamSireAKC(40000)
	dim DamSireUKC(40000)
	dim DamSireLink(40000)
	dim SireName(40000)
	dim SireColor(40000)
	dim SireAri(40000)
	dim SireAKC(40000)
	dim SireUKC(40000)
	dim SireLink(40000)
	dim SireDamName(40000)
	dim SireDamColor(40000)
	dim SireDamAri(40000)
	dim SireDamAKC(40000)
	dim SireDamUKC(40000)
	dim SireDamLink(40000)
	dim SireSireName(40000)
	dim SireSireColor(40000)
	dim SireSireAri(40000)
	dim SireSireAKC(40000)
	dim SireSireUKC(40000)
	dim SireSireLink(40000)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "Name(" & rowcount & ")"
	DamNamecount = "DamName(" & rowcount & ")"
	DamColorcount = "DamColor(" & rowcount & ")"
    DamAricount = "DamAri(" & rowcount & ")"
	DamAKCcount = "DamAKC(" & rowcount & ")"
	DamUKCcount = "DamUKC(" & rowcount & ")"
	DamLinkcount = "DamLink(" & rowcount & ")"

 
str1 = lcase(DamLinkcount )
str2 = "http://"
If InStr(str1,str2) > 0 Then
DamLinkcount = Replace(str1, str2, "")
End If

str1 = lcase(DamLinkcount )
str2 = "http:/"
If InStr(str1,str2) > 0 Then
DamLinkcount = Replace(str1, str2, "")
End If

str1 = lcase(DamLinkcount )
str2 = "http:"
If InStr(str1,str2) > 0 Then
DamLinkcount = Replace(str1, str2, "")
End If



	DamDamNamecount = "DamDamName(" & rowcount & ")"
	DamDamColorcount = "DamDamColor(" & rowcount & ")"
	DamDamAricount = "DamDamAri(" & rowcount & ")"
		DamDamAKCcount = "DamDamAKC(" & rowcount & ")"
			DamDamUKCcount = "DamDamUKC(" & rowcount & ")"
				DamDamLinkcount = "DamDamLink(" & rowcount & ")"


	DamSireNamecount = "DamSireName(" & rowcount & ")"
	DamSireColorcount = "DamSireColor(" & rowcount & ")"
		DamSireAricount = "DamSireAri(" & rowcount & ")"
				DamSireAKCcount = "DamSireAKC(" & rowcount & ")"
						DamSireUKCcount = "DamSireUKC(" & rowcount & ")"
								DamSireLinkcount = "DamSireLink(" & rowcount & ")"

	SireNamecount = "SireName(" & rowcount & ")"
	SireColorcount = "SireColor(" & rowcount & ")"
	SireAricount = "SireAri(" & rowcount & ")"
		SireAKCcount = "SireAKC(" & rowcount & ")"
			SireUKCcount = "SireUKC(" & rowcount & ")"
				SireLinkcount = "SireLink(" & rowcount & ")"


	SireDamNamecount = "SireDamName(" & rowcount & ")"
	SireDamColorcount = "SireDamColor(" & rowcount & ")"
	SireDamAricount = "SireDamAri(" & rowcount & ")"
		SireDamAKCcount = "SireDamAKC(" & rowcount & ")"
			SireDamUKCcount = "SireDamUKC(" & rowcount & ")"
				SireDamLinkcount = "SireDamLink(" & rowcount & ")"

	SireSireNamecount = "SireSireName(" & rowcount & ")"
	SireSireColorcount = "SireSireColor(" & rowcount & ")"
	SireSireAricount = "SireSireAri(" & rowcount & ")"
		SireSireAKCcount = "SireSireAKC(" & rowcount & ")"
			SireSireUKCcount = "SireSireUKC(" & rowcount & ")"
				SireSireLinkcount = "SireSireLink(" & rowcount & ")"

	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	DamName(rowcount)=Request.Form(DamNamecount )
	DamColor(rowcount)=Request.Form(DamColorcount) 
	DamAri(rowcount)=Request.Form(DamAricount) 
		DamAKC(rowcount)=Request.Form(DamAKCcount) 
			DamUKC(rowcount)=Request.Form(DamUKCcount) 
				DamLink(rowcount)=Request.Form(DamLinkcount) 

	DamDamName(rowcount)=Request.Form(DamDamNamecount) 
	DamDamColor(rowcount)=Request.Form(DamDamColorcount) 
	DamDamAri(rowcount)=Request.Form(DamDamAricount) 
		DamDamAKC(rowcount)=Request.Form(DamDamAKCcount) 
			DamDamUKC(rowcount)=Request.Form(DamDamUKCcount) 
				DamDamLink(rowcount)=Request.Form(DamDamLinkcount) 

	DamSireName(rowcount)=Request.Form(DamSireNamecount) 
	DamSireColor(rowcount)=Request.Form(DamSireColorcount) 
	DamSireAri(rowcount)=Request.Form(DamSireAricount) 
		DamSireAKC(rowcount)=Request.Form(DamSireAKCcount) 
	DamSireUKC(rowcount)=Request.Form(DamSireUKCcount) 
		DamSireLink(rowcount)=Request.Form(DamSireLinkcount) 

	SireName(rowcount)=Request.Form(SireNamecount)
	SireColor(rowcount)=Request.Form(SireColorcount)
	SireAri(rowcount)=Request.Form(SireAricount)
		SireAKC(rowcount)=Request.Form(SireAKCcount)
			SireUKC(rowcount)=Request.Form(SireUKCcount)
				SireLink(rowcount)=Request.Form(SireLinkcount)

	SireDamName(rowcount)=Request.Form(SireDamNamecount)
	SireDamColor(rowcount)=Request.Form(SireDamColorcount)
	SireDamAri(rowcount)=Request.Form(SireDamAricount)
		SireDamAKC(rowcount)=Request.Form(SireDamAKCcount)
			SireDamUKC(rowcount)=Request.Form(SireDamUKCcount)
				SireDamLink(rowcount)=Request.Form(SireDamLinkcount)
	SireSireName(rowcount)=Request.Form(SireSireNamecount)
	SireSireColor(rowcount)=Request.Form(SireSireColorcount)
	SireSireAri(rowcount)=Request.Form(SireSireAricount)
		SireSireAKC(rowcount)=Request.Form(SireSireAKCcount)
			SireSireUKC(rowcount)=Request.Form(SireSireUKCcount)
				SireSireLink(rowcount)=Request.Form(SireSireLinkcount)

	rowcount = rowcount +1
Wend

 rowcount =1

while (rowcount < TotalCount)

str1 = DamName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamName(rowcount)= Replace(str1, "'", "''")
End If

str1 = DamDamName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamDamName(rowcount)= Replace(str1, "'", "''")
End If

str1 = DamSireName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamSireName(rowcount)= Replace(str1, "'", "''")
End If

str1 = SireName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireName(rowcount)= Replace(str1, "'", "''")
End If

str1 = SireDamName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireDamName(rowcount)= Replace(str1, "'", "''")
End If

str1 = SireSireName(rowcount)
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireSireName(rowcount)= Replace(str1, "'", "''")
End If




	Query =  " UPDATE Ancestors Set DamName = '" +  DamName(rowcount) + "', " 
    Query =  Query + " DamColor = '" +  DamColor(rowcount) + "'," 
    Query =  Query + " DamAri = '" +  DamAri(rowcount) + "'," 
	    Query =  Query + " DamAKC = '" +  DamAKC(rowcount) + "'," 
		    Query =  Query + " DamUKC = '" +  DamUKC(rowcount) + "'," 
			    Query =  Query + " DamLink = '" +  DamLink(rowcount) + "'," 
    Query =  Query + " MaternalGranddam = '" +   DamDamName(rowcount) + "'," 
    Query =  Query + " MaternalGranddamsColor = '" +  DamDamColor(rowcount) + "'," 
    Query =  Query + " MaternalGranddamsAri = '" +  DamDamAri(rowcount) + "'," 
	    Query =  Query + " MaternalGranddamsAKC = '" +  DamDamAKC(rowcount) + "'," 
		    Query =  Query + " MaternalGranddamsUKC = '" +  DamDamUKC(rowcount) + "'," 
			    Query =  Query + " MaternalGranddamsLink = '" +  DamDamLink(rowcount) + "'," 
    Query =  Query + " MaternalGrandsire = '"  +  DamSireName(rowcount) + "'," 
    Query =  Query + " MaternalGrandsiresColor = '" +  DamSireColor(rowcount) + "',"
    Query =  Query + " MaternalGrandsiresAri = '" +  DamSireAri(rowcount) + "',"
	    Query =  Query + " MaternalGrandsiresAKC= '" +  DamSireAKC(rowcount) + "',"
		    Query =  Query + " MaternalGrandsiresUKC = '" +  DamSireUKC(rowcount) + "',"
			    Query =  Query + " MaternalGrandsiresLink = '" +  DamSireLink(rowcount) + "',"
	Query =  Query + " Sire = '" +  SireName(rowcount) + "'," 
	Query =  Query + " SireColor = '" +  SireColor(rowcount) + "'," 
	Query =  Query + " SireAri = '" +  SireAri(rowcount) + "'," 
		Query =  Query + " SireAKC = '" +  SireAKC(rowcount) + "'," 
			Query =  Query + " SireUKC = '" +  SireUKC(rowcount) + "'," 
				Query =  Query + " SireLink = '" +  SireLink(rowcount) + "'," 

	Query =  Query + " PaternalGranddam = '" +  SireDamName(rowcount) + "',"
	Query =  Query + " PaternalGranddamColor = '" +  SireDamColor(rowcount) + "',"
	Query =  Query + " PaternalGranddamAri = '" +  SireDamAri(rowcount) + "',"
		Query =  Query + " PaternalGranddamAKC = '" +  SireDamAKC(rowcount) + "',"
			Query =  Query + " PaternalGranddamUKC = '" +  SireDamUKC(rowcount) + "',"
				Query =  Query + " PaternalGranddamLink = '" +  SireDamLink(rowcount) + "',"

	Query =  Query + " PaternalGrandsire = '" +  SireSireName(rowcount) + "',"
	Query =  Query + " PaternalGrandsiresColor = '" +  SireSireColor(rowcount) + "'," 
	Query =  Query + " PaternalGrandsiresARI = '" +  SireSireAri(rowcount) + "'," 
		Query =  Query + " PaternalGrandsiresAKC = '" +  SireSireAKC(rowcount) + "'," 
			Query =  Query + " PaternalGrandsiresUKC = '" +  SireSireUKC(rowcount) + "'," 
				Query =  Query + " PaternalGrandsiresLink = '" +  SireSireLink(rowcount) + "'" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 

	'response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 

	  rowcount= rowcount +1
	Wend

IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made!")
  %></H2>

<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

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

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing

'response.redirect("AdminAnimalEdit.asp?id=" & id & "#Ancestry" )

%>
 </Body>
</HTML>
