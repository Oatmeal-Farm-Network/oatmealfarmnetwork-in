<% 	ID= Request.QueryString("ID") 
	DetailType= Request.QueryString("DetailType") 
'response.write("DetailType=")
'response.write(DetailType)
'response.write("ID=")
'response.write(ID)


   if ID= "" Then
			Response.Redirect("Herdsires.asp")
	end if


			conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
			Set rs = Server.CreateObject("ADODB.Recordset")
			
			if DetailType = "Dam" then
			
				sql = "select FemaleData.*, Ancestors.*, Animals.*, Photos.*, Pricing.*, Fiber.*  from Fiber, FemaleData, Animals, Photos, Pricing, Ancestors where animals.ID = Photos.ID and animals.ID = Pricing.ID and animals.ID = Ancestors.ID and animals.ID = FemaleData.ID and animals.ID = Fiber.ID and Animals.ID=" & ID
				gender = "female"
				'response.write(sql)
				rs.Open sql, conn, 3, 3
				Price = rs("AValue")

				If Len(Price) < 3 Or rs("AValue") = Null Then

						Price 	= "Call for price"
				Else		
						Price = rs("AValue")
				End If
				
			
				
			end if

			if DetailType = "Sire" Then

				sql = "select * from Males where Animals.ID=" & ID
				rs.Open sql, conn, 3, 3
				'response.write(sql)
				if rs.eof then
					rs.close
					
					sql = "SELECT *  FROM Animals, Photos, Ancestors, MaleData, fiber WHERE Animals.ID=Photos.ID And Animals.ID=Ancestors.ID And Animals.ID=fiber.ID And Animals.ID=MaleData.ID  and Animals.ID=" & ID
					rs.Open sql, conn, 3, 3
					
					 if not rs.eof then
						StudFee = rs("StudFee")
						ForSale	= "false"
						Price 	= "Call for price"
					end If
						StudFee = ""
						ForSale	= "false"
						Price 	= "Call for price"
				Else
					'response.write(sql)
				    StudFee = rs("StudFee")
					ForSale	= rs("Forsale")
					Price 	= rs("AValue")
				end if
				
			end if

			if DetailType = "non-breeder"  then
				sql = "SELECT  * FROM Animals, Pricing, Photos, Ancestors, Fiber WHERE Animals.ID=Pricing.ID And Animals.ID=Photos.ID And Animals.ID=Ancestors.ID And Animals.ID=fiber.ID  and  Animals.ID=" & ID

				gender = "non-breeder"
				rs.Open sql, conn, 3, 3
			end if

			if DetailType = "Other" or DetailType = "other" then
				sql = "select Ancestors.*, Animals.*, Photos.*, Pricing.*  from Animals, Photos, Pricing, Ancestors where animals.ID = Photos.ID and animals.ID = Pricing.ID and animals.ID = Ancestors.ID and Animals.ID=" & ID
				gender = "non-breeder"
				rs.Open sql, conn, 3, 3
				Price 	= rs("AValue")
			end if
				
	
		if not rs.eof then 
			photoID = "nophoto"
			imagelength = len(rs("DetailPageImage"))
			'response.write("imagelength=")
			'response.write(imagelength)
			if  imagelength > 5 then
				photoID = rs("DetailPageImage")
			end if

           If photoID = "nophoto" then 
				click = "<img width=""285"" src=""/Uploads/DetailPage/NotAvailableD.jpg""> "
			Else
				click = "<img  width=""285"" src=""/Uploads/DetailPage/" & photoID & """>" 
			End If
		
    		name 	= trim(rs("FullName"))
			
			DOB 	= rs("DOB")
			ARI 	= rs("ARI")
			Color   = rs("Color")
			Category 	= rs("Category")
			
		
			if DetailType = "Dam" then
				DueDate	=rs("DueDate")
		
				ExternalStudID	=rs("ExternalStudID")
				ServiceSireID	=rs("ServiceSireID")
			end if

			if not(detailtype = "Other" Or detailtype = "other") then
			
				AFDFiberDiameter 	= rs("Average")
				StandardDeviation 	= rs("StandardDev")
				CoefficientOfVariation 	= rs("COV")
				FiberGreaterThan30 	= rs("GreaterThan30")
				SampleDate = rs("SampleDate")
			end if
			dim Description
			DamName 	= rs("DamName")
			DamColor 	= rs("DamColor")
			DamLink 	= rs("DamLink")
			DamARI 	= rs("DamARI")
			DamComment 	= rs("DamComment")
			DamDamName 	= rs("MaternalGranddam")
			DamDamColor 	= rs("MaternalGranddamsColor")
			DamDamLink 	= rs("MaternalGranddamsLink")
			DamDamARI 	= rs("MaternalGranddamsARI")
			DamSireName 	= rs("MaternalGrandsire")
			DamSireColor 	= rs("MaternalGrandsiresColor")
			DamSireLink 	= rs("MaternalGrandsiresLink")
			DamSireARI 	= rs("MaternalGrandsiresARI")
			SireName 	= rs("Sire")
			SireColor 	= rs("SireColor")
			SireLink 	= rs("SireLink")
			SireARI 	= rs("SireARI")
			SireComment 	= rs("SireComment")
			SireDamName 	= rs("PaternalGranddam")
			SireDamColor 	= rs("PaternalGranddamColor")
			SireDamLink 	= rs("PaternalGranddamLink")
			SireDamARI 	= rs("PaternalGranddamARI")
			SireSireName 	= rs("PaternalGrandsire")
			SireSireColor 	= rs("PaternalGrandsiresColor")
			SireSireLink 	= rs("PaternalGrandsiresLink")
			SireSireARI 	= rs("PaternalGrandsiresARI")
			Description 	= rs("Description")
	
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
			end If
	end If
        %>


		<%
dim buttonimages(20)
dim buttontitle(20)

		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
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
		buttonimages(counter) = "/Uploads/DetailPage/" & rsA("Image")
		buttontitle(counter) = rsA("ImageTitle")
		'response.write(rsA("Image"))
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













