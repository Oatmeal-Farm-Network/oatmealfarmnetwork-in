<% SetLocale("en-us") %>
<html>

<head>

<% ID = request.form("ID")%>

<!--#Include file="AdminGlobalVariables.asp"-->
<!--#Include file="AdminReportsGlobalVariables.asp"-->
<% linecounter = 1 %>

<STYLE TYPE="text/css">
     H4 {page-break-before: always}
</STYLE> 

</head>
<body  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

   <table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"   width = "700" bgcolor = "white">
	<tr>
		 <td  align = "center" class = "body">	
<table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"   width = "600">
	<tr>
		 <td  align = "center" class = "body">	
		 <% if len(logo)> 1 then 
		 leftwidth = "50%" %>
		 <img src = "<%=Logo%>" border = "0" height = "100"><br>
		 <% else
leftwidth = "100%"		 
 end if %>
		 </td>
		 <td width = "<%=leftwidth%>">
		 <font face="arial" size="4"><b><%=Website%></b></font><br>
<font face="arial" size="3">
<% if len(Owners) > 1 then %>
	<%=Owners%>&nbsp;&nbsp;<br>
<% END IF %>
<%=PeoplePhone%>&nbsp;&nbsp;<br>
<% if len(PeopleCell) > 1 then %>
	<%=PeopleCell%>&nbsp;&nbsp;<br>
<% END IF %>
<% if len(PeopleFax) > 1 then %>
	Fax: <%=PeopleFax%>&nbsp;&nbsp;<br>
<% END IF %>
<% If  Len(AddressStreet) >1 Then %>
<%=AddressStreet%><br>
<% end if %>
<% If  Len(AddressApt) >1 Then %>
	<%=AddressApt%><br>
<% End If %>
<% IF LEN(Addresscity) > 1 then %>
<%=AddressCity%>, &nbsp;<%=AddressCity %>&nbsp; <%=Zip%><br>
<% end if %></font>
<font face="arial" size="3"><%=Website%></font><br>
<font face="arial" size="3"><%=Email%></font><br>
</td></tr></table>
	<br>						
				
	

<% ID = request.Form("ID")
     sql = "select animals.*, Pricing.*, colors.*, photos.*, ancestors.* from Animals, Pricing, Colors, photos, ancestors  where Animals.ID = Pricing.ID and animals.id = ancestors.id and animals.id = photos.id and animals.id = colors.id and animals.id=" & ID 
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	photoID = "nophoto"
  
        imagelength = len(rs("Photo1"))
		if  imagelength > 5 then
            photoID = rs("Photo1")
        else
       	 if  len(rs("Photo2")) > 5 then
            photoID = rs("Photo2")
       	end if
	end if
		
		
		
photo1 = photoID               
 Category = rs("Category")
 
 
 	
		Discount = (rs("Discount"))
	If discount > 1 Then
		DiscountPrice = FullPrice - fullprice*(discount/100)
	Else
		DiscountPrice = FullPrice
	End If

 
 %>
<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
    <tr>         
		<td align="center"  class = "body" colspan = "5" height = "25" bgcolor = "<%=ReportHighlightColor%>" ><font color = "white" face="arial"  size = "4"><b><%=rs("FullName")%></b></font></td>
	   </tr>
	   <tr>
 <td class= "body"  valign = "top">
		<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
			
				<% If rs("Price") = "sold" Or rs("Price") = "Sold" Then %>
				<tr><td valign = "top" class = "body" colspan = "2">
						<font size = "2" color = "#810000" face = "arial"><b>Sold</b></font>
				</td></tr>
				<% end if  %>
				<% If Len(rs("Price") ) > 2 Then %>
					<tr><td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial">Price:</font>				
					</td>
					<td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial"><b><%=Formatcurrency(rs("Price"),0)%></b></font>				
					</td></tr>
<% End If %>
<% If Discount > 1 Then %>
					<tr><td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial">Discount:</font>				
					</td>
					<td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial"><b><%=discount%>%</b></font>				
					</td></tr>
					<tr><td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial">Discount Price:</font>				
					</td>
					<td valign = "top" class = "body" >
						<font size = "2" color = "black" face = "arial"><b><%=Formatcurrency(DiscountPrice,0)%></b></font>				
					</td></tr>

<% End If %>
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">Category:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("Category")%></font><br>			
</td></tr>

<tr><td valign = "top" class = "body" with = "50">
				<font size = "2" color = "black" face = "arial">Color:</font>			
</td>
<td valign = "top" class = "body" width = "350">
	<font size = "2" color = "black" face = "arial" ><%
											Color1 = rs("Color1")
											Color2 = rs("Color2")
											Color3 = rs("Color3")
											Color4 = rs("Color4")
											Color5 = rs("Color5")
											%>
											
											<% If Len(Color1) > 1 Then %>
												<%=Color1%>
											<% end If %>
											
										<% If Len(Color2) > 1 Then %>
												/<%=Color2%>
											<% end If %>
												
												<% If Len(Color3) > 1 Then %>
												/<%=Color3%>
											<% end If %>

											<% If Len(Color4) > 1 Then %>
												/<%=Color4%>
											<% end If %>

											<% If Len(Color5) > 1 Then %>
												/<%=Color5 %>
											<% end If %>
</font><br>			
</td></tr>

<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">DOB:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%></font><br>			
</td></tr>
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">Sire:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("Sire")%> (<%=rs("SireColor")%>)</font><br>			
</td></tr>
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">Dam:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("Dam")%> (<%=rs("DamColor")%>)</font><br>			
</td></tr>

