<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Ancestry Data Results Page</title>
             <link rel="stylesheet" type="text/css" href="/administration/style.css">
</HEAD>

<BODY bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt
rowcount = 1



ID=Request.Form("ID") 
	FullName=Request.Form("FullName") 
	DamName=Request.Form("DamName")
	DamColor=Request.Form("DamColor") 
	DamAri=Request.Form("DamAri") 
		DamAKC=Request.Form("DamAKC") 
			DamUKC=Request.Form("DamUKC") 
				DamLink=Request.Form("DamLink") 
								DamComment=Request.Form("DamComment") 

	DamDamName=Request.Form("DamDamName") 
	DamDamColor=Request.Form("DamDamColor") 
	DamDamAri=Request.Form("DamDamAri") 
		DamDamAKC=Request.Form("DamDamAKC") 
			DamDamUKC=Request.Form("DamDamUKC") 
				DamDamLink=Request.Form("DamDamLink") 

	DamSireName=Request.Form("DamSireName") 
	DamSireColor=Request.Form("DamSireColor") 
	DamSireAri=Request.Form("DamSireAri") 
		DamSireAKC=Request.Form("DamSireAKC") 
	DamSireUKC=Request.Form("DamSireUKC") 
		DamSireLink=Request.Form("DamSireLink") 

	SireName=Request.Form("SireName")
	SireColor=Request.Form("SireColor")
	SireAri=Request.Form("SireAri")
		SireAKC=Request.Form("SireAKC")
			SireUKC=Request.Form("SireUKC")
				SireLink=Request.Form("SireLink")
				SireComment=Request.Form("SireComment")

	SireDamName=Request.Form("SireDamName")
	SireDamColor=Request.Form("SireDamColor")
	SireDamAri=Request.Form("SireDamAri")
		SireDamAKC=Request.Form("SireDamAKC")
			SireDamUKC=Request.Form("SireDamUKC")
				SireDamLink=Request.Form("SireDamLink")
	SireSireName=Request.Form("SireSireName")
	SireSireColor=Request.Form("SireSireColor")
	SireSireAri=Request.Form("SireSireAri")
		SireSireAKC=Request.Form("SireSireAKC")
			SireSireUKC=Request.Form("SireSireUKC")
				SireSireLink=Request.Form("SireSireLink")

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

str1 = DamName
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamName= Replace(str1, "'", "''")
End If

str1 = DamDamName
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamDamName= Replace(str1, "'", "''")
End If

str1 = DamSireName
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamSireName= Replace(str1, "'", "''")
End If

str1 = SireName
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireName= Replace(str1, "'", "''")
End If

str1 = SireDamName
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireDamName= Replace(str1, "'", "''")
End If

str1 = SireSireName
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireSireName= Replace(str1, "'", "''")
End If

str1 = DamComment
str2 = "'"
If InStr(str1,str2) > 0 Then
	DamComment= Replace(str1, "'", "''")
End If

str1 = SireComment
str2 = "'"
If InStr(str1,str2) > 0 Then
	SireComment= Replace(str1, "'", "''")
End If

	Query =  " UPDATE Ancestors Set DamName = '" +  DamName + "', " 
    Query =  Query + " DamColor = '" +  DamColor + "'," 
    Query =  Query + " DamAri = '" +  DamAri + "'," 
    Query =  Query + " DamLink = '" +  DamLink + "'," 
	    Query =  Query + " DamComment = '" +  DamComment + "'," 
    Query =  Query + " MaternalGranddam = '" +   DamDamName + "'," 
    Query =  Query + " MaternalGranddamsColor = '" +  DamDamColor + "'," 
    Query =  Query + " MaternalGranddamsAri = '" +  DamDamAri + "'," 
    Query =  Query + " MaternalGranddamsLink = '" +  DamDamLink + "'," 
    Query =  Query + " MaternalGrandsire = '"  +  DamSireName + "'," 
    Query =  Query + " MaternalGrandsiresColor = '" +  DamSireColor + "',"
    Query =  Query + " MaternalGrandsiresAri = '" +  DamSireAri + "',"
    Query =  Query + " MaternalGrandsiresLink = '" +  DamSireLink + "',"
	Query =  Query + " Sire = '" +  SireName + "'," 
	Query =  Query + " SireColor = '" +  SireColor + "'," 
	Query =  Query + " SireAri = '" +  SireAri + "'," 
	Query =  Query + " SireLink = '" +  SireLink + "'," 
	Query =  Query + " SireComment = '" +  SireComment + "'," 
	Query =  Query + " PaternalGranddam = '" +  SireDamName + "',"
	Query =  Query + " PaternalGranddamColor = '" +  SireDamColor + "',"
	Query =  Query + " PaternalGranddamAri = '" +  SireDamAri + "',"
	Query =  Query + " PaternalGranddamLink = '" +  SireDamLink + "',"

	Query =  Query + " PaternalGrandsire = '" +  SireSireName + "',"
	Query =  Query + " PaternalGrandsiresColor = '" +  SireSireColor + "'," 
	Query =  Query + " PaternalGrandsiresARI = '" +  SireSireAri + "'," 
	Query =  Query + " PaternalGrandsiresLink = '" +  SireSireLink + "'" 
    Query =  Query + " where ID = " + ID + ";" 

	'response.write(Query)

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 



DataConnection.Execute(Query) 


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 Else
 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
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
			To continue editing ancestry data select an animal below and push the edit button:<br>
			<form action= 'AncestorData3.asp' method = "post">
			&nbsp; &nbsp; <a href = "AncestorData2.asp" class ="body">

			
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
