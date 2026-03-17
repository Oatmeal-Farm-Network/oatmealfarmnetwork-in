<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Products</title>
       <link rel="stylesheet" type="text/css" href="style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="Globalvariables.asp"--> 

<!--#Include file="Header.asp"--> 
<!--#Include file="storeHeader.asp"--> 




<% 
ProdID=request.form("ProdID") 
If Len(ProdID) < 3 then
	ProdID= Request.QueryString("ProdID") 
End If
Session("ProdID") = ProdID
'response.write("ProdID=")
'response.write(ProdID)
Dim IDArray(1000)
Dim Prodname(10000)
Dim AdType(10000)
Dim ProductID(10000)

 If Len(ProdID) = 0 Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select distinct * from sfProducts  where custID = " & session("custid") & " order by Prodname"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("prodID")
		Prodname(acounter) = rs2("Prodname")
		ProductID(acounter) = rs2("ProductID")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<table border = "0" width = "675"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
					<tr>
							<td colspan = "2" ><h1>Edit Your Product - Step 1: Select a Product</h1></td>
					</tr>
					<tr>
						<td colspan = "2"   height = "2"  background = "images/Underline.jpg"><img src = "images/px.gif". height = "2"></td>
					</tr>
				<tr>
						<td colspan = "2"   height = "5"  class = "body"></td>
					</tr>

				

<form action="EditAd2.asp" method = "post">
		
			   <tr>
				<td width ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your listings:<br>
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=ProductID(count)%> -  <%=Prodname(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "body" >
				</td>
			  </tr>
		    </table>
		  </form>
<% Else %>
	
 <!-- #include file="ProductsPhotoFormInclude2.asp" -->
 <% End if %>

  <!-- #include file="Footer.asp" -->
 </Body>
</HTML>
