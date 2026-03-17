<!DOCTYPE HTML >
<HTML>
<HEAD>
<title>Add an Animal Step 5</title>
<link rel="stylesheet" type="text/css" href="/style.css">

<%

Dim TotalCount
dim rowcount
dim ID
dim Description


TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 1

ID=Request.Form("ID")
if len(ID) > 0 then
else
ID = Request.querystring("ID")
end if

if len(ID) > 0 then
	AnimalID= ID
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



Query =  " UPDATE Animals Set Description = '" & Description & "' "
Query =  Query & " where ID = " & ID & ";" 

Conn.Execute(Query) 

	  rowcount= rowcount +1

%>
</HEAD>
<BODY   >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 
<% Current2="AddAlpaca" %> 
<!--#Include file="MembersHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" valign = "top" height = "650">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" width = "800" >
	<tr>
		<td class = "body" align = "left">
			<h2><font color = "black">Awards</font></h2>Here you can enter up to 10 awards for you animal. There is room to enter the name of the show, your placing, and some Description (i.e. "placed first in a class of 12" or 'the judge said his fleece was outstanding").<br>
		</td>
	</tr>
</table>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center"  >

<form action= 'MembersAnimalAdd6.asp?wizard=True&PeopleID=<%=PeopleID %>&ID=<%=ID%>' method = "post">
  <tr>
  <th class = "body"><b>Year</b></th>
		<th class = "body"><b>Show</b></th>
		<th class = "body"><b>Class</b></th>
		<th class = "body"><b>Placing</b></th>
		<th class = "body"><b>Comments</b></th>
	</tr>
	<% For rowcount = 1 To 13 %>
	<tr >
				<td  align = "center" valign = "top">
					<select size="1" name="AwardYear(<%=rowcount%>)">
					<option value=" "></option>
				
			<% currentyear = year(date) 
						For yearv= currentyear To 1983 step -1  %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
				</td>
				<td  align = "center" valign = "top">
					<input name="Show(<%=rowcount%>)" value= "" size = "40">
				</td>
				<td  align = "center" valign = "top">
                <% if speciesID = 2 then %>
					<select size="1" name="AClass(<%=rowcount%>)">
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
        <input size="28" type = "text" name="AClass(<%=rowcount%>)">

        <% end if %>
	
				</td>
				<td  align = "center" valign = "top">
                  <% if speciesID = 2 then %>
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
                <% else %>
                	<input size="28" type = "text"  name="Placing(<%=rowcount%>)">
                <% end if %>
				</td>
				<td  align = "center"><textarea name="AwardDescription(<%=rowcount%>)"  cols="12" rows="4"   class = "body"   ></textarea>

				</td>

		</tr>
	<% next %>
		</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center" >
<tr>
		<td  align = "right"><br />
            <Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type=submit value = "Save & Proceed to Next Page" size = "110" Class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"--> </Body>
</HTML>
