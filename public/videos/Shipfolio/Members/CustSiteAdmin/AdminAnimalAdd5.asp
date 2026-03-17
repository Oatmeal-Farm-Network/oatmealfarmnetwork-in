<!DOCTYPE HTML >
<HTML>
<HEAD>
 <link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminGlobalvariables.asp"-->
</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
<!--#Include file="AdminHeader.asp"--> 
<%

Dim TotalCount
dim rowcount
dim ID
dim Description


TotalCount= Request.Form("TotalCount")
'rowcount = CInt(rowcount)
rowcount = 1
speciesID = request.Form("speciesid")
ID=Request.Form("ID") 
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
	
Description1 = Left(description, 2000)
If Len(Description) < 2001 Then
	Description2 = ""
Else
	Rightlength = Len(Description) - 2000
response.write("rl=" & rightlength)
	Description2 = right(description, Rightlength)
End If 



Query =  " UPDATE Animals Set Description1 = '" & Description1 & "',  "
Query =  Query & " Description2 = '" & Description2 & "'  "
Query =  Query & " where ID = " & ID & ";" 

Conn.Execute(Query) 

rowcount= rowcount +1
row = "odd"
%>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" valign = "top" height = "650">
<br />
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "960" align = "center" width = "800" >
	<tr>
		<td class = "body" align = "left">
			<h2><font color = "black">Awards</font></h2>Here you can enter up to 10 awards for you animal. There is room to enter the name of the show, your placing, and some Description (i.e. "placed first in a class of 12" or 'the judge said he was outstanding").<br>
		</td>
	</tr>
</table>
<table border = "0"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "center"  >

<form action= 'AdminAnimalAdd6.asp?wizard=True&PeopleID=<%=PeopleID %>&ID=<%=ID%>' method = "post">

<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" />

  <tr bgcolor = "#EEeeee">
  <th class = "body" height = "20"><div align = "center"><b>Year</b></div></th>
 <th class = "body" height = "20"><div align = "center"><b>Show</b></div></th>
	 <th class = "body" height = "20"><div align = "center"><b>Class</b></div></th>
	 <th class = "body" height = "20"><div align = "center"><b>Placing</b></div></th>
	 <th class = "body" height = "20"><div align = "center"><b>Comments</b></div></th>
	</tr>
	<% For rowcount = 1 To 13 
If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<tr bgcolor = "#EEeeee">
<% Else %>
	<tr>
<% End If %>
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
		
	
				</td>
				<td  align = "center" valign = "top">
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
					<option value="Best Crimp">Judge's Choice</option>
				</select>
				</td>
				<td  align = "center"><textarea name="AwardDescription(<%=rowcount%>)"  cols="40" rows="3"   class = "body"   ></textarea>

				</td>

		</tr>
	<% next %>
		</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900" align = "right" >
<tr>
		<td align = "right"><br />
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type=submit value = "Save & Proceed to Next page" size = "110" class = "regsubmit2"  <%=Disablebutton %> >
			</form><br />
		</td>
</tr>
</table>
</td>
</tr>
</table>
<br>
<!--#Include file="adminFooter.asp"--> </Body>
</HTML>
