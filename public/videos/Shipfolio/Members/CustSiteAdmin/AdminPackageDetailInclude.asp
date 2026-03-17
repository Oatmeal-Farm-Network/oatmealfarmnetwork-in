<%While Not rs2.eof 
counter = counter +1	%>  
 <tr>
  <%
     for x=1 to 1
				  if rs2.eof then
					exit for
 end if 
alpacaID = rs2("Animals.ID")
       'response.write( alpacaID)
       	alpacasPrice= rs2("Pricing.Price")

		 photoID = "nophoto"
  
imagelength = len(rs2("ListPageImage"))
		if  imagelength > 5 then
    photoID = rs2("ListPageImage")
		end if

       	If photoID = "nophoto" then 
			     click =  " <form action=""Details.asp"" method=""get"">" &_
     "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
    "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0 width=""120"" ></form>"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
     "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
    "<input name=Detail type=image src=""/uploads/ListPage/" & PhotoID &"""  border=0 width=""120"" ></form>"     

End If
				%> 
				
			<% Category = rs2("Category")%>


		<td align="center" width = "130" valign = "top" class = "body">  
       <%=click%>
	       </td>

	      <td class= "body"  valign = "top">
								<a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body"><big><%=Trim(rs2("FullName"))%></big></a><br>
										<br>
										
									<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
									<tr>
										<td valign = "top" class = "body" width = "100">
										
												Regular Price:<br>
								
										</td>
										<td valign = "top" class = "body" colspan = "2">
									
												<b><%=rs2("pricing.price")%></b><br>
									
											</td>
										
									<tr>
										<td valign = "top" class = "body" >
											Color: <br>
											DOB: <br>
											
											
										</td>
										<td valign = "top" class = "body" width = "160">
											<%=rs2("Color")%><br>
											<% If Len(rs2("DOB")) > 2 Then %>
												<%=rs2("DOB")%><br>
												<% End If %>

											
											
											</td>
											<td >
													&nbsp;
											
<%
			SireName = rs2("Sire")
			'response.write(SireName)
			DBSireName = SireName
			str1 = SireName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBSireName= Replace(str1, "'", "''")
				DBSireName = trim(DBSireName)
			End If

			Set rs2Sire = Server.CreateObject("ADODB.Recordset")
			sqlSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBSireName & "'"
			rs2Sire.Open sqlSire, conn, 3, 3 

			if not rs2Sire.eof then 
				SireChoice = 1 %>
				<%counter = counter +1
				SireName 	= trim(rs2Sire("FullName"))
				SireID 	= rs2Sire("ID")%>
					
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		rs2Sire.close
		set rs2Sire=nothing
		if SireChoice = 1 then %>	

		<% end if %>





<%
			DamName = rs2("DamName")
			'response.write(SireName)
			DBDamName = DamName
			str1 = DamName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBDamName= Replace(str1, "'", "''")
				DBDamName = trim(DBDamName)
			End If

			Set rs2Dam = Server.CreateObject("ADODB.Recordset")
			sqlDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBDamName & "'"
			rs2Dam.Open sqlDam, conn, 3, 3 

			if not rs2Dam.eof then 
				DamChoice = 1 %>
				<%Dcounter = Dcounter +1
				DamName 	= trim(rs2Dam("FullName"))
				DamID 	= rs2Dam("ID")%>
				
				
		<%
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		rs2Dam.close
		set rs2Dam=nothing
		%>
</td>
<td valign = "top" class = "body" width = "310">

<% if SireChoice = 1 then  %>
			Sire: &nbsp; &nbsp;&nbsp;<a href = "Details.asp?ID=<%=SireID%>&DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><%=SireName%></a><br>

	
		<%
			else if  SireChoice = 2 then%>
					Sire: &nbsp; &nbsp;&nbsp;<a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=SireName%></a><br>
			<%else %>
						Sire: &nbsp; &nbsp;&nbsp;<%=SireName%><br>
					<%
		   end if
		end if
%>



<%if DamChoice = 1 then %>
				Dam: &nbsp; &nbsp;<a href = "Details.asp?ID=<%=DamID%>&DetailType=Dam&Detail.x=53&Detail.y=21" class = "body"><%=DamName%></a>

		<%
			else if DamChoice = 2 then%>
					Dam: &nbsp; &nbsp;&nbsp;<a class = "slink" target = "_blank" href =<%=DamLink%>> <%=DamName%></a><br>
			<%else %>
						Dam: &nbsp; &nbsp;<%=DamName%><br>
				
					<%
		   end if
		  end if
		%>

							</td>
									</tr>
							<tr>
										<td colspan ="5" class = "body" valign = "top" >
											<br><%=rs2("animals.Description")%><br>
										

										</td>
									</tr>
									<tr>
										<td colspan ="5" class = "body" valign = "top" >
											<br><a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">Click here for details</a><br><br><br>
										</td>
									</tr>
								</table>
				</form>
		</td>
     <% rs2.movenext
     next %>
   </tr>
  <%     
 Wend %>

       </form>
       </table>