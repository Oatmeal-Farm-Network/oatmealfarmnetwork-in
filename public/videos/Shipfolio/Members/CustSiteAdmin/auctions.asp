<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Edit Auctions Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">
<!--#Include virtual="/Administration/globalvariables.asp"--> 
<%	
dim dID(1400)
dim dName(1400)
dim dPhotoID(1400)
Dim dImage(1400)
Dim dImageOrder(1400)
Dim dImageTitle(1400)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" 
	sqld = "select Animals.ID, Animals.FullName, AdditionalPhotos.* from Animals, AdditionalPhotos where Animals.ID = AdditionalPhotos.ID ORDER by Animals.FullName ASC"

	dcounter = 1
	Set rsd = Server.CreateObject("ADODB.Recordset")
	rsd.Open sqld, conn, 3, 3 
	While Not rsd.eof  
		dID(dcounter) = rsd("AdditionalPhotos.ID")
		dName(dcounter) = rsd("FullName")
		dPhotoID(dcounter) = rsd("PhotoID")
		dImage(dcounter) = rsd("Image")
		dImageOrder(dcounter) = rsd("PhotoOrder")
		dImageTitle(dcounter) = rsd("ImageTitle")
		'response.write (rsd("AdditionalPhotos.ID"))

		dcounter = dcounter +1
		rsd.movenext
	Wend		
	
		rsd.close
		set rsd=nothing
		set conn = nothing



%>

<%rowcount = 0%>

