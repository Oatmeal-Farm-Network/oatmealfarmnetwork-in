<!DOCTYPE HTML >
<HTML>
<HEAD>
<title>Add an Animal</title>
<link rel="stylesheet" type="text/css" href="/style.css">
</HEAD>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<!--#Include file="MembersSecurityInclude.asp"-->
<!--#Include file="MembersGlobalvariables.asp"--> 
<% Current2="AddAnimal" %> 
<!--#Include file="MembersHeader.asp"-->
<br /> 
<%
TotalCount= Request.Form("TotalCount")
'TotalCount = CInt(TotalCount)
'rowcount = CInt
rowcount = 1
SpeciesID = Request.form("SpeciesID")
ID=Request.Form("ID")
if len(ID) < 1 then
   ID=Request.querystring("ID")
end if
'response.write(ID)
'response.write("ID=")
	
if SpeciesID = 2 then
else
response.redirect("MembersAnimalAdd4.asp?SpeciesID=" & SpeciesID & "&ID=" & ID )
end if  
dim aID(40000)
dim aName(40000)

	sql2 = "select Animals.ID, Animals.FullName from Animals order by Fullname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		aID(acounter) = rs2("ID")
		aName(acounter) = rs2("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter + 1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "<%= screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = ""  align = "center"  >
	<tr>
		<td class = "body" align = "left">
			<h2><font color = "black">Fiber Facts</font></h2>
			Enter up to 20 years worth of fiber results.<br><br>
		</td>
	</tr>
	<tr><td>
<form action= 'MembersAnimalAdd4.asp?wizard=True&PeopleID=<%=PeopleID %>&AnimalID=<%=ID%>' method = "post" name = "myform">
<input type = "hidden" name="ID" value= "<%= ID%>" >


	<% For rowcount = 1 To 10  
	If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor = "#EEDD99">
<% Else %>
	<table border = "0" width = "100%"  align = "center" ">
<% End If %>
<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)"  ><input type = "hidden" name="FullName(<%=rowcount%>)"  ><tr >
		<td width = "160" class = "body" align= "left">Sample Date:<br />
			<select size="1" name="SampleDateMonth(<%=rowcount%>)">
					<option value = "" selected></option>
						<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
				</select>
				<select size="1" name="SampleDateDay(<%=rowcount%>)">
					<option value="" selected></option>
					<option value="1">1</option>
					<option  value="2">2</option>
					<option  value="3">3</option>
					<option  value="4">4</option>
					<option  value="5">5</option>
					<option  value="6">6</option>
					<option  value="7">7</option>
					<option  value="8">8</option>
					<option  value="9">9</option>
					<option  value="10">10</option>
					<option  value="11">11</option>
					<option  value="12">12</option>
					<option  value="13">13</option>
					<option  value="14">14</option>
					<option  value="15">15</option>
					<option  value="16">16</option>
					<option  value="17">17</option>
					<option  value="18">18</option>
					<option  value="19">19</option>
					<option  value="20">20</option>
					<option  value="21">21</option>
					<option  value="22">22</option>
					<option  value="23">23</option>
					<option  value="24">24</option>
					<option  value="25">25</option>
					<option  value="26">26</option>
					<option  value="27">27</option>
					<option  value="28">28</option>
					<option  value="29">29</option>
					<option  value="30">30</option>
					<option  value="31">31</option>
				</select>
		<select size="1" name="SampleDateYear(<%=rowcount%>)">
					<option value="" selected></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv= currentyear To 1983 step -1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
		<td class = "body2" align = "right">
			AFD:	<br>
			CF:
		</td>
		<td class = "body" align = "right">
			<input name="Average(<%=rowcount%>)"  size = "5" ><br>
			<input name="CF(<%=rowcount%>)"   size = "5">
		</td>
		<td class = "body2" align = "right" >
		    SD: <br />
		   Crimps/Inch: 
		</td>
        <td class = "body" align = "right" >
		  <input name="StandardDev(<%=rowcount%>)"  size = "5"  ><br />
		   <input name="CrimpPerInch(<%=rowcount%>)"  size = "5">
		</td>
		<td class = "body2" align = "right" >
			COV: <br>
			Staple Length: 
		</td>
		<td class = "body" align = "right" >
			<input name="COV(<%=rowcount%>)"   size = "5"><br>
			<input name="Length(<%=rowcount%>)"   size = "5">
		</td>
		<td class = "body2" align = "right" >
			% > 30: <br />
			Shear Wt:
		</td>
		<td class = "body" align = "right" >
			<input name="GreaterThan30(<%=rowcount%>)"  size = "5"  ><br />
			<input name="ShearWeight(<%=rowcount%>)"  size = "5">
		</td>
		<td class = "body2"  align = "right">
		 Curve:<br>
		 Blanket Wt:
		</td>
		<td class = "body"  align = "right">
		<input name="Curve(<%=rowcount%>)"   size = "5"><br>
		 <input name="BlanketWeight(<%=rowcount%>)"  size = "5">
		</td>
	</tr>
</table>

<% Next %>
	</td>
</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "right">
<tr>
	<td  valign = "right"><br />
    <Input type=Hidden name='SpeciesID' value = <%=SpeciesID%> >
		    <Input type = Hidden name='TotalCount' value = <%=TotalCount%> >	
			<input type=submit value = "Save & Proceed To Next Page" size = "110" class = "regsubmit2" >
	</td>
</tr>
</table>

</form>
	</td>
</tr>
</table>

<!--#Include virtual="/Footer.asp"-->  </Body>
</HTML>
