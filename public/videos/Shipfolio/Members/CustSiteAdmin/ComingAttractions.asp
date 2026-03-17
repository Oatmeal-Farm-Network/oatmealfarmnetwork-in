<HTML>

<HEAD>
    <title>A Washington Alpaca Farm,  Alpacas</title>
    <meta name="description" content="Comming Attractions, Suri and Huacaya Herdsires, Dams, and new cria.">
	<meta name="keywords" content="Oregon alpacas, herdsires, foundation females, dams, cria, Huacaya, Suri, Suris, raising alpacas, breeding alpacas, alpaca farm">
    <link rel="stylesheet" type="text/css" href="style.css">
<script language="Javascript"> 
   function PopupPic(sPicURL) { 
     window.open( "popup.htm?"+sPicURL, "",  
     "resizable=1,HEIGHT=200,WIDTH=200"); 
   } 
   </script> 
</HEAD>
<body bgcolor = "white" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 cellpadding=0 cellspacing=0>


<!--#Include virtual="/Header.asp"-->



<% 
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath("AlpacaData.mdb") & ";" & _
						"User Id=;Password=;" '& _ 

 dim firstColor, firstBreed, firstMale, firstFemale, firstPricing, firstOther, searchCondition, searchInput   
    firstColor=0
    firstBreed=0
    firstSex=0
    firstFemale=0
    firstPricing=0
    firstOther=0
    firstPackage=0
    firstForSale=0

    searchCondition=" where 1=1 " 
    hiddenInput=""
 
      
  if request.form("BacktoResult.x")<>"" then
    call getSearchResult()
  elseif request.form("Detail.x")<>"" then
        call getSearchDetail()
 elseif request.form("Detail2.x")<>"" then
        call getSearchDetail2()
  elseif request.form("Detail3.x")<>"" then
        call getSearchDetail3()
  else  
    call getSearchResult()   
  end if 
%>
<!--#Include virtual="/administration/Footer.asp"--> </Body>
</html>
<%

'dispaly search result
Sub getSearchResult()    
   

    
    sql = "select Animals.*, FemaleData.*, Photos.* from FemaleData, Animals, Photos where FemaleData.ID = Animals.ID and FemaleData.ID = Photos.ID and Bred = yes" 
' response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
 
   if rs.eof then
     response.write("&nbsp;&nbsp;&nbsp;<B><font face=""Ariel""  color=""#660000"" size=3 >Sorry, we have no Bred Females at the moment.</font></b>")
     // response.write("<form action=""sale.asp"" method=""post"">") 
     // response.write("<BR><BR>&nbsp;&nbsp;&nbsp;<input type=image   name=BacktoSearch src=images/back.gif>")
     //response.write("</form>")
   else %>     
      