<%
dim aID(200)
dim aName(200)



	acounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select ID, FullName from Animals order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	While Not rs.eof  
		aID(acounter) = rs("ID")
		aName(acounter) = rs("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = nothing%>

</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

<!--#Include virtual="/Administration/Header.asp"--> 

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr>
		<td Class = "body">
			<H2>Edit Auction Information<br>
			<img src = "images/underline.jpg"></H2>
			To make changes to your data, make your changes in the table below then select the "Submit Changes" button at the bottom of the page.<br><br>
		</td>
	</tr>
</table>


<form action= 'ActiveSaleHandleForm.asp' method = "post">
			<input type = "hidden" name="Special" value= "Auction" >
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from SpecialsLookupTable where special = 'Auction'"
  Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 

%>
<b>There currently is a sale :
<%if rs("Active") = True then %>
		True<input TYPE="RADIO" name="Active" Value = "True" checked>
		False<input TYPE="RADIO" name="Active" Value = "False" >
	<% else %>
		True<input TYPE="RADIO" name="Active" Value = "True" >
		False<input TYPE="RADIO" name="Active" Value = "False" checked>
	<%end if%>
</b>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>

<table>
<%
	dim DFileName(1400)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from AuctionHeader where FieldID = 1"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Title = rs("FieldContent")
%>
			<form action= 'AddAuctionContent.asp' method = "post">
<%
 sql = "select * from AuctionHeader where FieldID = 2"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text2 = rs("FieldContent")
%>

	<tr>
		<td>
		 <h2>Our Pricing Policy</h2>
            <textarea name="Text2" cols="90" rows="8" wrap="VIRTUAL" ><%=Text2%></textarea>

		</td>
	</tr>
	

<%
 sql = "select * from AuctionHeader where FieldID = 0"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

Text = rs("FieldContent")
%>

	<tr>
		<td>
		 <h2>...The Fine Print</h2>
            <textarea name="Text" cols="90" rows="8" wrap="VIRTUAL" ><%=Text%></textarea>

		</td>
	</tr>


	
<tr>
		<td>

					<center><input type=Submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" ></center>
				</td>
			  </tr>
		    </table>
			<br><br>
		  </form>






 <form action= 'AddAuctionhandleform.asp' method = "post">
  <table>
 <tr>
		<td colspan = "6" align = "center">
					<H2>Add a New Animal</H2>
		</td>
	</tr>
  <tr>
		<th >&nbsp;Alpaca's Name&nbsp;</th>
		<th >Buy Now Price<br><small>($ Format Only)</small></th>
		<th >Minimum Price<br><small>($ Format Only)</small></th>
		<th >Reserve<br><small>($ Format Only)</small></th>
		<th >Start Date</th>
		<th >End Date</th>
		
							
	</tr>
	<tr >
		<td>
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
				<td width = "110" align = "center" >
			<input name="BuyNowPrice" value= " "    size = "6">
		</td>
		<td width = "110" align = "center">
			<input name="StartingPrice" value= " "  size = "6">
		</td>
	<td >
			<input name="ReservePrice" value= ""  size = "12">
		</td>
		<td >
			<input name="Startdate" value= ""  size = "12">
		</td>
		<td >
			<input name="Enddate" value= "" size = "12">
		</td>
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>



<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, Auction.* from Animals, Auction where Animals.ID = Auction.animalID order by Animals.FullName, Startingprice, BuyNowPrice"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(200)
	dim AuctionID(200)
	dim FullName(200)
	dim Startingprice(200)
	dim BuyNowPrice(200)
	dim Sold(200)
	dim Reserve(200)
	dim Startdate(200)
	dim Enddate(200)
	dim salepending(200)
	dim AuctionOrder(200)


Recordcount = rs.RecordCount +1
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Edit an Existing Entry</H2>
		</td>
	</tr>
	<tr>
		<th width = "120">Alpaca's Name</th>
		<th width = "90">Buy Now Price<br><small>($ Format Only)</small></th>
		<th width = "90">Min. Price<br><small>($ Format Only)</small></th>
		<th width = "90">Reserve<br><small>($ Format Only)</small></th>
		<th >Start Date</th>
		<th >End Date</th>
		<th >Sale Pending?<br></th>
		<th width = "90">Sold?<br></th>
		<th align = "left">Order<br></th>
	</tr>


	
<%

 While  Not rs.eof         
	 ID(rowcount) =   rs("animalID")
	 AuctionID(rowcount) =   rs("AuctionID")
	 FullName(rowcount) =   rs("FullName")
	 StartingPrice(rowcount) =   rs("StartingPrice")
	 BuyNowPrice(rowcount) =   rs("BuyNowPrice")
	 Reserve(rowcount) =   rs("Reserve")
	Startdate(rowcount) =   rs("Startdate")
	Enddate(rowcount) =   rs("Enddate")
	Sold(rowcount) =   rs("Sold")
	SalePending(rowcount) =   rs("SalePending")
	AuctionOrder(rowcount) =   rs("AuctionOrder")
%>


	<form action= 'Auctionedithandleform.asp' method = "post">
	
	
	<tr >
		<td class = "body">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="AuctionID(<%=rowcount%>)" value= "<%= AuctionID( rowcount)%>" >
			
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
			<%=FullName(rowcount)%>
					
		</td>
		<td  align = "center" >
			<input name="BuyNowPrice(<%=rowcount%>)" value= "<%= FormatCurrency(BuyNowPrice(rowcount),0)%>" size = "6">
		</td>
		<td align = "center">
			<input name="StartingPrice(<%=rowcount%>)" value= "<%= FormatCurrency(StartingPrice(rowcount),0)%>" size = "6">
		</td>
		<td align = "center">
			<input name="Reserve(<%=rowcount%>)" value= "<%= FormatCurrency(Reserve(rowcount),0)%>" size = "6">
		</td>
		<td align = "center">
			<input name="Startdate(<%=rowcount%>)" value= "<%= FormatDateTime(Startdate(rowcount),2)%>" size = "10">
		</td>
		<td align = "center">
			<input name="Enddate(<%=rowcount%>)" value= "<%=Enddate(rowcount)%>" size = "10">
		</td>
		<td>
		<table>
		<tr>
		<td >
			<%
				if SalePending(rowcount) = "True" then %>
		<td nowrap>True<input TYPE="RADIO" name="SalePending(<%=rowcount%>)" Value = "True" checked>
		False<input TYPE="RADIO" name="SalePending(<%=rowcount%>)" Value = "False" ></td>
	<% else %>
		<td nowrap>True<input TYPE="RADIO" name="SalePending(<%=rowcount%>)" Value = "True" >
		False<input TYPE="RADIO" name="SalePending(<%=rowcount%>)" Value = "False" checked></td>
	<%end if%>
			
		
		</td>
		</tr>
		</table>
		</td>
		<td>
			<table>
				<tr>
					<td >
			<%
				if Sold(rowcount) = "True" then %>
		<td nowrap>True<input TYPE="RADIO" name="Sold(<%=rowcount%>)" Value = "True" checked>
		False<input TYPE="RADIO" name="Sold(<%=rowcount%>)" Value = "False" ></td>
	<% else %>
		<td nowrap>True<input TYPE="RADIO" name="Sold(<%=rowcount%>)" Value = "True" >
		False<input TYPE="RADIO" name="Sold(<%=rowcount%>)" Value = "False" checked></td>
	<%end if%>
					</td>
					</tr>
				</table>
		</td>
		<td >
			<table>
				<tr>
					<td>
			   <select size="1" name="AuctionOrder(<%=rowcount%>)">
					<option  value= "<%= AuctionOrder(rowcount)%>" selected><%= AuctionOrder(rowcount)%></option>
					<option  value= "1" >1</option>
					<option  value= "2" >2</option>
					<option  value= "3" >3</option>
					<option  value= "4" >4</option>
					<option  value= "5" >5</option>
					<option  value= "6" >6</option>
					<option  value= "7" >7</option>
					<option  value= "8" >8</option>
					<option  value= "9" >9</option>
					<option  value= "10" >10</option>
					<option  value= "11" >11</option>
					<option  value= "12" >12</option>
				</select> 
		</td>
		</tr>
		</table>
		</td>
		
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>
 










<%
	dim bID(200)
dim bName(200)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select distinct Auction.animalID, animals.FullName from Animals, Auction where Animals.ID = Auction.animalID order by Animals.FullName "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	bcounter = 1
	While Not rs.eof  
		bID(bcounter) = rs("animalID")
		bName(bcounter) = rs("FullName")
		'response.write (SSName(studcounter))

		bcounter = bcounter +1
		rs.movenext
	Wend		
	
	
	rs.close
		set rs=nothing
		set conn = nothing%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	 <tr>
		<td colspan = "6" align = "center">
					<H2>Remove an Entry</H2>
		</td>
	</tr><tr>
		<td>
			
			<form action= 'RemoveAuctionhandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < bcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=bID(count)%>">
							<%=bName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Remove" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
				</td>
			  </tr>
		    </table>
		  </form>
		</td>
	</tr>
</table>



<%
dim sID(200)
dim sName(200)



	scounter = 1

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Animals where Category ='Experienced Male'  order by Animals.FullName"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	
	While Not rs.eof  
		sID(scounter) = rs("ID")
		sName(scounter) = rs("FullName")
		response.write (sname(scounter))

		scounter = scounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing
		set conn = Nothing
		
		%>
		






 <form action= 'AddStudAuctionhandleform.asp' method = "post">
  <table>
 <tr>
		<td colspan = "6" align = "center">
					<H2>Add a New Stud</H2>
		</td>
	</tr>
  <tr>
		<th >&nbsp;Stud's Name&nbsp;</th>
		<th >Buy Now Price<br><small>($ Format Only)</small></th>
		<th >Start Date</th>
		<th >End Date</th>
		
							
	</tr>
	<tr >
		<td>
				<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count <= scounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=sID(count)%>">
							<%=sName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
			
					
				</td>
				
		<td width = "110" align = "center">
			<input name="BuyNowPrice" value= " "    size = "6">
		</td>
		<td >
			<input name="Startdate" value= ""  size = "12">
		</td>
		<td >
			<input name="Enddate" value= "" size = "12">
		</td>
		</tr>
		</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>



<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select Animals.FullName, BreedingAuction.* from Animals, BreedingAuction where Animals.ID = BreedingAuction.animalID order by AuctionOrder"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1



Recordcount = rs.RecordCount +1
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding="0" cellspacing="0">
 <tr>
		<td colspan = "9" align = "center">
					<H2>Edit an Existing Stud Entry</H2>
		</td>
	</tr>
	<tr>
		<th width = "120">Alpaca's Name</th>
		<th width = "90">Buy Now Price<br><small>($ Format Only)</small></th>
		<th >Start Date</th>
		<th >End Date</th>
		<th align = "left">Order<br></th>
	</tr>


	
<%

 While  Not rs.eof         
	 ID(rowcount) =   rs("animalID")
	 AuctionID(rowcount) =   rs("AuctionID")
	 FullName(rowcount) =   rs("FullName")
	 BuyNowPrice(rowcount) =   rs("BuyNowPrice")
	Startdate(rowcount) =   rs("Startdate")
	Enddate(rowcount) =   rs("Enddate")
	AuctionOrder(rowcount) =   rs("AuctionOrder")
%>


	<form action= 'AuctionStudedithandleform.asp' method = "post">
	
	
	<tr >
		<td class = "body">
			<input type = "hidden" name="ID(<%=rowcount%>)" value= "<%=  ID( rowcount)%>" >
			<input type = "hidden" name="AuctionID(<%=rowcount%>)" value= "<%= AuctionID( rowcount)%>" >
			
			<input type = "hidden" name="FullName(<%=rowcount%>)" value= "<%=  FullName( rowcount)%>" >
			<%=FullName(rowcount)%>
					
		</td>
		<td  align = "center" >
			<input name="BuyNowPrice(<%=rowcount%>)" value= "<%= FormatCurrency(BuyNowPrice(rowcount),0)%>" size = "6">
		</td>
		<td align = "center">
			<input name="Startdate(<%=rowcount%>)" value= "<%= FormatDateTime(Startdate(rowcount),2)%>" size = "10">
		</td>
		<td align = "center">
			<input name="Enddate(<%=rowcount%>)" value= "<%= FormatDateTime(Enddate(rowcount),2)%>" size = "10">
		</td>
		<td >
			<table>
				<tr>
					<td>
			   <select size="1" name="AuctionOrder(<%=rowcount%>)">
					<option  value= "<%= AuctionOrder(rowcount)%>" selected><%= AuctionOrder(rowcount)%></option>
					<option  value= "1" >1</option>
					<option  value= "2" >2</option>
					<option  value= "3" >3</option>
					<option  value= "4" >4</option>
					<option  value= "5" >5</option>
					<option  value= "6" >6</option>
					<option  value= "7" >7</option>
					<option  value= "8" >8</option>
					<option  value= "9" >9</option>
					<option  value= "10" >10</option>
					<option  value= "11" >11</option>
					<option  value= "12" >12</option>
				</select> 
		</td>
		</tr>
		</table>
		</td>
		
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	
%>
</table>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
<tr>
		<td  valign = "middle">
			<img src = "images/underline.jpg">
			<div align = "center">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" Class = "menu" ></div>
			</form>
		</td>

</tr>
</table>


<%


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(Databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select distinct BreedingAuction.animalID, animals.FullName from Animals, BreedingAuction where Animals.ID = BreedingAuction.animalID order by Animals.FullName "

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	bcounter = 1
	While Not rs.eof  
		bID(bcounter) = rs("animalID")
		bName(bcounter) = rs("FullName")
		'response.write (SSName(studcounter))

		bcounter = bcounter +1
		rs.movenext
	Wend		
	
	
	rs.close
		set rs=nothing
		set conn = nothing%>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	 <tr>
		<td colspan = "6" align = "center">
					<H2>Remove an Entry</H2>
		</td>
	</tr><tr>
		<td>
			
			<form action= 'RemoveStudAuctionhandleform.asp' method = "post">
				<input type = "hidden" name="PhotoType" value= "ListPage">
			   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				 <td>
					<b>Alpaca's Name</b><br>
					<select size="1" name="ID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < bcounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=bID(count)%>">
							<%=bName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
				</td>
				<td>
					<br>
					<input type=submit value = "Remove" style="background-image: url('images/background.jpg'); border-width:1px" size = "110" class = "menu" >
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
<br><br><br><br>
<!--#Include virtual="/Administration/Footer.asp"-->
</BODY>
</HTML>