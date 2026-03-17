<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add an Alpaca Step 5</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">





</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">


<!--#Include virtual="/Administration/Header.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID
dim Description


TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 1

ID=Request.Form("ID") 
Description=Request.Form("Description") 


str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, "'", "''")
End If




Set DataConnection = Server.CreateObject("ADODB.Connection")

DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 


Query =  "INSERT INTO AnimalDescriptions (ID, Description)" 
		Query =  Query + " Values ('" &  ID & "'," 
		Query =  Query & " '" & Description  & "')"
		'response.write(query)

'response.write(Query)

DataConnection.Execute(Query) 

	  rowcount= rowcount +1


	DataConnection.Close
	Set DataConnection = Nothing 

%>

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body"><img src = "images/WizardHeader.jpg">
			<a name="Add"></a>
			<blockquote><H1>Step 5: Awards</H1>
			Here you can enter up to 20 awards for you animal. There is room to enter the name of the show, your placing, and some Description (i.e. "placed first in a class of 12" or 'the judge said his fleece was outstanding").<br>
		</blockquote>
		</td>
	</tr>
	
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "775">
	<tr>
		<td class = "body">
			<h2><font color = "brown">Step 5: Awards</font> <small></small></h2><br>
		</td>
	</tr>
	</table>

<form action= 'AddanAlpaca6.asp' method = "post">
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "775">


  <tr>
  <th >Year</th>
		<th >Show</th>
		<th >Class</th>
		<th >Placing</th>
		<th >Comments</th>
	</tr>
	<% For rowcount = 1 To 20 %>
	<tr >
				<td  align = "center" >
					<select size="1" name="AwardYear(<%=rowcount%>)">
					<option value=" "></option>
				
			<% currentyear = year(date) 
						For yearv=1983 To currentyear %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
				</td>
				<td  align = "center" >
					<input name="Show(<%=rowcount%>)" value= "" size = "40">
				</td>
				<td  align = "center">
					<select size="1" name="AClass(<%=rowcount%>)">
					<option value="" selected></option>
					<option value="Halter">Halter</option>
					<option value="Fleece">Fleece</option>
					<option value="Composite">Composite</option>
						<option value="Shorn">Shorn</option>
					<option value="Spin-off">Spin-off</option>
					<option value="Get of Sire">Get of Sire</option>
					<option value="Produce of Dam">Produce of Dam</option>
					</select>
		
	
				</td>
				<td  align = "center">
					<select size="1" name="Placing(<%=rowcount%>)">
					<option value="" selected></option>
					<option value="Color Champion">Color Champion</option>
					<option value="Res. Color Champion">Res. Color Champion</option>
		
					<option value="1st Place">1st Place</option>
					<option  value="2nd Place">2nd Place</option>
					<option  value="3rd Place">3rd Place</option>
					<option  value="4th Place">4th Place</option>
					<option  value="5th Place">5th Place</option>
					<option  value="6th Place">6th Place</option>
					<option  value="7th Place">7th Place</option>
					<option  value="8th Place">8th Place</option>
					<option  value="9">9th Place</option>
					<option  value="10th Place">10th Place</option>
					<option  value="11th Place">11th Place</option>
					<option  value="12th Place">12th Place</option>	
					<option value="Best Crimp">Best Crimp</option>
					<option value="Best Crimp">Judge's Choice</option>
				</select>
				</td>
				<td  align = "center">
					<input name="AwardDescription(<%=rowcount%>)" value= "" size = "26">
				</td>

		</tr>
	<% next %>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "775">
<tr>
		<td  valign = "middle">
			<div align = "center">
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type=submit value = "Next->" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" >
			</form>
		</td>

</tr>
</table>
<br>
<br>
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>
