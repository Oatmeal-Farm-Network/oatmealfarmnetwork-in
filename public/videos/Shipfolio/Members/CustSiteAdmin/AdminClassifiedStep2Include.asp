 <%
 response.Write("prodID=" & prodID )
 ID = ProdID %>
 <!--#Include virtual="/ProdDetailDBInclude.asp"--> 
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "960">
	<tr>
		<td align = "center" valign = "top">
			<table  valign = "top" width = "400" align = "center">
			<tr>
			  	<td valign = "top">
				<%
					if not rsA.eof And foundimagecount > 1 Then
					%>
<table border="0" cellspacing="0" align = "left" valign = "top" >
			<tr><%	rsA.movefirst
						counter = 0
						counttotal = rsA.recordcount
						counttotal = 8
						'response.write("counttotal=" & 	counttotal)
						While counter < counttotal
			
			counter = counter +1
			If counter = 5 Then
			%>
			</tr>
			<tr><%
			End if
			
			if Len(buttonimages(counter)) > 10  then
			%><td valign = "top" align = "center">
			<font 
			onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
			onMouseOut="img<%=counter%>('but1')"  class = "menu">
			<img src="<%=buttonimages(counter)%>" width = "75" alt = "<%=buttontitle(counter)%>" border = "0">
			<% If Len(buttontitle(counter)) > 1 Then %>
					<br>
					<small><%=buttontitle(counter)%></small></font>
			<% End If %>
			</td>

		<%
			end if
		if counter< counttotal then
			'rsA.movenext
		end if

		%>
			
		<%
	Wend %>
</tr>
			</table>

	<% end if
%>

			</td>
		</tr>
		<tr>
				  <td valign = "top" >
						<% if foundimagecount < 1 then%>
							<table valign = "top" border = "0" align = "center"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
							<tr>
								<td  valign = "top" align = "center">
									<%=click%>
								</td>
							</tr>
							</table>
						<% else %>
							<table border = "0"  valign = "top" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
							<tr>
								<td valign = "top">
									<IMG alt="main image" border=0  name='but1' src="<%=buttonimages(1)%>" align = "center" width = "400">
								</td>
							</tr>
						</table>
						<% end if%>
				</td>
			</tr>
</table>		
	
		</td>
		<td width = "5"><img src = "images/px.gif" width = "1" height = "1" alt = "Alpaca Products for Sale"/></td>
		<td valign = "top">
<!--#Include virtual="/ProdDetailFacts.asp"--> 
		</td>
	</tr>
</table>
		</td>
	</tr>
</table>




















<% ' Clean directory NEA 4/2012 %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add a Product - Step 3: Confirm Text<a name="Add"></a></div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top" class = "body">
        <blockquote><div align = "left" class = "body">Please make sure that all of the information that you entered is correct.</div></blockquote>


 <%

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password= ;" 
	sql2 = "select * from sfProducts where  ProdID = '" & session("ProdID") & "' ;"

'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

ProductName= rs2("ProdName")
Prodweight= rs2("Prodweight")
Price= rs2("ProdPrice")
Description= rs2("ProdDescription")
QuantityAvailable= rs2("ProdQuantityAvailable")
ProdForSale= rs2("ProdForSale")
ProdSize1= rs2("ProdSize1")
ProdSize2= rs2("ProdSize2")
ProdSize3= rs2("ProdSize3")
ProdSize4= rs2("ProdSize4")
ProdSize5= rs2("ProdSize5")
ProdSize6= rs2("ProdSize6")
ProdSize7= rs2("ProdSize7")
ProdSize8= rs2("ProdSize8")
ProdSize9= rs2("ProdSize9")
ProdSize10= rs2("ProdSize10")

Color1=rs2( "Color1" ) 
	Color2=rs2( "Color2" ) 
	Color3=rs2( "Color3" ) 
	Color4=rs2( "Color4" ) 
	Color5=rs2( "Color5" ) 
	Color6=rs2( "Color6" ) 
	Color7=rs2( "Color7" ) 
	Color8=rs2( "Color8" ) 
	Color9=rs2( "Color9" ) 
	Color10=rs2( "Color10" ) 

Color11 =rs2("Color11")
Color12 =rs2("Color12")
Color13 =rs2("Color13")
Color14 =rs2("Color14")
Color15 =rs2("Color15")
Color16 =rs2("Color16")
Color17 =rs2("Color17")
Color18 =rs2("Color18")
Color19 =rs2("Color19")

