<!DOCTYPE html>
<% ' Clean directory NEA 4/2012 %>
<HTML>
<HEAD>
<title>The Andresen Group Content Management System</title>
<link rel="stylesheet" type="text/css" href="style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% 
dim IDArray2(1000) 
Dim ListAnimalName2(1000)
		
ID= Request.QueryString("ID") 
		If Len(ID) < 1 then
			ID= Request.Form("ID") 
		End If 
		

if ID > 0 then
Session("AnimalID") = ID
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
				
				 sql = "select FullName from Animals where ID = " & ID
				    rs.Open sql, conn, 3, 3
				   'response.write(rs.recordcount)
				If not rs.eof  Then
				name = rs("FullName")
				End if

end if
%>
	<!--#Include File="AdminHeader.asp"--> 
	     <% 
   Current3 = "AlpacaPhotos" %> 
 <!--#Include file="AdminAnimalsTabsInclude.asp"-->
<table width = "900" height = "300" align = "center"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr><td class = "body" valign = "top" >

<%  
'response.write("ID=")
'response.write(ID)

 If Len(ID) = 0 Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals  order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ID")
		ListAnimalName2(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Upload Photo</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">


<form action="AdminPhoto.asp" method = "post" name = "edit2">
			  <table border = "0" width = "900"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				
				 <td class = "body">
					<br>Select one of your animals:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ListAnimalName2(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
							<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
	</td>
			  </tr>
		    </table>	  	
<% Else %>
	
 <center><!-- #include file="AdminPhotoFormInclude.asp" --></center>
 <% End if %>
	</td>
			  </tr>
		    </table>
		    <br /><br />
  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
