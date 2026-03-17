   <%
'Option Explicit

Dim DestinationPath
DestinationPath = Server.mapPath("UploadFolder")

Dim Form: Set Form = New ASPForm %>

<!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 2000
Form.SizeLimit = &H100000

If Form.State = 0 Then 'Completted
	Form.Files.Save DestinationPath 
   tempname = Upload.Form("AID")
	response.write "<br>Files (" & Form.TotalBytes \1024 & "kB) was saved to " & tempname & " folder."

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then


%>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
  <title>Add a New Animal Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
 
<SCRIPT TYPE="text/javascript">
<!--
function popup(mylink, windowname)
{
if (! window.focus)return true;
var href;
if (typeof(mylink) == 'string')
href=mylink;
else
href=mylink.href;
window.open(href, windowname, 'width=400,height=200,scrollbars=yes');
return false;
}
//-->
</SCRIPT>




</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

<!--#Include virtual="/Administration/Header.asp"--> 

<table align = "center" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Add a new animal
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<form method="POST" ENCTYPE="multipart/form-data">


<%  
dim aID(200)
dim aName(200)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals"

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

public tempname

%>
  

		<select size="1" name="FullName">
		<option name = "ID" value= "" selected></option>
		<% count = 1
			while count < acounter
			response.write(count)
		%>
			<option name = "AID" value="<%=aID(count)%>" ><%=aID(count)%><%=aName(count)%></option>
		<% 	count = count + 1
			wend %>
		</select>

   File 1 : <input type="file" name="File1" value = <%=tempname%>><br>
 <%=tempname%>

<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input Name=SubmitButton Value="Upload files &gt;&gt;" Type=submit><br>

</Form>



</BODY></HTML>
