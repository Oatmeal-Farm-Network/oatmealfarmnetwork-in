<% SetLocale("en-us") %>
<html>

<head>

<% ID = request.form("ID")%>

<!--#Include file="ReportsGlobalVariables.asp"-->

<% linecounter = 1 %>
<link rel="stylesheet" type="text/css" href="/Style.css">
<STYLE TYPE="text/css">
     H4 {page-break-before: always}
</STYLE> 

</head>
<body  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

   
<table   border="0"  bordercolor = "#AA8560" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" background = "images/Background.jpg"  width = "600">
	<tr>
		 <td  align = "center" class = "body">	
		  <% if len(Logo) > 1 then%>
		    <img src = "<%=Logo%>" align = "center" />
		 <% end if %>
		 <font face="arial" size="4"><b><%=WebSiteName%></b></font><br>
<font face="arial" size="3">
Phone Number: <%=Phone%>&nbsp;&nbsp;<br>
		<% if len(Fax) > 1 then %>
					Fax: <%=Fax%>&nbsp;&nbsp;<br>
		<% end if %> 
				<% if len(Street) > 1 then %>
							<%=Street%><br>
				<% end if %>
					<% If  Len(Street2) >1 Then %>
						<%=Street2%><br>
					<% End If %>
					<% if len(City) > 1 then %>
					    <%=City%>, &nbsp;
					<% end if  %>
					<% if len(State) > 1 then %>
					<%=State%>&nbsp;
					<% end if %>
					<% if len(Zip) > 1 then %>
					    <%=Zip%>
					 <% end if %>
					 <% if len(City) > 1 or  len(State) > 1 or len(Zip) > 1 then %>
					 <br>
					 <% end if %></font>
					<font face="arial" size="3"><%=Email%></font><br />
</td></tr></table>
							
				
	

<% 	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" '& _ 
	' Get marketing text for the top of the page:
     
	sql = "select * from WebView where animals.id=" & ID 
	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
    alpacaID = rs("Animals.ID")
   'response.write( alpacaID)

	photoID = "nophoto"
  
        imagelength = len(rs("Photo1"))
		if  imagelength > 5 then
            photoID = rs("Photo1")
		end if
photo1 = rs("Photo1")
              
 Category = rs("Category")%>
<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
    <tr>         
		<td align="center"  class = "body" colspan = "5" height = "25" bgcolor = "<%=ReportHighlightColor%>" ><font color = "black" face="arial"  size = "4"><b><%=rs("FullName")%></b></font></td>
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
<% if not( rs("DOBMonth") = 0) and not( rs("DOBDay") = 0) and not( rs("DOBYear") = 0)  then %>		
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">DOB:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("DOBMonth")%>/<%=rs("DOBDay")%>/<%=rs("DOBYear")%></font><br>			
</td></tr>
<% end if %>
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">Sire:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("Sire")%> <% if len(rs("SireColor"))> 1 then %>(<%=rs("SireColor")%>)<% end if  %></font><br>			
</td></tr>
<tr><td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial">Dam:</font>			
</td>
<td valign = "top" class = "body" >
				<font size = "2" color = "black" face = "arial"><%=rs("Dam")%> <% if len(rs("DamColor"))> 1 then %>(<%=rs("DamColor")%>)<% end if  %></font><br>			
</td></tr>




<tr><td colspan ="5" class = "body" valign = "top" colspan = "2">
	<br><font size = "2" color = "black" face = "arial">
			<%=rs("Description")%><br></font>
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
              <% If len(rs("Photo1")) > 2  then %>
			     <img src="<%=rs("Photo1")%>"  border=0 width = "300">     
             <% End If  %>
  <br> <%=click%>
</td></tr>
<tr><td class = "body">
	


</td></tr>
</table>

<table width = "700"    border="0" cellspacing="0" cellpadding="0"  align = "center">
  <tr><td>
<!--#Include file="ServiceSireInclude.asp"-->
<% sql2 = "select distinct * from Fiber where Fiber.ID = " & ID & " order by SampleDate DESC, Average DESC,  StandardDev DESC ,  COV DESC, GreaterThan30 DESC , Blanketweight DESC, Shearweight DESC"

				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
	if not rs2.eof  then
		if (len(rs2("SampleDate")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then %>
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
	if (len(rs2("SampleDate")) >1 or len(rs2("Average")) >1 or len(rs2("StandardDev")) >1 or len(rs2("COV")) >1 or len(rs2("GreaterThan30")) >1 	or len(rs2("Blanketweight")) >1 or len(rs2("Shearweight")) >1	) then 

				 SampleDate	= rs2("SampleDate") 
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






						




</body>
</html>

