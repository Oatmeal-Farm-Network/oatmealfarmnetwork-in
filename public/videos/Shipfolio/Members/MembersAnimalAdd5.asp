<!DOCTYPE HTML >
<HTML>
<HEAD>
<title>Add an Animal Step 5</title>
<link rel="stylesheet" type="text/css" href="/style.css">
</HEAD>
<BODY  >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 
<% Current2="Animals" 
	Hidelinks = True
	Current3 = "AddAnimals"
	Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName
	%> 
<!--#Include file="MembersHeader.asp"-->
<div class ="container roundedtopandbottom">


<%

Dim TotalCount
dim rowcount
dim ID
dim Description

BusinessID = Request.querystring("BusinessID")

SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if

NumberofAnimals = Request.querystring("NumberofAnimals")

TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 1

AnimalID=Request.Form("AnimalID")
if len(AnimalID) > 0 then
else
AnimalID = Request.querystring("AnimalID")
end if

SpeciesID=Request.Form("SpeciesID")
if len(SpeciesID) > 0 then
else
SpeciesID= Request.querystring("SpeciesID")
end if
Description=Request.Form("Description") 

Dim str1
Dim str2
str1 = Description
str2 = "'"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "''")
	
End If  

str1 = Description
str2 = vbCrLf
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , "</br>")
	
End If  
	
'Description1 = Left(description, 2000)
'If Len(Description) < 2001 Then
'	Description2 = ""
'Else
'	Rightlength = Len(Description) - 2000
'	response.write("rl=" & rightlength)
'	Description2 = right(description, Rightlength)
'End If 


 sql2 = "select FullName from Animals where AnimalID = " &  AnimalID & ";" 	
	Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
    If not rs2.eof Then
      Name = rs2("FullName")
    end if


Query =  " UPDATE Animals Set Description = '" & Description & "' "
Query =  Query & " where AnimalID = " & AnimalID & ";" 

Conn.Execute(Query) 

	  rowcount= rowcount +1

'response.write("SpeciesID=" & SpeciesID)
If speciesID = 23 or speciesID = 18 or speciesID = 13 or speciesID = 21 or speciesID = 26 or speciesID = 19 or speciesID = 29 or speciesID = 33 or speciesID = 28 or speciesID = 30 or NumberofAnimals > 1 then
	response.redirect("MembersAnimalAdd6.asp?BusinessID=" & BusinessID & "&ID=" & ID & "&SpeciesID=" & SpeciesID & "&NumberofAnimals=" & NumberofAnimals)
end if
%>


<div class="row">
        <div class="col-sm-12">
            <H3>Awards</H3><a name="Top"></a>
        </div>
</div>

<div >
	<div>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%"   >

<form action= 'MembersAnimalAdd6.asp?wizard=True&BusinessID=<%=BusinessID %>&AnimalID=<%=AnimalID%>&SpeciesID=<%=SpeciesID %>&NumberofAnimals=<%=NumberofAnimals%>' method = "post">

	<% For rowcount = 1 To 10 %>
  <tr>
  <td align = "left">Year</td>
		<td align = "left">Show</td>
	</tr>
	<tr >
		<td align = "left" valign = "top">
			<select size="1" name="AwardYear(<%=rowcount%>)" style="width: 200px; text-align: left" class='formbox'>
				<option value=" "></option>
			    <% currentyear = year(date) 
				For yearv= currentyear To 1983 step -1  %>
				<option value="<%=yearv%>"><%=yearv%></option>		
				<% Next %>
             </select>
		</td>
		<td  align = "left" valign = "top">
			<input name="Show(<%=rowcount%>)" value= ""  style="width: 400px; text-align: left" class='formbox'>
		</td>
    </tr>
      <td align = "left">Class</td>
		<td align = "left">Placing</td>
	</tr>
    <tr>
		<td  align = "left" valign = "top">
          <% if speciesID = 2 then %>
				<select size="1" name="AClass(<%=rowcount%>)" class ='formbox'>
				<option value="" selected></option>
				<option value="Halter">Halter</option>
				<option value="Fleece">Fleece</option>
				<option value="Composite">Composite</option>
				<option value="Shorn">Shorn</option>
				<option value="Spin-off">Spin-off</option>
				<option value="Get of Sire">Get of Sire</option>
				<option value="Produce of Dam">Produce of Dam</option>
				<option value="Performance">Performance</option>
				</select>
		<% else %>
            <input size="28" type = "text" name="AClass(<%=rowcount%>)" style="width: 200px; text-align: left" class='formbox'>
        <% end if %>
		</td>
		<td  align = "left" valign = "top">
            <% if speciesID = 2 then %>
				<select size="1" name="Placing(<%=rowcount%>)" style="width: 200px; text-align: left" class='formbox'>
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
          <% else %>
            <input size="28" type = "text"  name="Placing(<%=rowcount%>)" style="width: 200px; text-align: left" class='formbox'>
        <% end if %>
	</td>
</tr>
 <tr>
  <td align = "left" colspan = 2>Description</td>
</tr>
<tr>
	<td colspan = 2 align = "left">
       <textarea class="formbox" id="Description" cols="55" rows="2" name="AwardDescription(<%=rowcount%>)" rows="1"></textarea>
	</td>
</tr>
<tr><td colspan = 2 align = "left" ><img src = "/images/px.gif" width = 100% height = 2/></td></tr>
<tr><td colspan = 2 align = "left" ><img src = "/images/px.gif" width = 100% height = 2/></td></tr>
	<% next %>
</table>
</div>
</div>
<div >
    <div align = "center">
            <Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type=submit value = "Next" size = "110" Class = "regsubmit2" >
			</form>
<br /><br />
		</div>
</div>
</div>


<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>
