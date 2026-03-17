


<% bcounter = 0
         pictureside = "left"

	 While Not rs.eof  
			
			counter = counter +1	
			If pictureside = "left" then
			    pictureside = "right"
		 Else
		     pictureside = "left" 
	    End if
		 %>          
         <table border = "0" width = "600"    leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" >

          <% oldproductid = productID
                productID = rs("ProductID")
				while productID=  oldproductid 
					rs.movenext
					productID = rs("ProductID")
				'response.write( productID)
				wend
		 
		 
		 productPrice= rs("Price")

		 photoID = "nophoto"


        imagelength = len(rs("image"))
		if  imagelength > 5 then
            photoID = rs("image")
		end if

               	If photoID = "nophoto" then 
			     click = "<img src =""/uploads/Products/NotAvailableL.jpg""  border=0   >"
			Else
   			     click =  "<img  src=""/uploads/Products/" & PhotoID & """  border=0  width=""200"" >"     
                
                End If
				%> 
				<tr>
            <td colspan = "2">
			<table width = "600">
				<tr>	
					<td class= "body"  valign = "top"  align = "left" height = "18" width = "620"><big><b><%=Trim(rs("FullName"))%></b></big>
					</td>
				<tr>
				<tr>
				<td   valign = "top" height = "2" valign = "top" background = "images/Ledge.jpg"><img src = "images/px.gif" height = "2" border = "0"></td>
				</tr>
			</table>
			</td>
        </tr>
					
			
		<%	If pictureside = "left" Then
		
			%>
		
		<tr>
			<td align="left" width = "200"  class = "body" valign = "top">       
				<!--#Include virtual="/ProductsDetailImageInclude.asp"--></td>
			  </form><br>
	       </td>
		   <td class= "body"  valign = "top" width = "350">
				<table width = "350">
				<tr>
				<td class= "body"  valign = "top" colspan = "3" width = "350">
							Product ID: <%=rs("ARI")%><br>
							<%=rs("Description")%><br>
					<% If (rs("price")) > 0 Then %>
									<br>	Price: <b><%=FormatCurrency(rs("price"))%></b><br>
									
	               <% End If  %>
								


<%


	ccounter = 1


 sql = "select Color from ProductColor where ProductID = " & rs("productID")

'response.write (sql)
    Set crs = Server.CreateObject("ADODB.Recordset")
    crs.Open sql, conn, 3, 3   
	
	While Not crs.eof  And crs.recordcount > 1
		cColor(ccounter) = crs("Color")
	
		ccounter = ccounter +1
		crs.movenext
	Wend		
	
		crs.close
		set crs=nothing

	scounter = 1


  sql = "select * from ProductSizes where ProductID = " & rs("ProductID")

'response.write (sql)
    Set srs = Server.CreateObject("ADODB.Recordset")
    srs.Open sql, conn, 3, 3   
	
	While Not srs.eof  And srs.recordcount > 1
		sSize(scounter) = srs("Size")
		sExtraCost(scounter) = srs("ExtraCost")
	
		scounter = scounter +1
		srs.movenext
	Wend		
	
		srs.close
		set srs=nothing
		%>
<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    >
	<tr>
		<td colspan = "2">
	




<% sql = "select ShowQuantity from Products where ProductID = " & rs("ProductID")

'response.write (sql)
    Set qrs = Server.CreateObject("ADODB.Recordset")
   qrs.Open sql, conn, 3, 3   

If qrs("ShowQuantity")=True Then %>

			 <select size="1" name="quantity">
			<option name = "Quantity0" value= "" selected><font color = "grey">quantity</font></option>
			<% count = 1
				while count < 6
			%>
				<option name = "Quantity1" value="<%=count%>">
						<%=count%> 
				
					<% 	count = count + 1
				wend %>
					</select>

<% 

qrs.close
set qrs=Nothing
End If
%>
	</tr>
	<tr>
		<td align = "right">

</td>
</form> 

		

		
		</td>
	</tr>
</table>














				</td>
			 </tr>
			 </table>
		</td>
</tr>
		   
		  	<% End if%>		














		<%	If pictureside = "right" Then
		
			%>
		
		<tr>
			
		   <td class= "body"  valign = "top" width = "350">
				<table width = "350">
				<tr>
				<td class= "body"  valign = "top" colspan = "3" width = "350">
							Product ID: <%=rs("ARI")%><br>
							<%=rs("Description")%><br>
					<% If (rs("price")) > 0 Then %>
						<br>Price: <b><%=FormatCurrency(rs("price"))%></b><br>
									
	               <% End If  %>


<%

	ccounter = 1


 sql = "select Color from ProductColor where ProductID = " & rs("ProductID")

'response.write (sql)
    Set crs = Server.CreateObject("ADODB.Recordset")
    crs.Open sql, conn, 3, 3   
	
	While Not crs.eof  And crs.recordcount > 1
		cColor(ccounter) = crs("Color")
	
		ccounter = ccounter +1
		crs.movenext
	Wend		
	
		crs.close
		set crs=nothing

	scounter = 1


  sql = "select * from ProductSizes where ProductID = " & rs("ProductID")

'response.write (sql)
    Set srs = Server.CreateObject("ADODB.Recordset")
    srs.Open sql, conn, 3, 3   
	
	While Not srs.eof  And srs.recordcount > 1
		sSize(scounter) = srs("Size")
		sExtraCost(scounter) = srs("ExtraCost")
	
		scounter = scounter +1
		srs.movenext
	Wend		
	
		srs.close
		set srs=nothing
		%>






<table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    >
	<tr>
		<td colspan = "2">
	







<% sql = "select ShowQuantity from Products where ProductID = " & rs("ProductID")

'response.write (sql)
    Set qrs = Server.CreateObject("ADODB.Recordset")
   qrs.Open sql, conn, 3, 3   

If qrs("ShowQuantity")=True Then %>

			 <select size="1" name="quantity">
			<option name = "Quantity0" value= "" selected><font color = "grey">quantity</font></option>
			<% count = 1
				while count < 6
			%>
				<option name = "Quantity1" value="<%=count%>">
						<%=count%> 
				
					<% 	count = count + 1
				wend %>
					</select>

<% End If

qrs.close
set qrs=nothing
%>
	</tr>
	<tr>
		<td align = "right">


</td>
</form> 

		

		
		</td>
	</tr>
</table>

				</td>
			 </tr>
			 </table>
		</td>
		<td align="left" width = "200"  class = "body" valign = "top">                 
				   <!--#Include virtual="/ProductsDetailImageInclude.asp"--> </td>
			  </form><br>
	       </td>
</tr>
		   
		  	<% End if%>	

             <% rs.movenext
           %>
           
		  </table>
          <%     
         Wend %>
        

  