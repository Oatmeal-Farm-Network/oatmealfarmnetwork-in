


<%

While Not rs.eof 
			counter = counter +1	
			linecounter = linecounter +1
			If linecounter = 3 Then
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
                alpacaID = rs("Animals.ID")
               'response.write( alpacaID)

		 photoID = "nophoto"
  
        imagelength = len(rs("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs("ListPageImage")
		end if

               	If photoID = "nophoto" then 
			     click =  "<img src=""/uploads/ImageNotAvailable.jpg""  border=0  width = ""130"">"
			Else
   			     click =  "<img src=""" & PhotoID &"""  border=0 width = ""130"">"     
                
                End If
           
			
				%> 
				
			<% Category = rs("Category")
			FullName = rs("FullName")
				str1 = FullName
str2 = "''"
If InStr(str1,str2) > 0 Then
	FullName= Replace(str1,  str2, "'")
End If 
			
			%>

             
		<td align="center"  class = "body" colspan = "5" height = "25" bgcolor = "<%=ReportHighlightColor%>" ><font color = "black" face="arial"  size = "4"><b><%=FullName %></b></font></td>
	   </tr>
	   <tr>
		<td align="center" width = "130" valign = "top" class = "body">                          
             <br><% If len(rs("Photo1")) > 2  then %>
			     <img src="<%=rs("Photo1")%>"  border=1 width = "130">     
             <% End If  %>

	       </td>
		   <td width = "5"><img src = "images/px.gif" ></td>

	      <td class= "body"  valign = "top">
									<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
									<tr>
										<td valign = "top" class = "body" >
												<br>
												<% If rs("Price") = "sold" Or rs("Price") = "Sold" Then %>
													<font size = "2" color = "#810000" face = "arial"><b>Sold</b></font><br>
												<%Else %>
												
												<font size = "2" color = "black" face = "arial">Price: <b><%=Formatcurrency(rs("Price"))%></b></font><br>
						
												<% If  Len(rs("salePrice")) > 1  Then %>
						
													<font size = "3" color = "#AA0000" face = "arial">Reduced Price: <b><%=rs("SalePrice") %></b></font><br>
												<%End If %>



												<%End If %>
													<font size = "2" color = "black" face = "arial">Category:&nbsp; &nbsp;<%=rs("Category")%><br>
							Color:&nbsp; &nbsp;						<%
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
											<% end If %><br />
							<% if not( rs("DOBMonth") = 0) and not( rs("DOBDay") = 0) and  not( rs("DOBYear") = 0)  then %>		DOB:&nbsp; &nbsp;		    <%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%><br>
							<% end if %>
											
<%
			SireName = rs("Sire")
			DamName = rs("Dam")
				
	str1 = SireName
str2 = "''"
If InStr(str1,str2) > 0 Then
	SireName= Replace(str1,  str2, "'")
End If  

	str1 = DamName
str2 = "''"
If InStr(str1,str2) > 0 Then
	DamName= Replace(str1,  str2, "'")
End If  


	%>

						Sire: &nbsp; &nbsp;&nbsp;<%=SireName%> <% if len(rs("SireColor"))> 1 then %>(<%=rs("SireColor")%>)<% end if  %><br>
						Dam: &nbsp; &nbsp;<%=DamName%> <% if len(rs("DamColor"))> 1 then %>(<%=rs("DamColor")%>)<% end if  %><br></font>
								</td>
									</tr>
							<tr>
										<td colspan ="5" class = "body" valign = "top" >
	<br><font size = "2" color = "black" face = "arial">
	
	<% Description =rs("Description")
	
	str1 = Description
str2 = "''"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "'")
End If  
	%>
												<%=Description %><br></font>
	<br>

										</td>
									</tr>
								</table>

				</form>
		</td>
		
		
             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>
        
