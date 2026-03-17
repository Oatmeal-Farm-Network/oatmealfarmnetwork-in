<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Ancestry Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<% dim TID

	TID=Request.Form("ID" ) 


	 %>
<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Edit Ancestry Data<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>
<%  
dim aID(400)
dim aName(400)

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

				
dim damsID(400)
dim damsName(400)

damscounter = 1
	sqldams = "select Animals.ID, Animals.FullName from Animals where category  = 'Maiden' or category  = 'Dam'  or category  = 'Unowned Animal'  order by Fullname"
	Set rsdams = Server.CreateObject("ADODB.Recordset")
	rsdams.Open sqldams, conn, 3, 3 

While Not rsdams.eof  
		damsID(damscounter) = rsdams("ID")
		damsName(damscounter) = rsdams("FullName")
		'response.write (SSName(studcounter))

		damscounter = damscounter +1
		rsdams.movenext
	Wend		
	
		rsdams.close
		set rsdams=nothing

dim siresID(400)
dim siresName(400)

sirescounter = 1
	sqlsires = "select Animals.ID, Animals.FullName from Animals where category  = 'Jr. Herdsire' or category  = 'Herdsire' or category  = 'External Stud' or category  = 'Unowned Animal' order by Fullname"
	Set rssires = Server.CreateObject("ADODB.Recordset")
	rssires.Open sqlsires, conn, 3, 3 

	While Not rssires.eof  
			siresID(sirescounter) = rssires("ID")
			siresName(sirescounter) = rssires("FullName")

			sirescounter = sirescounter +1
			rssires.movenext
		Wend		
	
		rssires.close
		set rssires=nothing

dim OSID(400)
dim OSName(400)

	OSsql =  "select ExternalStud.ExternalStudID,  ExternalStud.alpacaName from ExternalStud"

		OScounter = 1
		Set OSrs = Server.CreateObject("ADODB.Recordset")
		OSrs.Open OSsql, conn, 3, 3 
	
		While Not OSrs.eof  
		  OSID(OScounter) = OSrs("ExternalStudID")
		  OSName(OScounter) = OSrs("alpacaName")
		  OScounter = OScounter +1
		  OSrs.movenext
		Wend		
	
		OSrs.close
		set OSrs=nothing
		set conn = nothing
%>


<table border = "0" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "900">
	<tr>
		<td class = "body">
			Or you can edit another animal's data by selecting an animal below and push the edit button:
			<form action= 'AncestorData3.asp' method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="ID">
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
					<br>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Ancestors.* from Animals, Ancestors where Animals.ID = Ancestors.ID and Animals.ID =  " & TID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
Recordcount = rs.RecordCount +1


     ID =   rs("ID")
	 FullName =   rs("FullName")
	 DamName =   rs("DamName")
	 DamComment = rs("DamComment")
	 DamColor =   rs("DamColor")
	 DamAri =   rs("DamAri")
 	 DamLink =   rs("DamLink")
	DamDamLink =   rs("MaternalGranddamsLink")

	 DamDamName =   rs("MaternalGranddam")
	 DamDamColor =  rs("MaternalGranddamsColor")
 	 DamDamAri =  rs("MaternalGranddamsAri")
	DamSireLink =   rs("MaternalGrandsiresLink")

	 DamSireName =   rs("MaternalGrandsire")
	 DamSireColor =  rs("MaternalGrandsiresColor")
	 DamSireAri =  rs("MaternalGrandsiresAri")
	 SireLink =   rs("SireLink")

	 SireName =   rs("Sire")
	 SireComment =   rs("SireComment")
	 SireColor =   rs("SireColor")
	 SireAri =   rs("SireAri")
	SireDamLink =   rs("PaternalGranddamLink")


	 SireDamName =   rs("PaternalGranddam")
	 SireDamColor =  rs("PaternalGranddamColor")
	 SireDamAri =  rs("PaternalGranddamAri")
	 
	 SireSireName =   rs("PaternalGrandsire")
	 SireSireColor =  rs("PaternalGrandsiresColor")
	 SireSireAri =  rs("PaternalGrandsiresAri")
	SireSireLink =   rs("PaternalGrandsiresLink")


	 if DamName ="0" then
		DamName = ""
	end if
	 if DamColor="0" then
		DamColor= ""
	end if
	 if DamDamName ="0" then
		DamDamName= ""
	end if
	 if DamDamColor ="0" then
		DamDamColor= ""
	end if
	 if DamSireName="0" then
		DamSireName= ""
	end if
	 if DamSireColor="0" then
		DamSireColor= ""
	end if
	 if SireName="0" then
		SireName= ""
	end if
	 if SireColor="0" then
		SireColor= ""
	end if
	 if SireDamName="0" then
		SireDamName= ""
	end if
	 if SireDamColor ="0" then
		SireDamColor= ""
	end if
	 if SireSireName ="0" then
		SireSireName= ""
	end if
	 if SireSireColor="0" then
		SireSireColor= ""
	end if
%>


<table>
	<tr>
		<td>
			<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<form action= 'Ancestryhandleform2.asp' method = "post">
	<tr >
	<td align = "right" class = "body" valign = "top">Alpaca's Name:</td>
		
		<td colspan = "2">
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type = "hidden" name="FullName" value= "<%=  FullName%>">
			<b><%=  FullName%></b></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>&nbsp;</td>
