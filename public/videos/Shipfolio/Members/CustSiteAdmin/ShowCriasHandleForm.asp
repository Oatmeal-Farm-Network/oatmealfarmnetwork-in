<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4+0 Transitional//EN">
<HTML>
<HEAD>
 <title>Show Progeny Results Page</title>
      <link rel="stylesheet" type="text/css" href="style.css">
</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim	rowcount
dim	ID(200) 
dim	ShowWithSire(200) 
dim	ShowWithDam(200) 
Dim Gender(200)

TotalCount= Request.Form("TotalCount")
TotalCount = CInt(TotalCount)
'rowcount = CInt(rowcount)
rowcount = 1

while (rowcount < TotalCount)
    IDcount = "ID(" & rowcount & ")"
	ShowWithSirecount = "ShowWithSire(" & rowcount & ")"
	ShowWithDamcount = "ShowWithDam(" & rowcount & ")"
	Gendercount = "Gender(" & rowcount & ")"

	ID(rowcount)=Request.Form(IDcount) 
	ShowWithSire(rowcount)=Request.Form(ShowWithSirecount) 
	ShowWithDam(rowcount)=Request.Form(ShowWithDamcount) 
	Gender(rowcount)=Request.Form(Gendercount) 

'response.write(ShowWithDam(rowcount))
	rowcount = rowcount +1

Wend

 rowcount =1

while (rowcount < TotalCount)

If Gender(rowcount) = "Male" Then
	If ShowWithSire(rowcount) = "on" Then
		ShowWithSire(rowcount)  =  true
	Else
		ShowWithSire(rowcount)  =  False
	End if

	Query =  " UPDATE Animals Set ShowWithSire = " &  ShowWithSire(rowcount) 
    Query =  Query + " where ID = " & ID(rowcount) & ";" 
Else
'response.write("Female")
	If ShowWithDam(rowcount) = "on" Then
		ShowWithDam(rowcount)  = true
	Else
		ShowWithDam(rowcount)  = False
	End if

	Query =  " UPDATE Animals Set ShowWithDam = " &  ShowWithDam(rowcount) 
    Query =  Query + " where ID = " & ID(rowcount) & ";" 
End if



'response.write(Query)
Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 


DataConnection.Execute(Query) 


		
		DataConnection.Execute(Query) 
	  rowcount= rowcount +1
	Wend


 %>
<div align = "center"><H2>
<%
     response.write("Your changes have successfully been made.")
  %></H2>
</div>
<%

 

	DataConnection.Close
	Set DataConnection = Nothing 

%>
<%  
dim aID(40000)
dim aName(40000)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

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
<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body">
			<H2>Select the next Dam or Sire</H2>
			Select the next dam or sire who's cria you want to show...or not.
			<form action= 'ShowCrias.asp' method = "post">
			

			
				<input type = "hidden" name="PhotoType" value= "ListPage">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="Name">
					<option name = "Name" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "Name" value="<%=aName(count)%>">
							<%=aName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
