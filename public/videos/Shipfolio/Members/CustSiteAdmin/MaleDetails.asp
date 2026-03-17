
<html>

<head>

<title>Alpacas at Lone Ranch - Male Alpacas Details</title>
<META name="description" content="Alpacas at Lone Ranch, Oregon, Alpacas for sale, trade, and breeding.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, farm, Souther Oregon Alpaca Ranch, alpaca fiber,  Alpacas at Lone Ranch, Medford, Oregon, Herdsires, Stud services, breeding, alpacas for sale, trading, alpaca breeder, alpaca shows, ">


<link rel="stylesheet" type="text/css" href="core-styles.css">
<%
dim buttonimages(20)
dim buttontitle(20)
ID=request.form("ID") 
If Len(ID) = 0 Then
  Response.Redirect("males.asp")
End if
		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath("../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	
	Set rsA = Server.CreateObject("ADODB.Recordset")
	sql = "select * from AdditionalPhotos where ID=" & ID & " Order by PhotoOrder"
	'response.write(sql)
	rsA.Open sql, conn, 3, 3 
	if not rsA.eof then 

	imageone = "/DetailPage/" + rsA("Image")
	counter = 0
	counttotal = rsA.recordcount
	While counter < counttotal
		
		counter = counter +1
		buttonimages(counter) = "/Uploads/DetailPage/" + rsA("Image")
		buttontitle(counter) = rsA("ImageTitle")
%>
<script language="JavaScript">
               if (document.images) version = "n3";
               else version = "n2";
               if (version == "n3") {
				but<%=counter%>on = new Image(85, 115);
				but<%=counter%>on.src = "/Uploads/DetailPage/<%=rsA("Image")%>";
			   }
	

       function img<%=counter%>(imgName) {
               if (version == "n3") {
               imgOn = eval("but<%=counter%>on.src");
               document [imgName].src = imgOn;               }       }
      
      
</script>

<% 
		if counter< counttotal then
			rsA.movenext
		end if
	wend
%>

<% end if %>

</head>
<body bgcolor="#dadada" >

<table dir="ltr" border="0" cellpadding="0" cellspacing="0" align = "center">
		<tr>
			<td valign="top">
				<div align="left">
					<table border="0" cellpadding="0" cellspacing="0" width="760" style="border-collapse: collapse" bordercolor="#111111" background = "images/Background.jpg">
						 <tr>
							<td width="100%">
								<div align="left">
										<table border="0" cellpadding="0" cellspacing="0" background = "images/Background.jpg">
											<tr>
												<td width="100%" align="left">
												<p align="left">
												<img border="0" src="Logo/TopLogo/LogoLoneRanch2.jpg" width = "760" alt = "Alpacas at Lone Ranch Logo">

												<table border="0" cellpadding="0" cellspacing="0" width="740" >
													<tr>
														<td width="100%">
															<div align="center">
																	<center>
																<table border="0" cellpadding="5" cellspacing="0"   bordercolor="#111111">
															 <tr>
																<td valign="middle" align="center" ><a href="index.htm" class = "header">Home</a>&nbsp;</td>
																<td valign="middle" align="center"><a href="D_Dream.htm" class = "header" class = "header">The Dream</a>&nbsp;</td>
																<td valign="middle" align="center">&nbsp;<a href="R_Ranch.htm" class = "header">The Ranch</a></td>
																
																<td valign="middle" align="center"><a href="di_Distinction.htm" class = "header" >The Distinction</a></td>
																<td valign="middle" align="center">
																	<img border="0" src="images/HeaderSpot.jpg" alt= "Alpacas at Lone Ranch Mountains"></td>
																	<td valign="middle" align="center"><a href="fs_Sale.htm" class = "header">Sale or Trade</a></td>
																	<td valign="middle" align="center"><a href="Breeding.htm" class = "header">Herdsire Breeding</a></td>
																	<td valign="middle" align="center">
																	<a href="SpecialsHome.asp" class = "header">Special Offers</a></td>
																</tr>
												</table>
												</center>
								</div>
							</td>
						</tr>
					</table>
				</div>
        </td>
    </tr>
</table>
     
</div>
<div align="left">
<table border="0" cellpadding="5" cellspacing="0" width="760" style="border-collapse: collapse" bordercolor="#111111" background = "images/Background.jpg">
    <tr>
      <td width="80%" align = "center">
        <h6 ><i><font color="black"></font></i><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "700" height = "2"></h6>
		</td>
	</tr>
</table>
<table  cellpadding="5" cellspacing="0" width="760" style="border-collapse: collapse" bordercolor="#111111" background = "images/Background.jpg">
    <tr>
      <td width="25%" valign="top" align = "center" bordercolor="#111111" border = "2">
			<br>
	<a href = "fs_Sale.htm" class = "SideMenu"><big>For Sale</big></a><br>
	  <img border="0" src="images/Seperator.jpg" alt="Alpacas at Lone Ranch Seperator" ><br>
            <a href = "GodfatherSale.asp" class = "SideMenu">Godfather Sale</a><br><a href = "Specials.asp" class = "SideMenu">Weekly Specials</a><br><a href = "Packages.asp" class = "SideMenu">Packages</a><br>
			<a href = "Females.asp" class = "SideMenu">Females for Sale</a><br>
			<a href = "Males.asp" class = "SideMenu">Males for Sale</a><br>
			<a href = "Yearlings.asp" class = "SideMenu">Yearlings & Crias for Sale</a><br>
			<a href = "FiberAnimals.asp" class = "SideMenu">Fiber Animals</a><br>
			<a href = "Herdsires.asp" class = "SideMenu">Stud Services</a><br>
			<a href = "Blacks.asp" class = "SideMenu">Blacks</a><br>
			<a href = "Greys.asp" class = "SideMenu">Greys</a><br>
			<a href = "Browns.asp" class = "SideMenu">Browns</a><br>
			<a href = "Fawns.asp" class = "SideMenu">Fawns</a><br>
			<a href = "Whites.asp" class = "SideMenu">Whites</a><br>
			
			<a href = "fs_EscrowReturnPolicy.htm" class = "SideMenu">Return Policy</a><br>
			<a href = "D_Links.htm" class = "SideMenu">Handy Links</a><br>
			<a href = "D_Ranchtour.htm" class = "SideMenu">Ranch Tour</a><br>
			<a href = "D_Contact.htm" class = "SideMenu">Contact Us</a><br>
			<a href = "mailto:questionAlpacasOnTheWeb.com?Subject=I have a question?" class = "SideMenu">Question Box</a><br><a href = "SiteMap.asp" class = "SideMenu">Site Map</a><br>
			<img border="0" src="images/Seperator.jpg" alt="Alpacas at Lone Ranch Seperator" ><br>
			</td>
			<td>
<br>
<%
  dim counter
  counter = 1

		
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath("../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
	
	Set rs = Server.CreateObject("ADODB.Recordset")
	sql = "select * from WebView where Animals.ID=" & ID
	'response.write(sql)
	rs.Open sql, conn, 3, 3 
	if not rs.eof then 
 		photoID = rs("DetailPageImage")
 		If IsEmpty(photoID) or photoId = "0" then
            click = "<img   src=""uploads/DetailPage/NotAvailable.jpg"" width = '220'> "
        Else
            click = "<img   src=""uploads/DetailPage/" & photoID & """ >" 
        End If
    	name 	= trim(rs("FullName"))
		ForSale	= rs("ForSale")
		DOB 	= rs("DOB")
		ARI 	= rs("ARI")
		Color   = rs("Color")
		Female 	= rs("Female")
			
		DamName 	= rs("DamName")
		DamColor 	= rs("DamColor")
		DamLink 	= rs("DamLink")
		DamDamName 	= rs("MaternalGranddam")
		DamDamColor 	= rs("MaternalGranddamsColor")
		DamDamLink 	= rs("MaternalGranddamsLink")
		DamSireName 	= rs("MaternalGrandsire")
		DamSireColor 	= rs("MaternalGrandsiresColor")
		DamSireLink 	= rs("MaternalGrandsiresLink")
		SireName 	= rs("Sire")
		SireColor 	= rs("SireColor")
		SireLink 	= rs("SireLink")
		SireDamName 	= rs("PaternalGranddam")
		SireDamColor 	= rs("PaternalGranddamColor")
		SireDamLink 	= rs("PaternalGranddamLink")
		SireSireName 	= rs("PaternalGrandsire")
		SireSireColor 	= rs("PaternalGrandsiresColor")
		SireSireLink 	= rs("PaternalGrandsiresLink")
		Comments 	= rs("Description")

		    if DamLink= "0" or IsEmpty(DamLink) or len(DamLink) < 5 then
 			DamLinkDescription = "Not Available"
			DamLink = "NoLink.asp"
		else
			DamLinkDescription = "Click Here"
 		end if 
 		

		if DamDamLink = "0"  or IsEmpty(DamDamLink) or len(DamDamLink) < 5then
 			DamDamLinkDescription = "Not Available"
			DamDamLink  = "NoLink.asp"
		else
			DamDamLinkDescription = "Click Here"
 		end if 
	

 		

		if DamSireLink= "0" or IsEmpty(DamSireLink) or len(DamSireLink) < 5 then
 			DamSireLinkDescription = "Not Available"
			DamSireLink = "NoLink.asp"
		else
			DamSireLinkDescription = "Click Here"
 		end if 
 		
 		if SireLink= "0" or IsEmpty(SireLink) or len(SireLink) < 5 then
 			SireLinkDescription = "Not Available"
			SireLink = "NoLink.asp"
		else
			SireLinkDescription = "Click Here"
 		end if 


 		if SireDamLink= "0" or IsEmpty(SireDamLink) or len(SireDamLink) < 5 then
 			SireDamLinkDescription = "Not Available"
			SireDamLink = "NoLink.asp"
		else
			SireDamLinkDescription = "Click Here"
 		end if 

 		if SireSireLink= "0" or IsEmpty(SireSireLink) or len(SireSireLink) < 5 then
 			SireSireLinkDescription = "Not Available"
			SireSireLink = "NoLink.asp"
		else
			SireSireLinkDescription = "Click Here"
 		end if 

		if SireColor= "0" or IsEmpty(SireColor) or len(SireColor) < 2 then
			SireColor ="Not Available"
		end if

		if SireDamColor= "0" or IsEmpty(SireDamColor) or len(SireDamColor) < 2 then
			SireDamColor ="Not Available"
		end if

		if SireSireColor= "0" or IsEmpty(SireSireColor) or len(SireSireColor) < 2 then
			SireSireColor ="Not Available"
		end if

		if DamColor= "0" or IsEmpty(DamColor) or len(DamColor) < 2 then
			DamColor ="Not Available"
		end if

		if DamDamColor= "0" or IsEmpty(DamDamColor) or len(DamDamColor) < 2 then
			DamDamColor ="Not Available"
		end if

		if DamSireColor= "0" or IsEmpty(DamSireColor) or len(DamSireColor) < 2 then
			DamSireColor ="Not Available"
		end if


        %>
	<table border="0" cellspacing="0" width = "550" align = "center" >
	    <tr>
					<td colspan=3 align=center valign=top  >
						<h1><%=rs("FullName")%></h1></td>
            	</tr> 
		<tr>
 		<tr>
				<td  valign = "top" align = "center">
				<table border="0" cellspacing="0" width = "550" align = "center" valign = "top" >
				   <tr>
				     <td width = "500" align = "center" valign = "top" >
					<% if counter < 1 then%>
							<%=click%>
						<% else %>
							<IMG alt="main image" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" width = "400">
						<% end if%>
					</td>
					<td  valign = "top" align = "center">
					<%
	if not rsA.eof then
	rsA.movefirst
	counter = 0
	counttotal = rsA.recordcount
	While counter < counttotal
		%>

		<table border="0" cellspacing="0" align = "center" valign = "top" >
			<tr>
		<% for x= 1 to 1
		    
			 if counter = counttotal then
					exit for
             end if 
			counter = counter +1
			if rsA.recordcount > 1 then
			%>
			<td valign = "top" align = "center">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"></font>
			</td>

		<%
			end if
		if counter< counttotal then
			rsA.movenext
		end if
		
		next
		%>
			</tr>
			</table>
		<%
	wend
	end if
%>
				</td>
			</tr>
		</table>
				</td>
		</tr>
		<td  height="100"   valign=top>
			<table border=0  valign=top cellspacing="3"  >
			  <tr>
    					<td width="60"   class = "Details">Price:</td>
                    	<td class = "body"><b><%=rs("AValue")%></b></td>
                </tr>
				<tr>
    					<td width="60"   class = "Details"> Color:</td>
                    			<td width="200"   class = "body"><%=Color%></td>
          		</tr>		
				<tr>
    					<td width="60"   class = "Details"> DOB:</td>
                    	<td width="200"   class = "body"><%=DOB%></td>
                </tr>	
				<tr>
    					<td width="60"   class = "Details">ARI #:</td>
                    	<td   class = "body">
								<% if len(ARI) > 2 then%>
										<%=ARI%>
								<% end if %>
								</td>
                </tr>	
				<tr>
					<td width="60"  valign = "top"   class = "Details">Description:</td>
					<td  valign = "top"class = "body"><%=Comments%></td>
            	</tr>	
				
</table>

<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 psql = "select * from AdditionalPhotos where ID =" & ID 


    Set prs = Server.CreateObject("ADODB.Recordset")
    prs.Open psql, conn, 3, 3   
	rowcount = 1
	'dim ID(60)
	dim ImageName(60)
	dim pPhotoID(60)
	
Recordcount = prs.RecordCount
if Not prs.eof  then
%>

<table border="0" cellspacing="2" width = "550" align = "center" >
<tr>
<td>
        <table>
			
			<tr>
				<td valign = "top" align = "left">	
				<form>
	<%
		'end if

		While  Not prs.eof  
		counter = counter +1
			pPhotoID(rowcount) = prs("PhotoID")
			'ID(rowcount) = prs("ID")
			ImageName(rowcount) = prs("Image")
			image = "uploads/DetailPage/" & ImageName(rowcount)
	 
			Name = rs("FullName")
			str1 = Name
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				Name= Replace(str1, "'", "9")
			End If

			
		%>

		
		<%
			rowcount = rowcount + 1
			prs.movenext
		Wend
		TotalCount=rowcount 
			prs.close
		set prs=nothing
		'set conn = nothing
		%>
				</form>
				</td>
			</tr>
		</table>
	</td>
	</tr>
	</table>
<% end if%>

	

			
<%
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath("../db/AlpacaDB.mdb") & ";" & _
						"User Id=;Password=;" '& _ 
 fsql = "select * from Fiber where ID =" & ID 


    Set frs = Server.CreateObject("ADODB.Recordset")
    frs.Open fsql, conn, 3, 3   
	rowcount = 1
	
	Recordcount = frs.RecordCount
if  Not frs.eof  then
if len(frs("Average")) >1 or  len(frs("StandardDev")) >1 or  len(frs("COV")) > 1 then %>
<table border="0" cellspacing="2" width = "550" align = "center" >
		<tr>
				<td align="center" colspan = "5"><big><b> Fiber History</b></big><br><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "560" height = "2"></td>
		</tr>
	
		<tr>
			<td  valign="top"  class = "Details" align = "center"width = "80">
   					Sample Age
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Average Fiber Diameter
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Standard Deviation
			</td>
			<td  valign="top"  class = "Details" align = "center">
					Coefficient Of Variation
			</td>
			<td  valign="top"  class = "Details" align = "center">
					% Fiber over 30 Microns
			</td>
			</td>
		</tr>
<% end if
end if
While  Not frs.eof   	
		AverageFiberDiameter 	= frs("Average")
		StandardDeviation 	= frs("StandardDev")
		CoefficientOfVariation 	= frs("COV")
		FiberGreaterThan30 	= frs("GreaterThan30")
		SampleDate = frs("SampleDate")

Recordcount = frs.RecordCount
if Not frs.eof  then
%>
	
		<tr>
			<td  valign="top"  align = "center" class = "Body">
				<%=SampleDate%></td>
			<td  valign="top"  align = "center" class = "Body">
				<%=AverageFiberDiameter%></td>
			<td  valign="top" align = "center"  class = "Body">
				<%=StandardDeviation%></td>
			<td  valign="top" align = "center"  class = "Body">
				<%=CoefficientOfVariation%>
			</td>
			<td  valign="top" align = "center"  class = "Body">
				<%=FiberGreaterThan30%>
			</td>
			</td>
			<td valign="top">
			</td>
		</tr>		


<%
			rowcount = rowcount + 1
			frs.movenext
			end if
		Wend
		TotalCount=rowcount 
			frs.close
		set frs=nothing
		%>
<br><br>

<table border="0" cellspacing="2" width = "550" align = "center" >
				<tr>
				<td align="center" colspan = "4"><br><big><b> Ancestry</b></big><br><img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "560" height = "2"></td>
		</tr>
				<tr>
					<td colspan = "2" align= "center" ><b> Sire</b></td>
					<td colspan = "2" align= "center" ><b> Dam</b></td>
					
				</tr>
				<tr>
    					
					<td   class = "Details"  valign = "top" >
						Name: <br>
						Color:<br>
					</td>
                    			<td width="290"  class = "Body" valign = "top">
						<%
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

			if not rsSire.eof then %>
				<%counter = counter +1
				SireName 	= trim(rsSire("FullName"))
				SireID 	= rsSire("ID")%>
				<form action="HerdsireDetails.asp" method="post" height = "1" > 
				
				<img src= "images/px.gif"> &nbsp; <label for="inputdata<%=counter%>" > 
					<font  color = '#BF3333' 
						onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' ">
						<%=SireName%></font><br> &nbsp; &nbsp;  <%=SireColor%>
					

			 		<input name="Detail" type=image src= "images/px.gif" id="inputdata<%=counter%>">
					<input name=ID type=hidden value="<%=SireID%>" height = "0"> </label>
				</form>

		<%
			else if len(SireName) > 1 then%>
					<% if SireLink = "NoLink.asp" then%>
						<img src= "images/px.gif"> 
								<%=SireName%><br><img src= "images/px.gif"> <%=SireColor%>
						
					<%else%>
						<img src= "images/px.gif" align = "center"> 
								<a class = "slink" target = "_blank" href =<%=SireLink%> ><%=SireName%></a><br><img src= "images/px.gif"> <%=SireColor%>
						
					<%end if%>
					<%
		   end if
		end if
		rsSire.close
		set rsSire=nothing
		%>
						
					</td>
					<td width="40"  class = "Details" valign = "top">
 						Name:<br>
						Color:
					</td>
                    			<td width="290"  class = "Body" valign = "top">
						<%
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

			if not rsDam.eof then %>
						
				<%counter = counter +1
				DamName 	= trim(rsDam("FullName"))
				DamID 	= rsDam("ID")%>
				<form action="FemaleDetails.asp" method="post" height = "1" > 
				
				<img src= "images/px.gif"><label for="inputdata<%=counter%>" > 
						 <input name="FemaleDetails" type=image src= "images/px.gif" id="inputdata<%=counter%>">	
						 <font  color = "#BF3333"
						 onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' "><%=DamName%></font>
						<br> &nbsp; &nbsp;  &nbsp;<%=DamColor%>
						<input name=ID type="hidden" value="<%=DamID%>" height = "0"> </label>
				</form>
		<%
			else if len(DamName) > 1 then%>
					<% if DamLink = "NoLink.asp" then%>
						<img src= "images/px.gif"><%=DamName%><br><img src= "images/px.gif">  <%=DamColor%>
					<%else%>
						<img src= "images/px.gif" align = "center"> 
								<a class = "slink" target = "_blank" href =<%=DamLink%>><%=DamName%></a><br><img src= "images/px.gif"> <%=DamColor%>
					<%end if%>
		<%
		  end if
		end if
		rsDam.close
		set rsDam=nothing
		%>
					<td>
                		</tr>	
</table>
	
<table border="0" cellspacing="2" width = "550" align = "center" >
				<tr>
					<td colspan = "2" align= "center"> <br><b>Paternal Grandsire</b></td>
					<td colspan = "2" align= "center" ><br><b>Maternal Grandsire</b></td>
				</tr>	
</table>

<table border="0" cellspacing="2" width = "550" align = "center"  valign = "top">
				<tr>
    					<td   class = "Details" valign = "top">
						Name: <br>
						Color:<br>
					</td>
                    			<td width="290"   class = "Body" valign = "top">
						<%
if SireSireName <> "" then
			DBSireSireName = SireSireName
			str1 = SireSireName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBSireSireName= Replace(str1, "'", "''")
				DBSireSireName = trim(DBSireSireName)
			End If
			Set rsSireSire = Server.CreateObject("ADODB.Recordset")
			sqlSireSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBSireSireName & "'"
			rsSireSire.Open sqlSireSire, conn, 3, 3 

			if not rsSireSire.eof then %>
				<%counter = counter +1
				SireSireName 	= trim(rsSireSire("FullName"))
				SireSireID 	= rsSireSire("ID")%>
				<form action="HerdsireDetails.asp" method="post" height = "1" > 
								
				<img src= "images/px.gif"> &nbsp; <label for="inputdata<%=counter%>" > 
					<font  color = '#BF3333' 
						onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' ">
						<%=SireSireName%></font><br><img src= "images/px.gif">  <%=SireSireColor%>
					

			 		<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
					<input name=ID type=hidden value="<%=SireSireID%>" height = "0"> </label>
				
				</form>

		<%
			else if len(SireSireName) > 1 then%>
					<% if SireSireLink = "NoLink.asp" then%>
								<img src= "images/px.gif"> 
								<%=SireSireName%><br><img src= "images/px.gif">  <%=SireSireColor%>
					<%else%>
							<img src= "images/px.gif"> 
								<a class = "slink" target = "_blank" href =<%=SireSireLink%> ><%=SireSireName%></a><br><img src= "images/px.gif">  <%=SireSireColor%>
					<%end if%>
			<%
		  end if
		end if
		rsSireSire.close
		set rsSireSire=nothing
		
end if%>
						
						
					</td>
					<td   class = "Details">
 						Name:<br>
						Color:<br>
					</td>
                    			<td width="290"   class = "Body" valign = "top" >
						<%
			if DamSireName <> "" then
			DBDamSireName = DamSireName
			str1 = DamSireName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBDamSireName= Replace(str1, "'", "''")
				DBDamSireName = trim(DBDamSireName)
			End If
			Set rsDamSire = Server.CreateObject("ADODB.Recordset")
			sqlDamSire = "select ID, FullName from Animals where trim(FullName) = '"  & DBDamSireName & "'"
			rsDamSire.Open sqlDamSire, conn, 3, 3 

			if not rsDamSire.eof then %>
				<% counter = counter +1
				DamSireName 	= trim(rsDamSire("FullName"))
				DamSireID 	= rsDamSire("ID")%>
				<form action="FemaleDetails.asp" method="post" height = "1" > 
				
				<img src= "images/px.gif"> &nbsp; <label for="inputdata<%=counter%>" > 
					<font  color = '#BF3333' 
						onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' ">
						<%=DamSireName%></font><br><img src= "images/px.gif">  <%=DamSireColor%>
					

			 		<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
					<input name=ID type=hidden value="<%=DamSireID%>" height = "0"> </label>
					</form>
		<%
			else if len(DamSireName) > 1 then%>
					<% if DamSireLink = "NoLink.asp" then%>
						<img src= "images/px.gif"> 
								<%=DamSireName%><br><img src= "images/px.gif">  <%=DamSireColor%>
						
					<%else%>
						<img src= "images/px.gif"> 
								<a class = "slink" target = "_blank" href =<%=DamSireLink%> ><%=DamSireName%></a><br><img src= "images/px.gif">  <%=DamSireColor%>
						<%end if%>
					<%
					 end if
					end if
					rsDamSire.close
					set rsDamSire=nothing
		
					end if%>
						
					<td>
					
                		</tr>	
</table>
					
<table border="0" cellspacing="2" width = "550" align = "center" >
				<tr>
					<td colspan = "2" align= "center" ><br><b>Paternal Granddam's</b></td>
					<td colspan = "2" align= "center" ><br><b>Maternal  Granddam</b></td>
				</tr>	
</table>
<table border="0" cellspacing="2" width = "550" align = "center" >
				<tr>
    					
					<td    class = "Details" valign = "top">
						Name: <br>
						Color:<br>
					</td>
                    			<td width="290"   class = "Body" valign = "top">
						<%
			DBSireDamName = SireDamName
			str1 = SireDamName
			str2 = "'"
			If InStr(str1,str2) > 0 Then
				DBSireDamName= Replace(str1, "'", "''")
				DBSireDamName = trim(DBSireDamName)
			End If
			Set rsSireDam = Server.CreateObject("ADODB.Recordset")
			sqlSireDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBSireDamName & "'"
			rsSireDam.Open sqlSireDam, conn, 3, 3 

			if not rsSireDam.eof then %>
				<% counter = counter +1
				SireDamName 	= trim(rsSireDam("FullName"))
				SireDamID 	= rsSireDam("ID")%>
				<form action="HerdsireDetails.asp" method="post" height = "1" > 
				
				<img src= "images/px.gif"> &nbsp; <label for="inputdata<%=counter%>" > 
					<font  color = '#BF3333' 
						onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' ">
						<%=SireDamName%></font><br> &nbsp; <%=SireDamColor%>
					

			 		<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
					<input name=ID type=hidden value="<%=SireDamID%>" height = "0"> </label>
			</form>
		<%
			else if len(SireDamName) > 1 then%>
					<% if SireDamLink = "NoLink.asp" then%>
						<img src= "images/px.gif"> 
								<%=SireDamName%><br> &nbsp; <%=SireDamColor%>
					<%else%>
						<img src= "images/px.gif"> 
								<a class = "slink" target = "_blank" href =<%=SireDamLink%> ><%=SireDamName%></a><br> &nbsp; <%=SireDamColor%>
					<%end if%>
			<%
			end if
		end if
		rsSireDam.close
		set rsSireDam=nothing
		%>
						
						
					</td>
					<td width="40"   class = "Details" valign = "top">
 						Name:<br>
						Color:<br>
					</td>
                    			<td width="290"   class = "Body" valign = "top">
						<%
						DBDamDamName = DamDamName
						str1 = DamDamName
						str2 = "'"
						If InStr(str1,str2) > 0 Then
							DBDamDamName= Replace(str1, "'", "''")
							DBDamDamName = trim(DBDamDamName)
						End If
						Set rsDamDam = Server.CreateObject("ADODB.Recordset")
						sqlDamDam = "select ID, FullName from Animals where trim(FullName) = '"  & DBDamDamName & "'"
						rsDamDam.Open sqlDamDam, conn, 3, 3 

						if not rsDamDam.eof then %>
						<% counter = counter +1
						DamDamName 	= trim(rsDamDam("FullName"))
						DamDamID 	= rsDamDam("ID")%>
						<form action="FemaleDetails.asp" method="post" height = "1" > 
						<img src= "images/px.gif"><label for="inputdata<%=counter%>" > 
						<font  color = '#BF3333' 
						onMouseOver="this.style.color = 'black' " 
						onMouseOut="this.style.color = '#BF3333' "> <%=DamDamName%></font><br> &nbsp; <%=DamDamColor%>
						

			 			<input name=Detail type=image src= "images/px.gif" id="inputdata<%=counter%>">
						<input name=ID type=hidden value="<%=DamDamID%>" height = "0"> </label>
						</form>
		
		<%
			else if len(DamDamName) > 1 then%>
				
					<% if DamDamLink = "NoLink.asp" then%>
						<img src= "images/px.gif"> 
								&nbsp;<%=DamDamName%><br> &nbsp; <%=DamDamColor%>
						
					<%else%>
						<img src= "images/px.gif"> 
								<a class = "slink" target = "_blank" href =<%=DamDamLink%> ><%=DamDamName%></a><br> &nbsp; <%=DamDamColor%>
					<%end if%>
			<%
		   end if
		end if
		rsDamDam.close
		set rsDamDam=nothing
		%>
						
						
					<td>
                		</tr>	
</table>




					

<br>

<br>
           <center><font class = "body"> Renate &amp; Richard Gyuro<br>
          Alpacas at Lone Ranch<br>
          13856 Weowna Way,  Sams Valley, Oregon 97503<br>
		Tel & Fax: 541-826-7411 &nbsp; Phone: (541)826-7411<br>Toll Free: 866-231-3881<br>
		  </font><a href="mailto:richard@alpacasontheweb.com" class = "body">
          richard@alpacasontheweb.com</a></font><br>
          </center>

<%
	end if	
%>
</td>
    </tr>
  </table>
  </td>
    </tr>
<tr>
		<td align= "center" valign = "top" colspan = "3">
					<img src = "images/Line.jpg" alt="Alpacas at Lone Ranch Line" width = "680">	<br>

	<a href="Specials.asp"><font size="1" face="Arial">
	<b>Weekly Specials</b></font></a> | 
		<a href="Packages.asp">
	<font size="1" face="Arial"><b>Package Deals</b></font></a> | 
    <a href="Males.asp">
	<font size="1" face="Arial"><b>Male Alpacas for Sale</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Females.asp">
	<font size="1" face="Arial"><b>Female Alpacas for Sale</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Yearlings.asp">
	<font size="1" face="Arial"><b>Yearlings & Crias for Sale</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Herdsires.asp">
	<font size="1" face="Arial"><b>Stud Services</b></font></a><b><font size="1" face="Arial"></font></b><b><font size="1" face="Arial"> | </font></b><a href="SiteMap.asp"><font size="1" face="Arial"><b>Site Map</b></font></a><b><font size="1" face="Arial"></font></b>
	

	<br>
	<a href="FiberAnimals.asp"><font size="1" face="Arial"><b>Fiber Males</b></font></a><b><font size="1" face="Arial"> 
	| </font></b>
					<a href="Blacks.asp">
	<font size="1" face="Arial"><b>Black Alpacas</b></font></a> | <b><font size="1" face="Arial"> 
	
	</font></b><a href="Greys.asp">
	<font size="1" face="Arial"><b>Grey Alpacas</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Browns.asp">
	<font size="1" face="Arial"><b>Brown Alpacas</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Fawns.asp">
	<font size="1" face="Arial"><b>Fawn Alpacas</b></font></a><b><font size="1" face="Arial"> 
	| </font></b><a href="Whites.asp">
	<font size="1" face="Arial"><b>White Alpacas</b></font></a><b><font size="1" face="Arial"> 
	| </font></b>
         <a href="D_Dream.htm"><font size="1" face="Arial"><b>The Dream</b></font></a><b><font size="1" face="Arial"> 
	| </font></b>
          <a href="R_Ranch.htm"><font size="1" face="Arial">
	<b>The Ranch</b></font></a><b><font size="1" face="Arial"> | </font></b><font size="1" face="Arial">
	<b>
	<a href="di_Distinction.htm">The Distinction</a></b></font><br>
	
</div>
</center>
            
      </td>
    </tr>
  </table>

  <table width = "750">
	<tr>
		<td>
<font class = "copyright">© Copyright 2004-<%=Year(now)%> <a href="index.htm">Alpacas at Lone Ranch</a>, all rights reserved.</font>
		</td>
	</tr>
</table>
	
<!--Alpacas at Lone Ranch, Oregon, offers exquisite Alpacas for sale, trade, and breeding including highly desired maroon, black and grey alpacas and herdires.  The best website for Alpaca information and resources!">
<META name="keywords" content="alpacas, alpaca, ALPACAS, ALPACAS, Alpacas for sale, Peruvian Alpacas, Accoyo Alpacas, male alpacas, female alpacas, black, black alpacas, grey, grey alpacas, gray, gray alpacas, maroon, maroon alpacas, crias, color, ranch, alpaca ranching, ranching, farm, llama, llamas, Alpacas at Lone Ranch, Gold Beach, Oregon, breeding, sales, trading, stud service, family business, black herdsires, grey herdsires, maroon herdsires, breeder, investment -->
</body>
</html>

<%Function FormatPrice(price)
     pricelen=len(price)
     if pricelen>3 then
        price=left(price, pricelen-3) &  "," &  right(price, 3)
     end if
     FormatPrice=price   
End Function%>