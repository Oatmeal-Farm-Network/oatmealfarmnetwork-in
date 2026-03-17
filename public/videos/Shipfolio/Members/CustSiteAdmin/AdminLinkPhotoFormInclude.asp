

<%

			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			sql = "select * from Links where Linkid = " & LinkID
				'response.write(sql)
				rs.Open sql, conn, 3, 3

				If rs.eof Then
					Query =  "INSERT INTO Links (ID)" 
					Query =  Query & " Values (" &  LinkID & ")"

					'response.write(Query)
					
					Set DataConnection = Server.CreateObject("ADODB.Connection")

					DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
					DataConnection.Execute(Query) 
				rs.close

				sql = "select * from Links where LinkID = " & LinkID
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				
				End If 

					If Len(rs("LinkImage")) > 2 Then
							File1= rs("LinkImage")
				    else
						File1 = "/uploads/ImageNotAvailable.jpg"
					End if

				

			str1 = File1
			str2 = "''"
			If InStr(str1,str2) > 0 Then
				File1= Replace(str1,  str2, "'")
			End If  	 

			TempLinkText = rs("LinkText")

	rs.close
Dim LinkImage(1000)
Dim LinkText(1000)
Dim LinkIDArray(1000)			
%>

<% if mobiledevice = False  then %>     
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Upload Image for <%=TempLinkText %></div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
    <%  conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Links order by LinkText ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		LinkIDArray(acounter) = rs2("LinkID")
		LinkText(acounter) = rs2("Linktext")
		LinkImage(acounter) = rs2("LinkImage")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>
		
		<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Select Another Link</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" width = "960">

			<font class = "body">
		<form  action="AdminLinkPhotos.asp" method = "post">  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>Select one of your links:
					<select size="1" name="LinkID">
					<option name = "ALinkID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "ALinkID1" value="<%=LinkIDArray(count)%>">
							<%=Linktext(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" class="regsubmit2" >	 </form>
	 </font>
				</td>
			  </tr>
		    </table>

	 		</td>
			  </tr>
		    </table>
	<br />
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Upload Link Image</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">
   <table Border = "0" Bgcolor = "#dedede" width = "900" align = "center">
		<tr>
			<td colspan = "2">
				<h1>Link Image</h1>
			</td>
		</tr>
		<tr>
			<td width = "150" align = "center">
					<img src = "<%=File1%>" width = "100" >
					<center><b><%=PhotoCaption1%></b></center>
			</td>
			<td class = "body">
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLinkUploadImage.asp" >
	

						Upload New Photo: <input name="attach1" type="file" size=35 class="Submit" >
						<input  type=submit value="Upload" class="Submit">
					</form>

					<form action= 'AdminLinkRemoveImage.asp' method = "post">
							Would you like to remove this image? 
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="LinkID" value= "<%= LinkID %>" >
							<input type=submit value="Remove This Image" class="regsubmit2">
					</form>
			</td>
			</tr>
		</table>
			</td>
			</tr>
		</table>
    <br> 
    
    <% else %>
    
    
    <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "body">
<a href = "AdminLinkMaintenance.asp" class = "body"><b>Edit Links</b></a>
		
		<H1><div align = "left">Upload Image for <%=TempLinkText %></div></H1>
        </td></tr>
        <tr><td  align = "center" width = "100%">
    <%  conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
	"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from Links order by LinkText ;"
'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		LinkIDArray(acounter) = rs2("LinkID")
		LinkText(acounter) = rs2("Linktext")
		LinkImage(acounter) = rs2("LinkImage")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
 <table Border = "0"  width = "100%" align = "center">
		<tr>
			<td  align = "center" class = "body">
					<center><img src = "<%=File1%>" width = "150" ></center><br />
					<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminLinkUploadImage.asp" >
							Upload New Photo: <input name="attach1" type="file" size=20 class="regsubmit2 body" ><br /><br />
						<center><input  type=submit value="Upload" class="regsubmit2 body" ></center>
					</form><br />
            </td></tr>
            <tr><td colspan = "2">
					<br /><form action= 'AdminLinkRemoveImage.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="LinkID" value= "<%= LinkID %>" >
							<center><input type=submit value="Remove This Image" class="regsubmit2 body" ></center>
					</form>
			</td>
			</tr>
		</table>

    <br> 
       <br>   <br>
    <% end if %>