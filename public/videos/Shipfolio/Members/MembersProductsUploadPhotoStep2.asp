

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Upload Photos</title>
       <link rel="stylesheet" type="text/css" href="style.css">


<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include file="Header.asp"--> 

<!--#Include file="MembersGlobalvariables.asp"--> 

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
ID=request.form("ID") 
If Len(ID) < 1 then
	ID= Request.QueryString("ID") 
End If
Session("ID") = ID
'response.write("ID=")
'response.write(ID)





Dim IDArray(1000)
Dim Prodname(10000)

 
  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts  where custID = " & session("custid") & " order by Prodname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ProdID")
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
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester.asp" >
			
						
					
						Upload Photo: 
						<input name="ID" type="hidden" value = "<%=ID%>">
						<input name="attach1" type="file" size=35 ><br>
						<input  type=submit value="Upload">
					</form>

					 

			</td>
		</table>


  <!-- #include file="Footer.asp" -->
 </Body>
</HTML>
