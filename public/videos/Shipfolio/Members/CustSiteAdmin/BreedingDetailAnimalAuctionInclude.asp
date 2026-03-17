 <% 



    	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
		sql = "SELECT MaleWebView.*, BreedingAuction.* FROM MaleWebView, BreedingAuction WHERE Animals.ID = BreedingAuction.animalID and startdate < now and  animals.id = " & ID
 'response.write (sql)
    Set rs3 = Server.CreateObject("ADODB.Recordset")
    rs3.Open sql, conn, 3, 3  
 If Not rs3.eof then
 
				%> 
				

		<table border = "0" width = "300"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<%

		
		BuyNowPrice = FormatCurrency(rs3("BuyNowPrice"),0)
        FullName = rs3("FullName")        
		Startdate = FormatDateTime(rs3("startdate"),0)
		enddate =  FormatDateTime(rs3("enddate"),0) 
		currentdate =  FormatDateTime(now,4) 




		sql = "select * from AuctionBids where AnimalID = "  & ID & " order by Bid Desc"
		Set rs32 = Server.CreateObject("ADODB.Recordset")
		'response.write(sql)
		rs32.Open sql, conn, 3, 3 

%>
	
	<tr>
			<td colspan = "2"><br><h2>Bid on a breeding to this stud!</h2>	
			<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			
			
<tr>
			<td class = "body">Regular Stud Fee:</td>
			<td class = "body"><%=StudFee%></td>
		</tr>



		<tr>
				<td class = "body" valign = "top"><b><i>Buy Now Price: </b></i></td>
				<form action= 'BreedingBuyNowForm.asp' method = "post">
				<td class = "body" valign = "top"><b><i><%=BuyNowPrice%></b></i>&nbsp;

					
					<input type = "hidden" name="BuyNowPrice" value= "<%=BuyNowPrice%>" >
					<input type = "hidden" name="ID" value= "<%=ID%>">
					<input type = "hidden" name="Fullname" value= "<%=FullName%>">
				
			<input type="submit" value = "Buy Now!" style="background-image: url('images/ButtonBackground.jpg'); border-width:1px" size = "100" Class = "menu" >

				<br>
		</td>
	</tr>
</form>

			
			
			<tr>
				<td class = "body">Auction Ends:</td>
				<td class = "body"><%=enddate%> Midnight PST

				</td>
			</tr>

	
		</table>
		</td>
	</tr>

		</table>
	<%End if%>

