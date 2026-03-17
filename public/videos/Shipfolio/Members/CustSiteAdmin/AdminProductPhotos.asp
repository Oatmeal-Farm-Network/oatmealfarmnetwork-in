<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include file="AdminGlobalvariables.asp"--> 
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<!--#Include File="AdminHeader.asp"--> 
<br />
<% Current3 = "ProductPhotos"  %> 
<!--#Include virtual="/Administration/AdminProductsTabsInclude.asp"-->
<%  
Dim IDArray2(1000)
Dim ProductName2(1000)

ID= Request.QueryString("ID")
 
If Len(ID) < 1 then
	ID= Request.Form("ID") 
End If 
Session("ProductId")= ID
ProdID = ID
Dim ProductName(200) 


 If Len(ID) = 0 Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select ProdID, ProdName from sfProducts  order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray2(acounter) = rs2("ProdID")
		ProductName2(acounter) = rs2("ProdName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Upload Photos</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "960"  height = "200" valign = "top">
      

<form action="AdminProductPhotos.asp" method = "post">
			  	<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center">
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your products:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray2(count)%>">
							<%=ProductName2(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		  </form>
<% Else %>
	
 <!-- #include file="AdminProductsPhotoFormInclude2.asp" -->
 <% End if %>
</td>
</tr>
</table>
<br />
  <!-- #include file="AdminFooter.asp" -->
 </Body>
</HTML>
