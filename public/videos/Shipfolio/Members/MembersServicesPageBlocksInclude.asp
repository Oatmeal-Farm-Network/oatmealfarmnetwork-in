<% 
if TempImageOrientation = "Left" or mobiledevice = True or  screenwidth < 769 then %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td  align = "center" width = "100%" valign = "top"> 
<a name="<%=TempTextBlock %>"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width="<%=screenwidth -35 %>" align = "center" >
   <tr>
 <% 

 
if hideimage = "True" then
else
 %> 


    <td valign = "top"  >


      
<% if mobiledevice = False  then %> 
<% if  screenwidth > 768 then %> 
     <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
       <tr><td class = "roundedtop" align = "left">
       
		<H1><div align = "left">Image</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100">
     <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "left" >
   <tr><td class = "roundedtop" align = "left" width="<%=screenwidth -72 %>" >
       
		<H1><div align = "left">Image</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100">
     <% end if %>

     <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
       <tr><td  align = "left">
    <tr><td  align = "left">
    
		<H1><div align = "left">Image</div></H1>
</td></tr>
<tr><td  align = "center" width = "100">
     <% end if  %>


			<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "150">
			<tr>
				<td width = "100" align = "center">
					<% If Len(tempImage) > 2 Then %>
							<img src = "<%=tempImage%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			<tr>
				<td class = "body" valign = "top">
					<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
					   <tr>
					     <td class = "body2" align = "center">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp?pagelayoutid=<%=pagelayoutid %>&ServicesID=<%=ServicesID %>&ImageNum=<%=textblocknum %>&tempPageLayout2ID=<%=tempPageLayout2ID%>&returnpage=<%=returnpage %>" >
								Upload Photo: <br>
								
								
								<input name="attach" type="file" size=35 class = "regsubmit2"  <%=Disablebutton %>>
								<input  type=submit value="Upload" class = "regsubmit2"  <%=Disablebutton %>>
							</form>
						<td>
						</tr>
<% if mobiledevice = False  then %> 
						<tr>
							<td>
								<form method="POST" action="MembersServicesImageOrientation.asp" >
								<b>Orientation</b>
								   <% If tempImageCaption= "0" Then
											tempImageCaption = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
										 
						<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
						<input type = "hidden" name="PageName" value= "<%=PageName %>" >
						<input name="returnpage" type="hidden" value="<%=returnpage%>">
						<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum %>" >
	<center><input type=submit value = "Submit"  size = "110" Class = "regsubmit2"  <%=Disablebutton %> ></center>
								</form>
							</td>
						</tr>
							<tr>
						   <td class = "body" >
							<form action= 'AdminPageAddCaption.asp' method = "post">
								<b>Caption</b> (20 Character Max.): <input name="Caption" Value ="<%=tempImageCaption%>"  size = "40" maxlength = "80"><br>
								<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
								<input type = "hidden" name="PageName" value= "<%=PageName %>" >
								<input type = "hidden" name="CaptionID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PagelayoutID" value= "<%= PagelayoutID %>" >
								<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PagelayoutID=<%= PagelayoutID %>#TextBlock<%=textblocknum %>" >
								<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<center><input type=submit value="Submit" class = "regsubmit2" <%=Disablebutton %>></center>
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body2" align = "center">
					   <% If Len(tempImage) > 2 Then %>
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
							<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
							<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
									<input type = "hidden" name="PageName" value= "<%=Pagename %>" >
								<input type=submit value="Remove This Image" class = "regsubmit2"  <%=Disablebutton %>>
							</form>
							<% end if %>
					</td>
				</tr><% end if %>
				 </table>
	   <td>
	 </tr>
</table>




 <% 'response.Write("ServicesAvailable=" & ServicesAvailable )
  showPandS=False
  
 if (EcommerceAvailable = True or ServicesAvailable = True) and  showPandS = True then   
  
   if mobiledevice = False  then %> 
     <table border = "0" cellspacing="0" cellpadding = "0" align = "left"  width = "100%">
      <tr><td class = "roundedtop" align = "left">
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
      	 </div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" width = "150">
     <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
   <tr><td  align = "left">
   	<H1><div align = "left">
   	<% if EcommerceAvailable = True then %>
      	Products
      	<% end if %>
      	<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      	& 
      	<% end if %>
      	<% if ServicesAvailable = True then %>
      	Services
      	<% end if %></div></H1>
</td></tr>
<tr><td  align = "center" width = "150">
     <% end if  %>
