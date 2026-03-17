
		
						<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  width = "270" border = "0">

							<% If rs("ForSale") = True And Len (Price) > 2 then%>
							
							<tr>
    							<td  class = "Body"  >Price:</td>
                    			<td    class = "Body"><b>
								<b><%=Price%> &nbsp; <%=(rs("PriceComments"))%></b>
								</td>
							 </tr>
						<% end if%>
						<%' If id= 39  Or id= 98 Or id= 111 Or id= 67 Or id= 98 Or id= 50 Or id= 13   then
						'	
							'<tr>
    						'	<td  class = "Body" colspan = "2" >July 15, 2007 Offer:
							'	<b><%=FormatCurrency(rs("AValue") * .75,0)</b>
							'	</td>
							' </tr>
						' end if%>

 					 <tr>
    					<td    class = "Body" width ="10%">ARI#:</td>
                    			<td   class = "Body" ><% if ARI = "0" then
								ARI = ""
							 end if
						%>
						<%=ARI%><br></td>
                		</tr>		
				
			
				<% if len(Color) > 1 then %>
					<tr>
    					<td  class = "Body"> Color:</td>
                    			<td   class = "Body"><%=Color%></td>
                		</tr>		
				<%end if%>
				
	
				
				
				<% if len(DOB) > 1 then %>
					<tr>
    					<td    class = "Body"> DOB:</td>
                    			<td   class = "Body"><%=DOB%></td>
                		</tr>	
				<%end if%>
				<% if Category ="Jr. Herdsire" then %>
					<tr>
    					<td  class = "Body">Category:</td>
                    			<td   class = "Body">Jr. Herdsire</td>
                		</tr>	
				<%end if%>
				<tr>
					<td colspan = "2">
								<!--#Include virtual="/DetailAnimalAuctionInclude.asp"--> 	
								<!--#Include virtual="/BreedingDetailAnimalAuctionInclude.asp"-->
					</td>
				</tr>

				<% if Len(rs("Description")) > 3 then %>
					<tr>
    					<td  class = "Body" colspan = "2"><br><%=rs("Description") %></td>
                		</tr>	
				<%end if%>
						
						
			</table>
