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

TotalCount= Request.Form("TotalCount")
'TotalCount = CInt(TotalCount)
'rowcount = CInt
rowcount = 1


speciesID  = request.Form("speciesID")

ID=Request.Form("ID")
if len(ID) < 1 then
   ID=Request.querystring("ID")
end if
response.write(ID)
response.write("ID=")
if speciesID = 2 then
else
response.redirect("AdminAnimalAdd4.asp?wizard=True&ID=" & ID)
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
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Add a New Animal Wizard</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center">
<br />

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = ""  width = "960" align = "center"  >
	<tr>
		<td class = "body" align = "left">
			<h2><font color = "black">
             <% If AdministrationID  = 2 then %>
 Fibre
<% else %>
 Fiber
<% end if %> 

            Facts</font></h2>
			Enter up to 20 years worth of  <% If AdministrationID  = 2 then %>
 Fibre
<% else %>
 Fiber
<% end if %> results.<br><br>
		</td>
	</tr>
	<tr><td>
<form action= 'AdminAnimalAdd4.asp?wizard=True&PeopleID=<%=PeopleID %>&ID=<%=ID%>' method = "post" name = "myform">
<input type = "hidden" name="ID" value= "<%= ID%>" >
<input type = "hidden" name = "speciesID" value = "<%=speciesID %>" />

	<% For rowcount = 1 To 10  
	If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
		 If row = "even" Then %>
	<table border = "0" width = "100%"  align = "center" bgcolor = "#EEeeee">
<% Else %>
	<table border = "0" width = "100%"  align = "center">
<% End If %>
<input type = "hidden" name="IDArray(<%=rowcount%>)"  value="<%=ID%>" ><input type = "hidden" name="FiberID(<%=rowcount%>)"  ><input type = "hidden" name="FullName(<%=rowcount%>)"  ><tr >
		<td width = "70" class = "body" align= "left" valign = "top">Sample Year:<br />
			
		<select size="1" name="SampleDateYear(<%=rowcount%>)">
					<option value="" selected></option>
					
				
			<% currentyear = year(date) 
						response.write(currentyear)
					For yearv= currentyear To 1983 step -1 %>
					<option value="<%=yearv%>"><%=yearv%></option>		
					<% Next %></select>
		</td>
		<td class = "body" align = "right">
		<div align = "right">	AFD:	<input name="Average(<%=rowcount%>)"  size = "5" ><br>
			CF:<input name="CF(<%=rowcount%>)"   size = "5"></div>
		</td>
		<td class = "body" align = "right" >
		    <div align = "right">SD:   <input name="StandardDev(<%=rowcount%>)"  size = "5"  ><br />
		   Crimps/Inch: <input name="CrimpPerInch(<%=rowcount%>)"  size = "5"></div>
		</td>

		<td class = "body" align = "right" >
			<div align = "right">COV: <input name="COV(<%=rowcount%>)"   size = "5"><br>
			Staple Length: <input name="Length(<%=rowcount%>)"   size = "5"></div>
		</td>
		<td class = "body" align = "right" >
			<div align = "right">% > 30: <input name="GreaterThan30(<%=rowcount%>)"  size = "5"  ><br />
			Shear Wt: <input name="ShearWeight(<%=rowcount%>)"  size = "5"></div>
		</td>
		<td class = "body"  align = "right">
		 <div align = "right">Curve: <input name="Curve(<%=rowcount%>)"   size = "5"><br>
		 Blanket Wt:	<input name="BlanketWeight(<%=rowcount%>)"  size = "5"></div>
		</td>
	</tr>
</table>

<% Next %>
	</td>
</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "right">
<tr>
	<td  valign = "right"><br /><br />
		    <Input type = Hidden name='TotalCount' value = <%=TotalCount%> >	
			<input type=submit value = "Save & Proceed To Next Page" size = "110" class = "regsubmit2"  <%=Disablebutton %> ><br />
	</td>
</tr>
</table>

</form>
	</td>
</tr>
</table>
<br>
<!--#Include file="adminFooter.asp"-->   </Body>
</HTML>
