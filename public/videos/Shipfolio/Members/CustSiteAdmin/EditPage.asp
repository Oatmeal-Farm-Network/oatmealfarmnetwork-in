<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ Language=VBScript %>

<HTML>
<HEAD>
 <title>Edit Your Pages</title>
       <link rel="stylesheet" type="text/css" href="/administration/style.css">
		<!'--#Include virtual="/Administration/PhotosIncludeHead.asp"--> 

</head>
<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 ><!--#Include virtual="/Administration/Header.asp"-->


		<!--#Include virtual="/administration/adminDetailDBInclude.asp"--> 
		<!--#Include virtual="/Administration/Dimensions.asp"-->
		<!--#Include virtual="/Administration/PagesHeader.asp"-->
<% 

    Dim PageName(40000)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	
	sql2 = "select * from Pagelayout where PageAvailable = True"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
	
		PageName(acounter) = rs2("PageName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing


 If Len(ID) = 0 Then %>
 <table width = "680" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr>

		
<td class = "body" valign = "top" align = "center">

<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "700">
	<tr>
		<td class = "body">
			<a name="Add"></a>
			<H1>Edit Page Content</H1>
			* Indicates pages that you will need John to update.<br>
			   Click on the links below to edit the content of each page.
		</td>
	</tr>
	<tr>
		<td align = "center">
			
			   <table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600" align = "center">
			       <tr>
				     <td class = "body" width = "50%" valign = "top"> 
						<img src = "images/Pyramids.gif" height = "25"><b>Home Page *</b><br>
						<img src = "images/Pyramids.gif" height = "25"><b>Alpacas for Sale</b><br>
						<a href = "PageMantainance.asp?PageName=Complete Sales List" class = "body">Complete Sales List</a><br> 
						<a href = "PageMantainance.asp?PageName=Female Alpacas for Sale" class = "body">Female Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=Crias" class = "body">&nbsp;This Year's Crias</a><br>
						<a href = "PageMantainance.asp?PageName=Male Alpacas for Sale" class = "body">Male Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=Non-Breeders" class = "body">Non-Breeders</a><br>
						<a href = "PageMantainance.asp?PageName=Black Alpacas for Sale" class = "body">Black Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=Grey Alpacas for Sale" class = "body">Grey Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=Brown Alpacas for Sale" class = "body">Brown Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=Fawn Alpacas for Sale" class = "body">Fawn Alpacas</a><br>
						<a href = "PageMantainance.asp?PageName=White Alpacas for Sale" class = "body">White Alpacas</a><br>
						<a href = "PageData.asp?PageName=Our Guarantee" class = "body">Our Guarentee</a><br>
						<img src = "images/Pyramids.gif" height = "25"><b>Herdsires</b><br>
						<a href = "PageMantainance.asp?PageName=Herdsires" class = "body">Herdsires</a><br>
						
						
							<img src = "images/Pyramids.gif" height = "25"><b>Special Offers</b><br>
						<a href = "PageMantainance.asp?PageName=Special Offers Home" class = "body">Special Offers Home</a><br>
						<a href = "IRSAdmin.asp" class = "body">I.R.S.<a/> <br>
						<a href = "PageMantainance.asp?PageName=My Aching Back" class = "body">My Aching Back Sale</a><br>
						<a href = "packages.asp" class = "body"> Package Deals</a><br>
						<a href = "Godfather.asp" class = "body">Godfather Sale</a><br>
						<a href = "PageData.asp?PageName=Alpacas for Trade" class = "body">Alpacas for Trade</a><br>
					  	<a href = "Auctions.asp" class = "body"> Alpaca Auctions<a/> (not Currently Active)<br>


						<img src = "images/Pyramids.gif" height = "25"><b>Alpaca Products</b><br>
						<a href = "PageMantainance.asp?PageName=Products for Sale" class = "body">Alpaca Products</a><br>
						<img src = "images/Pyramids.gif" height = "25"><b>News</b><br>
						<a href = "NewsEdit.asp" class = "body">News</a><br>
							<a href = "ILoveAlpacasAdmin.asp" class = "body">I Love Alpacas</a><br>
						</td>
				     <td class = "body" width = "50%" valign = "top"> 
						<img src = "images/Pyramids.gif" height = "25"><b>The Dream</b><br>
						<a href = "PageData.asp?PageName=About Us" class = "body">About Us</a><br>
						<a href = "PageData.asp?PageName=Our Goals" class = "body">Our Goals</a><br>
						<a href = "PageData.asp?PageName=For Love" class = "body">For Love</a><br>
						<a href = "PageData.asp?PageName=For Money" class = "body">For Money</a><br>
						<a href = "PageData.asp?PageName=Dollars and Sense" class = "body">Dollars and Sense</a><br>
						<a href = "PageData.asp?PageName=Typical Investment" class = "body">Typical Investment</a><br>
						<a href = "PageData.asp?PageName=Tax benefits" class = "body">Tax Benefits</a><br>
						<a href = "PageData.asp?PageName=Family Business" class = "body">Family Business</a><br>
						<a href = "PageData.asp?PageName=About Alpacas" class = "body">About Alpacas</a><br>
						<a href = "PageData.asp?PageName=Alpaca Fleece" class = "body">Alpaca Fleece</a><br>
						<a href = "PageData.asp?PageName=Ranch Tour" class = "body">Ranch Tour</a><br>
						<img src = "images/Pyramids.gif" height = "25"><b>The Ranch</b><br>
						<a href = "PageData.asp?PageName=Alpaca Ranching" class = "body">Alpaca Ranching</a><br>
						<a href = "PageData.asp?PageName=The Lifestyle" class = "body">The Lifestyle</a><br>
						<a href = "PageData.asp?PageName=Typical Day" class = "body">Typical Day</a><br>
						<a href = "PageData.asp?PageName=Feeding and Nutrition" class = "body">Feeding & Nutrition</a><br>
						<a href = "PageData.asp?PageName=Cleanup" class = "body">Cleanup</a><br>
						<a href = "PageData.asp?PageName=Breeding" class = "body">Breeding</a><br>
						<a href = "PageData.asp?PageName=Birthing" class = "body">Birthing</a><br>
						<a href = "PageData.asp?PageName=Shearing" class = "body">Shearing</a><br>
						<a href = "PageData.asp?PageName=Fleece" class = "body">Fleece</a><br>
						<a href = "PageData.asp?PageName=Transporting" class = "body">Transporting</a><br>
						<a href = "PageData.asp?PageName=Shows" class = "body">Shows</a><br>
						<a href = "PageData.asp?PageName=Veterinary Care" class = "body">Veterinary Care</a><br>
						<a href = "PageData.asp?PageName=Marketing and Sales" class = "body">Marketing & Sales</a><br>
						<a href = "LinkMaintenance.asp" class = "body">Links</a><br>
						<br>
						<img src = "images/Pyramids.gif" height = "25"><b>The Distinction</b><br>
						<a href = "PageData.asp?PageName=Startup Assistance" class = "body">Startup Assistance</a><br>
						<a href = "PageData.asp?PageName=Before Buying" class = "body">Before Buying</a><br>
						<a href = "PageData.asp?PageName=Ranch Setup" class = "body">Ranch Setup</a><br>
						<a href = "PageData.asp?PageName=Bloodlines" class = "body">Bloodlines</a><br>
						<a href = "PageData.asp?PageName=Sales" class = "body">Sales</a><br>

<a href = "aboutusadmin.asp" class = "body">About Us</a><br> 

	
					 </td>
					</tr>
				</table>
			</td>
		</tr>
		</table>

				
		</td>
	</tr>
</table>
	
<br><br><br>
</td>
</tr>
</table>

<% else  %>
 <!--#Include virtual="/administration/EditPagecontentInclude.asp"--> 

<% End if %>
<!--#Include virtual="/administration/Footer.asp"-->

 </Body>
</HTML>