Color20 =rs2("Color20")
Color21 =rs2("Color21")
Color22 =rs2("Color22")
Color23 =rs2("Color23")
Color24 =rs2("Color24")
Color25 =rs2("Color25")
Color26 =rs2("Color26")
Color27 =rs2("Color27")
Color28 =rs2("Color28")
Color29 =rs2("Color29")

Color30 =rs2("Color30")
Color31 =rs2("Color31")
Color32 =rs2("Color32")
Color33 =rs2("Color33")
Color34 =rs2("Color34")
Color35 =rs2("Color35")
Color36 =rs2("Color36")
Color37 =rs2("Color37")
Color38 =rs2("Color38")
Color39 =rs2("Color39")

Color40 =rs2("Color40")
Color41 =rs2("Color41")
Color42 =rs2("Color42")
Color43 =rs2("Color43")
Color44 =rs2("Color44")
Color45 =rs2("Color45")
Color46 =rs2("Color46")
Color47 =rs2("Color47")
Color48 =rs2("Color48")
Color49 =rs2("Color49")

Color50 =rs2("Color50")
Color51 =rs2("Color51")
Color52 =rs2("Color52")
Color53 =rs2("Color53")
Color54 =rs2("Color54")
Color55 =rs2("Color55")
Color56 =rs2("Color56")
Color57 =rs2("Color57")
Color58 =rs2("Color58")
Color59 =rs2("Color59")

Color60 =rs2("Color60")
Color61 =rs2("Color61")
'response.write("Color61=" & Color61)
Color62 =rs2("Color62")
Color63 =rs2("Color63")
Color64 =rs2("Color64")
Color65 =rs2("Color65")
Color66 =rs2("Color66")
Color67 =rs2("Color67")
Color68 =rs2("Color68")
Color69 =rs2("Color69")

Color70 =rs2("Color70")
Color71 =rs2("Color71")
Color72 =rs2("Color72")
Color73 =rs2("Color73")
Color74 =rs2("Color74")
Color75 =rs2("Color75")



ProdDimensions= rs2("ProdDimensions")

sql2 = "select * from productCategoriesList, sfCategories where productCategoriesList.prodcategoryId =  sfCategories.catId and prodcategoryID > 0 and ProductID = '" & session("ProdID") & "';"

'Response.write(sql2)

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

if not rs2.eof then
	Category1= rs2("CatName")
	Category1ID = rs2("catID")
end if
if not rs2.eof then
	rs2.movenext
	end if
if not rs2.eof then
	Category2= rs2("CatName")
	Category2ID = rs2("catID")
end if
if not rs2.eof then
	rs2.movenext
end if
if not rs2.eof then
	Category3= rs2("CatName")
	Category3ID = rs2("catID")
end if

If Price = "0" Then
	Price = ""
End If 

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


%>


