<!DOCTYPE HTML>

<HTML>
<HEAD>
 <title>The Andresen Group Content Management System</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"--> 
<body >


<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminDetailDBInclude.asp"--> 

<%

dim Caption
Dim captionGalleryID

'response.write (GalleryID)

'rowcount = CInt
rowcount = 1
GallerycatID=Request.Form("GallerycatID") 
Caption=Request.Form("Caption") 
GalleryID=Request.Form("GalleryID") 
 rowcount =1


conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
"User Id=;Password=;" '& _ 
		
sql2 = "select * from Gallery where GalleryCatID = " & GalleryCatID & " order by GalleryID DESC" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
'response.write(sql2)

rs2.Open sql2, conn2, 3, 3   
	
 newitemorder = rs2.recordcount +1
rs2.close
set rs2=nothing
set conn2 = nothing





str1 = Caption
str2 = ","
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, ",", "")
End If

str1 = Caption
str2 = "'"
If InStr(str1,str2) > 0 Then
	Caption= Replace(str1, "'", "''")
End If

Query =  " UPDATE Gallery Set Gallerycaption = '" &  Caption & "', "
Query =  Query & " GallerycatID  = " & GallerycatID  & "," 
Query =  Query & " ImageOrder  = " & newitemorder  & "" 
Query =  Query & " where GalleryID = " & GalleryID & ";" 

'response.write(Query)	


Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 


DataConnection.Execute(Query) 

	  rowcount= rowcount +1


IF DataConnection.Errors.Count <> 0 then
     Call MyErrorHandler(oDBConn, sSQL)  ' pass database connection as param
 End If

	DataConnection.Close
	Set DataConnection = Nothing 


conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
		"Data Source=" & server.mappath(DatabasePath) & ";" & _
		"User Id=;Password=;" '& _ 
		
		sql2 = "select * from Gallery where GalleryID = " & GalleryID & " order by GalleryID DESC" 
		Set rs2 = Server.CreateObject("ADODB.Recordset")
		'response.write(sql2)

		rs2.Open sql2, conn2, 3, 3   
	
		GalleryID = rs2("GalleryID")
		File1 = rs2("GalleryImage")
		PhotoCaption1 = rs2("GalleryCaption")
		rs2.close
		set rs2=nothing
		set conn2 = nothing

%>

        <%    Current3="AddImages" %> 
        
<% if mobiledevice = False  then %>
<!--#Include file="AdminGalleryTabsInclude.asp"-->
   	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Your Gallery Image Has Been Added</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<br /><br />


<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900"  align = "center"  valign = "top">
			<tr>
				<td class = "body" width = "100" >
					<img src = "<%=File1%>" width = "100"><br>
					<%=Caption%>
				</td>
				<td class = "body" valign = "bottom">
		
				</td>
			</tr>
		</table>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900"  align = "center"  valign = "top">
			<tr>
			   <td width = "80">&nbsp;</td>
				<td class = "body"><br><h2>Next Steps:</h2>
					<a href = "AdminGalleryAddImage1.asp" class = "body"><big>->Add Another Image</big></a><br><br>
					<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%=GalleryCatID %>" class = "body"><big>->Edit Your Gallery Images</big></a><br>
					<br>
					</td>
			</tr>
		</table>
		
<% else %>


 	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>-10">
 	<tr><td class = "body">
		<H2><div align = "left">Your Gallery Image Has Been Added</div></H2>

					<img src = "<%=File1%>" width = "100"><br>
					<%=Caption%><br>
<br><h2>Next Steps:</h2>
					<a href = "AdminGalleryAddImage1.asp" class = "body"><big>Add Another Image-></big></a><br><br>
					<a href = "AdminGalleryEditImages.asp?GalleryCatID=<%=GalleryCatID %>" class = "body"><big>Edit Your Gallery Images-></big></a><br>
					<br>
					</td>
			</tr>
		</table>

<% end if %>
 </Body>
</HTML>
