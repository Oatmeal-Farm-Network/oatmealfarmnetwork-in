<%
oldcategory = ""
While Not rs.eof 
newcategory = rs("Category")

If Not (Trim(newcategory) = Trim(oldcategory)) then
%>

	<tr>
		<td colspan = "3">
<br><h2><%=newcategory%>s<br>
<img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "700" height = "2" ></h2>
		</td>
	</tr>

<%
End If
oldcategory = rs("Category")
		CurrentID = rs("Animals.ID")
		
		rs.movenext
		last = false
		if rs.eof  then
			last = true
		else
			NextID = rs("Animals.ID")
			if CurrentID <> NextID then
				last = true
			end if
		end if
		rs.moveprevious
		
		
		ID = rs("Animals.ID")
		Unique =false
		if ID <> OldID then
			Unique =True
		end if

		
		if Unique = true then
		
		OldID= rs("Animals.ID")
			counter = counter +1	
			
			if counter <>1 then%> 
					<tr><td colspan = "6"></td></tr>
			<%end if


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
                            "<input name=Detail type=image src=""/uploads/ListPage/NotAvailableL.jpg""  border=0 bordercolordark=#rrggbb width=""111"" >"
			Else
   			     click =  " <form action=""Details.asp"" method=""get"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
							  "<input name=DetailType type=hidden value=" & DetailType & ">" &_
                            "<input name=Detail type=image bordercolordark=#rrggbb src=""/uploads/ListPage/" & PhotoID &"""  border=0  width=""111"" >"     
                End If

				%> 
				
			<% Category = rs("Category")

			If DetailType = "Dam" Then 
				sex = "Female"
			Else
				sex = "Male"
			End if

				ColorCategory =rs("ColorCategory")

%>
		
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
										
										<td valign = "top" class = "body" width = "45">
											Color: <br>
											DOB: <br>
											
											
										</td>
										<td valign = "top" class = "body" width = "160">
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
<td valign = "top" class = "body" width = "510">

<% if SireChoice = 1 then  %>
			<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Sire:</td>
					<td class = "body"><a href = "Details.asp?ID=<%=SireID%>&DetailType=Sire&Detail.x=53&Detail.y=21" class = "body"><%=SireName%></a></td>
				</tr>
			</table>

	
		<%
			else if  SireChoice = 2 then%>
					<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Sire:</td>
					<td class = "body"><a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=SireName%></a></td>
				</tr>
				</table>
			<%else %>
			<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Sire:</td>
					<td class = "body"><%=SireName%></td>
				</tr>
				</table>
					<%
		   end if
		end if
%>



<%if DamChoice = 1 then %>
				<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Dam:</td>
					<td class = "body"><a href = "Details.asp?ID=<%=DamID%>&DetailType=Dam&Detail.x=53&Detail.y=21" class = "body"><%=DamName%></a></td>
				</tr>
				</table>
	
		<%
			else if DamChoice = 2 then%>
				<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Dam:</td>
					<td class = "body"><a class = "slink" target = "_blank" href =<%=DamLink%>> <%=DamName%></a></td>
				</tr>
				</table>
			<%else %>
						<table border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
				<tr>
					<td width = "30" class = "body">Dam:</td>
					<td class = "body"><%=DamName%></td>
				</tr>
				</table>
					<%
		   end if
		  end if
		%>
				
			</td>
		</tr>
		<tr>
			<td colspan ="5" class = "body" valign = "top" >
							List Price: <%=rs("AValue")%>
				</td>
			</tr>


<% End if	%>
			<tr>
				<td colspan ="4" class = "body" valign = "top" >
	
				<%=rs("Week")%> 
				<%if Last = True then 
						%>
					
						Price: <b><%=rs("specials.Price")%> </b>
				<% 
				else%>
						Price: <strike> <%=rs("specials.Price")%></strike> 
				<% end if%>
				
					<%if rs("SalePending") = True then %>
						<b>Sale Pending</b>
					<% end if%>

						
				</td>
			</tr>


                    <% 
					
			 rs.movenext
           %>
     <%if Last = True then %>
		<tr>
				<td colspan ="4" class = "body" valign = "top" >
<div align = "center"><br><a href = "Details.asp?ID=<%=alpacaID%>&DetailType=<%=DetailType%>&Detail.x=53&Detail.y=21" class = "body">Click here for more information</a></div>
			</td>
		</tr>
		</table>
	 <%End If %>
          <%     
         Wend 
		 
		 %>
        
    
        		</table>
		</form>
		<br>
		<br>
       </form>
       





















<% While Not rs.eof 
		CurrentID = rs("Animals.ID")
		
		rs.movenext
		last = false
		if rs.eof  then
			last = true
		else
			NextID = rs("Animals.ID")
			if CurrentID <> NextID then
				last = true
			end if
		end if
		rs.moveprevious
		
		
		ID = rs("Animals.ID")
		Unique =false
		if ID <> OldID then
			Unique =True
		end if

		
		if Unique = true then
		
		OldID= rs("Animals.ID")
			counter = counter +1	
			
			if counter <>1 then%> 
					<tr><td colspan = "6"> &nbsp;<br><br><br></td></tr>
			<%end if%>
		 
		 <table>
    



		 <tr><td width="3">&nbsp;</td>
     
          <%
			    alpacaID = rs("Animals.ID")
                
                'if (rs("AValue")) <100 then 
                 '  alpacasPrice=""
                'else 
                	alpacasPrice= rs("AValue")
                'end if
                'if len(Price) = 1 then
                '	if Price = "$" then
                '		Price = "<i>call for price</i>"
			'end if
	          'end if
		photoID = "x"
		photoID = rs("ListPageImage")

		if len(photoID) < 5 or IsEmpty(rs("ListPageImage")) then
                     photoID = "nophoto"
		end if
			

               	If photoID = "nophoto" then 
			     click =  " <form style='display: inline; margin: 0;'  action=""Details.asp"" method=""post"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                            "<input name=Detail type=image src=""/images/NotAvailable.jpg""  border=0 width=""110"" ></form> "
			Else
   			     click = "<form style='display: inline; margin: 0;'  action=""Details.asp"" method=""post"">" &_
                             "<input name=ID type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                             "<input name=Detail type=image src= ""/uploads/ListPage/"& photoID & """  border=0 width=""110"" ></form>"            
                
                End If
                %> 
		
				

                    <td align="center" width = "100" valign = "bottom">                          
                               <%=click%>
								</form>
	       </td>
		   <td width = "20">
				&nbsp;
			</td>

							
					       <td class= "body" width = "600" valign = "top">
							<form action="Details.asp" method="post" style='display: inline; margin: 0;' >
								<input name=ID type=hidden value="<%=alpacaID %>">
								<label for="Ninputdata<%=counter%>" > <font  color = '#BF3333' 
										onMouseOver="this.style.color = 'black' ,this.style.cursor='Hand';"  
										onMouseOut="this.style.color = '#BF3333' "><big><%=Trim(rs("FullName"))%></big></font></label>
									<input name="Detail" type=image src= "images/px.gif" id="Ninputdata<%=counter%>">
										</form>
										
									<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
								
									<tr>
										<td valign = "top" class = "body">
											Category: <%=rs("Category")%><br>
											Color: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("Color")%><br>
											DOB: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=rs("DOB")%>					
											
										</td>
										<td class = "body">
										
											
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
				<form action="HerdsireDetails.asp" name = "inputdata<%=counter%>" method="post" height = "1" style='display: inline; margin: 0;' > 
						<input name="Hinputdata<%=counter%>" type=image src= "images/px.gif" id="Hinputdata<%=counter%>">
						<input name=ID type=hidden value="<%=SireID%>" height = "0"> 
				</form>
					
		<%
			else if len(SireLink) > 1 then 
				SireChoice = 2
			else SireChoice = 3 
		   end if
		end if
		rsSire.close
		set rsSire=nothing
		%>






