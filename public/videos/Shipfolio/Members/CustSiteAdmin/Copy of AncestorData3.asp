<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Ancestry Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">



</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<% dim TID

	TID=Request.Form("ID" ) 
	 %>
<!--#Include virtual="/administration/Header.asp"--> 

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
dim aID(300)
dim aName(300)

	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
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
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Ancestors.* from Animals, Ancestors where Animals.ID = Ancestors.ID and Animals.ID =  " & TID

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID
	dim FullName
	dim DamName
	dim DamColor
	dim DamAri
	dim DamLink
	dim DamDamName
	dim DamDamColor
	dim DamDamARI
	dim DamDamLink
	dim DamSireName
	dim DamSireColor
	dim DamSireAri
	dim DamSireLink
	dim SireName
	dim SireColor
	dim SireAri
	dim SireLink
	dim SireDamName
	dim SireDamColor
	dim SireDamAri
	dim SireDamLink
	dim SireSireName
	dim SireSireColor
	dim SireSireAri
	dim SireSireLink

Recordcount = rs.RecordCount +1
%>


	
<%
     ID =   rs("ID")
	 FullName =   rs("FullName")
	 DamName =   rs("DamName")
	 DamColor =   rs("DamColor")
	 DamAri =   rs("DamAri")
 	 DamLink =   rs("DamLink")
	DamDamAKC =   rs("MaternalGranddamsAKC")
	DamDamUKC =   rs("MaternalGranddamsUKC")
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
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width ="700">
	<form action= 'Ancestryhandleform2.asp' method = "post">
	<tr >
	<td align = "right" class = "body" valign = "bottom">Alpaca's Name:</td>
		
		<td colspan = "2">
			<input type = "hidden" name="ID" value= "<%= ID%>" >
			<input type = "hidden" name="FullName" value= "<%=  FullName%>">
			<b><%=  FullName%></b></td>
</tr>
<tr>
		<td align = "right"  width = "250" class = "body">Dam's Name:</td>
		<td width = "150" class = "body"><b>Enter info:</b><br><input name="DamName" value= "<%= DamName%>" size = "40"></td>
		
		<form action= 'AncestorData3.asp' method = "post">
				<td rowspan = "24" valign = "bottom" width = "300"><input type = "hidden" name="PhotoType" value= "ListPage">
			  		or select name:<br>
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
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
		  
		</td>
</form>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Dam's Color:</td>
		<td  class = "body"><input name="DamColor" value= "<%= DamColor%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Dam's ARI:</td>
		<td  class = "body"><input name="DamAri" value= "<%= DamAri%>" size = "40"></td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "bottom">Dam's Link:</td>
		<td  class = "body"><input name="DamLink" value= "<%= DamLink%>" size = "40"></td>
</tr>



<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Granddam's Name:</td>
		<td  class = "body"><input name="DamDamName" value="<%= DamDamName%>" size = "40"></td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Granddam's Color:</td>
		<td wrap><input name="DamDamColor" value="<%= DamDamColor%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Granddam's ARI:</td>
		<td wrap><input name="DamDamARI" value="<%= DamDamARI%>"  size = "40">
		</td>
</tr>

<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Granddam's Link:</td>
		<td wrap><input name="DamDamLink" value="<%= DamDamLink%>"  size = "40">
		</td>
</tr>


<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Grandsire's Name:</td>

		<td  class = "body"><input name="DamSireName" value="<%= DamSireName%>"  size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Grandsire's Color:</td>
		<td  class = "body"><input name="DamSireColor" value="<%=  DamSireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Grandsire's ARI:</td>
		<td  class = "body"><input name="DamSireARI" value="<%=  DamSireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Maternal Grandsire's Link:</td>
		<td  class = "body"><input name="DamSireLink" value="<%=  DamSireLink%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" >Sire's Name:</td>
		<td  class = "body"><input name="SireName" value="<%= SireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Sire's Color:</td>
		<td  class = "body"><input name="SireColor" value="<%=SireColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Sire's ARI:</td>
		<td  class = "body"><input name="SireARI" value="<%=SireARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Sire's Link:</td>
		<td  class = "body"><input name="SireLink" value="<%=SireLink%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal GrandDam's Name:</td>
		<td  class = "body"><input name="SireDamName" value="<%=SireDamName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal GrandDam's Color:</td>
		<td  class = "body"><input name="SireDamColor" value="<%=SireDamColor%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal GrandDam's ARI:</td>
		<td  class = "body"><input name="SireDamARI" value="<%=SireDamARI%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal GrandDam's Link:</td>
		<td  class = "body"><input name="SireDamLink" value="<%=SireDamLink%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal Grandsire's Name:</td>
		<td  class = "body"><input name="SireSireName" value="<%=SireSireName%>" size = "40">
		</td>
</tr>
<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal Grandsire's Color:</td>

		<td  class = "body"><input name="SireSireColor" value="<%=SireSireColor%>" size = "40">
		</td>
	</tr>
	<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal Grandsire's ARI:</td>

		<td  class = "body"><input name="SireSireARI" value="<%=SireSireARI%>" size = "40">
		</td>
	</tr>
	
	<tr>
		<td align = "right" class = "body" valign = "bottom">Paternal Grandsire's Link:</td>

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
		<td  align = "center" colspan ="3">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>