<div class = "body">Select the <% if EcommerceAvailable = True then %>
      	products
      	<% end if %>
      	<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      	& 
      	<% end if %>
      	<% if ServicesAvailable = True then %>
      	services
      	<% end if %> that you want to appear at the bottom of this block of text:</div>

<% 
numservices = 0
Set rsn = Server.CreateObject("ADODB.Recordset")
sqln = "select * from ProdServiceReferenceTable, services  where services.PageLayoutID = " & PageLayoutID  & " and ProdServiceIDType = 'Service' and ProdServiceReferenceTable.ProdServiceID = Services.servicesID and BlockNum = " & textblocknum & " order by ProdServiceReferenceID DESC " 
'response.Write("sqln=" & sqln)
rsn.Open sqln, conn, 3, 3 
if Not rsn.eof then 
  numservices = rsn.recordcount
end if
rsn.close

numproducts = 0
Set rsn = Server.CreateObject("ADODB.Recordset")
sqln = "select * from ProdServiceReferenceTable, sfProducts  where PageLayoutID = " & PageLayoutID  & " and ProdServiceIDType = 'Product' and ProdServiceReferenceTable.ProdServiceID = cint(sfProducts.ProdID) and BlockNum  = " & textblocknum & " order by ProdServiceReferenceID DESC "  
'response.Write("sqln=" & sqln)
rsn.Open sqln, conn, 3, 3 
if Not rsn.eof then 
  numproducts = rsn.recordcount
 ' response.Write("numproducts=" & numproducts )
end if
rsn.close


 %>
 
 <% if ServicesAvailable = True then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "body"><iframe src="MembersServicePageEditServicesInclude.asp?PageLayoutID=<%=PageLayoutID %>&TextBlock=<%=textblocknum %>" height = '<%=(numservices *40) + 65 %>' width = '300' frameborder= '0' seamless = Yes scrolling = no></iframe></td></tr></table>
<% end if %>



<% end if %>
</td>
	 </tr>
</table>


  </td>

 <% end if  ' Hide Text%>

  <% if mobiledevice = False and screenwidth > 768 then %> 
  <td >&nbsp;</td>
  <% else %>
  </tr><tr>
  <% end if  %>
      <td valign = "top">
       <% if mobiledevice = False  then %> 
   <% if  screenwidth > 768  then %> 
<% if hideimage = "True" then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" valign = "top" width = "100%">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" valign = "top" width = "600">
<% end if %>
<tr><td class = "roundedtop" align = "left" valign = 'top'>
    <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "left" valign = "top" width = "<%=screenwidth - 50 %>">
<tr><td class = "roundedtop" align = "left" valign = 'top'>
    
    <% end if %>
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" valign = "top" width = "100%">
<tr><td align = "left" valign = 'top'>
<% end if %>


		<H1><div align = "left">Text</div></H1>
</td></tr>
 <% if mobiledevice = False  then %> 
<tr><td class = "roundedBottom" align = "center" width = "100%" valign = 'top'>
<% else %>
 <tr><td align = "center" width = "100%" valign = 'top'>
<% end if %>
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%">
	<form action= 'AdminPageDataHandleForm.asp' method = "post">
	<input name="returnpage" type="hidden" value="<%=returnpage%>">
	<input name="ReturnTextBlock"  size = "70" value = "<%=TempTextBlock %>" type = "hidden">
	<input name="TextBlock"  size = "60" value = "<%=TempTB %>" type = "hidden">
	<input name="PageName"  size = "60" value = "<%=PageName %>" type = "hidden">
     
     <input name="textblocknum"   value = "<%=textblocknum %>" type = "hidden">

	<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
	<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
		<tr>
			<td  colspan = "2" class = "body" valign = "top">
            <b>Change Text Block Order To:</b> <select size="1" name="TextBlockOrder">
	<option value="<%=textblocknum %>" selected><%=textblocknum %></option>
	<% ordercounter = 1
	 while ordercounter < (TotalTextBlocks + 1 ) 
     if ordercounter = textblocknum then
     else
      %>									
	   		<option  value="<%=ordercounter%>"><%=ordercounter%></option>
		<% 
	end if
ordercounter = ordercounter + 1
        wend %>
    </select><br />

          Heading: <TEXTAREA name="PageHeading" cols="50" rows="2" wrap="file"><%=tempPageHeading %></textarea>
	<% if mobiledevice = False  then %> 			
		
    <script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.

WYSIWYG.attach("Text<%=TextBlockNum %>", mysettings);
mysettings.Width = "470px"
mysettings.Height = "460px"
 </script>
 <% end if %>
