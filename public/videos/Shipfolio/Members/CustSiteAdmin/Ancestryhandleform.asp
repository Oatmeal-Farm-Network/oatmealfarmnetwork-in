<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Ancestry Data Results Page</title>
             <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(400)
	dim FullName(400)
	dim DamName(400)
	dim DamColor(400)
	dim DamAri(400)
	dim DamAKC(400)
	dim DamUKC(400)
	dim DamLink(400)
	dim DamDamName(400)
	dim DamDamColor(400)
	dim DamDamARI(400)
	dim DamDamAKC(400)
	dim DamDamUKC(400)
	dim DamDamLink(400)
	dim DamSireName(400)
	dim DamSireColor(400)
	dim DamSireAri(400)
	dim DamSireAKC(400)
	dim DamSireUKC(400)
	dim DamSireLink(400)
	dim SireName(400)
	dim SireColor(400)
	dim SireAri(400)
	dim SireAKC(400)
	dim SireUKC(400)
	dim SireLink(400)
	dim SireDamName(400)
	dim SireDamColor(400)
	dim SireDamAri(400)
	dim SireDamAKC(400)
	dim SireDamUKC(400)
	dim SireDamLink(400)
	dim SireSireName(400)
	dim SireSireColor(400)
	dim SireSireAri(400)
	dim SireSireAKC(400)
	dim SireSireUKC(400)
	dim SireSireLink(400)

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
		set conn = nothing



%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			To continue editing ancestry data shoose one of the following:<br>
			<form action= 'AncestorData3.asp' method = "post">
			&nbsp; &nbsp; <a href = "AncestorData2.asp" class ="body">1. Click here to edit Ancestry Data for all of your animals.</a><br>
			&nbsp; &nbsp; 2. Select an animal below and push the edit button to edit Ancestry Data one animals at one time:<br><%
			dim fs,fo,x, count
			dim FileName(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("e:\\inetpub\\wwwroot\\starter\\alpacas3\\twilightalpacas.com\\www\\images\\ListPage")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) = x.Name
			  ' Response.write(FileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing
			%>

			
				<input type = "hidden" name="PhotoType" value= "ListPage">
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
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