<br>	 
	 <table align = "center" border="0" cellpadding="2" cellspacing="2" width="780" > 
	<tr>
		<td colspan = "7" class = "body" align = "center">
		<H1>Breeding for Quality</h2>
		Check out the Dam's we bred this year, the Herdsires we bred them to and wait to see how great the cria turn out!<br><br>
		<i>Click on the images below to see more detail.</i><br>
   	<tr>	
		<td align=center colspan = "3"><H3>Dam</H3></td>
		<td align=center colspan = "2" ><H3>Service Sire</H3></td>
		<td align=center colspan = "2" ><H3>Cria</H3></td>
      </tr>
	  <tr>
		<td colspan = "7"><img src="images/underline.jpg" width="770" alt = " Alpacas Underline"></td>
	</tr>
					  
       
       <%  While Not rs.eof%>          
         <tr><td width="3">&nbsp;</td>
     
          <%
             for x=1 to 1
                if rs.eof then%>
                    
                    <%exit for
                 end if 
				alpacaID = ""
                alpacaID = rs("Animals.ID")
		
		 
		photoID = "x"
		photoID = rs("ListPageImage")
		ServiceSireID = rs("ServiceSireID") 
		ExternalStudID = rs("ExternalStudID")
		if len(ServiceSireID) > 0 and not ServiceSireID = 0 then
			conns = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath("/AlpacaData.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
			sqls = "select Animals.FullName, Animals.Color, Photos.ListPageImage from Animals, Photos where Animals.ID = Photos.ID and Photos.ID =" & ServiceSireID

			Set rss = Server.CreateObject("ADODB.Recordset")
			rss.Open sqls, conns, 3, 3 

			ServiceSireName = rss("FullName")
			ServiceSireColor = rss("Color")
			ServiceSireImage 	= "images/ListPage/" + rss("ListPageImage")
			
			rss.close
			set rss=nothing
			set conns = nothing

			sireclick = "<form action=""ComingAttractions.asp"" method=""post"">" &_
                             "<input name=ID2 type=hidden value=" &  ServiceSireID & ">" & hiddenInput &_
                             "<input name=Detail2 type=image src= "& ServiceSireImage & "  border=0 height=""132"" width=""115"">"

		else if Len(ExternalStudID) > 0 then 
			conn6 = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
			"Data Source=" & server.mappath("/AlpacaData.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
			sql6 = "select * from ExternalStud where ExternalStudID =" & ExternalStudID

			Set rs6 = Server.CreateObject("ADODB.Recordset")
			rs6.Open sql6, conn6, 3, 3 

			CurrentXStudID = rs6("ExternalStudID")
			ServiceSireName = rs6("FullName")
			CurrentXStudLink = rs6("ServiceSireLink")
			CurrentXStudImage = "images/ListPage/" + rs6("ServiceSireImage")
			
			rs6.close
			set rs6=nothing
			set conn6 = nothing
			
			sireclick = "<a href = ""http:///"& CurrentXStudLink &""" border = 0><img src ="""& CurrentXStudImage &""" height=""132"" width=""115"" border = 0 alt =  Alpacas Herdsire></a>"
			end if
		end if

		if len (photoID) < 5 or IsEmpty(rs("ListPageImage")) then
                     photoID = "nophoto"
		end if
			

        If photoID = "nophoto" then 
			     click3 =  " <form action=""ComingAttractions.asp"" method=""post"">" &_
                             "<input name=ID3 type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                            "<input name=Detail3 type=image src=Thumbnails/NoImage.jpg  border=0 height=""132"" width=""115"">"
			Else
   			     click3 = "<form action=""ComingAttractions.asp"" method=""post"">" &_
                             "<input name=ID3 type=hidden value=" &  alpacaID & ">" & hiddenInput &_
                             "<input name=Detail3 type=image src= images/ListPage/"& photoID & "  border=0 height=""132"" width=""115"">"                
                
                End If

		
		RecentProgenyID = rs("RecentProgenyID")

		if RecentProgenyID = 0 then 
			click2 =  " <img  src=""images/ListPage/NotYet.jpg""  border=0 alt = ""Not born yet, come back "">"
			DueDate = "Due: " & RS("Duedate")
			CriaName = " "
			CriaColor = " "

		else
		    
			sqlp = "select Animals.*, Photos.* from  Animals, Photos where Animals.ID = Photos.ID and Animals.ID=" &  RecentProgenyID
			' response.write (sql)
			Set rsp = Server.CreateObject("ADODB.Recordset")
			rsp.Open sqlp, conn, 3, 3   
			CriaName = rsp("FullName")
			CriaColor = (rsp("Color"))
			DueDate = " "
			ID2 = rsp("Animals.ID")
			photoID = "x"
			photoID = rsp("ListPageImage")
               	If photoID = "nophoto" then 
			     click2 =  " <form action=""ComingAttractions.asp"" method=""post"">" &_
                             "<input name=ID2 type=hidden value=" &  ID2 & ">" & hiddenInput &_
                            "<input name=Detail2 type=image src=images/ListPage/NotYet.jpg  border=0 height=""140"" width=""100"">"
				Else
   			     click2 = "<form action=""ComingAttractions.asp"" method=""post"">" &_
                             "<input name=ID2 type=hidden value=" &  ID2 & ">" & hiddenInput &_
                             "<input name=Detail2 type=image src= images/ListPage/"& photoID & "  border=0 height=""140"" width=""100"">"                
                
                End If
		end if
		




		%> 
           <td align=center width = "100">                          
                              <%=click3%>      
	       </td>
	       <td class= "body" width = "200">
                                <H3><%=Trim(rs("FullName"))%></H3>
                                 <%=rs("Color")%>&nbsp;<%=rs("Breed")%><br>
								 <br>
                              <BR><%=hiddenInput%></font></b>
				
		</td>
		<td align=center width = "100">                          
                              <%= sireclick%>
	       </td>
	       <td class= "body" width = "200">
                                <H3> <%=ServiceSireName%></H3>
                                <%=ServiceSireColor%><br><br>
                                <BR><%=hiddenInput%></font></b>
				
		</td>
		<td align=center width = "120">                          
                               <%=click2%>
	       </td>
	       <td class= "body" width = "200">
                                <H3> <%=CriaName%></H3>
                               <%=CriaColor%><br>
							   <%=DueDate%><br><br>
                               <BR><%=hiddenInput%></font></b>
				</form>
		</td>
                
                      
              
             <% rs.movenext
             next %>
           </tr>
          <%     
         Wend %>
         

       </form>
       </table>
	   <br><br>
<!--#Include virtual="/Footer.asp"-->
<%
  end if 
  rs.close
  set rs=nothing
  set conn = nothing
End Sub 

'for selected alpaca's detail info
Sub getSearchDetail()
	ID=request.form("ID3") 
	
	if ID="" then
		ID=request.queryString("ID3")
	end if 
	ID=request.form("ID3")
	if ID="" then
		ID=request.queryString("ID3")
	end if 
	
	'set conn = server.createobject("adodb.connection")
	'conn.Open "DSN=webdata;DRIVER={Driver do Microsoft Access (*.mdb)}"
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT Animals.*, Photos.* FROM Animals, Photos WHERE Photos.ID=Animals.ID And  Animals.ID=" & ID 

	rs.Open sql, conn, 3, 3 
	
	if not rs.eof then 

 		photoID = "images/DetailPage/" & rs("DetailPageImage")
		fiberphotoID = "images/Fleece/" & rs("FiberImage")
		ARIImage = "images/ARI/" & rs("Photos.ARI")
     
 		If IsEmpty(photoID) or photoId = "0" then
            click = "<img height=429 width=347 src=images/DetailPage/NotAvailable.jpg alt = Alpaca image not available Underline> "
        Else
            click = "<img height=429 width=347 src=" & photoID & " alt =  Alpaca Image>" 
        End If
    	name 	= trim(rs("FullName"))
		DOB 	= rs("DOB")
		ARI 	= rs("Animals.ARI")
		Color   = rs("Color")
		Breed   = rs("Breed")
		Male 	= rs("Male")
		Comments 	= rs("Comments")
		if Male = True then
			Sex = "Male"
		else
			Sex = "Female"
		end if


		sql2 = "select * from Fiber where Fiber.ID = " & ID
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
        if Not rs2.eof  then
			LHistogram= "images/Histograms/LargeHistogram/" & rs2("LargeHistogram")
			SHistogram= "images/Histograms/SmallHistogram/" & rs2("SmallHistogram")
		else 
			LHistogram= "images/Histograms/LargeHistogram/0" 
			SHistogram= "images/Histograms/SmallHistogram/0" 
		end if

        %>
	<table border="0" width="760" align = "center" >
		<tr>
 			<td align=center ><br><H1><%=rs("FullName")%><H1>
			</td>
		</tr>
	</table>
	<table border="0" cellspacing="2" width="760" align = "center" >
		<tr>
		  <td  height="200" align=left valign=top>
			<table border=0  valign=top cellspacing="3"  >
						
								
				<tr>
    					<td  align=left class = "TableHead" >Color:</td>
                    			<td align=left class = "body" width = "550"><%=Color%></td>
                		</tr>		
				<tr>
    					<td  align=left class = "TableHead"> DOB:</td>
                    			<td  align=left class = "body"><%=DOB%></td>
                </tr>
				<tr>
    					<td  align=left class = "body" colspan = "2"><br><%=Comments%></td>
                </tr>
				<tr>
    				<td  align="left" class = "body" colspan = "2">
				<%
					If IsEmpty(fiberphotoID) or fiberphotoID = "images/Fleece/0" then
					else
						FleeceClick = fiberphotoID 
						
				%>
						<a href="javascript:PopupPic('<%=fiberphotoID%>')" class = "link" ><img src ="<%=fiberphotoID%>" height = "100" align = "left" ></a>
				<% End if %>
					<%
					If IsEmpty(ARIImage) or ARIImage = "images/ARI/0" then
					else
						ARIClick = ARIImage 
						
					%>
						<a href="javascript:PopupPic('<%=ARIClick%>')" class = "link" ><img src ="<%=ARIClick%>" height = "100" align = "left" ></a>
					<% End if %>   


					<%
					If IsEmpty(SHistogram) or SHistogram = "images/Histograms/SmallHistogram/0" then
					else
												
					%>
						<a href="javascript:PopupPic('<%=LHistogram%>')" class = "link"><img src ="<%=SHistogram%>" height = "100" align = "left" ></a>
					<% End if %>   
					</td>
				</tr>	
                 <% 
			
				sqlc = "select * from CriaShots where ID = " & ID
				Set rsc = Server.CreateObject("ADODB.Recordset")
				rsc.Open sqlc, conn, 3, 3 
				if Not rsc.eof Then 
				%>
					<tr>
						<td colspan = "3">
							<div align = "center"><H3>Cria Image(s)</H3><br>

							<% While Not rsc.eof
								CriaShot= "images/ListPage/" & rsc("Image")
								If CriaShot= "images/ListPage/0" then
								else
								%>
								<a href="javascript:PopupPic('<%=CriaShot%>')" class = "link"><img src ="<%=CriaShot%>" height = "100" align = "left" ></a>
								<% End if 
								rsc.movenext
					  		 wend 
							 %>
						</td>
					</tr>
				<% End if %>
			</table>
		</td>
	
	   <td width = "300">
	   <%
		If photoId <> "images/DetailPage/0" then
            
       %>
			<%=click%>

			<%End If%>
        </td>
    </tr> 

	
</table>

<% 

				While Not rs2.eof         
				 SampleDate	= rs2("SampleDate") 
				 Average	= rs2("AverageFiberDiameter") 
				 COV	= rs2("CoefficientOfVariation")
				 GreaterThan30	= rs2("FiberGreaterThan30")
				 %>
<table  width = "776"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr>
		<td valign = "top" align = "center" class= "Details"> 
			<H2> Fiber Analysis</H2>
			<table>
				<tr  >
					<td   width = "100"  valign = "bottom" align = "center"  class = "TableHead">Sample Date </td>
					<td  width = "200" valign = "bottom" align = "center"  class = "TableHead">Ave. Fiber Diameter (microns)</td>
					<td  width = "180" valign = "bottom" align = "center"  class = "TableHead">Coefficient of Variation (%)</td>
					<td   width = "180" valign = "bottom" align = "center"  class = "TableHead" >Fibers < 30 microns (%)</td>
                 </tr>     
				
				<tr>	
					<td width = "100" align = "center"  class = "TableBody"><%=SampleDate%></td>
					<td width = "200" align = "center"  class = "TableBody"><%=Average%></td>
					<td width = "180" align = "center"  class = "TableBody"><%=COV%></td>
					<td width = "180" align = "center"  class = "TableBody" ><%=GreaterThan30%></td>
                 </tr>     
            
			
		  </table>
		</td>
	</tr>
</table>

 <% 
					rs2.movenext
				Wend 
			%>					


<% sql3= "select * from Ancestors where Ancestors.ID = " & ID
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				rs3.Open sql3, conn, 3, 3 

				While Not rs3.eof         
				 Dam	= rs3("DamName") 
				 MaternalGranddam	= rs3("DamDamName") 
				 MaternalGrandsire	= rs3("DamSireName")
				 Sire	= rs3("SireName")
				 PaternalGranddam	= rs3("SireDamName")
				 PaternalGrandsireDescription	= rs3("SireSireName")
				 %>
<table width = "776" align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr width = "660" colspan = "9">
		<td align = "center" colspan = "6" >
				<br><H2> Ancestry</H2>
		</td>
	</tr>
	<tr  align = "center">
		<td>
		<table align = "center" valign = "top" border = "0">
			<tr>
					<td valign = "top" align = "left"  class= "TableHead"> 
						Dam:<br>
						Maternal Granddam:<br>
						Maternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Dam%><br>
						<%=MaternalGranddam%><br>
						<%=MaternalGrandsire%><br>
					</td>
					<td width = "5">
						&nbsp;
					</td>
		
					<td valign = "top" align = "left" class= "TableHead"> 
						Sire:<br>
						Paternal Granddam:<br>
						Paternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Sire%><br>
						<%=PaternalGranddam%><br>
						<%=PaternalGrandsireDescription%><br>
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>

<% 
					rs3.movenext
				Wend 
			%>					
<table width = "660" align = "center">
	<tr walign = "left">
		<td>
			<br><a  class = "link" href="javascript:void(history.go(-1))"> Back</a>
			<br>
		</td>
	</tr>
</table>
<br>

<br>
<!--#Include virtual="/Footer.asp"-->

<%
	end if	
End Sub

'for selected aplaca's detail info
Sub getSearchDetail2()
	ID=request.form("ID2") 
	
	if ID="" then
		ID=request.queryString("ID2")
	end if 
	ID=request.form("ID2")
	if ID="" then
		ID=request.queryString("ID2")
	end if 
	
	'set conn = server.createobject("adodb.connection")
	'conn.Open "DSN=webdata;DRIVER={Driver do Microsoft Access (*.mdb)}"
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT Animals.*, StudData.*, Photos.* FROM Animals, StudData, Photos WHERE StudData.ID =Animals.ID And Photos.ID=Animals.ID And  Animals.ID=" & ID 

	rs.Open sql, conn, 3, 3 
	
	if not rs.eof then 

 		photoID = "images/DetailPage/" & rs("DetailPageImage")
		fiberphotoID = "images/Fleece/" & rs("FiberImage")
		ARIImage = "images/ARI/" & rs("Photos.ARI")
     
 		If IsEmpty(photoID) or photoId = "0" then
            click = "<img height=429 width=347 src=images/DetailPage/NotAvailable.jpg> "
        Else
            click = "<img height=429 width=347 src=" & photoID & ">" 
        End If
    	name 	= trim(rs("FullName"))
		DOB 	= rs("DOB")
		ARI 	= rs("Animals.ARI")
		Color   = rs("Color")
		Breed   = rs("Breed")
		Male 	= rs("Male")
		Comments 	= rs("StudComments")
		if Male = True then
			Sex = "Male"
		else
			Sex = "Female"
		end if


		sql2 = "select * from Fiber where Fiber.ID = " & ID
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
        if Not rs2.eof  then
			LHistogram= "images/Histograms/LargeHistogram/" & rs2("LargeHistogram")
			SHistogram= "images/Histograms/SmallHistogram/" & rs2("SmallHistogram")
		else 
			LHistogram= "images/Histograms/LargeHistogram/0" 
			SHistogram= "images/Histograms/SmallHistogram/0" 
		end if
		
		
        %>
	<table border="0" width="760" align = "center" >
		<tr>
 			<td align=center ><br><H1><%=rs("FullName")%><H1>
			</td>
		</tr>
	</table>
	<table border="0" cellspacing="2" width="760" align = "center" >
		<tr>
		  <td  height="200" align=left valign=top>
			<table border=0  valign=top cellspacing="3"  >
						
								
				<tr>
    					<td  align=left class = "TableHead">Color:</td>
                    			<td align=left class = "body" width = "550"><%=Color%></td>
                		</tr>		
				<tr>
    					<td  align=left class = "TableHead"> DOB:</td>
                    			<td  align=left class = "body"><%=DOB%></td>
                </tr>
				<tr>
    					<td  align=left class = "body" colspan = "2"><br><%=Comments%></td>
                </tr>
				<tr>
    				<td  align="left" class = "body" colspan = "2">
				<%
					If IsEmpty(fiberphotoID) or fiberphotoID = "images/Fleece/0" then
					else
						FleeceClick = fiberphotoID 
						
				%>
						<a href="javascript:PopupPic('<%=fiberphotoID%>')" class = "link" ><img src ="<%=fiberphotoID%>" height = "100" align = "left" ></a>
				<% End if %>
					<%
					If IsEmpty(ARIImage) or ARIImage = "images/ARI/0" then
					else
						ARIClick = ARIImage 
						
					%>
						<a href="javascript:PopupPic('<%=ARIClick%>')" class = "link" ><img src ="<%=ARIClick%>" height = "100" align = "left" ></a>
					<% End if %>   


					<%
					If IsEmpty(SHistogram) or SHistogram = "images/Histograms/SmallHistogram/0" then
					else
												
					%>
						<a href="javascript:PopupPic('<%=LHistogram%>')" class = "link"><img src ="<%=SHistogram%>" height = "100" align = "left" ></a>
					<% End if %>   
					</td>
				</tr>
				<% 
			
				sqlc = "select * from CriaShots where ID = " & ID
				Set rsc = Server.CreateObject("ADODB.Recordset")
				rsc.Open sqlc, conn, 3, 3 
				if Not rsc.eof Then 
				%>
					<tr>
						<td colspan = "3">
							<br>
							<div align = "center"><H3>Cria Image(s)</H3><br>

							<% While Not rsc.eof
								CriaShot= "images/ListPage/" & rsc("Image")
								If CriaShot= "images/ListPage/0" then
								else
								%>
								<a href="javascript:PopupPic('<%=CriaShot%>')" class = "link"><img src ="<%=CriaShot%>" height = "100" align = "left" ></a>
								<% End if 
								rsc.movenext
					  		 wend 
							 %>
						</td>
					</tr>
				<% End if %>
			</table>
		</td>
	
	   <td width = "300">
	   <%
		If photoId <> "images/DetailPage/0" then
            
       %>
			<%=click%>

			<%End If%>
        </td>
    </tr> 

	
</table>

<% 

				While Not rs2.eof         
				 SampleDate	= rs2("SampleDate") 
				 Average	= rs2("AverageFiberDiameter") 
				 COV	= rs2("CoefficientOfVariation")
				 GreaterThan30	= rs2("FiberGreaterThan30")
				 %>
<table  width = "776"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr>
		<td valign = "top" align = "center" class= "Details"> 
			<H2> Fiber Analysis</H2>
			<table>
				<tr  >
					<td   width = "100"  valign = "bottom" align = "center"  class = "TableHead">Sample Date </td>
					<td  width = "200" valign = "bottom" align = "center"  class = "TableHead">Ave. Fiber Diameter (microns)</td>
					<td  width = "180" valign = "bottom" align = "center"  class = "TableHead">Coefficient of Variation (%)</td>
					<td   width = "180" valign = "bottom" align = "center"  class = "TableHead" >Fibers < 30 microns (%)</td>
                 </tr>     
				
				<tr>	
					<td width = "100" align = "center"  class = "TableBody"><%=SampleDate%></td>
					<td width = "200" align = "center"  class = "TableBody"><%=Average%></td>
					<td width = "180" align = "center"  class = "TableBody"><%=COV%></td>
					<td width = "180" align = "center"  class = "TableBody" ><%=GreaterThan30%></td>
                 </tr>     
                
			
		  </table>
		</td>
	</tr>
</table>


 <% 
					rs2.movenext
				Wend 
			%>					


<% sql3= "select * from Ancestors where Ancestors.ID = " & ID
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				rs3.Open sql3, conn, 3, 3 

				While Not rs3.eof         
				 Dam	= rs3("DamName") 
				 MaternalGranddam	= rs3("DamDamName") 
				 MaternalGrandsire	= rs3("DamSireName")
				 Sire	= rs3("SireName")
				 PaternalGranddam	= rs3("SireDamName")
				 PaternalGrandsireDescription	= rs3("SireSireName")
				 %>
<table width = "776" align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr width = "660" colspan = "9">
		<td align = "center" colspan = "6" >
				<br><H2> Ancestry</H2>
		</td>
	</tr>
	<tr  align = "center">
		<td>
		<table align = "center" valign = "top" border = "0">
			<tr>
					<td valign = "top" align = "left"  class= "TableHead"> 
						Dam:<br>
						Maternal Granddam:<br>
						Maternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Dam%><br>
						<%=MaternalGranddam%><br>
						<%=MaternalGrandsire%><br>
					</td>
					<td width = "5">
						&nbsp;
					</td>
		
					<td valign = "top" align = "left" class= "TableHead"> 
						Sire:<br>
						Paternal Granddam:<br>
						Paternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Sire%><br>
						<%=PaternalGranddam%><br>
						<%=PaternalGrandsireDescription%><br>
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>

<% 
					rs3.movenext
				Wend 
			%>					
<table width = "660" align = "center">
	<tr walign = "left">
		<td>
			<br><a  class = "link" href="javascript:void(history.go(-1))"> Back</a>
			<br>
		</td>
	</tr>
</table>
<br>

<br>
<!--#Include virtual="/Footer.asp"-->

<%
	end if	
End Sub

%>

<%
'for selected Dam's detail info
Sub getSearchDetail3()
	ID=request.form("ID3") 
	
	if ID="" then
		ID=request.queryString("ID3")
	end if 
	ID=request.form("ID3")
	if ID="" then
		ID=request.queryString("ID3")
	end if 
	
	'set conn = server.createobject("adodb.connection")
	'conn.Open "DSN=webdata;DRIVER={Driver do Microsoft Access (*.mdb)}"
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "SELECT Animals.*, Photos.* FROM Animals, Photos WHERE Photos.ID=Animals.ID And  Animals.ID=" & ID 

	rs.Open sql, conn, 3, 3 
	
	if not rs.eof then 

 		photoID = "images/DetailPage/" & rs("DetailPageImage")
		fiberphotoID = "images/Fleece/" & rs("FiberImage")
		ARIImage = "images/ARI/" & rs("Photos.ARI")
     
 		If IsEmpty(photoID) or photoId = "0" then
            click = "<img height=429 width=347 src=images/DetailPage/NotAvailable.jpg> "
        Else
            click = "<img height=429 width=347 src=" & photoID & ">" 
        End If
    	name 	= trim(rs("FullName"))
		DOB 	= rs("DOB")
		ARI 	= rs("Animals.ARI")
		Color   = rs("Color")
		Breed   = rs("Breed")
		Male 	= rs("Male")
		Comments 	= rs("Comments")
		if Male = True then
			Sex = "Male"
		else
			Sex = "Female"
		end if


		sql2 = "select * from Fiber where Fiber.ID = " & ID
				Set rs2 = Server.CreateObject("ADODB.Recordset")
				rs2.Open sql2, conn, 3, 3 
        if Not rs2.eof  then
			LHistogram= "images/Histograms/LargeHistogram/" & rs2("LargeHistogram")
			SHistogram= "images/Histograms/SmallHistogram/" & rs2("SmallHistogram")
		else 
			LHistogram= "images/Histograms/LargeHistogram/0" 
			SHistogram= "images/Histograms/SmallHistogram/0" 
		end if

		
        %>
	<table border="0" width="760" align = "center" >
		<tr>
 			<td align=center ><br><H1><%=rs("FullName")%><H1>
			</td>
		</tr>
	</table>
	<table border="0" cellspacing="2" width="760" align = "center" >
		<tr>
		  <td  height="200" align=left valign=top>
			<table border=0  valign=top cellspacing="3"  >
						
								
				<tr>
    					<td  align=left class = "TableHead" >Color:</td>
                    			<td align=left class = "body" width = "550"><%=Color%></td>
                		</tr>		
				<tr>
    					<td  align=left class = "TableHead">DOB:</td>
                    			<td  align=left class = "body"><%=DOB%></td>
                </tr>
				<tr>
    					<td  align=left class = "body" colspan = "2"><br><%=Comments%></td>
                </tr>
				<tr>
    				<td  align="left" class = "body" colspan = "2">
				<%
					If IsEmpty(fiberphotoID) or fiberphotoID = "images/Fleece/0" then
					else
						FleeceClick = fiberphotoID 
						
				%>
						<a href="javascript:PopupPic('<%=fiberphotoID%>')" class = "link" ><img src ="<%=fiberphotoID%>" height = "100" align = "left" ></a>
				<% End if %>
					<%
					If IsEmpty(ARIImage) or ARIImage = "images/ARI/0" then
					else
						ARIClick = ARIImage 
						
					%>
						<a href="javascript:PopupPic('<%=ARIClick%>')" class = "link" ><img src ="<%=ARIClick%>" height = "100" align = "left" ></a>
					<% End if %>   


					<%
					If IsEmpty(SHistogram) or SHistogram = "images/Histograms/SmallHistogram/0" then
					else
												
					%>
						<a href="javascript:PopupPic('<%=LHistogram%>')" class = "link"><img src ="<%=SHistogram%>" height = "100" align = "left" ></a>
					<% End if %>   
					</td>
				</tr>	
				<% 
			
				sqlc = "select * from CriaShots where ID = " & ID
				Set rsc = Server.CreateObject("ADODB.Recordset")
				rsc.Open sqlc, conn, 3, 3 
				if Not rsc.eof Then 
				%>
					<tr>
						<td colspan = "3">
							<div align = "center"><H3>Cria Image(s)</H3><br>

							<% While Not rsc.eof
								CriaShot= "images/ListPage/" & rsc("Image")
								If CriaShot= "images/ListPage/0" then
								else
								%>
								<a href="javascript:PopupPic('<%=CriaShot%>')" class = "link"><img src ="<%=CriaShot%>" height = "100" align = "left" ></a>
								<% End if 
								rsc.movenext
					  		 wend 
							 %>
						</td>
					</tr>
				<% End if %>
			</table>
		</td>
	
	   <td width = "300">
	   <%
		If photoId <> "images/DetailPage/0" then
            
       %>
			<%=click%>

			<%End If%>
        </td>
    </tr> 

	
</table>

<% 

				While Not rs2.eof         
				 SampleDate	= rs2("SampleDate") 
				 Average	= rs2("AverageFiberDiameter") 
				 COV	= rs2("CoefficientOfVariation")
				 GreaterThan30	= rs2("FiberGreaterThan30")
				 %>
<table  width = "776"  align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr>
		<td valign = "top" align = "center" class= "Details"> 
			<H2> Fiber Analysis</H2>
			<table>
				<tr  >
					<td   width = "100"  valign = "bottom" align = "center"  class = "TableHead">Sample Date </td>
					<td  width = "200" valign = "bottom" align = "center"  class = "TableHead">Ave. Fiber Diameter (microns)</td>
					<td  width = "180" valign = "bottom" align = "center"  class = "TableHead">Coefficient of Variation (%)</td>
					<td   width = "180" valign = "bottom" align = "center"  class = "TableHead" >Fibers < 30 microns (%)</td>
                 </tr>     
				
				<tr>	
					<td width = "100" align = "center"  class = "TableBody"><%=SampleDate%></td>
					<td width = "200" align = "center"  class = "TableBody"><%=Average%></td>
					<td width = "180" align = "center"  class = "TableBody"><%=COV%></td>
					<td width = "180" align = "center"  class = "TableBody" ><%=GreaterThan30%></td>
                 </tr>     
            
			
		  </table>
		</td>
	</tr>
</table>


 <% 
					rs2.movenext
				Wend 
			%>					


<% sql3= "select * from Ancestors where Ancestors.ID = " & ID
				Set rs3 = Server.CreateObject("ADODB.Recordset")
				rs3.Open sql3, conn, 3, 3 

				While Not rs3.eof         
				 Dam	= rs3("DamName") 
				 MaternalGranddam	= rs3("DamDamName") 
				 MaternalGrandsire	= rs3("DamSireName")
				 Sire	= rs3("SireName")
				 PaternalGranddam	= rs3("SireDamName")
				 PaternalGrandsireDescription	= rs3("SireSireName")
				 %>
<table width = "776" align = "center" 
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" border=0 
	cellpadding=0 cellspacing=0>
	<tr width = "660" colspan = "9">
		<td align = "center" colspan = "6" >
				<br><H2> Ancestry</H2>
		</td>
	</tr>
	<tr  align = "center">
		<td>
		<table align = "center" valign = "top" border = "0">
			<tr>
					<td valign = "top" align = "left"  class= "TableHead"> 
						Dam:<br>
						Maternal Granddam:<br>
						Maternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Dam%><br>
						<%=MaternalGranddam%><br>
						<%=MaternalGrandsire%><br>
					</td>
					<td width = "5">
						&nbsp;
					</td>
		
					<td valign = "top" align = "left" class= "TableHead"> 
						Sire:<br>
						Paternal Granddam:<br>
						Paternal Grandsire:<br>
					</td>
		
					<td align = "left" valign = "top"  class= "body" width = "200" > 
						<%=Sire%><br>
						<%=PaternalGranddam%><br>
						<%=PaternalGrandsireDescription%><br>
					</td>
				</tr>
			</table>
		</td>
		
	</tr>
</table>

<% 
					rs3.movenext
				Wend 
			%>					
<table width = "660" align = "center">
	<tr valign = "left">
		<td>
			<br><a  class = "link" href="javascript:void(history.go(-1))"> Back</a>
			<br>
		</td>
	</tr>
</table>
<br>

<br>
<!--#Include virtual="Footer.asp"-->

<%
	end if	
End Sub

%>