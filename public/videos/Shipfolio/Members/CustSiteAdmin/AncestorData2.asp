<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Ancestry Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

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
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Ancestors.* from Animals, Ancestors where Animals.ID = Ancestors.ID order by Animals.FullName "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(400)
	dim FullName(400)
	dim DamName(400)
	dim DamColor(400)
	dim DamAri(400)
	dim DamLink(400)
	dim DamDamName(400)
	dim DamDamColor(400)
	dim DamDamARI(400)
	dim DamDamLink(400)
	dim DamSireName(400)
	dim DamSireColor(400)
	dim DamSireAri(400)
	dim DamSireLink(400)
	dim SireName(400)
	dim SireColor(400)
	dim SireAri(400)
	dim SireLink(400)
	dim SireDamName(400)
	dim SireDamColor(400)
	dim SireDamAri(400)
	dim SireDamLink(400)
	dim SireSireName(400)
	dim SireSireColor(400)
	dim SireSireAri(400)
	dim SireSireLink(400)
			

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<th width = "190"  id="F1">&nbsp;Alpaca's Name&nbsp;</th>
			
		<th >&nbsp;Dam's Name&nbsp;</th>
			
		<th  >&nbsp;Dam's Color&nbsp;</th>
			
		<th >&nbsp;Dam's ARI#&nbsp;</th>
			<th >&nbsp;Dam's Link#&nbsp; </th>
			
		<th  >&nbsp;Maternal GrandDam's Name&nbsp;</th>
		
		<th  >&nbsp;Maternal GrandDam's Color&nbsp; </th>
			
			<th >&nbsp;Maternal GrandDam's ARI#&nbsp; </th>
			<th  >&nbsp;Maternal GrandDam's Link#&nbsp; </th>
			
		<th >&nbsp;Maternal GrandSire's Name&nbsp;</th>
			
		<th >&nbsp;Maternal GrandSire's Color&nbsp; </th>
		
			<th  >&nbsp;Maternal GrandSire's ARI#&nbsp; </th>
			<th >&nbsp;Maternal GrandSire's Link#&nbsp; </th>
			
		<th >&nbsp;Sire's Name&nbsp;</th>
		
		<th >&nbsp;Sire's Color&nbsp; </th>
		
			<th >&nbsp;Sire's ARI#&nbsp; </th>
			<th  >&nbsp;Sire's Link#&nbsp; </th>
			
	<th  >&nbsp;Paternal GrandDam's 	Name&nbsp;</th>
			
		<th >&nbsp;Paternal GrandDam's Color&nbsp; </th>
			
			<th  >&nbsp;Paternal GrandDam's ARI#&nbsp; </th>
			<th >&nbsp;Paternal GrandDam's Link#&nbsp; </th>
			
		<th  >&nbsp;Paternal GrandSire's Name&nbsp;</th>
			
		<th >&nbsp;Paternal GrandSire's Color&nbsp; </th>
			
			<th  ">&nbsp;Paternal GrandSire's ARI#&nbsp; </th>
			<th >&nbsp;Paternal GrandSire's Link#&nbsp; </th>
			
	</tr>

	
<%
 While  Not rs.eof         
	 ID(rowcount) =   rs("ID")
	 FullName(rowcount) =   rs("FullName")
	 DamName(rowcount) =   rs("DamName")
	 DamColor(rowcount) =   rs("DamColor")
	 DamAri(rowcount) =   rs("DamAri")
 	 DamLink(rowcount) =   rs("DamLink")
	DamDamLink(rowcount) =   rs("MaternalGranddamsLink")

	 DamDamName(rowcount) =   rs("MaternalGranddam")
	 DamDamColor(rowcount) =  rs("MaternalGranddamsColor")
 	 DamDamAri(rowcount) =  rs("MaternalGranddamsAri")
	DamSireLink(rowcount) =   rs("MaternalGrandsiresLink")

	 DamSireName(rowcount) =   rs("MaternalGrandsire")
	 DamSireColor(rowcount) =  rs("MaternalGrandsiresColor")
	 DamSireAri(rowcount) =  rs("MaternalGrandsiresAri")
	SireLink(rowcount) =   rs("SireLink")

	 SireName(rowcount) =   rs("Sire")
	 SireColor(rowcount) =   rs("SireColor")
	 SireAri(rowcount) =   rs("SireAri")
	SireDamLink(rowcount) =   rs("PaternalGranddamLink")


	 SireDamName(rowcount) =   rs("PaternalGranddam")
	 SireDamColor(rowcount) =  rs("PaternalGranddamColor")
	 SireDamAri(rowcount) =  rs("PaternalGranddamAri")
	 
	 SireSireName(rowcount) =   rs("PaternalGrandsire")
	 SireSireColor(rowcount) =  rs("PaternalGrandsiresColor")
	 SireSireAri(rowcount) =  rs("PaternalGrandsiresAri")
	SireSireLink(rowcount) =   rs("PaternalGrandsiresLink")





	 if DamName(rowcount) ="0" then
		DamName(rowcount) = ""
	end if
	 if DamColor(rowcount)="0" then
		DamColor(rowcount)= ""
	end if
	 if DamDamName(rowcount) ="0" then
		DamDamName(rowcount)= ""
	end if
	 if DamDamColor(rowcount) ="0" then
		DamDamColor(rowcount)= ""
	end if
	 if DamSireName(rowcount)="0" then
		DamSireName(rowcount)= ""
	end if
	 if DamSireColor(rowcount)="0" then
		DamSireColor(rowcount)= ""
	end if
	 if SireName(rowcount)="0" then
		SireName(rowcount)= ""
	end if
	 if SireColor(rowcount)="0" then
		SireColor(rowcount)= ""
	end if
	 if SireDamName(rowcount)="0" then
		SireDamName(rowcount)= ""
	end if
	 if SireDamColor(rowcount) ="0" then
		SireDamColor(rowcount)= ""
	end if
	 if SireSireName(rowcount) ="0" then
		SireSireName(rowcount)= ""
	end if
	 if SireSireColor(rowcount)="0" then
		SireSireColor(rowcount)= ""
	end if
