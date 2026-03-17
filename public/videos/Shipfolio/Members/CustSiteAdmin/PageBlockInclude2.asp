<table width = "720"><tr><td class = "body">

 <a name = "<%=Textblock%>"></a>
    
	 		<form action= 'PageDataHandleForm2.asp?PageName=<%=PageName%>' method = "post">
			<input name="TextBlock"  size = "60" value = "<%=Textblock%>" type = "hidden">

<input name="TempPageLayout2ID"  size = "60" value = "<%=TempPageLayout2ID%>" type = "hidden">

			
			
			<input name="Heading"  size = "50" value = "<%=PageHeading%>" class = "body"><br>
			<TEXTAREA NAME="Text" cols="65" rows="18" wrap="file" class = "body"><%=PageText%></textarea><br>
			<input type=submit value = "Submit Changes"  size = "110" Class = "body" >
	        </form>
	        <form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadaDownload.asp?PageLayout2ID=<%=TempPageLayout2ID%>&filename=<%=filename%>" >
	        

								Upload a Downloadable File <br>
								<% if len(Upload)> 40 then %>
								Download:  <b><%=right(Upload, len(Upload) - 39)%></b>
								<% end if %>
								<input name="attach1" type="file" size=35>
								<input  type=submit value="Upload">
							</form>
							<% if len(Upload)> 1 then %>

							<form action= 'RemoveUpload.asp' method = "post">
								<input type = "hidden" name="PageLayout2ID" value= "<%=TempPageLayout2ID %>" >
								<input type = "hidden" name="filename" value= "<%=filename%>" >
								<input type=submit value="Remove Image">
							</form>

	<% end if %>
	         	<td valign="top">
	 	
	 	
	 	</td>
	   </tr>
	   </table>
	   
	   <table width = "720"><tr><td class = "body">
<%=Textblock = "2A"%>
 <a name = "<%=Textblock%>"></a>
    
	        <form name="frmSend" method="POST" enctype="multipart/form-data" action="UploadaDownload2.asp?PageLayout2ID=<%=TempPageLayout2ID%>&filename=<%=filename%>" >
								Upload a Downloadable File <br>
								<% if len(Upload2A)> 1 then %>
								Download:  <b><%=right(Upload2A, len(Upload2A) - 39)%></b>
								<% end if %>
								<input name="attach1" type="file" size=35>
								<input  type=submit value="Upload">
							</form>
							<% if len(Upload)> 1 then %>

							<form action= 'RemoveUpload.asp' method = "post">
								<input type = "hidden" name="PageLayout2ID" value= "<%=TempPageLayout2ID %>" >
								<input type = "hidden" name="filename" value= "<%=filename%>" >
								<input type=submit value="Remove Image">
							</form>

	<% end if %>
	         	<td valign="top">
	 	
	 	
	 	</td>
	   </tr>
	   </table>