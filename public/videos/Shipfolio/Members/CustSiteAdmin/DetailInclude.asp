


<%While Not rs.eof 
			counter = counter +1	%>          
         <tr>
          <%
             for x=1 to 1
	
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
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0  width=""111"" >"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image src=""/uploads/ListPage/" & PhotoID &"""  border=0  width=""111"" >"     
                End If

				%> 
				
			<% Category = rs("Category")%>

		<td align="left" width = "135" valign = "top" class = "body" rowspan = "2">                          
            <table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 style="border-style: ridge; border-color: #6a7d67 ; border-right-width: 3; border-left-width: 2; border-top-width: 2; border-bottom-width: 3" >
			  <tr>
			     <td><%=click%></td>
			</tr>
			</table></form><br>
	       </td>

	      <td class= "body"  valign = "top" >
								<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><big><%=Trim(rs("FullName"))%></big></a>
								
			</td>
			</tr>
			<tr>
				<td class= "body"  valign = "top" >
								<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
									<tr>
										<% If Len(rs("Avalue")) > 2 Then %>
												<td valign = "top" class = "body" width = "45">
												Price:
											<br>
										</td>
										<% End If %>
										<% If Len(rs("Avalue")) > 2 Then %>
										<td valign = "top" class = "body" colspan = "2">
												<b><%=(rs("Avalue"))%></b><br>
											</td>
									<tr>
									<% End If %>
										<td valign = "top" class = "body" width = "45">
											Color: <br>
											DOB: <br>
											
											
										</td>
										<td valign = "top" class = "body" width = "130">
											<%=rs("Color")%><br>
											<% If Len(rs("DOB")) > 2 Then %>
												<%=rs("DOB")%><br>
												<% End If %>

											
											
											</td>
											<td >
													&nbsp;
											
<%
			SireName = rs("Sire")
			'response.write(SireName)
			DBSireName = SireName
			str1 = SireName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBSireName= Replace(str1, "'", "''")
				DBSireName = trim(DBSireName)
			End If

			Set rsSire = Server.CreateObject("ADODB.Recordset")
			sqlSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBSireName & "'"
			rsSire.Open sqlSire, conn, 3, 3 

			if not rsSire.eof then 
				SireChoice = 1 %>
				<%counter = counter +1
				SireName 	= trim(rsSire("FullName"))
				SireID 	= rsSire("ID")%>
					
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		rsSire.close
		set rsSire=nothing
		if SireChoice = 1 then %>	

		<% end if %>





<%
			DamName = rs("DamName")
			'response.write(SireName)
			DBDamName = DamName
			str1 = DamName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBDamName= Replace(str1, "'", "''")
				DBDamName = trim(DBDamName)
			End If

			Set rsDam = Server.CreateObject("ADODB.Recordset")
			sqlDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBDamName & "'"
			rsDam.Open sqlDam, conn, 3, 3 

			if not rsDam.eof then 
				DamChoice = 1 %>
				<%Dcounter = Dcounter +1
				DamName 	= trim(rsDam("FullName"))
				DamID 	= rsDam("ID")%>
				
				
		<%
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		rsDam.close
		set rsDam=nothing
		%>
</td>
<td valign = "top" class = "body" width = "310">

<% if SireChoice = 1 then  %>
			Sire: &nbsp;<a href = "Details.asp?ID=<%=SireID%>&DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><%=SireName%></a><br>

	
		<%
			else if  SireChoice = 2 then%>
					Sire: &nbsp;<a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=SireName%></a><br>
			<%else %>
						Sire: &nbsp;<%=SireName%><br>
					<%
		   end if
		end if
%>



<%if DamChoice = 1 then %>
				Dam:&nbsp;<a href = "Details.asp?ID=<%=DamID%>&DetailType=Dam&Detail.x=53&Detail.y=21" class = "body"><%=DamName%></a><br>

		<%
			else if DamChoice = 2 then%>
					Dam:&nbsp;&nbsp;<a class = "slink" target = "_blank" href =<%=DamLink%>> <%=DamName%></a><br>
			<%else %>
						Dam:&nbsp;<%=DamName%><br>
				
					<%
		   end if
		  end if
		%>
				
			</td>
		</tr>

		<tr>
			<td colspan ="5" class = "body" valign = "top" >
				<br><div ><a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">Click here for more information</a></div><br><br>
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
        
       </form>
       </table>