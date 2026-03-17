<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>General Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <H2>Edit General Animal Data<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Animals order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(300)
	dim	Name(300)
	dim	ForSale(300)
	dim	ARI(300)
	dim	DOB(300)
	dim	Color(300)
	dim	Category(300)
		dim	ColorCategory(300)
	dim	PackageID(300)
	dim PackageName(300)


Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<th >Full Name<img src = "images/web.gif" height = "18"></th>
		<th >DOB<img src = "images/web.gif" height = "18"></th>
		<th >Color<img src = "images/web.gif" height = "18"></th>
		<th >Color Category <img src = "images/web.gif" height = "18"></th>
		<th >ARI#<img src = "images/web.gif" height = "18"></th>
		<th >Category <img src = "images/web.gif" height = "18"></th>
		<th >Package<img src = "images/web.gif" height = "18"></th>

	</tr>
	
<%
 While  Not rs.eof         
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 ARI(rowcount) =   rs("ARI")
     DOB(rowcount) =  rs("DOB")
	 Color(rowcount) =   rs("Color")
	Category(rowcount) =   rs("Category")
	ColorCategory(rowcount) =   rs("ColorCategory")

	 
%>

	<form action= 'Animalshandleform.asp' method = "post">
	<tr onmouseover="this.className='highlighted';this.style.cursor='hand';" onmouseout="this.className='normal'">
		
		<td >
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
		
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" size = "30"></td>
		
		
		<td ><input name="DOB(<%=rowcount%>)" value="<%= DOB( rowcount)%>" size = "10"></td>
		<td width = "100" ><input name="Color(<%=rowcount%>)" value="<%= Color( rowcount)%>" >
		<td width = "100" ><select size="1" name="ColorCategory(<%=rowcount%>)">
					<option name = "ColorCategory1" value= "<% = ColorCategory(rowcount)%>" selected><% = ColorCategory(rowcount)%></option>
					<option name = "ColorCategory2" value="White">White</option>
					<option name = "ColorCategory3" value="Fawn">Fawn</option>
					<option name = "ColorCategory6" value="Grey">Grey</option>
					<option name = "ColorCategory7" value="Brown">Brown</option>
					<option name = "ColorCategory8" value="Black">Black</option>
					</select>
		</td>
		


			<td >
			<input name="ARI(<%=rowcount%>)" value= "<%= ARI(rowcount)%>"   size = "8"></td>
			
			<td width = "100">
			<select size="1" name="Category(<%=rowcount%>)">
					<option name = "Category1" value= "<% = Category(rowcount)%>" selected><% = Category(rowcount)%></option>
					<option name = "Category2" value="Male Cria">Male Cria</option>
					<option name = "Category3" value="Female Cria">Female Cria</option>
					<option name = "Category4" value="Maiden">Maiden</option>
					<option name = "Category6" value="Yearling">Yearling</option>
					<option name = "Category7" value="Juvenile Male">Juvenile Male</option>
					<option name = "Category8" value="Jr. Herdsire">Jr. Herdsire</option>
					<option name = "Category9" value="Herdsire">Herdsire</option>
					<option name = "Category11" value="Dam">Dam</option>
					<option name = "Category12" value="Fiber Animals">Fiber Animals</option>
					<option name = "Category13" value="External Stud">External Stud</option>
					<option name = "Category14" value="Related Progeny">Related Progeny</option>
					</select>
			
		</td>
		<td>

			<% 	rowcount2 = 1

			if rs("PackageID") = 0  then
				tempPackageName = "none"
				tempPackageID =0
			else
			   'response.write(rs("PackageID"))
				sql2 = "select * from Package where PackageID = " & rs("PackageID")
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3   
				if not rs2.eof then
					tempPackageName = rs2("PackageName")
					tempPackageID =rs("PackageID")
				else
					tempPackageName = "none"
					tempPackageID =0
				end if
			end if

			sql2 = "select * from Package order by PackageName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
	
			While  Not rs2.eof         
				PackageID(rowcount2) =   rs2("PackageID")
				PackageName(rowcount2) =   rs2("PackageName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

				<select size="1" name="PackageID(<%=rowcount%>)" size = "20">
					<option name = "PackageID0" value= "<%=tempPackageID%>" selected size = "20"><%=tempPackageName%></option>
					<option name = "PackageID1" value="0" size = "20">none</option>
					<% count = 1
						while count < TotalCount2
						'response.write(TotalCount2)
					%>
						<option name = "PackageID2" value="<%=PackageID(count)%>" size = "20">
							<%=PackageName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			</td>
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
		<td colspan = "16" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 <!--#Include virtual="/administration/Footer.asp"--> 
 </Body>
</HTML>