<% if mobiledevice = False  then %> 
<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="60" rows="16" wrap="file"><%= TempPageText%></textarea>
<% else %>
<% if SmallMobile = False then %>
<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="40" rows="10" wrap="file"><%= TempPageText%></textarea>
<% else %>
<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="28" rows="10" wrap="file"><%= TempPageText%></textarea>
<% end if %>
<% end if %>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<center><input type=submit value = "Submit Changes"  size = "110" Class = "regsubmit2" <%=Disablebutton %> ></center>
		</td>
		</tr>
		</table>

</form>
	  </td>
	 </tr>
</table>
 </td>
	 </tr>
</table>
  <td>
	 </tr>
</table>

 <% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width="<%=screenwidth -35 %>" >
<tr><td  align = "left" width = "100%" valign = "top"> 
<a name="TempTextBlock"></a>
<table border = "0"  cellpadding=0 cellspacing=0 width="<%=screenwidth -35 %>" align = "left" >
   <tr>
       <td valign = "top">
     <% if mobiledevice = False  then %> 
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" valign = "top" width = "600">
   <tr><td class = "roundedtop" align = "left">
       <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "left" valign = "top" width = "100%">
     <tr><td align = "left">
       <% end if %> 
     
		<H1><div align = "left">Text</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "center" width = "100%">
<table border = "0" bordercolor = "eeeeee" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  width = "100%">
		<form action= 'AdminPageDataHandleForm.asp' method = "post">
	<input name="returnpage" type="hidden" value="<%=returnpage%>">
	<input name="ReturnTextBlock"  size = "70" value = "<%=TempTextBlock %>" type = "hidden">
	<input name="TextBlock"  size = "60" value = "<%=TempTB %>" type = "hidden">
	<input name="PageName"  size = "60" value = "<%=PageName %>" type = "hidden">
     
     <input name="textblocknum"   value = "<%=textblocknum %>" type = "hidden">

	<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
	<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
		<tr>
			<td  colspan = "2" class = "body" valign = "top">
            <b>Change Text Block Order To:</b> <select size="1" name="TextBlockOrder">
	<option value="<%=textblocknum %>" selected><%=textblocknum %></option>
	<% ordercounter = 1
	 while ordercounter < (TotalTextBlocks + 1 ) 
     if ordercounter = textblocknum then
     else
      %>									
	   		<option  value="<%=ordercounter%>"><%=ordercounter%></option>
		<% 
	end if
ordercounter = ordercounter + 1
        wend %>
    </select><br />
             Heading: <TEXTAREA name="PageHeading" cols="50" rows="2" wrap="file"><%=tempPageHeading %></textarea>




				
	<% if mobiledevice = False  then %> 	
    <script language="javascript1.2" type="text/javascript">
// attach the editor to the textarea with the identifier 'textarea1'.

WYSIWYG.attach("Text<%=TextBlockNum %>", mysettings);
mysettings.Width = "470px"
mysettings.Height = "360px"
 </script>
 <% end if %>
 <% if mobiledevice = False  then %> 
<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="60" rows="16" wrap="file"><%= TempPageText%></textarea><br />
<font class = "body"><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</font>
<% else %>
<TEXTAREA NAME="Text" ID="Text<%=TextBlockNum %>" cols="40" rows="10" wrap="file"><%= TempPageText%></textarea>
<% end if %>
			</td>
		</tr>
		<tr>
		<td  valign = "middle" colspan = "2" align = "center">
			<center><input type=submit value = "Submit Changes"  size = "110" Class = "regsubmit2"  <%=Disablebutton %> ></center>
		</td>
		</tr>
		</table>

</form>
   <td>
	 </tr>
</table>
	  </td>  
	  <% if mobiledevice = False  then %> 

	    <% else %>
	    </tr><tr>   
	    <% end if  %>
	  <td valign = "top" width = "340" >
      <% if mobiledevice = False  then %> 
     <table border = "0" cellspacing="0" cellpadding = "0" align = "left"  width = "340">
      <tr><td class = "roundedtop" align = "left">
      	<H1><div align = "left">Image</div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" width = "150">
     <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
   <tr><td  align = "left">
   	<H1><div align = "left">Image</div></H1>
