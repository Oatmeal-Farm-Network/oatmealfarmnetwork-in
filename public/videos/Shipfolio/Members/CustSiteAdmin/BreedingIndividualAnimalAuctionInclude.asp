 <%
    	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	    
		sql = "SELECT MaleWebView.*, BreedingAuction.* FROM MaleWebView, BreedingAuction WHERE Animals.ID = BreedingAuction.animalID and breedingAuction.StartDate < Now and animals.id = " & ID 
'response.write (sql)
    Set rs3 = Server.CreateObject("ADODB.Recordset")
    rs3.Open sql, conn, 3, 3  
 
 If Not rs3.eof then
   
 

               	StudFee= rs3("StudFee")

		 photoID = "nophoto"
  
        imagelength = len(rs3("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs3("ListPageImage")
		end if

               	If photoID = "nophoto" then 
			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0 bordercolordark=#rrggbb width=""111"" >"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image bordercolordark=#rrggbb src=""/uploads/ListPage/" & PhotoID &"""  border=0  width=""111"" >"     
                End If

				%> 
				
			<% Category = rs3("Category")

			If DetailType = "Dam" Then 
				sex = "Female"
			Else
				sex = "Male"
			End if

				ColorCategory =rs3("ColorCategory")

%>
<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
	<tr>
		<td align="left" width = "135" valign = "top" class = "body" rowspan = "2">                          
            <table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #6a7d67 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
			  <tr><td><%=click%></td></tr></table></form><center><a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">Click here for more information</a></center><br><br><br><br>
	       </td>

	      <td class= "body"  valign = "top" width = "365" colspan = "2">
								&nbsp;<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><big><%=Trim(rs3("FullName"))%></big></a><br>
		 </td>
		</tr>
		
		<tr>
		<td valign = "top">
		<table border = "0" width = "300"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			<tr>
				<td class = "body" valign = "top" width = "20">&nbsp;Color: </td>
				<td class = "body" width = "280"><%=rs3("Color")%></td>
			</tr>
			<tr>
				<td class = "body" valign = "top">&nbsp;DOB:</td>
				<td class = "body"><% If Len(rs3("DOB")) > 2 Then %>
							 <%=rs3("DOB")%><br>
						<% End If %></td>
			</tr>
			<tr>
				<td class = "body" valign = "top" width = "20">&nbsp;Category: </td>
				<td class = "body" width = "280"><%=rs3("Category")%></td>
			</tr>
					
						
				

<%
			SireName = rs3("Sire")
			'response.write(SireName)
			DBSireName = SireName
			str1 = SireName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBSireName= Replace(str1, "'", "''")
				DBSireName = trim(DBSireName)
			End If

			Set rs3Sire = Server.CreateObject("ADODB.Recordset")
			sqlSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBSireName & "'"
			rs3Sire.Open sqlSire, conn, 3, 3 

			if not rs3Sire.eof then 
				SireChoice = 1 %>
				<%counter = counter +1
				SireName 	= trim(rs3Sire("FullName"))
				SireID 	= rs3Sire("ID")%>
					
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		rs3Sire.close
		set rs3Sire=nothing
		if SireChoice = 1 then %>	

		<% end if %>





<%
			DamName = rs3("DamName")
			'response.write(DamName)
			DBDamName = DamName
			str1 = DamName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBDamName= Replace(str1, "'", "''")
				DBDamName = trim(DBDamName)
			End If

			Set rs3Dam = Server.CreateObject("ADODB.Recordset")
			sqlDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBDamName & "'"
			rs3Dam.Open sqlDam, conn, 3, 3 
		

			if not rs3Dam.eof then 
				DamChoice = 1 %>
				<%Dcounter = Dcounter +1
				DamName 	= trim(rs3Dam("FullName"))
				DamID 	= rs3Dam("ID")%>
				
				
		<%
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		rs3Dam.close
		set rs3Dam=nothing
		%>


<% if SireChoice = 1 then  %>
		<tr>
				<td class = "body" valign = "top">&nbsp;Sire: </td>
				<td class = "body"><a href = "Details.asp?ID=<%=SireID%>&DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><%=SireName%></a></td>
			</tr>
		<%
			else if  SireChoice = 2 then%>
			<tr>
				<td class = "body" valign = "top">&nbsp;Sire: </td>
				<td class = "body"><a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=SireName%></a></td>
			</tr>
			<%else %>
			<tr>
				<td class = "body" valign = "top">&nbsp;Sire: </td>
				<td class = "body"><%=SireName%></td>
			</tr>
					<%
		   end if
		end if
%>



<%if DamChoice = 1 then %>
			<tr>
				<td class = "body" valign = "top">&nbsp;Dam: </td>
				<td class = "body"><a href = "Details.asp?ID=<%=DamID%>&DetailType=Dam&Detail.x=53&Detail.y=21" class = "body"><%=DamName%></a></td>
			</tr>
	
		<%
			else if DamChoice = 2 then%>
				<tr>
				<td class = "body" valign = "top">&nbsp;Dam: </td>
				<td class = "body"><a class = "slink" target = "_blank" href =<%=DamLink%>> <%=DamName%></a></td>
			</tr>
			<%else %>
					<tr>
				<td class = "body" valign = "top">&nbsp;Dam: </td>
				<td class = "body"><%=DamName%></td>
			</tr>
					<%
		   end if
		  end if
		%>
 


			
		<%


		ListPrice = rs3("AValue")			
		BuyNowPrice = FormatCurrency(rs3("BuyNowPrice"),0)
        FullName = rs3("FullName")        
			Startdate = FormatDateTime(rs3("startdate"),0)
		enddate =  FormatDateTime(rs3("enddate"),0) 
		currentdate =  FormatDateTime(now,4) 
'response.write(enddate)
'response.write(currentdate)		
'daysremaining =  DateDiff("d", currentdate, enddate )
'hours3remaining =  DateDiff("h", currentdate, enddate )
'response.write("hours3remaining =  ")
'response.write(hours3remaining)

'dayhours3 = daysremaining * 24
'response.write("dayhours3 =  ")
'response.write(dayhours3)
'Shorthours3remaining = (hours3remaining- dayhours3)

'response.write("Time Remaining ")
'response.write(daysremaining)
'response.write("Days - ")
'response.write(Shorthours3remaining)
'response.write("Hours3 - ")




		sql = "select * from AuctionBids where AnimalID = "  & ID & " order by Bid Desc"
		Set rs32 = Server.CreateObject("ADODB.Recordset")
		'response.write(sql)
		rs32.Open sql, conn, 3, 3 
		
%>
	
	<tr>
			<td colspan = "2"><br>
			<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			
			
<tr>
			<td class = "body">Regular Stud Fee:</td>
			<td class = "body"><%=StudFee%></td>
		</tr>



		<tr>
				 <td class = "body" valign = "top"><b><i>Buy Now Price:</b></i></td>
			
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

			
		
			</tr>
				<td class = "body" colspan = "2">Auction Ends: <%=enddate%> Midnight PST

				</td>
			</tr>


		</table>
		</td>
	</tr>

		</table>
	</td>
</tr>

		</table>
<% End If %>
