


<%While Not rs.eof 
			counter = counter +1	%>          
         <tr>
          <%
             for x=1 To 4
	
				  if rs.eof then
					exit for
                 end if 
                alpacaID = rs("Animals.ID")
               'response.write( alpacaID)
               	alpacasPrice= rs("Avalue")

		 photoID = "nophoto"
  
        imagelength = len(rs("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs("ListPageImage")
		end if

               	If photoID = "nophoto" then 
			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0  Height=""111"" ></form>"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/" & PhotoID &"""  border=0  height=""111"" ></form>"     
                End If

				%> 
				
			<% Category = rs("Category")%>

		<td align="center" width = "170" valign = "top" class = "body" >                          
            <%=click%>
			<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><%=Trim(rs("FullName"))%></a><br>
			<b><%=(rs("Avalue"))%></b><br>
						
			<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">For Details...</a></div><br>
		</td>

             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>

       </table>