<table    cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "900" Border = "0" Bgcolor = "#eeeeee">
<tr><td colspan = "2" height ="5"><Img src = "images/px.gif" height = "5" width = "900" /></td></tr>
 <tr>
    <td width = "500" align = "center" valign = "top">
        <table    cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   valign ="top"    width = "450" Border = "0" >
         		<tr>
			<td  class = "body"><div align = "right">
					Item Name:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<b><%=ProductName%></b>
			</td>
		</tr>
		<tr>
			<td  class = "body"><div align = "right">
					Category: </div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<%=Category1%>
			</td>
		</tr>
		<tr>
			<td  class = "body"><div align = "right">
					Category: </div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<%=Category2%>
			</td>
		</tr>
		<tr>
			<td  class = "body"><div align = "right">
					Category: </div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
				<%=Category3%>
			</td>
		</tr>
		
		<tr>
			<td  class = "body"><div align = "right">
					Price:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
			<% If Len(Price) > 1 Then %>
				 <%=FormatCurrency(Price,2)%>
				<% End If %>
			</td>
		</tr>
        <tr>
			<td  class = "body"><div align = "right">
					For Sale:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=ProdForSale%>
			</td>
		</tr>
		<tr>
			<td  class = "body"><div align = "right">
					Weight:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=Prodweight%>
			</td>
		</tr>
				<tr>
			<td  class = "body"><div align = "right">
					Made In:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=ProdMadeIn%>
			</td>
		</tr>
	
		<tr>
			<td  class = "body" valign = "top"><div align = "right">
					Composition:</div>
			</td>
			<td>&nbsp;</td>
			<td class = "body">
			<% if len(prodFiberPercent1)> 0 or len(ProdFiberType1) > 0 then %>
			    <%=prodFiberPercent1%>%  <%=ProdFiberType1%><br />
			<% end if %>
					<% if len(prodFiberPercent2)> 0 or len(ProdFiberType2) > 0 then %>
			    <%=prodFiberPercent2%>%   <%=ProdFiberType2%><br />
			<% end if %>
			<% if len(prodFiberPercent3)> 0 or len(ProdFiberType3) > 0 then %>
			    <%=prodFiberPercent3%>%   <%=ProdFiberType3%><br />
			<% end if %>
			<% if len(prodFiberPercent4)> 0 or len(ProdFiberType4) > 0 then %>
			    <%=prodFiberPercent4%>%   <%=ProdFiberType4%><br />
			<% end if %>
					<% if len(prodFiberPercent5)> 0 or len(ProdFiberType5) > 0 then %>
			    <%=prodFiberPercent5%>%   <%=ProdFiberType5%><br />
			<% end if %>
			</td>
		</tr>
		<tr>
		  <td  class = "body" valign = "top"><div align = "right">Sizes</div></td>
		  <td>&nbsp;</td>
		  <td>
		  <table border = "0" cellpadding = "0" cellspacing = "0">
			<tr>
				<td  class = "body"><div align = "right">
					Size 1:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize1%>
				</td>
				<td width = "10">&nbsp;</td>
				<td  class = "body"><div align = "right">
					Size 6:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize6%>
				</td>
			</tr>

	<tr>
				<td  class = "body"><div align = "right">
					Size 2:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize2%>
				</td>
				<td width = "10">&nbsp;</td>
				<td  class = "body"><div align = "right">
					Size 7:</div>
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize7%>
				</td>
			</tr>

	<tr>
				<td  class = "body"><div align = "right">
					Size 3:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize3%>
				</td>
				<td width = "10">&nbsp;</td>
				<td  class = "body"><div align = "right">
					Size 8:</div>
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize8%>
				</td>
			</tr>
	<tr>
				<td  class = "body"><div align = "right">
					Size 4:</div>
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize4%>
				</td>
				<td width = "10">&nbsp;</td>
				<td  class = "body"><div align = "right">
					Size 9:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize9%>
				</td>
			</tr>
				<tr>
				<td  class = "body"><div align = "right">
					Size 5:</div>
				</td>
				<td>&nbsp;</td>
					<td class = "body">
					<%=ProdSize5%>
				</td>
				<td width = "10">&nbsp;</td>
				<td  class = "body"><div align = "right">
					Size 10:</div>
				</td>
				<td>&nbsp;</td>
				<td class = "body">
					<%=ProdSize10%>
				</td>
			</tr>
			<tr>
			<td  class = "body" align = "right">
					# Available:
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=ProdQuantityAvailable%>
			</td>
		</tr>
			<tr>
			<td  class = "body" align = "right">
					Description:
			</td>
			<td>&nbsp;</td>
			<td class = "body"><%=ProdDescription%>
			</td>
		</tr>
        </table>
        </td>
        </tr>
        </table>
    </td>
   <td width = "400" align = "center">
           <table border = "0" width = "390" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
		<tr>
				<td class = "body"  colspan = "3">
					Colors:
				</td>
			</tr>
			<tr>
				<td  class = "body">
					1:<%=Color1 %>
				</td>
				<td  class = "body">
					26:<%=Color26%>
				</td>
				<td  class = "body">
					51:<%=Color51 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					2:<%=Color2%>
				</td>
				<td class = "body">
					27:<%=Color27 %>
				</td>
				<td class = "body">
					52:<%=Color52 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					3:<%=Color3 %>
				</td>
				<td class = "body">
					28:<%=Color28 %>
				</td>
				<td class = "body">
					53:<%=Color53 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					4:<%=Color4 %>
				</td>
				<td class = "body">
					29:<%=Color29 %>
				</td>
				<td class = "body">
					54:<%=Color54 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					5:<%=Color5 %>
				</td>
				<td class = "body">
					30:<%=Color30 %>
				</td>
				<td class = "body">
					55:<%=Color55 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					6:<%=Color6 %>
				</td>
				<td class = "body">
					31:<%=Color31 %>
				</td>
				<td class = "body">
					56:<%=Color56 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					7:<%=Color7 %>
				</td>
				<td class = "body">
					32:<%=Color32 %>
				</td>
				<td class = "body">
					57:<%=Color57 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					8:<%=Color8 %>
				</td>
				<td class = "body">
					33:<%=Color33 %>
				</td>
				<td class = "body">
					58:<%=Color58 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					9:<%=Color9 %>
				</td>
				<td class = "body">
					34:<%=Color34 %>
				</td>
				<td class = "body">
					59:<%=Color59 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<%=Color10 %>
				</td>
				<td class = "body">
					35:<%=Color35 %>
				</td>
				<td class = "body">
					60:<%=Color60 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					11:<%=Color11 %>
				</td>
				<td class = "body">
					36:<%=Color36 %>
				</td>
				<td class = "body">
					61:<%=Color61 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					12:<%=Color12 %>
				</td>
				<td class = "body">
					37:<%=Color37 %>
				</td>
				<td class = "body">
					62:<%=Color62 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					13:<%=Color13 %>
				</td>
				<td class = "body">
					38:<%=Color38 %>
				</td>
				<td class = "body">
					63:<%=Color63 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					14:<%=Color14 %>
				</td>
				<td class = "body">
					39:<%=Color39 %>
				</td>
				<td class = "body">
					64:<%=Color64 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					15:<%=Color15 %>
				</td>
				<td class = "body">
					40:<%=Color40 %>
				</td>
				<td class = "body">
					65:<%=Color65 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					16:<%=Color16 %>
				</td>
				<td class = "body">
					41:<%=Color41 %>
				</td>
				<td class = "body">
					66:<%=Color66 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					17:<%=Color17 %>
				</td>
				<td class = "body">
					42:<%=Color42 %>
				</td>
				<td class = "body">
					67:<%=Color67 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					18:<%=Color18 %>
				</td>
				<td class = "body">
					43:<%=Color43 %>
				</td>
				<td class = "body">
					68:<%=Color68 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					19:<%=Color19 %>
				</td>
				<td class = "body">
					44:<%=Color44 %>
				</td>
				<td class = "body">
					69:<%=Color69 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					20:<%=Color20 %>
				</td>
				<td class = "body">
					45:<%=Color45 %>
				</td>
				<td class = "body">
					70:<%=Color70 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					21:<%=Color21 %>
				</td>
				<td class = "body">
					46:<%=Color46 %>
				</td>
				<td class = "body">
					71:<%=Color71 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					22:<%=Color22 %>
				</td>
				<td class = "body">
					47:<%=Color47 %>
				</td>
				<td class = "body">
					72:<%=Color72 %>
				</td>
			</tr>
			<tr>
				<td class = "body">
					23:<%=Color23 %>
				</td>
				<td class = "body">
					48:<%=Color48 %>
				</td>
				<td class = "body">
					73:<%=Color73 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					24:<%=Color24 %>
				</td>
				<td class = "body">
					49:<%=Color49 %>
				</td>
				<td class = "body">
					74:<%=Color74 %>
				</td>
			</tr>
				<tr>
				<td class = "body">
					25:<%=Color25 %>
				</td>
				<td class = "body">
					50:<%=Color50 %>
				</td>
				<td class = "body">
					75:<%=Color75 %>
				</td>
			</tr>
			</table>
			
 



