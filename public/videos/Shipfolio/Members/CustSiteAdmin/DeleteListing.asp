<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete an Listing</title>
<link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="Header.asp"--> 
<!--#Include file="storeHeader.asp"--> 
<!--#Include file="GlobalVariables.asp"--> 

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body">
			 <H2>Delete a Product<br>
			<img src = "images/underline.jpg" width = "600"></H2>
			To delete an product simply select it below and push the button.<br> <b>But careful. Once a listing is deleted from your database, it's gone!</b><br><br>
		</td>
	</tr>
</table>

<%  
dim aID(40000)
dim aName(40000)
dim aAdType(40000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts where custID = " & session("custID") & " order by Prodname "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	recordcount = rs2.recordcount
	While Not rs2.eof  
		aID(acounter) = rs2("prodID")
		aName(acounter) = rs2("ProdName")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top" >
	<tr>
	<td width = "10">&nbsp;</td>
		<td class = "body" valign = "top" align = "center">
	
			<%If recordcount = 0 then %>		
					<h1>You do not currently have any products listed to delete.</h1>
			<% Else %>
			<form action= 'DeleteListinghandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
			   <tr>
				 <td align = "center">
					<b>Product</b><br>
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
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "body" >
				</td>
			  </tr>
			  <tr>
			     <td height = "200">&nbsp;
				 </td>
				</tr>
		    </table>
		  </form>
		  <% End If %>
		</td>
	</tr>
</table>

<!--#Include file="Footer.asp"--> </Body>
</HTML>