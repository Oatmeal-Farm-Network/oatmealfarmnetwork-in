 <% 



    	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
		sql = "SELECT WebView.*, Auction.* FROM WebView, Auction WHERE Animals.ID = Auction.animalID and startdate< now and animals.id = " & ID
 'response.write (sql)
    Set rs3 = Server.CreateObject("ADODB.Recordset")
    rs3.Open sql, conn, 3, 3  
 If Not rs3.eof then
 
				%> 
				

		<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >

		<%
		ListPrice = rs3("AValue")			
		BuyNowPrice = FormatCurrency(rs3("BuyNowPrice"),0)
        FullName = rs3("FullName")        
		Owner = rs3("Auction.Owner")   
		StartingPrice  = formatcurrency(rs3("StartingPrice"),0)
		Startdate = FormatDateTime(rs3("startdate"),0)
		enddate =  FormatDateTime(rs3("enddate"),0) 
		currentdate =  FormatDateTime(now,4) 




		sql = "select * from AuctionBids where AnimalID = "  & ID & " order by Bid Desc"
		Set rs32 = Server.CreateObject("ADODB.Recordset")
		'response.write(sql)
		rs32.Open sql, conn, 3, 3 
		If Not rs32.eof then
			Highbid = rs32("Bid")
			
			currentbid =  FormatCurrency(Highbid,0)
			minbid = FormatCurrency(currentbid + 100,0)
		Else
			currentbid =  "No bids yet"
				minbid = FormatCurrency(StartingPrice,0)
		End if
%>
	
	<tr>
			<td colspan = "2"><br><h2>Bid on this Alpacas!</h2>	
			<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			
			
<tr>
			<td class = "body">Regular List Price:</td>
			<td class = "body"><%=ListPrice%></td>
		</tr>
<% If rs3("SalePending") = True  Or rs3("Sold") = True Then 
			If rs3("Sold") = True  Then %>
				<tr>
					<td class = "body" colspan = "2" align = "center"><big><b><i>SOLD!</i></b></big>
					</td>
				</tr>
			<%Else%>
				
					<tr>
					<td class = "body" colspan = "2" align = "center"><big><b><i>Sale Pending</i></b></big>
					</td>
				</tr>
			<%End If %>

<%else%>


		<tr><%If category = "Dam" Then %>
				 <td class = "body" valign = "top"><b><i>Buy Now Price:</b></i></td>
			<% Else %>
				<td class = "body" valign = "top"><b><i>Buy Now Price: </b></i></td>
			<% End If %>
				<form action= 'BuyNowForm.asp' method = "post">
				<td class = "body" valign = "top"><b><i><%=BuyNowPrice%></b></i><br>

					<input type = "hidden" name="Owner" value= "<%=Owner%>">
					<input type = "hidden" name="BuyNowPrice" value= "<%=BuyNowPrice%>" >
					<input type = "hidden" name="ID" value= "<%=ID%>">
					<input type = "hidden" name="Fullname" value= "<%=FullName%>">
				
			<input type="submit" value = "Buy Now!" style="background-image: url('images/ButtonBackground.jpg'); border-width:1px" size = "100" Class = "menu" ><br>

				<br>
		</td>
	</tr>

</form>
			
			</tr>
				<td class = "body">Current Bid:</td>
				<td class = "body"><%=currentbid%>	

				</td>
			</tr>
			</tr>
				<td class = "body">Auction Ends:</td>
				<td class = "body"><%=enddate%> 12PM PST

				</td>
			</tr>
			</tr>
				<td class = "body" valign = "top">Place a bid:<br>(enter <%= minbid%><br> or more)</td>
				<td class = "body">
				
				

				<form action= 'PlaceABidForm.asp' method = "post">
					<input name="Newbid" value= " " SIZE = "8">
					<input type = "hidden" name="ID" value= "<%=ID%>">
					<input type = "hidden" name="Owner" value= "<%=Owner%>">
					<input type = "hidden" name="minbid" value= "<%= minbid%> ">
					<input type = "hidden" name="Fullname" value= "<%=FullName%>">

			<input type="submit" value = "Place Bid" style="background-image: url('images/ButtonBackground.jpg'); border-width:1px" size = "100" Class = "menu" >

				</td>
			</tr>	
	<%End if%>
		</table>
		</td>
	</tr>

		</table></form>
			<%End if%>

