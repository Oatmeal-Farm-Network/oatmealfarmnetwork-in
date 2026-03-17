<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>General Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  background = "images/background.jpg">

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
	dim	Breed(300)
	dim	ColorCategory(300)
	dim	GroupID(300)
	dim GroupName(300)

Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<th >Full Name<img src = "images/web.gif" height = "18"></th>
		<th >DOB<img src = "images/web.gif" height = "18"></th>
		<th >Color<img src = "images/web.gif" height = "18"></th>
		<th>Breed</th>
		<th >ARI#<img src = "images/web.gif" height = "18"></th>
		<th >Category <img src = "images/web.gif" height = "18"></th>
		<th >Group </th>
	</tr>
	
<%
 While  Not rs.eof         
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 ARI(rowcount) =   rs("ARI")
     DOB(rowcount) =  rs("DOB")
	 Color(rowcount) =   rs("Color")
	Category(rowcount) =   rs("Category")
	 Breed(rowcount)=   rs("Breed")
	 GroupID(rowcount)=   rs("GroupID")
%>

	<form action= 'Animalshandleform.asp' method = "post">
	<tr onmouseover="this.className='highlighted';this.style.cursor='hand';" onmouseout="this.className='normal'">
		
		<td >
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
		
		    <input name="Name(<%=rowcount%>)" value= "<%= Name( rowcount)%>" size = "30"></td>
		
		
		<td ><input name="DOB(<%=rowcount%>)" value="<%= DOB( rowcount)%>" size = "10"></td>
		<td width = "100" ><div id="F5T" style="overflow:hidden;"><input name="Color(<%=rowcount%>)" value="<%= Color( rowcount)%>"   ></div>
		</td>
		
<%if Breed(rowcount) = "Huacaya" then %>
		<td nowrap>Huacaya<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Huacaya" checked>
		Suri<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Suri" ></td>
	<% else %>
		<td nowrap>Huacaya<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Huacaya" >
		Suri<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Suri" checked></td>
	<%end if%>


			<td >
			<input name="ARI(<%=rowcount%>)" value= "<%= ARI(rowcount)%>"   size = "8"></td>
			
			<td width = "100">
			<select size="1" name="Category(<%=rowcount%>)">
					<option name = "Category1" value= "<% = Category(rowcount)%>" selected><% = Category(rowcount)%></option>
					<option name = "Category3" value="Jr. Herdsire">Jr. Herdsire</option>
					<option name = "Category4" value="Herdsire">Herdsire</option>
					<option name = "Category5" value="Unbred Female">Unbred Female</option>
					<option name = "Category6" value="Bred Female">Bred Female</option>
					<option name = "Category7" value="Non-Breeder">Non-Breeder</option>
					<option name = "Category8" value="External Stud">External Stud</option>
					<option name = "Category9" value="Unowned Animal">Unowned Animal</option>
					</select>
			
		</td>
		<td>

			<% 	rowcount2 = 1

			if rs("GroupID") = 0  then
				tempGroupName = "none"
				tempGroupID =0
			else
				sql2 = "select * from Groups where GroupID = " & rs("GroupID")
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3   
				tempGroupName = rs2("GroupName")
				tempGroupID =rs("GroupID")
			end if

			sql2 = "select * from Groups order by GroupName"
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
	
			While  Not rs2.eof         
				GroupID(rowcount2) =   rs2("GroupID")
				GroupName(rowcount2) =   rs2("GroupName")
				rowcount2 = rowcount2 + 1
				rs2.movenext
			Wend
			TotalCount2=rowcount2 
			%>

				<select size="1" name="GroupID(<%=rowcount%>)" size = "20">
					<option name = "GroupID0" value= "<%=tempGroupID%>" selected><%=tempGroupName%></option>
					<option name = "GroupID1" value="0">none</option>
					<% count = 1
						while count < TotalCount2
						response.write(TotalCount2)
					%>
						<option name = "GroupID2" value="<%=GroupID(count)%>" >
							<%=GroupName(count)%>
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
 
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>