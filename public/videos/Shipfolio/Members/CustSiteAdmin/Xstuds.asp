<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Outside Stud Data Edit Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bgcolor = "white">

<!--#Include virtual="/administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<H2>Edit Outside Stud Data<br>
			<img src = "images/underline.jpg"></H2>
			Edit your changes in the table below then select the "Submit Changes" button located under the table.<br><br>
		</td>
	</tr>
</table>


<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ExternalStudID(300)
	dim FullName(300)
	dim ServiceSireLink(300)
	dim Breed(300)
	dim ServiceSireImage(300)
	dim ServiceSireColor(300)
	
Recordcount = rs.RecordCount +1
%>

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<th >Stud's Name</th>
			
		<th width = "200">Website Address</th>
			
		<th  >Breed</th>
			
		<th >Image</th>
			
		<th >Color</th>
				
	</tr>

<%
			dim fs,fo,x, count
			dim FileName(200)
			set fs=Server.CreateObject("Scripting.FileSystemObject")
			set fo=fs.GetFolder("E:\\Inetpub\\wwwroot\\ecommerce-1\\richard\\alpacasontheweb.com\\www\\uploads\\ListPage")
			pcount = 1
			for each x in fo.files
			  FileName(pcount) = x.Name
			  ' Response.write(FileName(pcount) & "<br />")
			pcount = pcount + 1
			next
			set fo=nothing
			set fs=nothing
			%>

	
<%
 While  Not rs.eof         
	 ExternalStudID(rowcount) =   rs("ExternalStudID")
	 FullName(rowcount) =   rs("AlpacaName")
	 ServiceSireLink(rowcount) =   rs("ServiceSireLink")
	 Breed(rowcount) =   rs("Breed")
	 ServiceSireImage(rowcount) =   rs("ServiceSireImage")
	 ServiceSireColor(rowcount) =   rs("ServiceSireColor")

%>

	<form action= 'XStudhandleform.asp' method = "post">
	<tr >
		<td nowrap >
			<input type = "hidden" name="ExternalStudID(<%=rowcount%>)" value= "<%= ExternalStudID( rowcount)%>" >
			<input name="FullName(<%=rowcount%>)" value= "<%= FullName(rowcount)%>"   ></td>
		<td nowrap><input name="ServiceSireLink(<%=rowcount%>)" value= "<%= ServiceSireLink(rowcount)%>" size = "30"></td>
		
	<% 	if trim(Breed(rowcount)) = "Huacaya" then %>
		<td nowrap>Huacaya<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Huacaya" checked>
			Suri<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Suri" >
		</td>
		<% else %>
			<td nowrap>Suri<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Suri" >
			Huacaya<input TYPE="RADIO" name="Breed(<%=rowcount%>)" Value = "Huacaya" checked>
		</td>
	<%end if%>
				
		<td><select size="1" name="ServiceSireImage(<%=rowcount%>)">
					<option name = "ServiceSireImage(<%=rowcount%>)" value= "<%= ServiceSireImage( rowcount)%>" selected><%= ServiceSireImage( rowcount)%></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "ServiceSireImage(<%=rowcount%>)" value="<%=FileName(count)%>">
							<%=FileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
		
		<td nowrap><input name="ServiceSireColor(<%=rowcount%>)" value= "<%= ServiceSireColor(rowcount)%>" ></td>
		
		
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
 






<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td>
				<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		<H2>Add an Outside Stud<br>
			<img src = "images/underline.jpg" width = "400" height = "2"></H2>
	<form action= 'AddXStudhandleform.asp' method = "post">
	<tr>
		<td width = "120">
			Stud's Full Name:
		</td>
		<td>
			<input name="FullName">
		</td>
	</tr>


			   <tr>
				<td>
					Photo:
				</td>
				<td>
					<select size="1" name="PhotoName">
					<option name = "PhotoOption" value= "" selected></option>
					<% count = 1
						while count < pcount
						response.write(count)
					%>
						<option name = "PhotoOption(count)" value="<%=FileName(count)%>">
							<%=FileName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>




	
	<tr>
		<td>
			Website Address:
		</td>
		<td>
			<input name="ServiceSireLink">
		</td>
	</tr>
	<tr>
		<td>
			Breed:
		</td>
		<td>
			Huacaya<input TYPE="RADIO" name="Breed" Value = "Huacaya" checked>
			Suri<input TYPE="RADIO" name="Breed" Value = "Suri"><br>
		</td>
	</tr>
	<tr>
		<td>
			Color:
		</td>
		<td>
			<input name="ServiceSireColor">
		</td>
	</tr>
	<tr>
		<td  align = "center" valign = "middle" colspan = "2">
			<input type=submit value = "Add Stud" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
		</td>
			<td valign = "top">
				<%  
				dim aID(300)
				dim aName(300)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select ExternalStud.ExternalStudID,  ExternalStud.AlpacaName from ExternalStud"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ExternalStudID")
				aName(acounter) = rs2("AlpacaName")

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing



%>



<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td valign = "top" >
			<H2>Delete an Outside Stud<br>
			<img src = "images/underline.jpg" width = "300" height = "2"></H2>
			<form action= 'DeleteXAlpacahandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
				 
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
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>
</td>
	</tr>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>