<tr><td colspan ="5" class = "body" valign = "top" colspan = "2">
	<br><font size = "2" color = "black" face = "arial">
			<%=rs("Description1")%><%=rs("Description2")%><br></font>
	<br>
<%
		 sql3= "select * from Awards where Awards.ID = " & ID & " order by Awards.Placing desc"
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				'response.write(sql3)
				rs3.Open sql3, conn, 3, 3 
				if Not rs3.eof  then
					if len(rs3("Show")) > 1  or len(rs3("Placing")) > 1   or len(rs3("Class")) > 1 then 
				%>

<table border="0" cellspacing="2"  width = "100%"  align = "center" >
		<tr>
			<td colspan = "4" align = "center" class = "body" ><font size = "2" color = "black" face = "arial"><b>Awards</b></font>
			</td>
		</tr>
		<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1" colspan = "53"><img src = "images/px.gif" height = "1"></td>
			</tr>
		<tr  bgcolor = "antiquewhite">
				<td width = "9"    valign = "top" align = "center" class = "body" ><b>Year</b></td>
				<td    valign = "top" align = "center" class = "body"><b>Show</b></td>
				<td   valign = "top" align = "center" class = "body" ><b>Placing</b></td>
				<td    valign = "top" align = "center" class = "body" ><b>Class</b></td>
		</tr>  

	<%
		While Not rs3.eof  
		   If Len(rs3("AwardYear")) > 2 then
			AwardYear	= rs3("AwardYear") 
			aShow	= rs3("Show") 
			aPlacing	= rs3("Placing") 
				aClass	= rs3("Type") 
			Awardcomments		= rs3("Awardcomments") 
	%>
			<tr bgcolor = "linen">
				<td   class = "body" ><%=AwardYear%> </td>	
					<td   class = "body" ><%=aShow%> </td>	
					<td align = "center" class = "body"  valign = "top"><%=aPlacing%> </td>
					<td align = "center" class = "body"  valign = "top"><%=AClass%> </td>
		   		</tr>     
         <%
		 End if
		rs3.movenext
		Wend 
	%>
</table>

<%End if%>
<%End if%>
</td>
</tr>
</table>
</td>
<td align="center" width = "130" valign = "top" class = "body">                          
              <% If len(photo1) > 2  then %>
			     <img src="<%=Photo1 %>"  border=0 width = "300">     
             <% End If  %>
  <br> <%=click%>
</td></tr>
<tr><td class = "body">
	


</td></tr>
</table>

<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
  <tr><td>

<% sql2 = "select * from Fiber where Fiber.ID = " & ID & " order by SampleDateYear DESC, SampleDateMonth DESC, Average DESC,  StandardDev DESC ,  COV DESC, GreaterThan30 DESC , Blanketweight DESC, Shearweight DESC"
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
	if not rs2.eof  then
		if (len(rs2("SampleDateYear")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then %>
<table border="0" cellspacing="2"  width = "100%"  align = "center" >
	<tr>
		<td valign = "top" align = "center" class = "body"> 
			<font size = "2" color = "black" face = "arial"><b>Fiber Stats</b></font>
			</td>
				</tr>
			<tr>
				<td class = "body" align ="left" bgcolor = "#670000" height = "1" colspan = "3"><img src = "images/px.gif" height = "1"></td>
			</tr>
			<tr>
			  <td>
			  <table border = "0"width = "100%"  align = "center" >
			<tr>	
		<td class = "body" width = "140" valign= "top" align = "center" bgcolor= "antiquewhite" >
		<b>Sample Date:</b>
		</td>
		<td class = "body" width = "140" valign= "top" align = "center" bgcolor= "antiquewhite">
		<b>AFD</b>
		</td>
		<td class = "body" width = "140" valign= "top" align = "center" bgcolor= "antiquewhite">
			<b>SD</b>
		</td>
		<td class = "body" width = "140" valign= "top" align = "center" bgcolor= "antiquewhite">
			<b>COV</b>
		</td>
		<td class = "body" valign = "top" width = "140" align = "center" bgcolor= "antiquewhite" >
			<b>%>30 micron</b>
		</td>
</tr>
<% While Not rs2.eof  
	if (len(rs2("SampleDateYear")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then 

				 SampleDate	= rs2("SampleDateMonth") & rs2("SampleDateMonth")  & rs2("SampleDateYear") 
				Average	= rs2("Average") 
				 StandardDev	= rs2("StandardDev") 
				 COV	= rs2("COV")
				GreaterThan30	= rs2("GreaterThan30")
				 Blanketweight	= rs2("Blanketweight")
				 Shearweight	= rs2("Shearweight")
				  CF	= rs2("CF")
				 Length	= rs2("Length")
				 Curve= rs2("Curve")
				 CrimpPerInch= rs2("CrimpPerInch")
				 %>
				
<tr>	
<td class = "body" width = "120" valign= "top" align = "center" bgcolor= "antiquewhite" >
	<%=SampleDate%>
	</td>
	<td class = "body"  valign= "top" align = "center" bgcolor= "linen">
	<%=Average%>
	</td>
		<td class = "body" valign= "top" align = "center" bgcolor= "linen" >
	<%=StandardDev%>
		</td>
		<td class = "body" valign= "top" align = "center" bgcolor= "linen" >
		<%=COV%>
		</td>
		<td class = "body" valign = "top"  align = "center" bgcolor= "linen">
			<%=GreaterThan30%>		
		</td>
	</tr>

             <% End if
					rs2.movenext
				Wend 
			%>
	</table>	  
	
<%End if%>
<%End if%>
<br>


<br>
				</td>
				</tr>
				</table>
</td></tr></table>
</body>
</html>

