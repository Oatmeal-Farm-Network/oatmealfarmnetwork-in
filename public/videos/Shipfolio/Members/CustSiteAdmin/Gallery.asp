<html>
<head>

<title>Alpacas of Swallow Ridge  - Gallery</title>
<meta name="keywords" content="Huacaya Alpacas, Alpacas, Alpacas WA, Alpacas Washington, Alpacas Whatcom,  Alpacas Ferndale">
<meta name="description" content="Alpacas of Swallow Ridge">

<!--#Include virtual="/test/Header.asp"--> 
<%
Session("DSN_Name") = "DSN=homeinfatuation;DRIVER={Microsoft Access Driver (*.mdb)};"

	If Trim(Request.QueryString("referer")) <> "" Then
		Session("TradingPartnerID") = Request.QueryString("referer")
	End If	

	Session("HttpReferer") = Request.ServerVariables("HTTP_REFERER") 


	page=request.form("nextpage") 
	if page < 2 then
		page = 1
	end if
	
	Counter = 1
%>
			<%	cnn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath("../../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" 

						sql = "SELECT  * FROM GalleryHeadings WHERE PageID = " & page 
						Set rs = Server.CreateObject("ADODB.Recordset")
						'response.write(sql)
						rs.Open sql, cnn, 3, 3   %>


			


		<table width = "720" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellspacing=0 align ="center">
			<tr>
				<td class = "body">
					<h1><%= rs("Title")%></h1>
					<blockquote><%= rs("Description")%><br><br>
					Please click on an image to see it enlarged.</blockquote>

						<%
						sql = "SELECT  GalleryPhotos.*, GalleryHeadings.* FROM GalleryPhotos, GalleryHeadings WHERE GalleryPhotos.PageID = GalleryHeadings.PageID  order by Location" 
						Set rs = Server.CreateObject("ADODB.Recordset")
						'response.write(sql)
						rs.Open sql, cnn, 3, 3   


						oldid = 0
						counter = 0
						lcounter = 0
						if rs.eof then
						%>
								Sorry, currently we don't have any pictures.

						<% else 
							
							nextpage = page +1
							
								totalrecordcount = rs.recordcount
									numberofpages = round(totalrecordcount/5)
									pagecounter = 0
									first = 1
									%>
							
						<table border="0" cellpadding="0" cellspacing="0" align = "center" height = "200" width = "100%">
							<tr>
								<td  colspan = "9" align = "right" >
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
											<label for="inputdata<%=counter%>" > 
											Page: <font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' ">First</font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=first%>" height = "0"> </label>
										</form></td>
										<% if page > 1 then 
											counter = counter +1
											previousarrow = page -1%>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
										<label for="inputdata<%=counter%>" > 
										<input name=Detail type=image src= "images/previous.jpg"  id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=previousarrow%>" height = "0"> </label>
										</form></td>
								<%end if
								
									while pagecounter < (numberofpages)
										pagecounter = pagecounter +1
										Counter= Counter+1

										if trim(pagecounter)  = trim(page) and   rs("GalleryPhotos.PageID")= trim(page)then
											%>
										<td  class = "body"  valign = "top" align = "center" width = "12"><big><%=pagecounter%></big>
										</td>
										<% else %><form action="Gallery.asp" method="post" > 
										<td  class = "body"  valign = "top" align = "center" width = "12"><label for="inputdata<%=counter%>" > 
											<font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' "><%=pagecounter%></font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=pagecounter%>" height = "0"></label></td></form>
								<% end if
									wend
									Counter= Counter + 1

									nextarrow = page +1 
									if trim(page) < trim(numberofpages) then
									%>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
										<label for="inputdata<%=counter%>" > 
										<input name=Detail type=image src= "images/next.jpg"  id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=nextarrow%>" height = "0"> </label>
										</form></td>

										<% end if%>
										<td width = "34" align = "bottom" class = "body">
										<form action="Gallery.asp" method="post" > 
											<label for="inputdata<%=counter%>" > 
											<font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' ">Last</font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=numberofpages%>" height = "0"> </label>
										</form>
										</td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
							<td>
								<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
									<tr>
						
						<%   imagecount = 0	
							gotorecord = (page-1) * 5
							recordcounter = 0
							while recordcounter < gotorecord
								rs.movenext
								recordcounter = recordcounter +1
							wend
							PhotoLocation = 0
							
						sql = "SELECT  GalleryPhotos.*, GalleryHeadings.* FROM GalleryPhotos, GalleryHeadings WHERE GalleryPhotos.PageID = GalleryHeadings.PageID and GalleryPhotos.PageID = " & page & " order by Location" 
						Set rs = Server.CreateObject("ADODB.Recordset")
						'response.write(sql)
						rs.Open sql, cnn, 3, 3   

							done = false
							%>
		
<table border="0" cellpadding="0" cellspacing="0"  width = "778"  >
				<tr>
				<td width = "1">&nbsp;</td>
					<td valign = "top" align = "center">
							<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
								<tr>
											<% 
											If Not rs.eof then 
												If rs("Location") = "1"  Then %>
												<% if rs("Shape") = "Rectangle" then %>
															<td align = "center" >
																	<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="/Uploads/galleryPagesL/<%= rs("PhotoL")%>" border=3 bordercolor = "#ad0022" class = "tableborder" width = "200"><br>
																	<%= rs("Caption")%></a>
															</td>
												<% End if 
												if rs("Shape") = "Portrait Oval" then%>
															<td width = "163" height = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/POval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Landscape Oval" then%>
															<td Height = "163" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/LOval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Circle" then%>
															<td Height = "251" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/Circle.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

													If Not rs.eof Then
													rs.movenext 
											End If
											else%>

												<td width = "200" height = "260" align = "center" >
												&nbsp;
												</td>
										<% 
										End If 	
										End If 
										%>
									
								</tr>
								</table>
								<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
								<tr>
									<% 
											If Not rs.eof then 
												If rs("Location") = "2"  Then %>
												<% if rs("Shape") = "Rectangle" then %>
															<td align = "center" >
																	<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="/Uploads/galleryPagesL/<%= rs("PhotoL")%>" border=3 bordercolor = "#ad0022" class = "tableborder" width = "200"><br>
																	<%= rs("Caption")%></a>
															</td>
												<% End if 
												if rs("Shape") = "Portrait Oval" then%>
															<td width = "163" height = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/POval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Landscape Oval" then%>
															<td Height = "163" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/LOval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Circle" then%>
															<td Height = "251" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/Circle.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

													If Not rs.eof Then
													rs.movenext 
											End If
											else%>

												<td width = "200" height = "260" align = "center" >
												&nbsp;
												</td>
										<% 
										End If 	
										End If 
										%>
								</tr>
							</table>
					</td>
					<td width = "1">&nbsp;</td>
					<td >
							<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
								<tr>
												<% 
											If Not rs.eof then 
												If rs("Location") = "3"  Then %>
												<% if rs("Shape") = "Rectangle" then %>
															<td align = "center" >
																	<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="/Uploads/galleryPagesL/<%= rs("PhotoL")%>" border=3 bordercolor = "#ad0022" class = "tableborder" width = "200"><br>
																	<%= rs("Caption")%></a>
															</td>
												<% End if 
												if rs("Shape") = "Portrait Oval" then%>
															<td width = "163" height = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/POval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Landscape Oval" then%>
															<td Height = "163" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/LOval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Circle" then%>
															<td Height = "251" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/Circle.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

													If Not rs.eof Then
													rs.movenext 
											End If
											else%>

												<td width = "200" height = "260" align = "center" >
												&nbsp;
												</td>
										<% 
										End If 	
										End If 
										%>
								</tr>
							</table>
					</td>
					<td width = "1">&nbsp;</td>
					<td valign = "top" align = "center">
							<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
								<tr>
											<% 
											If Not rs.eof then 
												If rs("Location") = "4"  Then %>
												<% if rs("Shape") = "Rectangle" then %>
															<td align = "center" >
																	<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="/Uploads/galleryPagesL/<%= rs("PhotoL")%>" border=3 bordercolor = "#ad0022" class = "tableborder" width = "200"><br>
																	<%= rs("Caption")%></a>
															</td>
												<% End if 
												if rs("Shape") = "Portrait Oval" then%>
															<td width = "163" height = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/POval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Landscape Oval" then%>
															<td Height = "163" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/LOval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Circle" then%>
															<td Height = "251" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/Circle.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

													If Not rs.eof Then
													rs.movenext 
											End If
											else%>

												<td width = "200" height = "260" align = "center" >
												&nbsp;
												</td>
										<% 
										End If 	
										End If 
										%>
									
								</tr>
								</table>
								<table border="0" cellpadding="0" cellspacing="0"  align = "center"  >
								<tr>
									<% 
											If Not rs.eof then 
												If rs("Location") = "5"  Then %>
												<% if rs("Shape") = "Rectangle" then %>
															<td align = "center" >
																	<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="/Uploads/galleryPagesL/<%= rs("PhotoL")%>" border=3 bordercolor = "#ad0022" class = "tableborder" width = "80">cvjbjsdf<br>
																	<%= rs("Caption")%></a>
															</td>
												<% End if 
												if rs("Shape") = "Portrait Oval" then%>
															<td width = "163" height = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/POval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Landscape Oval" then%>
															<td Height = "163" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/LOval.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

												if rs("Shape") = "Circle" then%>
															<td Height = "251" Width = "251"  align = "center" background = "/Uploads/galleryPagesL/<%= rs("Photo")%>" >
																<a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><img src="images/Circle.gif" border=0 ></a></td>
																<tr>
																	<td align = "center"><a href = "/Uploads/galleryPages/<%= rs("Photo")%>" class = "body"><%= rs("Caption")%></a></td>
																</tr>
															
												<% End if 

													If Not rs.eof Then
													rs.movenext 
											End If
											else%>

												<td width = "200" height = "260" align = "center" >
												&nbsp;
												</td>
										<% 
										End If 	
										End If 
										%>
								</tr>
							</table>
					</td>
							</tr>
						</table>

<% End if %>




						
<br>
						<% pagecounter = 0
						first = 1
						counter = 20
						%>
						<table border="0" cellpadding="0" cellspacing="0"  align = "right" >
							<tr>
								<td  colspan = "9" align = "right">
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
											<label for="inputdata<%=counter%>" > 
											Page: <font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' ">First</font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=first%>" height = "0"> </label>
										</form></td>
										<% if page > 1 then 
											counter = counter +1
											previousarrow = page -1%>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
										<label for="inputdata<%=counter%>" > 
										<input name=Detail type=image src= "images/previous.jpg"  id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=previousarrow%>" height = "0"> </label>
										</form></td>
								<%end if
								
								while pagecounter < (numberofpages)
										pagecounter = pagecounter +1
										Counter= Counter+1

										if trim(pagecounter)  = trim(page) then
											%>
										<td  class = "body"  valign = "top" align = "center" width = "12"><big><%=pagecounter%></big>
										</td>
										<% else %><form action="Gallery.asp" method="post" > 
										<td  class = "body"  valign = "top" align = "center" width = "12"><label for="inputdata<%=counter%>" > 
											<font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' "><%=pagecounter%></font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=pagecounter%>" height = "0"></label></td></form>
								<% end if
									wend
									Counter= Counter + 1

									nextarrow = page +1 
									if trim(page) < trim(numberofpages) then
									%>
										<td  align = "bottom" class = "body">
										<form action="Gallery.asp" method="post"  > 
										<label for="inputdata<%=counter%>" > 
										<input name=Detail type=image src= "images/next.jpg"  id="inputdata<%=counter%>">
										<input name=nextpage type=hidden value="<%=nextarrow%>" height = "0"> </label>
										</form></td>

										<% end if%>
										<td width = "34" align = "bottom" class = "body">
										<form action="Gallery.asp" method="post" > 
											<label for="inputdata<%=counter +1 %>" > 
											<font  color = '#ad0022'  
											onMouseOver="this.style.color = 'black'; this.style.cursor = 'hand'" 
											onMouseOut="this.style.color = '#ad0022' ">Last</font>
			 							<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter +1 %>">
										<input name=nextpage type=hidden value="<%=numberofpages%>" height = "0"> </label>
										</form>
										</td>
									</tr>
									</table>
					</td>
			</tr>
		</table>
<br>
<br>
	<!--#Include virtual="/test/Footer.asp"--> 
</BODY>
</HTML>
