<!DOCTYPE html>
<%@ Language=VBScript %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<HEAD>
 <title>Edit Your Animal Listing</title>
       <link rel="stylesheet" type="text/css" href="/style.css">
</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/administration/AdminGlobalVariables.asp"-->
<% 
Current2="AnimalsHome"
Current3="AnimalEdit" %> 
<!--#Include virtual="/administration/adminHeader.asp"-->
<% 

ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
if len(ID) > 0 then
Response.redirect("editanimal.asp?ID=" & ID)
end if

end if



If Len(ID) > 0 then
sql2 = "select * from Photos where ID = " &  ID & ";" 
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
If rs2.eof Then
Query =  "INSERT INTO Photos (ID)" 
Query =  Query & " Values (" &  ID & ")"
Conn.Execute(Query) 
End If 
End if

sql2 = "select Animals.ID, Animals.FullName from Animals where PeopleID = " & session("PeopleID") & " order by Fullname"
acounter = 1
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3 
	if rs2.eof then 
   'NumberofAnimals = rs2("NumberofAnimals")  
    %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"  ><tr><td class = "body roundedtopandbottom" align = "left">
		<H2><div align = "left">Edit a Listing</div></H2>
        Currently you do not have any animals entered. To add animals please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add Animals</a> tab.<br /><br />
        </td>
        </tr>
        </table>
        
<%	else
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ID")
		alpacaName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing

 If Len(ID) = 0 Then %>
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "989" height = "300" ><tr><td class = "roundedtopandbottom" align = "left" valign = "top">
<H2><div align = "left">Transfer an Animal's Listing</div></H2>
<form  action="TransferAnimalManager.asp" method = "post" name = "edit1">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 valign = "top">
<tr><td colspan ="30">
					&nbsp;
				</td>
	<td class = "body" valign = "top">
					<br>Select one of your animals:
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<input type=submit Value = "Submit" class = "regsubmit2" >
				</td>
 </tr>
		    </table>
		  </form>
<br><br><br>
</td>
</tr>
<tr><td></td></tr>
</table>

<% End if %>
<% End if %>
<!--#Include virtual="/administration/Footer.asp"-->

 </Body>
</HTML>
