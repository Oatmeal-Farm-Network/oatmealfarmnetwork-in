


<%

While Not rs.eof 
			counter = counter +1	
			linecounter = linecounter +1
			If linecounter = 4 Then
				linecounter = 1
			%>       
				<tr>
					<td colspan = "5">
		<br style="page-break-before:always;">

					</td>
				</tr>

			<% End If %>
         <tr>
          <%
             for x=1 to 1
				  if rs.eof then
					exit for
                 end if 
                alpacaID = rs("animals.ID")
               'response.write( alpacaID)

		 photoID = "nophoto"
  
        imagelength = len(rs("Photo1"))
		if  imagelength > 5 then
            photoID = rs("Photo1")
		end if
photo1 = rs("Photo1")

FullPrice = rs("Price")           
   Discount = (rs("Discount"))
	If Discount > 1 Then
		DiscountPrice = FullPrice - FullPrice*(Discount/100)
	Else
		DiscountPrice = FullPrice	
	End If
	'response.write("FullPrice=" & FullPrice)

			
				%> 
				
			<% Category = rs("Category")%>

             
		<td align="center"  class = "body" colspan = "5" height = "25" bgcolor = "<%=ReportHighlightColor%>" ><font color = "black" face="arial"  size = "4"><b>
		<% FullName = rs("FullName")
					
if len(FullName) > 1 then
For loopi=1 to Len(FullName)
    spec = Mid(FullName, loopi, 1)
    specchar = ASC(spec)
    
    if specchar < 32 or specchar > 126 then
    	FullName= Replace(FullName,  spec, " ")
   end if
  
 Next
end if
%>	


		
		<%=rs("FullName")%></b></font></td>
	   </tr>
	   <tr>
		<td align="center" width = "130" valign = "top" class = "body">                       
              <% If len(rs("Photo1")) > 5  then %>
			     <img src="<%=rs("Photo1")%>"  border=0 width = "130">     
             <% End If  %>
	       </td>
		   <td width = "5"><img src = "images/px.gif" ></td>

	      <td class= "body"  valign = "top">
									<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
									<tr>
										<td valign = "top" class = "body" >
												<% If rs("Price") = "sold" Or rs("Price") = "Sold" Then %>
													<font size = "2" color = "#810000" face = "arial"><b>Sold</b></font><br>
												<%Else %>
												<% If Len(rs("Price") ) > 2 Then %>
														<font size = "2" color = "black" face = "arial">Price: <b><%=Formatcurrency(rs("Price"),0)%></b></font><br>
												<% End If %>
										
<% If Discount > 1 Then %>
					<tr><td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial">Discount:</font>				
						<font size = "2" color = "black" face = "arial"><b><%=discount%>%</b></font>				
					</td></tr>
					<tr><td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial">Discount Price:</font>				
						<font size = "2" color = "black" face = "arial"><b><%=formatcurrency(DiscountPrice,0)%></b></font>				
					</td></tr>

<% End If %>



												<%End If %>
													<font size = "2" color = "black" face = "arial">Category:&nbsp; &nbsp;<%=rs("Category")%><br>
													Color:&nbsp; &nbsp;&nbsp;
													<%
											Color1 = rs("Color1")
											Color2 = rs("Color2")
											Color3 = rs("Color3")
											Color4 = rs("Color4")
											Color5 = rs("Color5")
											%>
											
											<% If Len(Color1) > 1 Then %>
												<%=Color1%>
											<% end If %>
											
										<% If Len(Color2) > 1 Then %>
												/<%=Color2%>
											<% end If %>
												
												<% If Len(Color3) > 1 Then %>
												/<%=Color3%>
											<% end If %>

											<% If Len(Color4) > 1 Then %>
												/<%=Color4%>
											<% end If %>

											<% If Len(Color5) > 1 Then %>
												/<%=Color5 %>
											<% end If %>
											<br>
DOB:&nbsp; &nbsp;&nbsp;
											    <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>
											
<%
			SireName = rs("Sire")
			DamName = rs("Dam")
	%>

						Sire: &nbsp; &nbsp;&nbsp;<%=SireName%><br>
						Dam: &nbsp; &nbsp;<%=DamName%><br></font>
								</td>
									</tr>
							<tr>
										<td colspan ="5" class = "body" valign = "top" >
	<br><font size = "2" color = "black" face = "arial">
<% Description = rs("Description1") & rs("Description2")
					
if len(Description) > 1 then
For loopi=1 to Len(Description)
    spec = Mid(Description, loopi, 1)
    specchar = ASC(spec)
    
    if specchar < 32 or specchar > 126 then
    	Description= Replace(Description,  spec, " ")
   end if
  
 Next
end if
%>	

<%=Description%><br></font>
	<br>

										</td>
									</tr>
								</table>


		</td>
		
		
             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>
        
