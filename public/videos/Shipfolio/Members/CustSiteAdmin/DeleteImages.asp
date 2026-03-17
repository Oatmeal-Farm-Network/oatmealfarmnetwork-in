<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Delete Images Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 background = "images/background.jpg">
<!--#Include virtual="/Administration/Header.asp"--> 
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Delete Images<br>
			<img src = "images/underline.jpg"></H2>
			Perhaps you have images that you have uploaded but you would like removed from the system. To have them removed scroll down to:
			<ul>
				<li><a href = "#ListPage" class ="ranchname" >List Page Images (small) </a> or</li>
				<li><a href = "#DetailPage" class ="ranchname" >Detail Page Images (Large)</a></li>
			</ul>
			and select the images that you would like deleted and then select the "Submit" button. This will create a email that will be sent to WebArtists.biz. We will get the email, backup your images, delete the requested images, and then send you an email confirming that the images have been deleted.<br>
			<br>
			
			<big>Make sure that the images you want deleted are NOT associated with any animals!</big>
			<br><br>
		</td>
	</tr>
</table>


<center>

<a name="ListPage"></a><h3>Delete List Page Images (Small)</h3></center>
<FORM NAME="DeleteImagesSendEmail" ACTION="DeleteImagesSendEmail.asp" METHOD="POST" >	
	<input name="_recipients" type="hidden" value="johna@webartists.biz">
    	<input name="_subjectField" type="hidden" value="name">
		 <input TYPE="hidden" name="FileType"  value = "ListPage">
<table width="550" border="1" align="CENTER" cellpadding="3" >
		<tr>
			<th >Delete Image</th >
			<th >File Name</th >
			<th >Image</th >
	</tr>
	<%
			dim fs,fo,x, count
			dim FileName(400)
			dim  LongName(400)
			dim  DeleteImage(400)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\ecommerce-1\\richard\\alpacasontheweb.com\\www\\uploads\\ListPage")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) =  x.Name 
			  LongName(pcount) = "/Uploads/ListPage/" & x.Name %>
				<tr>
					<td align = "center">
						<input TYPE="hidden" name="Filename(<%=pcount%>)"  value = "<%= FileName(pcount)%>">
						<input TYPE="checkbox" name="DeleteImage(<%=pcount%>)"  >
					</td>
					<td>
						<%= FileName(pcount)%>
					</td>
					<td>
						<img src = "<%= LongName(pcount)%>" height = "40">
					</td>
				</tr>
			 <%pcount = pcount + 1
			Next
			TotalCount = pcount
			set fo=nothing
			set fs=nothing
			%>
            	<tr> 
                	<td align=center colspan="4" width="550" class = "body">   
							<input TYPE="hidden" name="TotalCount"  value = "<%=TotalCount%>">
                    		<input type="submit" value="Submit">
                    		<input type="reset" value="Reset"><br>
                	</td>
           	</tr>
	</table>
</form>

<center><a name="DetailPage"></a><h3>Delete Detail Page Images (Large)</h3></center>
<FORM NAME="DeleteImagesSendEmail" ACTION="DeleteImagesSendEmail.asp" METHOD="POST">	
	<input name="_recipients" type="hidden" value="johna@webartists.biz">
    	<input name="_subjectField" type="hidden" value="name">
					  <input TYPE="hidden" name="FileType"  value = "DetailPage">
<table width="550" border="1" align="CENTER" cellpadding="3" >
		<tr>
			<th >Delete Image</th >
			<th >File Name</th >
			<th >Image</th >
	</tr>
	<%
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\ecommerce-1\\richard\\alpacasontheweb.com\\www\\uploads\\DetailPage")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) =  x.Name 
			  LongName(pcount) = "/Uploads/ListPage/" & x.Name %>
				<tr>
					<td align = "center">
						<input TYPE="hidden" name="Filename(<%=pcount%>)"  value = "<%= FileName(pcount)%>">
						<input TYPE="checkbox" name="DeleteImage(<%=pcount%>)"  >
					</td>
					<td>
						<%= FileName(pcount)%>
					</td>
					<td>
						<img src = "<%= LongName(pcount)%>" height = "40">
					</td>
				</tr>
			 <%pcount = pcount + 1
			Next
			TotalCount = pcount
			set fo=nothing
			set fs=nothing
			%>
            	<tr> 
                	<td align=center colspan="4" width="550" class = "body">   
							<input TYPE="hidden" name="TotalCount"  value = "<%=TotalCount%>">
                    		<input type="submit" value="Submit">
                    		<input type="reset" value="Reset"><br>
                	</td>
           	</tr>
	</table>
</form>

<!--#Include virtual="/administration/Footer.asp"--> 
</body>
</html>