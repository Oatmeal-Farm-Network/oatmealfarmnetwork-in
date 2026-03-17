<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
<link rel="stylesheet" href="https://www.HarvestHub.world/members/Membersstyle.css">
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
 <link href="https://www.globallivestocksolutions.com/dist/css/bootstrap.min.css" rel="stylesheet">
<% PageLayoutID=request.querystring("PageLayoutID")
   textblocknum=request.querystring("textblocknum")
  x =textblocknum

sql = "select * from Pagelayout2 where PagelayoutID = " & PagelayoutID & " and BlockNum=" & textblocknum	
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3
i = 0
if not rs.eof then
	TempPageText= rs("PageText")
	 tempImage= rs("Image")
	tempImageCaption= rs("ImageCaption")
	tempPageLayout2ID=rs("PageLayout2ID")
	TempImageOrientation=rs("ImageOrientation")
	if tempImageCaption = "0" then
	   tempImageCaption = ""
	end if
end if

TempTB = "TB" & x
TempTextBlock = "TextBlock" & x
ReturnPage="AdminPageData.asp?PageLayoutID=" & PageLayoutID & "#Textblock" & x

 %>

<div class ="container-flex" >
<a name="<%=TempTextBlock %>"></a>
  <div class="row" >
      <div class="col-md-7 col-sm-12 order-sm-1 roundedtopandbottomgrey" style="min-height: 650px;">

			<% 'response.Write("ServicesAvailable=" & ServicesAvailable )
			  showPandS=False
  
			 if (EcommerceAvailable = True or ServicesAvailable = True) and  showPandS = True then   
			 %> 
				
      				<H1><div align = "left">
      				<% if EcommerceAvailable = True then %>
      				Products
      				<% end if %>
      				<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      				& 
      				<% end if %>
      				<% if ServicesAvailable = True then %>
      				Services
      				<% end if %>
      				</H1>
		

			Select the <% if EcommerceAvailable = True then %>
      				products
      				<% end if %>
      				<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      				& 
      				<% end if %>
      				<% if ServicesAvailable = True then %>
      				services
      				<% end if %> that you want to appear at the bottom of this block of text:

			<% 
			numservices = 0
			Set rsn = Server.CreateObject("ADODB.Recordset")
			sqln = "select * from ProdServiceReferenceTable, services  where services.PageLayoutID = " & PageLayoutID  & " and ProdServiceIDType = 'Service' and ProdServiceReferenceTable.ProdServiceID = Services.servicesID and textblock = " & textblocknum & " order by ProdServiceReferenceID DESC " 
			'response.Write("sqln=" & sqln)
			rsn.Open sqln, conn, 3, 3 
			if Not rsn.eof then 
			  numservices = rsn.recordcount
			end if
			rsn.close

			numproducts = 0
			Set rsn = Server.CreateObject("ADODB.Recordset")
			sqln = "select * from ProdServiceReferenceTable, sfProducts  where PageLayoutID = " & PageLayoutID  & " and ProdServiceIDType = 'Product' and ProdServiceReferenceTable.ProdServiceID = cint(sfProducts.ProdID) and textblock = " & textblocknum & " order by ProdServiceReferenceID DESC "  
			'response.Write("sqln=" & sqln)
			rsn.Open sqln, conn, 3, 3 
			if Not rsn.eof then 
			  numproducts = rsn.recordcount
			 ' response.Write("numproducts=" & numproducts )
			end if
			rsn.close


			 %>
 
			 <% if ServicesAvailable = True then %>
			<iframe src="AdminPageEditServicesInclude.asp?PageLayoutID=<%=PageLayoutID %>&textblock=<%=textblocknum %>" height = '<%=(numservices *40) + 65 %>' width = '300' frameborder= '0' seamless = Yes scrolling = no></iframe>
			<% end if %>


			<% if EcommerceAvailable = True then %>
			<iframe src="AdminPageEditProductsInclude.asp?PageLayoutID=<%=PageLayoutID %>&textblock=<%=textblocknum %>&numproducts=<%=numproducts %>" height = '<%=(numproducts *40) + 65 %>' width = '300' frameborder= '0' seamless = Yes scrolling = no></iframe>
			<% end if %>
			<% end if %>


		<H1>Text</H1>

			<form target="_top" action= 'AdminPageDataHandleForm.asp' method = "post">
			<input type = "hidden" name="ReturnTextBlock" value= "<%=textblocknum%>" >
			<input name="returnpage" type="hidden" value="<%=returnpage%>">
			<input name="ReturnTextBlock"  size = "70" value = "<%=TempTextBlock %>" type = "hidden">
			<input name="TextBlock"  size = "60" value = "<%=TempTB %>" type = "hidden">
			<input name="PageName"  size = "60" value = "<%=PageName %>" type = "hidden">
			<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
			<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >

		
		
		<script language="javascript1.2" type="text/javascript">
            // attach the editor to the textarea with the identifier 'textarea1'.

            WYSIWYG.attach("Text<%=TextBlockNum %>", mysettings);
            mysettings.Width = "470px"
            mysettings.Height = "460px"
        </script>

		<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="60" rows="16" wrap="file"><%= TempPageText%></textarea>
			<center><input type=submit value = "Submit"  size = "110" Class = "regsubmit2" ></center>
		</form>


    </div>
	<div class="col-md-5 col-sm-12 order-sm-2 roundedtopandbottomgrey" style="min-height: 650px" >
		<H2>Image</H2>
					<% If Len(tempImage) > 2 Then %>
							<img src = "<%=tempImage%>" height = "100">
					<% Else %>
							<b>No Image</b><br /><br />
					<% End If %>
				<% If Len(tempImage) > 2 Then %>
							<form target="_top" action= 'AdminPageDataRemoveImage.asp' method = "post">
							<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
							<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
									<input type = "hidden" name="PageName" value= "<%=Pagename %>" >
								<input type=submit value="Remove" class = "regsubmit2 body">
							</form><br />
						<% end if %>
				<form name="frmSend" method="POST" target="_top" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp?pagelayoutid=<%=pagelayoutid %>&ServicesID=<%=ServicesID %>&ImageNum=<%=textblocknum %>&tempPageLayout2ID=<%=tempPageLayout2ID%>&returnpage=<%=returnpage %>" >
						<b>Upload Photo</b> <br>
						<input name="attach" type="file" size=35 style="min-width: 390px; min-height:38px" class = "formbox">
						<input  type=submit value="Upload" class = "regsubmit2">
					</form>
		 
		<br />
					<form method="POST" target="_top" action="AdminPageDataImageOrientation.asp" >
						<b>Orientation</b><br />
							<% If tempImageCaption= "0" Then
								tempImageCaption = ""
							End If %>
							<select size="1" name="Orientation" style="min-width: 390px; min-height:38px" class = "formbox">>
								<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
								<option value="Left">Left</option>
								<option  value="Right">Right</option>
							</select>
								<input type=submit value = "Submit"  size = "110" Class = "regsubmit2" >
								<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
								<input type = "hidden" name="PageName" value= "<%=PageName %>" >
								<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum %>" >
								</form>
							<form target="_top" action= 'AdminPageAddCaption.asp' method = "post">
								<b>Caption</b><br>
								<input name="Caption" Value ="<%=tempImageCaption%>" style="min-width: 390px; min-height:38px" class = "formbox">
								<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
								<input type = "hidden" name="PageName" value= "<%=PageName %>" >
								<input type = "hidden" name="CaptionID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PagelayoutID" value= "<%= PagelayoutID %>" >
								<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PagelayoutID=<%= PagelayoutID %>#textblock<%=textblocknum %>" >
								<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type=submit value="Submit" class = "regsubmit2">
								(20 Character Max.)
							</form>
					  
      </div>
  </div>
</div>
<script src="https://www.globallivestocksolutions.com/dist/js/bootstrap.bundle.min.js"></script>