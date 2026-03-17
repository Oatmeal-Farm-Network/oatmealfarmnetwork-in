<!DOCTYPE HTML >
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<!--#Include file="AdminHeader.asp"--> 
<!--#Include file="AdminDetailDBInclude.asp"--> 
<!--#Include file="AdminDimensions.asp"--> 
<%  
PackageID=Trim(Request.Form("PackageID")) 
If Len(PackageID) < 1 then
	PackageID= Request.QueryString("PackageID") 
End if

session("PackageID") = PackageID
'response.write("PackageID=")
'response.write(PackageID)
Dim PackageIDArray2(1000)
Dim PackageTextArray(1000)


 If Len(PackageID) = 0 Then 

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Package order by PackageName"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		PackageIDArray2(acounter) = rs2("PackageID")
		PackageTextArray(acounter) = rs2("PackageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
			<tr>
				<td class = "body">
					<H1>Upload Photos </H1>			
				</td>
			</tr>
		</table>
<form action="AdminPackagePhotos.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your Packages:
					<select size="1" name="PackageID">
					<option name = "APackageID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "APackageID1" value="<%=PackageIDArray2(count)%>">
							<%=PackageTextArray(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
<% Else %>
	
 <!-- #include file="AdminPackagePhotoFormInclude.asp" -->
 <% End if %>

  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
