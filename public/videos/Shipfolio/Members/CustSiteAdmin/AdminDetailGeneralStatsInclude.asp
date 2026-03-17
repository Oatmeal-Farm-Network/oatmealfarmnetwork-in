  
	<%
salepending =  rs("salepending")
	    FullPrice =  rs("price")
If Len(rs("StartingPrice")) > 3 Then
	Startingprice =  rs("StartingPrice")
else
	Startingprice =  FullPrice
End If


	
		Discount = (rs("Discount"))
	If discount > 1 Then
		DiscountPrice = FullPrice - fullprice*(discount/100)
	Else
		DiscountPrice = FullPrice
	End If

Description = rs("Description")



%>		
	<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    width = "260" border = "0" valign = "top" align = "left">
		<tr>
			<td>
						<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    width = "300" border = "0" valign = "top" align = "left">
							<% If Len(rs("priceComments")) > 2 Then %>
								  <tr>
									<td  class = "Body" align = "center" ><b><%=rs("pricecomments")%></b><br><br></td>
								  </tr>
								 <%End If %>
								
								<% If Sold = True Then %>
										<tr>
											<td  class = "Body"  colspan = "2" height = "30">
													<br><font color = "red" size = "8">SOLD</font><br><br>
												</td>
										 </tr>
								<% End if %>
								
								<% If SalePending= True  And Sold = False Then %>
										<tr>
											<td  class = "Body"  colspan = "2" height = "30">
													<br><font color = "red" size = "5">Sale Pending</font><br><br>
												</td>
										 </tr>
								<% Else %>
								
								
								<% If Len(rs("price")) > 2 And Sold = False and SalePending = False Then %>
								  
								 <tr>
									<td  class = "Body"  >
									
								
										
												
										<% If SalePending= True  And Sold = False Then %>
										<tr>
											<td  class = "Body"  colspan = "2" height = "30">
													<br><font color = "red" size = "5">Sale Pending</font><br><br>
												</td>
										 </tr>
								<% End if %>
								
								
								<% If Len(rs("price")) > 2 And Sold = False and SalePending = False Then %>
										Full Price:<b><%=formatcurrency(Fullprice,0)%></b><br>
									  	<% If Discount  > 2 Then %>
										Discount:<b><font color ="red"><%=Discount%>%</font></b><br>
										Discount Price: <b><font color ="red"><%=formatcurrency(DiscountPrice, 0)%></font></b><br>
										<% End If %>
								<%End If %>			
												
									
									Breed: <%=rs("Breed")%><br>
						
									
									</td>
								  </tr>
	
									
<%End If %>
							<% end if %>
								
								

							
							
					<% If Len(ARI) > 1 Then %>
 					 <tr>
    					<td    class = "Body" >ARI#:<%=ARI%><br></td>
                		</tr>		
				<% End If %>
					<% If Len(CLAA) > 1 Then %>
 					 <tr>
    					<td    class = "Body" >CLAA#:<%=CLAA%><br></td>
                		</tr>		
				<% End If %>
			
	
				
					<tr>
    					<td    class = "Body"> DOB:<%=DOBMonth%>/<%=DOBDay%>/<%=DOBYear%></td>
                		</tr>	
	
				<% if Category ="Jr. Herdsire" then %>
					<tr>
    					<td  class = "Body">Category:Jr. Herdsire</td>
                		</tr>	
				<%end if%>
				<% if Category ="Herdsire" then %>
					<tr>
    					<td  class = "Body">Category: Herdsire</td>
                		</tr>	
				<%end if%>
				<% if Category ="Maiden" then %>
					<tr>
    					<td  class = "Body">Category: Maiden</td>
                		</tr>	
				<%end if%>
				<% if Category ="Dam" then %>
					<tr>
    					<td  class = "Body">Category: Dam</td>
                		</tr>	
				<%end if%>
				<% if Category ="Non-Breeder" then %>
					<tr>
    					<td  class = "Body">Category: Pet/ Fiber Quality</td>
                		</tr>	
				<%end if%>

						<tr>
    					<td colspan = "2">
							<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    width = "200" border = "0" valign = "top" align = "left">
						
						<td  class = "Body" valign = "top"> Color:
							<% If Len(rs("color1")) > 1 Then %>
										<%=Color1%><% end if %>
							<% If Len(rs("color2")) > 1 Then %>/<%=Color2%>
						    <% end if %>
						<% If Len(rs("color3")) > 1 Then %>
										<br><img src = "images/px.gif" width = "22" height = "2"><br>/<%=Color3%>
						    <% end if %>
							<% If Len(rs("color4")) > 1 Then %>
										<br>/<%=Color4%>
						    <% end if %>
							<% If Len(rs("color5")) > 1 Then %>
										 <br>/<%=Color5%>
						    <% end if %>	
					

						</td>
                		</tr>	
						</table>

					</td>
					</tr>
					<tr>
					<td class = "body">
<!--#Include virtual="/Auctions/DescriptionInclude.asp"-->
					</td>
				</tr>
</table>	
		</td>
       </tr>
	   <tr>
		<td>

			</td>
								  </tr>
						
			</table>