%>

	<form action= 'Ancestryhandleform.asp' method = "post">
	<tr >
		<td width ="190" nowrap>
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName(rowcount)%>">
			<%=  FullName( rowcount)%></td>


		<td ><input name="DamName(<%=rowcount%>)" value= "<%= DamName(rowcount)%>" ></td>
		<td ><input name="DamColor(<%=rowcount%>)" value= "<%= DamColor(rowcount)%>" ></td>
		<td ><input name="DamAri(<%=rowcount%>)" value= "<%= DamAri(rowcount)%>" ></td>
		<td ><input name="DamLink(<%=rowcount%>)" value= "<%= DamLink(rowcount)%>" ></td>
		<td ><input name="DamDamName(<%=rowcount%>)" value="<%= DamDamName( rowcount)%>" ></td>
		<td wrap><input name="DamDamColor(<%=rowcount%>)" value="<%= DamDamColor( rowcount)%>"  >
		</td>
		<td wrap><input name="DamDamAri(<%=rowcount%>)" value="<%= DamDamAri( rowcount)%>"  ></td>
		<td wrap><input name="DamDamLink(<%=rowcount%>)" value="<%= DamDamLink( rowcount)%>"  >		</td>

		<%TempDamSireName = DamSireName(rowcount) %>

		<td ><input name="DamSireName(<%=rowcount%>)" value="<%= DamSireName( rowcount)%>"  >
		</td>
		<td ><input name="DamSireColor(<%=rowcount%>)" value="<%=  DamSireColor( rowcount)%>" >
		</td>
		<td ><input name="DamSireAri(<%=rowcount%>)" value="<%=  DamSireAri( rowcount)%>" >	</td>
		<td ><input name="DamSireLink(<%=rowcount%>)" value="<%=  DamSireLink( rowcount)%>" >	</td>

		<td ><input name="SireName(<%=rowcount%>)" value="<%= SireName(rowcount)%>" >
		</td>
		<td ><input name="SireColor(<%=rowcount%>)" value="<%=SireColor(rowcount)%>" >
		</td>
		<td ><input name="SireAri(<%=rowcount%>)" value="<%=SireAri(rowcount)%>" ></td>
		<td ><input name="SireLink(<%=rowcount%>)" value="<%=SireLink(rowcount)%>" ></td>


		<td ><input name="SireDamName(<%=rowcount%>)" value="<%=SireDamName(rowcount)%>" >
		</td>
		<td ><input name="SireDamColor(<%=rowcount%>)" value="<%=SireDamColor(rowcount)%>" >
		</td>
		<td ><input name="SireDamAri(<%=rowcount%>)" value="<%=SireDamAri(rowcount)%>" ></td>
		<td ><input name="SireDamLink(<%=rowcount%>)" value="<%=SireDamLink(rowcount)%>" ></td>
		<td ><input name="SireSireName(<%=rowcount%>)" value="<%=SireSireName(rowcount)%>" >
		</td>
		<td ><input name="SireSireColor(<%=rowcount%>)" value="<%=SireSireColor(rowcount)%>" >
		</td>
		<td ><input name="SireSireAri(<%=rowcount%>)" value="<%=SireSireAri(rowcount)%>" ></td>
		<td ><input name="SireSireLink(<%=rowcount%>)" value="<%=SireSireLink(rowcount)%>" ></td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
		<td colspan = "26"  valign = "middle" >
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
<!--#Include virtual="/Administration/Footer.asp"--> </Body>
</HTML>