</tr>
<tr>
	<td align = "right"  width = "300" class = "body">Dam's Name:</td>
				<td width = "150" class = "body"><b>Enter info:</b><br><input name="DamName" value= "<%= DamName%>" size = "40"></td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Dam's Color:</td>
		<td  class = "body"><input name="DamColor" value= "<%= DamColor%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Dam's ARI:</td>
		<td  class = "body"><input name="DamAri" value= "<%= DamAri%>" size = "40"></td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Dam's Link:</td>
		<td  class = "body"><input name="DamLink" value= "<%= DamLink%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Dam's Comments:</td>
		<td  class = "body"><textarea name="DamComment" cols="32" rows="8" wrap="VIRTUAL" ><%= DamComment%></textarea></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>


<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Name:</td>
		<td  class = "body"><input name="DamDamName" value="<%= DamDamName%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Color:</td>
		<td wrap><input name="DamDamColor" value="<%= DamDamColor%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's ARI:</td>
		<td wrap><input name="DamDamARI" value="<%= DamDamARI%>"  size = "40">
		</td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Maternal Granddam's Link:</td>
		<td wrap><input name="DamDamLink" value="<%= DamDamLink%>"  size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Name:</td>

		<td  class = "body"><input name="DamSireName" value="<%= DamSireName%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Color:</td>
		<td  class = "body"><input name="DamSireColor" value="<%=  DamSireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's ARI:</td>
		<td  class = "body"><input name="DamSireARI" value="<%=  DamSireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Maternal Grandsire's Link:</td>
		<td  class = "body"><input name="DamSireLink" value="<%=  DamSireLink%>" size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" >Sire's Name:</td>
		<td  class = "body"><input name="SireName" value="<%= SireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Color:</td>
		<td  class = "body"><input name="SireColor" value="<%=SireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's ARI:</td>
		<td  class = "body"><input name="SireARI" value="<%=SireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Link:</td>
		<td  class = "body"><input name="SireLink" value="<%=SireLink%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Sire's Comments:</td>
		<td  class = "body"><textarea name="SireComment" cols="32" rows="8" wrap="VIRTUAL" ><%= SireComment%></textarea></td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Name:</td>
		<td  class = "body"><input name="SireDamName" value="<%=SireDamName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Color:</td>
		<td  class = "body"><input name="SireDamColor" value="<%=SireDamColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's ARI:</td>
		<td  class = "body"><input name="SireDamARI" value="<%=SireDamARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal GrandDam's Link:</td>
		<td  class = "body"><input name="SireDamLink" value="<%=SireDamLink%>" size = "40">
		</td>
</tr>
<tr >
	<td align = "right" class = "body" valign = "top"><br>&nbsp;</td>
	<td colspan = "2" class ="body"><br>Enter info:</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Name:</td>
		<td  class = "body"><input name="SireSireName" value="<%=SireSireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Color:</td>

		<td  class = "body"><input name="SireSireColor" value="<%=SireSireColor%>" size = "40">
		</td>
	</tr>
	<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's ARI:</td>

		<td  class = "body"><input name="SireSireARI" value="<%=SireSireARI%>" size = "40">
		</td>
	</tr>
	<tr>
		<td align = "right" class = "body" valign = "top">Paternal Grandsire's Link:</td>

		<td  class = "body"><input name="SireSireLink" value="<%=SireSireLink%>" size = "40">
		</td>
	</tr>

<%

TotalCount=1
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td  align = "center" colspan ="2">
			
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
		</td>
		<td valign = "top">
			<table>
				<tr>
				<td  valign = "top" class = "body" height ="300"><br><br><br>
					<form action= 'AncestryAddAnimals.asp' method = "post">
						<input type = "hidden" name="ID" value= "<%= ID%>" >
				  		or select one of your Dams:<br>
						<select size="1" name="DamID">
						<option name = "AID0" value= "" selected></option>
						<% count = 1
							while count < damscounter
						%>
							<option name = "AID1" value="<%=DamsID(count)%>">
								<%=DamsName(count)%>
							</option>
						<% 	count = count + 1
							wend %>
						</select>
						<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				<br><br><br><br><br><br><br><br><br><br><br><br>
				</td>
				</tr>
				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Dams:<br>
					<select size="1" name="DamDamID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < damscounter
					%>
						<option name = "AID1" value="<%=damsID(count)%>">
							<%=damsName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				</td>
				</tr>

							<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="DamSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>


				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSDamSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>


				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="SireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
						<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				<br><br><br><br><br><br><br>

				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Dams:<br>
					<select size="1" name="SireDamID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Damscounter
					%>
						<option name = "AID1" value="<%=DamsID(count)%>">
							<%=DamsName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
				</td>
				</tr>

				<tr>
				<td  valign = "top" class = "body" height ="124">
				<form action= 'AncestryAddAnimals.asp' method = "post">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select one of your Sires:<br>
					<select size="1" name="SireSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < Sirescounter
					%>
						<option name = "AID1" value="<%=SiresID(count)%>">
							<%=SiresName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</form>
					<form action= 'AncestryAddAnimals.asp' method = "post" border = "0">
					<input type = "hidden" name="ID" value= "<%= ID%>" >

			  		or select an Outside Stud:<br>
					<select size="1" name="OSSireSireID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < OScounter
					%>
						<option name = "AID1" value="<%=OSID(count)%>">
							<%=OSName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Populate" style="background-image: url('images/background.jpg'); border-width:1px"  class = "menu" >
				</form>
				</td>
				</tr>
			</table>
		</td>
	</tr>
</table>





 
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>