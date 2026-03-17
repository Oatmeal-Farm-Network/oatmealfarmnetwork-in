<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Upload & Associate PDF File</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">

<script>
var bResize	= false;
var cResize	= false;
function Clear() {
	try {
		document.selection.empty();
	} catch(err) {}
}

function Resize() {
	try{
		oObj	= document.getElementById(cell)
		oObjT	= document.all(cell+"T")
		if (event.button != 1) {bResize=false; cell=''; return;}
		if (bResize) {
			Clear();
			for(var i=0; i<oObjT.length; i++){
				oObjT(i).style.width=event.clientX-oObj.offsetLeft+document.body.scrollLeft-4;
			}
		}
	} catch(err) {}
	event.returnValue	= false;
}

function doFocus(obj) {
	obj.className	= 'inputfocus';
	obj.	= false;
	if (obj.createTextRange) {
		var v = obj.value;
		var r = obj.createTextRange();
		r.moveStart('character', v.length);
		r.select();
	}
}

function doBlur(obj) {
	obj.className	= 'inputblur';
	obj.	= true;
}

document.onmousemove	= Resize;
</script>

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 

<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <a href = "Upload"></a><H2>Upload PDF<img src = "images/web.gif">
			<img src = "images/underline.jpg"></H2>
			Before you can associate a file with an animal you have to copy it up to the server first. <br><br>
		</td>
	</tr>
</table>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td width = "400" align = "center">
	
			<p><font face="Verdana, Arial, Helvetica, sans-serif" size="2"></font></p>
			<p><b><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FF0000">only pdf format</font><br>
			</p>
			</center>
			
			<form ENCTYPE="multipart/form-data" ACTION="http://www.camelot-ranch.com/cgi-bin/uploadPDF.cgi" METHOD="POST"><center>
<input TYPE="FILE" NAME="file-to-upload-01" SIZE="35">
<p>
<input TYPE="SUBMIT" VALUE="Upload Now!">
    <p> <font size="1" face="Verdana, Arial, Helvetica, sans-serif">After clicking 
      &quot;Upload Now&quot; it may take a short while to send your file.</font><br>
</center>

	
		</td>
	</tr>
</table>
</form>
<table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <a href = "Associate"></a><H2>Associate PDF<img src = "images/web.gif">
			<img src = "images/underline.jpg"></H2>
			After your files have have been uploaded to the server they need to be associate with your site. Use the tool below to associate your PDF with  your site.<br><br>
			<br><br>
		</td>
	</tr>
</table>

<%  
dim aID(300)
dim aName(300)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Animals.FullName "

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>




<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td>
			</H3>
			<%
			dim fs,fo,x, count
			dim FileName(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\virtual\\carolb\\camelot-ranch.com\\www\\uploads\\PDF")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) = x.Name
			  ' Response.write(FileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing
			%>

			<form action= 'AddPDFhandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="AID">
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
					<b>PDF File</b><br>
					<select size="1" name="PDF">
					<option name = "PDFName" value= "" selected></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "FileName" value="<%=FileName(count)%>">
							<%=FileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=Submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>

</table>
<br><br>



</table>
<br><br><br>
<!--#Include virtual="/administration/Footer.asp"--> 
</BODY>
</HTML>