<% bcounter = 0
 pictureside = "left"
 icounter = 0
 While (Not rs.eof)  And icounter < 2
	 icounter =  icounter + 1
	   ProdDescription = rs("ProdDescription")
		str1 = ProdDescription
		str2 = vblfvblf
		If InStr(str1,str2) > 0 Then
			ProdDescription= Replace(str1, str2 , "</br>")
		End If  
		str1 = ProdDescription
		str2 = vblf
		If InStr(str1,str2) > 0 Then
			ProdDescription= Replace(str1, str2 , "</br>")
		End If  

		str1 = ProdDescription
		str2 = vbtab
		If InStr(str1,str2) > 0 Then
			ProdDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
		End If  
prodPurchasemethod = rs("prodPurchasemethod")
PaypalEmail = rs("PaypalEmail")
OtherURL= rs("OtherURL")
		counter = counter +1	
			If pictureside = "left" then
			    pictureside = "right"
		 Else
		     pictureside = "left" 
	    End if
		 %>     
         <table border = "0" width = "600"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >

          <% oldProdID = ProdID
                ProdID = rs("ProdID")
				while ProdID=  oldProdID 
					rs.movenext
					ProdID = rs("ProdID")
				wend
		 ProdPrice= rs("ProdPrice")
%> 
<tr>
<% For counter = 1 To 2 %>
<td class = "products" width = "200" align = "center" >
<%If Not rs.eof Then 
	If Len(rs("productImage1")) < 2 Then  
							 Image = "/uploads/imagenotavailable.jpg" 
					    else
							If Len(rs("productImage1")) < 30 Then 
							        Image = "/uploads/" & rs("productImage1")
								  Else
								   Image = rs("productImage1")
								End If 
						End If 							
								
								%>

										<a href = "ProductDetails.asp?prodid=<%=rs("prodid")%>&custID=<%=CustID%>" class = "products">
											<IMG alt="main image" border=0  src="<%= Image %>" align = "center" height = "95"><br>
											<div align = "left"><b><%=Trim(rs("ProdName"))%></b><br>
											<%=Trim(rs("SubCategoryName"))%><br>
											<%=FormatCurrency(rs("ProdPrice"))%>
										</a><br><br>
										</div>
				  </td>
				             <%
							 
							 rs.movenext  
							End If %>
				 <% Next %>
				 </tr>

		  </table>
          <%     
         Wend %>
        

  