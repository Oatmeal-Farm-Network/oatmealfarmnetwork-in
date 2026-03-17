<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Ancestry Data Results Page</title>
             <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY background = "images/background.jpg">
<!--#Include virtual="/administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID(300)
dim FullName(300)
dim DamName(300)
dim DamColor(300)
dim DamDamName(300)
dim DamDamColor(300)
dim DamSireName(300)
dim DamSireColor(300)
dim SireName(300)
dim SireColor(300)
dim SireDamName(300)
dim SireDamColor(300)
dim SireSireName(300)
dim SireSireColor(300)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
	IDcount = "ID(" & rowcount & ")"	
	FullNamecount = "Name(" & rowcount & ")"
	DamNamecount = "DamName(" & rowcount & ")"
	DamColorcount = "DamColor(" & rowcount & ")"
	DamDamNamecount = "DamDamName(" & rowcount & ")"
	DamDamColorcount = "DamDamColor(" & rowcount & ")"
	DamSireNamecount = "DamSireName(" & rowcount & ")"
	DamSireColorcount = "DamSireColor(" & rowcount & ")"
	SireNamecount = "SireName(" & rowcount & ")"
	SireColorcount = "SireColor(" & rowcount & ")"
	SireDamNamecount = "SireDamName(" & rowcount & ")"
	SireDamColorcount = "SireDamColor(" & rowcount & ")"
	SireSireNamecount = "SireSireName(" & rowcount & ")"
	SireSireColorcount = "SireSireColor(" & rowcount & ")"
	
	ID(rowcount)=Request.Form(IDcount) 
	FullName(rowcount)=Request.Form(FullNamecount) 
	DamName(rowcount)=Request.Form(DamNamecount )
	DamColor(rowcount)=Request.Form(DamColorcount) 
	DamDamName(rowcount)=Request.Form(DamDamNamecount) 
	DamDamColor(rowcount)=Request.Form(DamDamColorcount) 
	DamSireName(rowcount)=Request.Form(DamSireNamecount) 


	DamSireColor(rowcount)=Request.Form(DamSireColorcount) 
	SireName(rowcount)=Request.Form(SireNamecount)
	SireColor(rowcount)=Request.Form(SireColorcount)
	SireDamName(rowcount)=Request.Form(SireDamNamecount)
	SireDamColor(rowcount)=Request.Form(SireDamColorcount)
	SireSireName(rowcount)=Request.Form(SireSireNamecount)
	SireSireColor(rowcount)=Request.Form(SireSireColorcount)
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
    Query =  Query + " MaternalGranddam = '" +   DamDamName(rowcount) + "'," 
    Query =  Query + " MaternalGranddamsColor = '" +  DamDamColor(rowcount) + "'," 
    Query =  Query + " MaternalGrandsire = '"  +  DamSireName(rowcount) + "'," 
    Query =  Query + " MaternalGrandsiresColor = '" +  DamSireColor(rowcount) + "',"
	Query =  Query + " Sire = '" +  SireName(rowcount) + "'," 
	Query =  Query + " SireColor = '" +  SireColor(rowcount) + "'," 
	Query =  Query + " PaternalGranddam = '" +  SireDamName(rowcount) + "',"
	Query =  Query + " PaternalGranddamColor = '" +  SireDamColor(rowcount) + "',"
	Query =  Query + " PaternalGrandsire = '" +  SireSireName(rowcount) + "',"
	Query =  Query + " PaternalGrandsiresColor = '" +  SireSireColor(rowcount) + "'" 
    Query =  Query + " where ID = " + ID(rowcount) + ";" 

	'response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath("../../db/AlpacaDB.mdb") & ";" 



DataConnection.Execute(Query) 

	  rowcount= rowcount +1
	Wend

IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 End If

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<%  
dim aID(300)
dim aName(300)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
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
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>