<%dim DamName
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
				<form action="FeDetails.asp" method="post" height = "1" style='display: inline; margin: 0;' > 
				
				
			 		<input name="Detail" type=image src= "images/px.gif" id="Dinputdata<%=Dcounter%>">
					<input name=ID type=hidden value="<%=DamID%>" height = "0"> 
				</form>

		<%
			else if len(DamLink) > 1 then
				DamChoice = 2
			else DamChoice = 3
		   end if
		end if
		rsDam.close
		set rsDam=nothing
		%>


<br><% if SireChoice = 1 then  %>
				<label for="Hinputdata<%=counter%>" > 
					Sire:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font  color = '#BF3333' ,  style="font-family : Arial,  sans-serif, font-size: 11pt;"
					onMouseOver="this.style.color = 'black' " 
					onMouseOut="this.style.color = '#BF3333' ,this.style.cursor='Hand';"  ><%=SireName%></font><br>
			 		</label>
					
		<%
			else if  SireChoice = 2 then%>
					Sire:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class = "body" target = "_blank" href ="http://<%=SireLink%>"> <%=SireName%></a><br>
			<%else %>
						Sire:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=SireName%><br>
				
					<%
		   end if
		end if

%>



<%if DamChoice = 1 then %>
				<label for="Dinputdata<%=Dcounter%>" > 
					Dam&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font  color = '#BF3333' ,  style="font-family : Arial,  sans-serif, font-size: 11pt;"
					onMouseOver="this.style.color = 'black' " 
					onMouseOut="this.style.color = '#BF3333' ,this.style.cursor='Hand';"  ><%=DamName%></font><br>			
				</label>

		<%
			else if DamChoice = 2 then%>
					Dam:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a class = "slink" target = "_blank" href =<%=DamLink%>> <%=DamName%></a><br>
			<%else %>
						Dam:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=DamName%><br>
				
					<%
		   end if
		  end if
		%><br>Starting Price: <%=rs("AValue")%><br>
			</td>
		</tr>
		

</table>

		</td>
        </tr>         
         <%end if %>
	    <tr>
			<td colspan = "3">
				&nbsp;
			</td>
			<td colspan = "3" class = "body" valign = "top">
                

				<%=rs("Week")%> 
				<%if Last = True then %>
						Price: <b><%=rs("Price")%> </b>
				<% else%>
						Price: <strike> <%=rs("Price")%></strike> 
				<% end if%>
				
					<%if rs("SalePending") = True then %>
						<b>Sale Pending</b>
					<% end if%>
			</td>
		</tr>
             </form>
             <% 
			 rs.movenext
           %>
          
          <%  
		  
         Wend 
		 
		 %>

		 
<%
 
  rs.close
  set rs=nothing
  set conn = nothing

%>
