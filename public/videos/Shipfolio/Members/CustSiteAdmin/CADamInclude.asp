  <%' Dam %>

		<%
		photoID = "x"
		photoID = rs("ListPageImage")

	
			

        If len (photoID) < 5 or IsEmpty(rs("ListPageImage")) then 
		     click3 =  "NotAvailableL.jpg"    
		Else
   		     click3 = rs("ListPageImage")      
        End If
'response.write(click3)
		DamName= Trim(rs("FullName"))
	   %>
		<td align=center   width = "180" valign = "top">        
			<table>
				<tr>
					<td align=center   width = "180" valign = "top">  
						<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #7B9D7C ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
							<tr>
								<td>
									<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=Dam&Detail.x=53&Detail.y=21" class = "body">
									<img src= "/uploads/ListPage/<%=click3%>" border = "0" width = "110"></a>
								</td>
							</tr>
						</table>  
					</td>
			</tr>
			<tr>
				<td align=center   width = "180" valign = "top">                          
					<b><%=Trim(rs("FullName"))%></b><br>
					<%=rs("Color")%><br>
					<br>
					<BR><%=hiddenInput%></font></b>
				</td>
			</tr>
		  </table>
		</td>

