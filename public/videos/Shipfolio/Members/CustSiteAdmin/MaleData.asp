<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Your Studs</title>
       <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Your Studs (if you have any) <br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.*, MaleData.* from Animals, MaleData where Animals.ID = MaleData.ID and (Category = 'Jr. Herdsire' or Category = 'Herdsire' or Category = 'External Stud')"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(300)
	dim FullName(300)
	dim JrHerdsire(300)
	dim StudFee(300)
	dim Category(300)
	
Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr onmouseover="this.className='highlighted';this.style.cursor='hand';" onmouseout="this.className='normal'">
		<th >
			Name
		</th>
			<th >
			Category<img src = "images/web.gif" >
			</th>
			<th >
			Stud Fee<img src = "images/web.gif" >
		</th>
	<tr>



	
<%
 While  Not rs.eof         
	 ID(rowcount) =   rs("Animals.ID")
	 FullName(rowcount) =   rs("FullName")
	 JrHerdsire(rowcount) =   rs("JrHerdsire")
	 StudFee(rowcount) =   rs("StudFee")
	 Category(rowcount)=   rs("Category")

	 if StudFee(rowcount) = "0" then
		StudFee(rowcount) = ""
	end if

%>

	<form action= 'Maledatahandleform.asp' method = "post">
	<tr onmouseover="this.className='highlighted';this.style.cursor='hand';" onmouseout="this.className='normal'">
		<td valign = "top">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>">
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%= FullName( rowcount)%>">
			<%= FullName( rowcount)%>
		</td>
		<td>
	<select size="1" name="Category(<%=rowcount%>)">
					<option name = "Category1" value= "<% = Category(rowcount)%>" selected><% = Category(rowcount)%></option>
					<option name = "Category2" value="Herdsire">Herdsire</option>
					<option name = "Category3" value="Jr. Herdsire">Jr. Herdsire</option>
					<option name = "Category4" value="Other Male">Other Male</option>
					<option name = "Category5" value="Dam">Dam</option>
					<option name = "Category6" value="Other Female">Other Female</option>
					<option name = "Category6" value="Fiber Animals">Fiber Animals</option>
					</select>
			
			</td>
			<td>
			<input name="StudFee(<%=rowcount%>)" value= "<%= StudFee(rowcount)%>">
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
		<td colspan = "8" align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>