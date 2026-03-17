


<% bcounter = 0
         pictureside = "left"

	
	



			sql = "SELECT  distinct * FROM SFProducts WHERE  SFProducts.custId = " & custID & " order by SFProducts.prodSubCategoryId, ProdPrice DESC " 
			'response.write(sql)
     
			Set rs = Server.CreateObject("ADODB.Recordset")
			rs.Open sql, conn, 3, 3  
				NewSubcategoryID = rs("ProdSubcategoryID")
				NewSubcategoryName = "No SubCategory"

			
		
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


			counter = counter +1	
			If pictureside = "left" then
			    pictureside = "right"
		 Else
		     pictureside = "left" 
	    End if
		 %>          
      

          <%
				while Not rs.eof
					
		    ID = rs("ProdID")
		 
		ProdPrice= FormatCurrency(rs("ProdPrice"),2)


				%>  
				<table border = "0" width = "625"     leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >
		<tr>
			<td>
			
	
		<table bgcolor = "#F0E1CF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" border = "0">
			<tr> 
			
			<td align="center" width = "125"  class = "body" valign = "top"> <br>      
				<!--#Include file="ProductsDetailImageInclude.asp"--><br> 
			</td>
		  <td class= "body"  valign = "top" align = "center" width = "400"><br>
				<!--#Include file="StoreProdInfoInclude.asp"--><br> 
			</td>
		</tr>
		</table>
		   <br>
			</td>
			</tr>
  </table>
		

 <% OldSubCategoryName = NewSubCategoryName
             rs.movenext  %>
           
		
          <%     
         Wend %>
        

  