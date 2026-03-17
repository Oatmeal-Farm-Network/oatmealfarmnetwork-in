<% 	prodID= Request.QueryString("prodID") 
	

dim buttonimages(20)
dim buttontitle(20)

		conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
	
	Set rsA = Server.CreateObject("ADODB.Recordset")
	sql = "select * from sfProducts, ProductsPhotos where ProductsPhotos.id = cint(sfproducts.prodid) and Products.prodID='" & prodID & "'"
	'response.write(sql)
	rsA.Open sql, conn, 3, 3 
	Description = rsA("prodDescription")
	str1 = Description
	str2 = vblf
	If InStr(str1,str2) > 0 Then
		Description= Replace(str1, str2 , "</br>")
	End If  

	str1 = Description
	str2 = vbtab
	If InStr(str1,str2) > 0 Then
		Description= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
	End If  


	 If Len(rsA("ProductImage1")) < 2 And Len(rsA("ProductImage2"))< 2  And Len(rsA("ProductImage3")) < 2  And Len(rsA("ProductImage4")) < 2  And Len(rsA("ProductImage5")) < 2 And Len(rsA("ProductImage6")) < 2  And Len(rsA("ProductImage7")) < 2  And Len(rsA("ProductImage8")) < 2 then 
				click = "<img width=""260"" src=""/Uploads/ImageNotAvailable.jpg""> "
				noimage = True
				  response.write("found")
				Else 
						noimage = false

		End If
	
	if not rsA.eof then 

	pcounter = 0
	counter = 0
	counttotal = 8
	foundimagecount = 0
	While counter < counttotal
		'response.write("counter=")
		'response.write(counter)

		counter = counter +1

		Photonum = "ProductImage" & counter
		Captionnum = "PhotoCaption" & counter
		image = rsA(Photonum)
	
		If Len(image)> 2 Then
		foundimagecount =foundimagecount  + 1
		pcounter = pcounter +1
		If Len(image) < 30 then
			buttonimages(pcounter) = "/Uploads/" & image
			
		Else
			buttonimages(pcounter) =  image
		End If 
		buttontitle(pcounter) = Caption
		newimage = buttonimages(pcounter)
		response.write(buttonimages(pcounter))
%>
<script language="JavaScript">
               if (document.images) version = "n3";
               else version = "n2";
               if (version == "n3") {
				but<%=pcounter%>on = new Image(85, 115);
				but<%=pcounter%>on.src = "<%=newimage %>";
			   }
	

       function img<%=pcounter%>(imgName) {
               if (version == "n3") {
               imgOn = eval("but<%=pcounter%>on.src");
               document [imgName].src = imgOn;               }       }
      
      
</script>

<% 
   End if
	wend
%>

<% end if %>