<% 	prodID= Request.QueryString("prodID") 
	

dim buttonimages(20)
dim buttontitle(20)

	if len(prodID) > 0 then
	else
	response.Redirect("default.asp")
	end if
	Set rsA = Server.CreateObject("ADODB.Recordset")
	sql = "select * from sfProducts, ProductsPhotos where ProductsPhotos.id = sfproducts.prodid and prodID=" & prodID & ""
	'response.write(sql)
	rsA.Open sql, conn, 3, 3 
	if not rsA.eof then
	Description = rsA("prodDescription")
prodName = rsA("ProdName")
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
	
str1 = lcase(buttonimages(pcounter))
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
buttonimages(pcounter) =  Replace(str1, str2 , "http://www.livestockofamerica.com")
End If  
	newimage = buttonimages(pcounter)
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
<% else 
response.redirect("Default.asp")
 end if %>
<% end if %>