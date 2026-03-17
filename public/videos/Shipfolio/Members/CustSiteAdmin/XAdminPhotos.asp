<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload Photos</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 
  <!--#Include virtual="/administration/Dimensions.asp"--> 
<!--#Include virtual="/Administration/AlpacasHeader.asp"--> 


<% 
ID= Request.Form("ID")
'response.write("ID=")
'response.write(ID)
session("AnimalID") = ID

 If Len(ID) = 0 Or ID = "" Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from ExternalStud order by Alpacaname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ExternalStudID")
		alpacaName(acounter) = rs2("AlpacaName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "775">
			<tr>
				<td class = "body">
					<H1>Upload Photos of Other People's Studs</H1>			
				</td>
			</tr>
		</table>
<form action="XAdminPhotos.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of the listed outside studs:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
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
	
 <!-- #include file="XPhotoFormInclude.asp" -->
 <% End if %>

  <!-- #include file="Footer.asp" -->
 </Body>
</HTML>
