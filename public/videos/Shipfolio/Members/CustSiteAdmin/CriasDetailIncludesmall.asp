


<%While Not rs.eof 
			counter = counter +1	
			
			
%>          
         <tr>
          <%
		  Found  = False
		  Nobody = true
             for x=1 To 3
	
				  if rs.eof then
					exit for
                 end if 

'response.write(rs("DOB"))
		If Not(rs("DOB") = "unknown")And Not(rs("DOB") = "0") then		
			BDate = CDate((rs("DOB")))
	
	
		If Year(BDate) = Year(now) And Not(BDATE = "unknown") Then
			found = True
			 Nobody = false




                alpacaID = rs("Animals.ID")
               'response.write( alpacaID)
               	alpacasPrice= rs("Avalue")

		 photoID = "nophoto"
  



        imagelength = len(rs("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs("ListPageImage")
		end if

               	If len(rs("ListPageImage"))<5 then 
				
			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0  Height=""120"" ></form>"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/" & PhotoID &"""  border=0  height=""120"" ></form>"     
                End If

				%> 
				
			<% Category = rs("Category")%>

		<td align="center" width = "170" valign = "top" class = "body" >                          
            <%=click%>
			<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><%=Trim(rs("FullName"))%></a><br>
			<% If rs("Avalue") = "Sold!" Then %>
					<b><%=(rs("Avalue"))%></b><br>
			<% End If %>
					Birthdate: <%=Trim(BDate)%>	<br>
			<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">For Details...</a></div><br>
				
		</td>

             <% 
			 
			 		Else
			 			x = X-1
						If found = False Then
							x = 0
						End If 
					End If
End If
rs.movenext
             next %>
           </tr>
          <%     
         Wend 
		 
		 
		  If Nobody = True then
		 
			'<td valign = "top" height = "200" align = "center">
			'	<h2>Sorry, no crias yet. Please check back with us for updates!</h2>
			'</td>
		 %> </tr>
		 <% End If %>
       </table>