</td></tr>
<tr><td  align = "center" width = "150">
     <% end if  %>
 
	
			<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "150">
			<tr>
				<td width = "100" align = "center">
					<% If Len(tempImage) > 2 Then %>
							<img src = "<%=tempImage%>" height = "100">
					<% Else %>
							<h2>No Image</h2>
					<% End If %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
					   <tr>
					     <td class = "body2" align = "center">
							<form name="frmSend" method="POST" enctype="multipart/form-data" action="AdminPageDataUploadPageImage.asp?PageLayoutID=<%=PageLayoutID %>&ImageNum=<%=textblocknum %>&tempPageLayout2ID=<%=tempPageLayout2ID %>&returnpage=<%=returnpage %>" >
								Upload Photo: <br>
								<input name="attach" type="file" size=35 Class = "Submit">
								<center><input  type=submit value="Upload" class = "regsubmit2" <%=Disablebutton %>></center>
							</form>
						<td>
						</tr>
				
						<tr>
							<td>
								<form method="POST" action="MembersServicesImageOrientation.asp" >
								<b>Orientation </b>
								   <% If tempImageCaption= "0" Then
											tempImageCaption = ""
										End If %>

										<select size="1" name="Orientation">
										<option value="<%=TempImageOrientation%>" selected><%=TempImageOrientation%></option>
										<option value="Left">Left</option>
										<option  value="Right">Right</option>
										</select>
								<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
									<input type = "hidden" name="OrientationImageID" value= "<%=textblocknum %>" >
<input type=submit value = "Submit"  size = "110" Class = "regsubmit2"  <%=Disablebutton %> >
								</form>
							</td>
						</tr>
								
							<tr>
						   <td class = "body" >
							<form action= 'AdminPageAddCaption.asp' method = "post">
								<b>Caption</b> (20 Character Max.): <input name="Caption" Value ="<%=tempImageCaption%>"  size = "40" maxlength = "80"><br>
								<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
								<input type = "hidden" name="PageName" value= "<%=PageName %>" >
								<input type = "hidden" name="CaptionID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PagelayoutID" value= "<%= PagelayoutID %>" >
								<input type = "hidden" name="Redirectpage" value= "AdminPageData.asp?PagelayoutID=<%= PagelayoutID %>#textblock<%=textblocknum %>" >
								<center><input type=submit value="Submit" class = "regsubmit2"  <%=Disablebutton %>></center>
								</form>
						   </td>
						 </tr>
						<tr>
					    <td class = "body2" align = "center"><% If Len(tempImage) > 2 Then %>
							<form action= 'AdminPageDataRemoveImage.asp' method = "post">
							<input type = "hidden" name="tempPageLayout2ID" value= "<%=tempPageLayout2ID %>" >
							<input name="returnpage" type="hidden" value="<%=returnpage%>">
								<input type = "hidden" name="ImageID" value= "<%=textblocknum %>" >
								<input type = "hidden" name="PageLayoutID" value= "<%=PageLayoutID %>" >
									<input type = "hidden" name="PageName" value= "<%=Pagename %>" >
								<input type=submit value="Remove This Image" class = "regsubmit2"  <%=Disablebutton %>>
							</form>
							<% end if %>
					</td>
				</tr>
				</table>
	
   <td>
	 </tr>
</table>
  </td></tr>
</table>
  <% 'response.Write("ServicesAvailable=" & ServicesAvailable )
  showPandS=False
  
 if (EcommerceAvailable = True or ServicesAvailable = True) and  showPandS = True then   
  
   if mobiledevice = False  then %> 
     <table border = "0" cellspacing="0" cellpadding = "0" align = "left"  width = "340">
      <tr><td class = "roundedtop" align = "left">
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
      	 </div></H1>
</td></tr>
<tr><td class = "roundedBottom" align = "left" width = "150">
     <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
   <tr><td  align = "left">
   	<H1><div align = "left">
   	<% if EcommerceAvailable = True then %>
      	Products
      	<% end if %>
      	<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      	& 
      	<% end if %>
      	<% if ServicesAvailable = True then %>
      	Services
      	<% end if %></div></H1>
</td></tr>
<tr><td  align = "center" width = "150">
     <% end if  %>
<div class = "body">Select the <% if EcommerceAvailable = True then %>
      	products
      	<% end if %>
      	<%  if EcommerceAvailable = True and ServicesAvailable = True then    %>
      	& 
      	<% end if %>
      	<% if ServicesAvailable = True then %>
      	services
      	<% end if %> that you want to appear at the bottom of this block of text:</div>

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
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "body"><iframe src="MembersServicePageEditServicesInclude.asp?PageLayoutID=<%=PageLayoutID %>&textblock=<%=textblocknum %>" height = '<%=(numservices *40) + 45 %>' width = '300' frameborder= '0' seamless = Yes scrolling = no></iframe></td></tr></table>
<% end if %>



<% end if %>
 </td>
	 </tr>
</table>

</td>
</tr>
</table>
 <% end if %>
<br />
<table>

				</td>
				</tr>
	 </table>
	
	 <br />
   	 	
 