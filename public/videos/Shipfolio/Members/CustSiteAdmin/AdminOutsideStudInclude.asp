
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from ExternalStud"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim TExternalStudID(40000)
	dim TFullName(40000)
	dim TServiceSireLink(40000)
	dim TBreed(40000)
	dim TServiceSireImage(40000)
	dim TServiceSireColor(40000)
     dim TServiceSireARI(40000)
	
Recordcount = rs.RecordCount +1
%>

<table border = "0">
   <tr>
     <td colspan = "3">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
	<tr>
		<td class = "body">
			<H2>Other People's Studs<br>
			<img src = "images/underline.jpg"></H2>
			Edit your changes in the tables below then select the "Submit Changes" button located under the table.<br><br>
		</td>
	</tr>
</table>



	 </td>
	</tr>
	<tr>
	  <td>

	<form action= 'AdminOutsideStudAddHandleForm.asp' method = "post">
<table border = "0"  bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500" align = "left">
    <tr>
		<td class = "body" colspan = "2">
		<H2>Add an Outside Stud<br>
			<img src = "images/underline.jpg" width = "400" height = "2"></H2>
		</td>
	</tr>
	<tr>
		<td width = "120" class = "body" align = "right">
			Stud's Full Name:
		</td>
		<td>
			<input name="FullName" class = "body">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			Website Address:
		</td>
		<td>
			http://<input name="ServiceSireLink" size = "40">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			Color:
		</td>
		<td>
			<input name="ServiceSireColor">
		</td>
	</tr>
	<tr>
		<td class = "body" align = "right">
			ARI#:
		</td>
		<td>
			<input name="ServiceSireARI">
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
  <td width = "300" class = "body" valign = "top">
<%    

Dim IDArray(1000)
Dim animalName(1000)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from ExternalStud order by alpacaname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		IDArray(acounter) = rs2("ExternalStudID")
		animalName(acounter) = rs2("alpacaName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>
		<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			<tr>
				<td class = "body">
					<H2>Upload Photos</H2>			
				</td>
			</tr>
		</table>
<form action="AdminOutsidePhoto.asp" method = "post">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body">
					<br>To upload photos select below <br>one of the listed outside studs:<br><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=animalName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Edit" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>

  </td>
</tr>







  <tr>
		<td class = "body" colspan = "2">
		<H2>Edit Outside Stud Information<br>
			<img src = "images/underline.jpg" width = "300" height = "2"></H2>
		</td>
	</tr>

<tr>
  <td colspan = "2">

<table border = "1" bordercolor = "bbbbbb" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	
	<tr>
		<th >Stud's Name</th>
			
		<th width = "200">Website Address</th>
		<th >Color</th>
		<th >ARI</th>
		
	</tr>


	
<%
 While  Not rs.eof         
	 TExternalStudID(rowcount) =   rs("ExternalStudID")
	 TFullName(rowcount) =   rs("alpacaname")
	 TServiceSireLink(rowcount) =   rs("ServiceSireLink")
	 TBreed(rowcount) =   rs("Breed")
	 TServiceSireImage(rowcount) =   rs("ServiceSireImage")
	 TServiceSireColor(rowcount) =   rs("ServiceSireColor")
	  TServiceSireARI(rowcount) =   rs("ServiceSireARI")

%>

	<form action= 'AdminOutsideStudHandleForm.asp' method = "post">
	<tr >
		<td nowrap >
			<input type = "hidden" name="ExternalStudID(<%=rowcount%>)" value= "<%= TExternalStudID( rowcount)%>" >
			<input name="FullName(<%=rowcount%>)" value= "<%= TFullName(rowcount)%>"   ></td>
		<td nowrap><input name="ServiceSireLink(<%=rowcount%>)" value= "<%= TServiceSireLink(rowcount)%>" size = "30"></td>
		
				
			
		<td nowrap><input name="ServiceSireColor(<%=rowcount%>)" value= "<%= TServiceSireColor(rowcount)%>" ></td>
		<td nowrap><input name="ServiceSireari(<%=rowcount%>)" value= "<%= TServiceSireari(rowcount)%>"  SIZE =  "12"></td>
		
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
 <br><br>


  </td>
</tr>
<tr>
  <td colspan = "2">




				<%  
				dim aID(40000)
				dim aName(40000)

				conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
				"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
				sql2 =  "select ExternalStud.ExternalStudID,  ExternalStud.AlpacaName from ExternalStud"

			acounter = 1
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3 
	
			While Not rs2.eof  
				aID(acounter) = rs2("ExternalStudID")
				aName(acounter) = rs2("alpacaname")

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
			<form action= 'AdminOutsideAnimalDeletehandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td valign = "top">
				 
					<b>Animal's Name</b><br>
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
<br><br><br><br>
<br><br><br><br>