<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<HEAD>
 <title>Administration Home Page</title>
       <link rel="stylesheet" type="text/css" href="style.css">

<%
Function GetPrevMonth(iThisMonth,iThisYear)
 GetPrevMonth=month(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetPrevMonthYear(iThisMonth,iThisYear)
 GetPrevMonthYear=Year(dateserial(iThisYear,iThisMonth,1)-1)
End Function

Function GetNextMonth(iThisMonth,iThisYear)
 GetNextMonth=month(dateserial(iThisYear,iThisMonth+1,1))
End Function

Function GetNextMonthYear(iThisMonth,iThisYear)
 GetNextMonthYear=year(dateserial(iThisYear,iThisMonth+1,1))
End Function
%>


</HEAD>

<BODY  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  bgcolor = "white">
<!--#Include file="GlobalVariables.asp"--> 
<!--#Include file="Header.asp"--> 

	
<% 
	  
	

CustID = session("CustID")

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 
 sql = "select custCompany from sfCustomers where custID = " & session("custID")
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   

	
	custCompany = rs("custCompany")

rs.close
  sql = "select * from Ranchpages where custID = " & session("custID")
response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
If rs.eof Then
rs.close

Dim DataConnection, cmdDC, RecordSet
Dim RecordToEdit, Updated
Set DataConnection = Server.CreateObject("ADODB.Connection")

	Query =  "INSERT INTO Ranchpages (custID)" 
	Query =  Query &  " Values ("  & session("custID") &" )" 

response.write(Query)
DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(databasepath) & ";" 
DataConnection.Execute(Query) 
DataConnection.Close


 sql = "select * from RanchPages where custID = " & session("custID")
'response.write(sql)
		
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3

End If 
DBLayoutStyle = rs("LayoutStyle")

DBMenuBackgroundColor = rs("MenuBackgroundColor")
DBMenuBackgroundImage = rs("MenuBackgroundImage")
DBPageBackgroundColor = rs("PageBackgroundColor")
DBPageBackgroundImage = rs("PageBackgroundImage")

DBScreenBackgroundColor = rs("ScreenBackgroundColor")
DBScreenBackgroundImage = rs("ScreenBackgroundImage")
DBAnimalListbackgroundColor = rs("AnimalListbackgroundColor")
DBAnimalListbackgroundColor = rs("AnimalListbackgroundImage")

DBTitleColor = rs("TitleColor")
DBTitleFont = rs("TitleFont")
DBTitleSize = rs("TitleSize")

DBMenuColor = rs("MenuColor")
DBMenuFontMouseOverColor = rs("MenuFontMouseOverColor")
DBMenuSize = rs("MenuSize")
DBMenuFont = rs("MenuFont")

DBPageTextColor = rs("PageTextColor")
DBPageTextFontsize = rs("PageTextFontSize")
DBPageTextFont = rs("PageTextFont")




		MenuBackgroundColor=Request.Form("MenuBackgroundColor" ) 
		If Len(MenuBackgroundColor) > 1  then
			Session("MenuBackgroundColor") =MenuBackgroundColor
		Else
			Session("MenuBackgroundColor") = DBMenuBackgroundColor
			MenuBackgroundColor = DBMenuBackgroundColor
		End If

		MenuBackgroundImage=Request.Form("MenuBackgroundImage" ) 
		If Len(MenuBackgroundImage) > 1  then
			Session("MenuBackgroundImage") =MenuBackgroundImage
		Else
			Session("MenuBackgroundImage") = DBMenuBackgroundImage
			MenuBackgroundImage = DBMenuBackgroundImage
		End If


	PageBackgroundColor=Request.Form("PageBackgroundColor" ) 
		If Len(PageBackgroundColor) > 1  then
			Session("PageBackgroundColor") =PageBackgroundColor
		Else
			Session("PageBackgroundColor") = DBPageBackgroundColor
			PageBackgroundColor = DBPageBackgroundColor
		End If

		PageBackgroundImage=Request.Form("PageBackgroundImage" ) 
		If Len(PageBackgroundImage) > 1  then
			Session("PageBackgroundImage") =PageBackgroundImage
		Else
			Session("PageBackgroundImage") = DBPageBackgroundImage
			PageBackgroundImage = DBPageBackgroundImage
		End If

		ScreenBackgroundColor=Request.Form("ScreenBackgroundColor" ) 
		If Len(ScreenBackgroundColor) > 1  then
			Session("ScreenBackgroundColor") =ScreenBackgroundColor
		Else
			Session("ScreenBackgroundColor") = DBScreenBackgroundColor
			ScreenBackgroundColor = DBScreenBackgroundColor
		End If

		ScreenBackgroundImage=Request.Form("ScreenBackgroundImage" ) 
		If Len(ScreenBackgroundImage) > 1  then
			Session("ScreenBackgroundImage") =ScreenBackgroundImage
		Else
			Session("ScreenBackgroundImage") = DBScreenBackgroundImage
			ScreenBackgroundImage = DBScreenBackgroundImage
		End If

		AnimalListbackgroundColor=Request.Form("AnimalListbackgroundColor" ) 
		If Len(AnimalListbackgroundColor) > 1  then
			Session("AnimalListbackgroundColor") =AnimalListbackgroundColor
		Else
			Session("AnimalListbackgroundColor") = DBAnimalListbackgroundColor
			AnimalListbackgroundColor = DBAnimalListbackgroundColor
		End If

		AnimalListbackgroundImage=Request.Form("AnimalListbackgroundImage" ) 
		If Len(AnimalListbackgroundImage) > 1  then
			Session("AnimalListbackgroundImage") =AnimalListbackgroundImage
		Else
			Session("AnimalListbackgroundImage") = DBAnimalListbackgroundImage
			AnimalListbackgroundImage = DBAnimalListbackgroundImage
		End If

		TitleColor=Request.Form("TitleColor" ) 
		If Len(TitleColor) > 1  then
			Session("TitleColor") =TitleColor
		Else
			Session("TitleColor") = DBTitleColor
			TitleColor = DBTitleColor
		End If

		TitleFont=Request.Form("TitleFont" ) 
		If Len(TitleFont) > 1  then
			Session("TitleFont") =TitleFont
		Else
			Session("TitleFont") = DBTitleFont
			TitleFont = DBTitleFont
		End If

		TitleSize=Request.Form("TitleSize" ) 
		If Len(TitleSize) > 1  then
			Session("TitleSize") =TitleSize
		Else
			Session("TitleSize") = DBTitleSize
			TitleSize = DBTitleSize
		End If




		MenuColor=Request.Form("MenuColor" ) 
		If Len(MenuColor) > 1  then
			Session("MenuColor") =MenuColor
		Else
			Session("MenuColor") = DBMenuColor
			MenuColor = DBMenuColor
		End If

		MenuFont=Request.Form("MenuFont" ) 
		If Len(MenuFont) > 1  then
			Session("MenuFont") =MenuFont
		Else
			Session("MenuFont") = DBMenuFont
			MenuFont = DBMenuFont
		End If

		MenuSize=Request.Form("MenuSize" ) 
		If Len(MenuSize) > 1  then
			Session("MenuSize") =MenuSize
		Else
			Session("MenuSize") = DBMenuSize
			MenuSize = DBMenuSize
		End If


		MenuFontMouseOverColor=Request.Form("MenuFontMouseOverColor" ) 
		If Len(MenuFontMouseOverColor) > 1  then
			Session("MenuFontMouseOverColor") =MenuFontMouseOverColor
		Else
			Session("MenuFontMouseOverColor") = DBMenuFontMouseOverColor
			MenuFontMouseOverColor = DBMenuFontMouseOverColor
		End If

		

	

		PageTextColor=Request.Form("PageTextColor" ) 
		If Len(PageTextColor) > 1  then
			Session("PageTextColor") =PageTextColor
		Else
			Session("PageTextColor") = DBPageTextColor
			PageTextColor = DBPageTextColor
		End If

PageTextFont=Request.Form("PageTextFont" ) 
		If Len(PageTextFont) > 1  then
			Session("PageTextFont") =PageTextFont
		Else
			Session("PageTextFont") = DBPageTextFont
			PageTextFont = DBPageTextFont
		End If

PageTextFontSize=Request.Form("PageTextFontSize" ) 
		If Len(PageTextFontSize) > 1  then
			Session("PageTextFontSize") =PageTextFontSize
		Else
			Session("PageTextFontSize") = DBPageTextFontSize
			PageTextFontSize = DBPageTextFontSize
		End If

		LayoutStyle=Request.Form("LayoutStyle" ) 
		If Len(LayoutStyle) > 1  then
			Session("LayoutStyle") =LayoutStyle
		Else
			Session("LayoutStyle") = DBLayoutStyle
			LayoutStyle = DBLayoutStyle
		End If



		

%>

<a name="Top"></a>



<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" >
	<tr>
		<td Class = "body">
			<H2>Ranchsite Design<br>
			<img src = "images/underline.jpg" width = "800"></H2>
			<b>Definition: <i>RanchSite:</i></b> Your Alpaca Infinity website that can be found on Alpaca RanchQuest. Everywhere on the Alpaca Infinity websites that you refered there is a link to your RanchSite.<br><br>
			Your ARQ RanchSite is at:<br> <a href = "http://www.alpacainfinity.com/alpacaranchquest/RanchHome.asp?custid=<%=custID%>" target= "blank" class = "body">www.alpacainfinity.com/alpacaranchquest/RanchHome.asp?custid=<%=custID%></a><br><br>

			Us the tool below to:
				<ol>
					<li><a href = "#select" class = "body">Select your settings (left side of page).</a>
					<li><a href = "#preview" class = "body">Preview your settings (right side of page).</a>
					<li><a href = "#publish" class = "body">Publish your settings (bottom of the page).</a>
				</ol>
			</td>
	</tr>
</table>
<table>

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
	<tr>
		<td class = "body" width = "300" valign = "top">
		   <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
				<tr>
					<td class ="body" colspan = "2">
						<a name = "select"></a><h2>Step 1. Select Your Settings</h2>
						Make changes to your settings below, and then select the preview button. <br>
						<i>The pallet of colors is at on the right side of this page. </i><br><br>
					</td>
			 </tr>
			 <form action= 'Layoutedit.asp' method = "post">	 
			 </tr>
		
		<tr>
		<td class = "body">
			Layout Style:
		</td>
		<td>
			<select size="1" name="LayoutStyle">
					<option value= "<%=LayoutStyle%>" selected><%=LayoutStyle%></option>
					<% If Len(LayoutStyle) > 1 then
						If LayoutStyle = "Landscape" Then %>
							<option value= "Portrait" >Portrait</option>
						<% Else %>
							<option value= "Landscape" >Landscape</option>
						<% End If 
						Else %>
						<option value= "Portrait" >Portrait</option>
						<option value= "Landscape" >Landscape</option>

						<% End If %>
					</select>

	
		</td>
	</tr>
		<tr>
		<td class = "body">
			Background Color:
		</td>
		<td>
			<select size="1" name="PageBackgroundColor">
					<option value= "<%=PageBackgroundColor%>" selected><%=PageBackgroundColor%></option>
					<!--#Include file="ColorOptionsInclude.asp"--> 		
	
					</select>

	
		</td>
	</tr>
<tr>
		<td class = "body">
			Menu Background Color:
		</td>
		<td>
			<select size="1" name="MenuBackgroundColor">
					<option value= "<%=MenuBackgroundColor%>" selected><%=MenuBackgroundColor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
					</select>

	
		</td>
	</tr>

	<td class = "body">
		Menu Font Color:
		</td>
		<td>
			<select size="1" name="MenuColor">
					<option value= "<%=MenuFontColor%>" selected><%=MenuColor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>
	<td class = "body">
			Menu Mouseover Color:
		</td>
		<td>
			<select size="1" name="MenuFontMouseOverColor">
					<option value= "<%=MenuFontMouseOverColor%>" selected><%=MenuFontMouseOverColor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>


			<tr>
					<td class = "body">
								Heading Font Color:
					</td>
					<td>
								<select size="1" name="TitleColor">
								<option value= "<%=TitleColor%>" selected><%=TitleColor%></option>
									<!--#Include file="ColorOptionsInclude.asp"--> 	
					</select>

	
		</td>
	</tr>
	<tr>
		<td class = "body">
			Heading Text Size:
		</td>
		<td>
			<select size="1" name="TitleSize">
					<option value= "<%=TitleSize%>" selected><%=TitleSize%></option>
					<option value="13" >13</option>	
					<option value="14" >14</option>
					<option  value="15" >15</option>
					<option  value="16" >16</option>
					<option  value="17" >17</option>
			</select>

	
		</td>
	</tr>
	
	<tr>
		<td class = "body">
			Page Text Color:
		</td>
		<td>
			<select size="1" name="PageTextColor">
					<option value= "<%=PageTextColor%>" selected><%=PageTextColor%></option>
						<!--#Include file="ColorOptionsInclude.asp"--> 	
				
					</select>

	
		</td>
	</tr>
		<tr>
		<td class = "body">
			Page Text Size:
		</td>
		<td>
			<select size="1" name="PageTextFontSize">
					<option value= "<%=PageTextFontSize%>" selected><%=PageTextFontSize%></option>
					<option value="10" >10</option>	
					<option value="11" >12</option>
					<option  value="13" >13</option>
			</select>

	
		</td>
	</tr>
</table>	

<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "300">
<tr>
		<td  align = "center" valign = "middle">
			
			<input type=submit value = "Preview" style="font-size:24; background-image: url('images/background.jpg'); border-width:2px" size = "110"  >
			</form>
		
		</td>
</tr>
<tr>
   <td align = "center">
<form action= 'LayoutSubmit.asp' method = "post">	   
<a name = "publish"></a>	<input type=submit value = "Publish!" style="font-size:24; background-image: url('images/background.jpg'); border-width:2px" size = "410" >
</form>


   </td>
  </tr>
 <tr>
			  <td colspan = "2" class = "body" colspan = "2" bgcolor = "wheat" >
			  Note: Select the Preview button above before you upload a logo or header image, otherwise some of your changes may lost.
								<h2>Logo
								<% If Len(logo) > 1 then%>
									<img src = "/uploads/logos/<%= logo%>" height = "25">
								<% End If %></h2>
								 
							</td>
						</tr><form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadLogohandle2.asp" >
					<td class = "body" colspan = "2" bgcolor = "wheat">
						
						<% If Logo = "ImageNotAvailable.jpg" Then %>
								Current Logo Image Name: Not Defined<br>
						<% End If %>

						Upload Logo: <input name="attach1" type="file" size=35 ><br>
						<center><input  type=submit value="Upload Logo" style="font-size:10"></center>
					</td>
				</tr>
				<tr>
					</form>
					<td align= "center" colspan = "2" bgcolor = "wheat">
					<form action= 'RemoveLogo2.asp' method = "post">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove The Logo" style="font-size:10"></center>
	
				</td>	</form>
			</tr>
			  <tr>
			  <td colspan = "2" class = "body" bgcolor = "wheat">
								<h2>Header<% If Len(Header) > 1 then%>
									<img src = "/uploads/logos/<%= Header%>" height = "25">
								<% End If %></h2>
								 <b>Only used with a Landscape Layout.</b>
							</td>
				</tr>
				<td class = "body" colspan = "2" bgcolor = "wheat">
				<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadHeaderhandle2.asp" >
				
						
						<% If Header = "ImageNotAvailable.jpg" Then %>
								Current Logo Image Name: Not Defined<br>
						<% End If %>

						Upload Header: <input name="attach1" type="file" size=35 ><br>
						<center><input  type=submit value="Upload Header" style="font-size:10"></center>
					</td>
				</tr>
				</form>
					<form action= 'RemoveHeader2.asp' method = "post">
				<tr>
					<td colspan = "2" bgcolor = "wheat">
							<input type = "hidden" name="ImageID" value= "1" >
							<input type = "hidden" name="ID" value= "<%= ID %>" >
							<center><input type=submit value="Remove The Header" style="font-size:10"></center>
					</form>
		
	
				</td>
			</tr>
			
</table>
	
		</td>
		<td width = "1" bgcolor = "black"><img src = "images/px.gif" width = "1" height = "340"></td>
		<td class = "body" width = "400" valign = "top">
		
			

				
	<a name = "preview"></a>
	<h2>Step 2. Preview Your Settings</h2>
			<b></b> Below is a roughly half-sized preview of your about us page with your changes. When you are happy with your design, select the Publish button to implement your changes. <b>If you don't select the Publish button your changes will be lost when you leave the admin area! </b><br><br>
   <br>
<center>Below is a rough approximation of your site to show your design. Everything is at 50% it's final size.
   <% If LayoutStyle = "Landscape" Then %>

			<iframe src ="FrameLandscapeAboutUs.asp" width="460" height="650">
			 <p>Your browser does not support iframes.</p>
			</iframe>

   <% Else %>
			<iframe src ="FramePortraitAboutUs.asp" width="460" height="650">
				<p>Your browser does not support iframes.</p>
			</iframe>

			<% End If %>

		</td>
	</tr>
</table><form action= 'LayoutSubmit.asp' method = "post">	   
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">
<tr>
  <td class = "body"><h2>Step 3. Publish Your Settings</h2></td></tr>
  <tr>
		<td  align = "center" valign = "middle" bgcolor = "BlanchedAlmond">	<a name = "publish"></a>	<input type=submit value = "Publish!" style="font-size:24; background-image: url('images/background.jpg'); border-width:2px" size = "410" ></td>
</tr>
</table></form>



	
<!-- #include virtual="/administration/Footer3.asp" -->
 </Body>
</HTML>
