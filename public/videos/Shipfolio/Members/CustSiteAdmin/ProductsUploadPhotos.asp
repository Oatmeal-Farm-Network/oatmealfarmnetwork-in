<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload Product Photos</title>
       <link rel="stylesheet" type="text/css" href="style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<% Showsearch = True %>
<!--#Include file="Header.asp"--> 
<!--#Include file="storeHeader.asp"--> 
<!--#Include file="Globalvariables.asp"--> 



<% 
ProdID=request.form("ProdID") 
'response.write("ProdID1=")
'response.write(ProdID)
If Len(ProdID) < 1 then
	ProdID= Request.QueryString("ProdID") 
End If
Session("ProdID") = ProdID
'response.write("ProdID2=")
'response.write(ProdID)
Dim ProdIDArray(10000)
Dim Prodname(100000)
Dim AdType(100000)
Dim	IDArray(100000) 
 If Len(ProdID) = 0 Then 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
    "Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts  where custID = " & session("custid") & " order by Prodname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		ProdIDArray(acounter) = rs2("ProdID")
		Prodname(acounter) = rs2("Prodname")
		
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
<table border = "0" width = "800"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "left" valign = "top">
					<tr>
							<td colspan = "2" ><br><h1>Upload Product Photos - Step 1: Select a Product</h1></td>
					</tr>
					<tr>
						<td colspan = "2"   height = "2"  background = "images/Underline.jpg"><img src = "images/px.gif". height = "2"></td>
					</tr>
				<tr>
						<td colspan = "2"   height = "5"  class = "body"></td>
					</tr>

				

<form action="ProductsuploadPhotos.asp" method = "post">
		
			   <tr>
				<td width ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your products:<br>
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=ProdIDArray(count)%>">
							<%=Prodname(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "body" >
				</td>
			  </tr>
			  <tr>
			      <td height = "200"> &nbsp;</td>
			</tr>
		    </table>
		  </form>
		  <br><br><br><br>
<% Else %>
	
   <!-- #include file="ProductsPhotoFormInclude2.asp" -->
 <% End if %>
		  <br><br><br><br>
  <!-- #include file="Footer.asp" -->
 </Body>
</HTML>
