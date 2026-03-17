<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Add or Delete an Animal</title>
       <link rel="stylesheet" type="text/css" href="style.css">


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">



<!--#Include virtual="/administration/Header.asp"--> 

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H2>Add a New Alpaca<br>
			<img src = "images/underline.jpg"></H2>
			To add an animal, enter data in the boxes below then select the "Submit Changes" button at the bottom of the form.<br><br>
		</td>
	</tr>
</table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
		
	<form action= 'AddAlpacashandleform.asp' method = "post">
	<tr>
		<td width = "190">
			Full Name:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<input name="Name" size = "30">
		</td>
	</tr>
	<tr>
		<td>
			ARI #:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<input name="ARI">
		</td>
	</tr>
	
	<tr>
		<td>
			Date of Birth:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<input name="DOB">
		</td>
	</tr>
	<tr>
		<td>
			Color:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<input name="Color">
		</td>
	</tr>
	<tr>
		<td>
			Color Category:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<select size="1" name="ColorCategory">
					<option name = "ColorCategory1" value= "" selected></option>
					<option name = "ColorCategory2" value="White">White</option>
					<option name = "ColorCategory3" value="Fawn">Fawn</option>
					<option name = "ColorCategory6" value="Grey">Grey</option>
					<option name = "ColorCategory7" value="Brown">Brown</option>
					<option name = "ColorCategory8" value="Black">Black</option>
					</select>
		</td>
	</tr>
	<tr>
		<td>
			Category:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<select size="1" name="Category">
					<option name = "Category1" value= "" selected></option>
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
		<td Valign= "top">
			Sales Description:<img src = "images/web.gif" height = "18">
		</td>
		<td>
			<textarea name="Comments" cols="63" rows="8" wrap="VIRTUAL" ></textarea>
		</td>
	</tr>
</table>	

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  align = "center" valign = "middle">
			<img src = "images/underline.jpg"><br>
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
			</form>
		</td>
</tr>
</table>
 
 <table leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td class = "body">
			 <a name="Delete"></a> <H2>Delete an Alpaca<img src = "images/web.gif"><br>
			<img src = "images/underline.jpg"></H2>
			To delete an alpaca from the database simply select the animals name and push the delete button.<br> <b>But be careful. Once an animal is deleted from your database, it's gone!</b>
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
<br>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td>
			<form action= 'DeleteAlpacahandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
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
					<input type=submit value = "Delete" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>
<br><br><br>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</HTML>