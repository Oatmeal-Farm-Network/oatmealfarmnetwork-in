
<%

			conn2 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs3 = Server.CreateObject("ADODB.Recordset")
			
			sql3 = "select * from ExternalStud where ExternalStudID = " & ID
				'response.write(sql)
				rs3.Open sql3, conn2, 3, 3
	
					ServiceSireImage = rs3("ExternalStudImage")
					If Len(ServiceSireImage) > 2 Then
						File1 =ServiceSireImage
					else
						File1= rs3("ExternalStudImage")
					End If
					 If Len(ServiceSireImage) > 3 Then

					 else
						File1 = "/Uploads/ImageNotAvailable.jpg"
					End if


			str1 = ServiceSireImage
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				ServiceSireImage= Replace(str1,  str2, "'")
			End If  	 

			



%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Upload Photos for <%=rs3("ExternalStudName")%></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">
    	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "960">
<%  
dim IDArray(1000) 
dim alpacaName(1000) 
				rs3.close
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	sql4 = "select * from ExternalStud order by ExternalStudName"
'response.write(sql2)
	acounter = 1
	Set rs4 = Server.CreateObject("ADODB.Recordset")
	rs4.Open sql4, conn, 3, 3 
	
	While Not rs4.eof  
		IDArray(acounter) = rs4("ExternalStudID")
		alpacaName(acounter) = rs4("ExternalStudName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs4.movenext
	Wend		
	
		rs4.close
		set rs4=nothing
		set conn = nothing



%>
<tr><td align = "right">
<table border = "0" cellspacing="0" cellpadding = "0" align = "right" width = "400"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Select Another Outside Stud</div></H2>
</td></tr>
<tr><td class = "roundedBottom body2"  valign = "top">

		<form  action="AdminOutsidePhoto.asp" method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center" width = "400">
<tr><td class = "body">
					Select one of listed outside studs:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						'response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit"  class = "regsubmit2" >
				</td>
			  </tr>
		    </table>
		    </td>
			  </tr>
		    </table>
	 </form>
	 
	</td></tr>
	<tr><td> 
	<br /><br /> 
	 
	 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "400"><tr><td class = "roundedtop" align = "left">
<H2><div align = "left">Upload Stud Photo</div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "150" valign = "top">
	 
   <table Border = "0"  width = "900" align = "center">
	<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" height = "100">
					
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminOutsideStudUpload.asp" >
						<% If Not (File1 = "ImageNotAvailable.jpg") Then %>

						<% Else %>
							Current Image: <b>Not Defined</b><br>
						<% End If %>

			
					
						Upload New Photo: <input name="attach1" type="file" size=35 class = "regsubmit2"  >
						<input  type=submit value="Upload" class = "regsubmit2" >
					</form>
					<form action= 'AdminXRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<input type=submit value="Remove This Image" class = "regsubmit2" >
					</form>
			</td>
			</tr>
		</table>
</td>
			</tr>
		</table>

    <br> 