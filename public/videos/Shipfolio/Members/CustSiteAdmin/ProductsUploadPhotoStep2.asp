<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload Photos</title>
       <link rel="stylesheet" type="text/css" href="style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="Header.asp"--> 

<!--#Include file="Globalvariables.asp"--> 

<table border = "0" width = "625"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
					<tr>
							<td colspan = "2" ><h1>Upload Photos - Step 2: Upload Your Photo</h1></td>
					</tr>
					<tr>
						<td colspan = "2"   height = "2"  background = "images/Underline.jpg"><img src = "images/px.gif". height = "2"></td>
					</tr>
				<tr>
						<td colspan = "2"   height = "5"  class = "body"></td>
					</tr>
				</table>

<% 
ProdID=request.form("ProdID") 
If Len(ProdID) < 1 then
	ProdID= Request.QueryString("ProdID") 
End If
Session("ProdID") = ProdID
'response.write("ProdID=")
'response.write(ProdID)





Dim ProdIDArray(1000)
Dim Prodname(10000)

 
  
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

				


	
  <table Border = "0"  width = "600" align = "center">

		<tr>
			<td class = "body" align = "center">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="ProductsuploadStep3.asp" >
			
						
					
						Upload Photo: 
						<input name="ProdID" type="hidden" value = "<%=ProdID%>">
						<input name="attach1" type="file" size=35 ><br>
						<input  type=submit value="Upload">
					</form>

					 

			</td>
		</table>


  <!-- #include file="Footer.asp" -->
 </Body>
</HTML>
