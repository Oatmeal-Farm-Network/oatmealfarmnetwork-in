


<%While Not rs.eof 
			counter = counter +1	%>          
         <tr>
          <%
             for x=1 to 1
				  if rs.eof then
					exit for
                 end if 
                alpacaID = rs("Animals.ID")
                
               	Studfee= rs("Studfee")

		 photoID = "nophoto"
  
        imagelength = len(rs("ListPageImage"))
		if  imagelength > 5 then
            photoID = rs("ListPageImage")
		end if

               	If photoID = "nophoto" then 
			     click =  " <form action=""HerdsireDetails.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value='Sire'>" &_
                            "<input name=Detail type=image src=""/Uploads/ListPage/NotAvailable.jpg""  border=0 width=""115"" ></form>"
			Else
   			     click =  " <form action=""HerdsireDetails.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value='Sire'>" &_
                            "<input name=Detail type=image src=""/Uploads/ListPage/" & PhotoID &"""  border=0 width=""115"" ></form>"     
                
                End If
				%> 
				
			<% Category = rs("Category")%>

                
		<td align="center" width = "130" valign = "top" class = "body">                          
                               <%=click%>
	       </td>

	      <td class= "body"  valign = "top">
							<form action="HerdsireDetails.asp" method="get">
							<input name="ID" type="hidden" value="<%=alpacaID %>">
							<input name="DetailType" type="hidden" value="Sire">	
								<label for="Ninputdata<%=counter%>" > <font  color = '#6A3515' 
										onMouseOver="this.style.color = 'black' ,this.style.cursor='Hand';"  
										onMouseOut="this.style.color = '#6A3515'">
										<big><%=Trim(rs("FullName"))%></big></font></label>
									<input name="Detail" type=image src= "images/px.gif" id="Ninputdata<%=counter%>">
										</form>
										
									<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
									<tr>
										<td valign = "top" class = "body" width = "50">
											Stud Fee:<br>
											Color: <br>
											DOB: <br>
											
											
										</td>
										<td valign = "top" class = "body" width = "180">
											<b><%=rs("Studfee")%></b><br>
											<%=rs("Color")%><br>
											<%=rs("DOB")%><br>
											
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
				SireName 	= trim(rsSire("Animals.FullName"))
				SireID 	= rsSire("ID")%>
				<form action="HerdsireDetails.asp" name = "inputdata<%=counter%>" method="get" height = "1" >
						<input name="DetailType" type="hidden" value="other">	
						<input name="Hinputdata<%=counter%>" type=image src= "images/px.gif" id="Hinputdata<%=counter%>">
						<input name=ID type=hidden value="<%=SireID%>" height = "0"> 
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		rsSire.close
		set rsSire=nothing
		if SireChoice = 1 then %>	
			</form>	
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
				<form action="HerdsireDetails.asp" method="get" >
				<input name="DetailType" type="hidden" value="other">	
			 		<input name="Detail" type=image src= "images/px.gif" id="Dinputdata<%=Dcounter%>">
					<input name=ID type=hidden value="<%=DamID%>" height = "0"> 
		<%
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		rsDam.close
		set rsDam=nothing
		%>
</td></form>
<td valign = "top" class = "body" width = "310">

<% if SireChoice = 1 then  %>
				<label for="Hinputdata<%=counter%>" > 
					Sire: &nbsp; &nbsp;&nbsp;<font  color = '#6A3515' ,  style="font-family : Arial,  sans-serif, font-size: 11pt;"
					onMouseOver="this.style.color = 'black' " 
					onMouseOut="this.style.color = '#6A3515' ,this.style.cursor='Hand';"  ><%=SireName%></font><br>
			 		</label>
					
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
				<label for="Dinputdata<%=Dcounter%>" > 
					Dam: &nbsp; &nbsp;<font  color = '#6A3515' ,  style="font-family : Arial,  sans-serif, font-size: 11pt;"
					onMouseOver="this.style.color = 'black' " 
					onMouseOut="this.style.color = '#6A3515' ,this.style.cursor='Hand';"  ><%=DamName%></font><br>			
				</label>

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
										<td colspan ="5" class = "body" valign = "top" align = "center">
											<br><form action="HerdsireDetails.asp" method="get">
								<input name=ID type=hidden value="<%=alpacaID %>">
								<input name="DetailType" type="hidden" value="Sire">
								<label for="Ninputdata<%=counter%>" > <font  color = '#6A3515' 
										onMouseOver="this.style.color = 'black' ,this.style.cursor='Hand';"  
										onMouseOut="this.style.color = '#6A3515' ">Click here for details</font></label>
									<input name="Detail" type=image src= "images/px.gif" id="Ninputdata<%=counter%>">
										</form><br>															
										</td>
									</tr>
								</table>
								<%=hiddenInput%>
				</form>
		</td>
             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>
        
       </form>
       </table>