<%
rs2.close
sql2 = "select * from sfproducts where sfProducts.ProdID = '" & session("ID")  & "' ;"
'response.write(sql2)

Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 

File1= rs2("prodImageLargePath")
If Len(File1) < 2 Then
   File1 = "http://www.ArtisanBarn.org/uploads/Artwork/ImageNotAvailable.jpg"
End If 
'response.write("File1=")
'response.write(rs2("ProdImage1"))
rs2.close
	   %>

		</td>
	</tr>
</table><br><br>




		
  
    <br> 

<table width = "700" align = "center">
	<tr>
		<td>
<form action= 'AdminAdEdit2.asp' method = "post">
<input name="box1" type = "hidden" value = "<%=CategoryID%>">
<input name="box2ID" type = "hidden" value = "<%=SubCategoryID%>">


<input name="ProdID" type = "hidden" value = "<%=session("ID") %>">
			<input type=submit value = "<--Go Back and Make Changes"  class = "submit" >
			</form>
		
<form action= 'AdminClassifiedAdPlace.asp' method = "post">


			<input type=submit value = "Add Another Product -->" class = "submit" >
			</form>
		<form action= "AdminProductPhotos.asp?ID=<%=session("ID") %>" method = "post">

<input name="ProdID" type = "hidden" value = "<%=session("ID") %>">
			<input type=submit value = "Upload Photo -->"  class = "submit" >
			</form>
   </td>
    </tr>
</table>

	
<br><br> </td>
    </tr>
</table><br>