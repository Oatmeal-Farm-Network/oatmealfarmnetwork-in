<% 
ProdID=request.form("ProdID") 
If ProdID  >0 then
Else
ProdID= Request.QueryString("ProdID") 

End if

Session("PhotoPageCount") = 0

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password= ;" 

'*******************Get Customer Location *********************
CustID = Session("CustID")
Dim CurrentCategoryID
Dim CurrentCategoryName

Dim SubCurrentCategoryID
Dim SubCurrentCategoryName
'response.write(ID)]

sql = "select * from sfProducts where sfProducts.ProdID = '" & ProdID & "';" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
	
CurrentCategoryID  = rs("prodCategoryId")
SubCurrentCategoryID  = rs("prodSubCategoryId")
'response.write("SubCategoryID = ")
'response.write(SubCategoryID)


ProdPrice  = rs("ProdPrice")
ProdDimensions  = rs("ProdDimensions")
Prodsize1 =rs("Prodsize1")
ProdSize2  = rs("ProdSize2")
ProdSize3  = rs("ProdSize3")
ProdSize4  = rs("ProdSize4")
ProdSize5  = rs("ProdSize5")
ProdSize6  = rs("ProdSize6")
ProdSize7  = rs("ProdSize7")
ProdSize8  = rs("ProdSize8")
ProdSize9  = rs("ProdSize9")
ProdSize10  = rs("ProdSize10")

Color1 =rs("Color1")
Color2 =rs("Color2")
Color3 =rs("Color3")
Color4 =rs("Color4")
Color5 =rs("Color5")
Color6 =rs("Color6")
Color7 =rs("Color7")
Color8 =rs("Color8")
Color9 =rs("Color9")
Color10 =rs("Color10")


Color11 =rs("Color11")
Color12 =rs("Color12")
Color13 =rs("Color13")
Color14 =rs("Color14")
Color15 =rs("Color15")
Color16 =rs("Color16")
Color17 =rs("Color17")
Color18 =rs("Color18")
Color19 =rs("Color19")

Color20 =rs("Color20")
Color21 =rs("Color21")
Color22 =rs("Color22")
Color23 =rs("Color23")
Color24 =rs("Color24")
Color25 =rs("Color25")
Color26 =rs("Color26")
Color27 =rs("Color27")
Color28 =rs("Color28")
Color29 =rs("Color29")

Color30 =rs("Color30")
Color31 =rs("Color31")
Color32 =rs("Color32")
Color33 =rs("Color33")
Color34 =rs("Color34")
Color35 =rs("Color35")
Color36 =rs("Color36")
Color37 =rs("Color37")
Color38 =rs("Color38")
Color39 =rs("Color39")

Color40 =rs("Color40")
Color41 =rs("Color41")
Color42 =rs("Color42")
Color43 =rs("Color43")
Color44 =rs("Color44")
Color45 =rs("Color45")
Color46 =rs("Color46")
Color47 =rs("Color47")
Color48 =rs("Color48")
Color49 =rs("Color49")

Color50 =rs("Color50")
Color51 =rs("Color51")
Color52 =rs("Color52")
Color53 =rs("Color53")
Color54 =rs("Color54")
Color55 =rs("Color55")
Color56 =rs("Color56")
Color57 =rs("Color57")
Color58 =rs("Color58")
Color59 =rs("Color59")

Color60 =rs("Color60")
Color61 =rs("Color61")
'response.write("Color61=" & Color61)
Color62 =rs("Color62")
Color63 =rs("Color63")
Color64 =rs("Color64")
Color65 =rs("Color65")
Color66 =rs("Color66")
Color67 =rs("Color67")
Color68 =rs("Color68")
Color69 =rs("Color69")

Color70 =rs("Color70")
Color71 =rs("Color71")
Color72 =rs("Color72")
Color73 =rs("Color73")
Color74 =rs("Color74")
Color75 =rs("Color75")


ProdMadeIn= rs("ProdMadeIn")

	ProdFiberType1= rs("ProdFiberType1") 
	ProdFiberType2= rs("ProdFiberType2") 
	ProdFiberType3= rs("ProdFiberType3") 
	ProdFiberType4= rs("ProdFiberType4") 
	ProdFiberType5= rs("ProdFiberType5") 

	prodFiberPercent1= rs("prodFiberPercent1") 
	prodFiberPercent2= rs("prodFiberPercent2") 
	prodFiberPercent3= rs("prodFiberPercent3") 
	prodFiberPercent4= rs("prodFiberPercent4") 
	prodFiberPercent5= rs("prodFiberPercent5") 
ProdWeight =rs("ProdWeight")
ProdQuantityAvailable  = rs("ProdQuantityAvailable")
prodImageLargePath  = rs("prodImageLargePath")
ProdDescription = rs("ProdDescription")
ProdSellStore =request.form("ProdSellStore")
ProdForSale = rs("ProdForSale")
If ProdQuantityAvailable = 0 Then
	ProdForSale = false
End if

ProdName  = rs("ProdName")

str1 = ProdName
str2 = "'"
If InStr(str1,str2) > 0 Then
	ProdName= Replace(str1, "'", "'")
End If

	rs.close


 sql = "select * from sfCategories where CatID = " & CurrentCategoryID & ";"

	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	
	If Not rs.eof Then
		CurrentCategoryName = rs("CatName")
	End if
	'response.write("CurrentCategoryName=" & CurrentCategoryName )



 sql = "select * from sfSubCategories where subcatId = " & SubCurrentCategoryID & ";"
	'	response.write(sql)	
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
		SubCurrentCategoryName = rs("SubCategoryName")
	End If
	'response.write("SubCategoryName=")
	'response.write(SubCurrentCategoryName)


Dim CategoryID(100,100)
Dim CatName(100,100)

Dim SubCategoryIDX(1000)
Dim SubCatName(1000)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from SFCategories  order by Catname " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("CatID")
		CatName(CatCounter,0) = rs("CatName")
		'response.write(CatName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
firsttime = False
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1
	
	

	sql = "select * from SFSubCategories where CategoryID = '" & CategoryID(CatCounter,0) & "' Order by SubcategoryName"
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	If Not rs.eof Then
	SubCatCounter= 0
	If Len(SubCurrentCategoryName) > 0 And firsttime = False  Then
		firsttime = True
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """], "
		Varieties =  Varieties  & " ["" No Sub Categories "" ," & vbCrLf
	Else
			Varieties =  Varieties  & " ["" Sub Categories "", "
	End if
	While Not rs.eof
		SubCatCounter= SubCatCounter +1
		SubCatCounter2 = SubCatCounter2  +1
		CategoryID(CatCounter,SubCatCounter) = rs("subcatId") 
		CatName(CatCounter,SubCatCounter) = rs("SubCategoryName") 

		SubCategoryIDX(SubCatCounter2) = rs("subcatId") 
		SubCatName(SubCatCounter2) = rs("SubCategoryName") 
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  %>
		
      

		<% rs.movenext
			If Not(rs.eof) Then 
				Varieties  = Varieties  &  """ , " 
			 End If 
	Wend
	Varieties  = Varieties & """ ]," & vbCrLf
	Else
		If SubCurrentCategoryID > 0  Then
		
		Varieties =  Varieties  & " [""" & SubCurrentCategoryName & """ ]," & vbCrLf
		
		Else
		If firsttime = False Then
			firsttime = True
				Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
					Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		Else
						Varieties =  Varieties  & " ["" No Sub Categories "" ]," & vbCrLf
		End if
		
		End if
	End If 
wend

FinalSubCatCounter2 = SubCatCounter2
   		FinalSubCatCounter = CatCounter

Varietielen  = Len(Varieties)
'response.write(Varieties)
Varieties = Left(Varieties, (Varietielen-3))
%>





 <script type="text/javascript">
<!--
var varieties=[<%=Varieties%>];

function Box2IDpick(box2pick) {
var f=document.myform;
f.box2ID.value=null;

f.box2ID.value = box2pick
}


 //-->
</script>




<script type="text/javascript">
var varieties=[<%=Varieties%>];

function Box2(idx) {
var f=document.myform;
f.box2.options.length=null;
for(i=0; i<varieties[idx].length; i++) {
    f.box2.options[i]=new Option(varieties[idx][i], i); 
    }    
}

onload=function() {Box2(0);};
</script>



<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "700">
	<tr>
		<td class = "body" valign = "top"  >

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "700">
	<tr>
		<td class = "body" valign = "top"  ><a name="Add"></a><h2>Edit Your Product- Step 2: Make Changes</h2>
			To make your changes, edit your text  in the boxes below and then select the "submit" changes button.
		</td>
	</tr>
</table>
</td>
</tr>
<tr>
<td>

<% 
Dim XIDArray(1000)
Dim XProdname(1000)

  
	conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" 
	sql2 = "select * from sfProducts  where custID = " & session("custid") & " order by Prodname"

	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof  
		XIDArray(acounter) = rs2("prodID")
		XProdname(acounter) = rs2("Prodname")

		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs2.movenext
	Wend		
	
		rs2.close
		set rs2=nothing
		set conn = nothing
%>

</td>
</tr>
<tr>
<td>

				

<form action="EditAd2.asp" method = "post">
		<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"    width = "900"  align = "left">
			   <tr>
				 <td class = "body" align = "center">
					Select another one of your listings:
					<select size="1" name="ProdID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=XIDArray(count)%>">
							<%=XProdname(count)%> <font class = "small"></font>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
					<input type=submit value = "Select" style="background-image: url('images/background.jpg'); border-width:1px" size = "210" class = "body" >
				</td>
			  </tr>
		    </table>
		  </form>

<br><br>
</td>
</tr>
<tr>
<td>

<form action= 'AdminEditad3.asp' method = "post" name="myform">
<input name="Subject" type = "hidden" value = "<%=Subject%>">
<input name="ProdID" type = "hidden" value = "<%=ProdID%>">
<input name="AdType" type = "hidden" value = "<%=AdType%>">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800" align = "left">
  <tr>
    <td valign = "top">
	<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "400">
	<tr>
			<td  class = "body"  colspan = "3" >
			Category:
			<%=CurrentCategoryName%>
	
		</td>
	</tr>
		<tr>
			<td  class = "body"  colspan = "3" bgcolor = "#D4D4D4"><br>
			<b> Use the drop down below to change the category:</b><br><br>
			Change Category:
	<select name="box1" onchange="Box2(this.selectedIndex)">
    <% 
	CatCounter = 0 %>
		<option value="<%=CurrentCategoryID%>"><%=CurrentCategoryName%></option>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter,0)%>"><%=CatName(CatCounter,0)%></option>
	<% Wend %>
</select>
		</td>
	</tr>
	<tr>
		<td  class = "body" align = "right">
			Item Name:
		</td>
		<td>&nbsp;</td>
		<td>
			<input name="ProdName" value="<%=ProdName %>" size = "50">
		</td>
<tr><td  class = "body" align = "right" >
			Price:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			$<input name="ProdPrice" value="<%=formatnumber(ProdPrice ,2)%>" size = "20"><i>Must be a number.</i>
</td></tr>
<tr><td  class = "body" align = "right" >
			For Sale:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			 <% 'response.write("prodForsale=" & ProdForSale ) %>
			 
			 
			<% if  ProdForSale = "Yes" Or  ProdForSale = True Then %>
						True<input TYPE="RADIO" name="ProdForSale" Value = True checked>
						False<input TYPE="RADIO" name="ProdForSale" Value = False >
					<% Else %>
						True<input TYPE="RADIO" name="ProdForSale" Value = True >
						False<input TYPE="RADIO" name="ProdForSale" Value = False checked>
				<% End if%>
		</td>
	</tr>
	<tr><td  class = "body" align = "right" >
			Country Made In:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			<input name="ProdMadeIn" value="<%=ProdMadeIn%>" size = "20">
</td></tr>

		<tr>
	<td  class = "body" align = "right" valign = "top">
			Weight:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
		<% If ProdWeight = "0" Then
		ProdWeight = " "
		End If %>
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='prodweight' size=10 maxlength=10 value="<%=ProdWeight %>"> lbs <i>Must be a number. Round to the pound.<br>
	Necessary to determine shipping costs.</i>
			
		</td>
	</tr>

	
	<tr>
	<td class = "body" valign = "top" align = "right">Composition:</td>
	<td  class = "body" align = "left" colspan = "2">
	    <table bgcolor = "#D4D4D4">
			<tr>
				<td class = "body" colspan ="3">
					Alpaca Fiber:<input type="hidden" name='ProdFiberType1' value = "Alpaca" value="<%=ProdFiberType1 %>">
					<input type=text 	name='prodFiberPercent1' size=3 maxlength=4 value="<%=prodFiberPercent1 %>">%
				</td>
		</tr>
		<tr>
				<td class = "body">
					Fiber 2: <input type=text name='ProdFiberType2' size=20 maxlength=60 value="<%=ProdFiberType2 %>">
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent2' size=3 maxlength=4 value="<%=prodFiberPercent2 %>">%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 3: <input type=text name='ProdFiberType3' size=20 maxlength=60 value="<%=ProdFiberType3 %>">
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent3' size=3 maxlength=4 value="<%=prodFiberPercent3 %>">%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 4: <input type=text name='ProdFiberType4' size=20 maxlength=60 value="<%=ProdFiberType4 %>">
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent4' size=3 maxlength=4 value="<%=prodFiberPercent4 %>">%
				</td>
			</tr>
			<tr>
				<td class = "body">
					Fiber 5: <input type=text name='ProdFiberType5' size=20 maxlength=60 value="<%=ProdFiberType5 %>">
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text name='prodFiberPercent5' size=3 maxlength=4 value="<%=prodFiberPercent5 %>">%
				</td>
			</tr>
			</table>
			
		</td>
	</tr>

	<tr>
	<td></td>
	<td  class = "body" align = "left" colspan = "2">
	    <table  border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  >
			<tr>
				<td class = "body" >Size 1:</td>
				
				<td>
					<input type=text 	name='ProdSize1' size = 15 maxlength=60 value = "<%=ProdSize1 %>">
				</td>
				<td class = "body">
					Size 6:
				</td>
				<td>
					<input type=text 	name='ProdSize6' size = 15 maxlength=60 value = "<%=ProdSize6 %>">
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 2:
				</td>

				<td>
					<input type=text 	name='ProdSize2' size = 15 maxlength=60 value = "<%=ProdSize2 %>">
				</td>
				<td class = "body">
					Size 7:
				</td>

				<td>
					<input type=text 	name='ProdSize7' size = 15 maxlength=60 value = "<%=ProdSize7 %>">
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 3:
				</td>
				<td>
					<input type=text 	name='ProdSize3' size = 15 maxlength=60 value = "<%=ProdSize3 %>">
				</td>
				<td class = "body">
					Size 8:
				</td>
				<td>
					<input type=text 	name='ProdSize8' size = 15 maxlength=60 value = "<%=ProdSize8 %>" >
				</td>
			</tr>
			<tr>
				<td class = "body">
					Size 4:
				</td>
				<td>
					<input type=text 	name='ProdSize4' size = 15 maxlength=60 value = "<%=ProdSize4 %>">
				</td>
				<td class = "body">
					Size  9:
				</td>
				<td>
							<input type=text 	name='ProdSize9' size = 15 maxlength=60 value = "<%=ProdSize9 %>" >
				</td>
			</tr>
				<tr>
				<td class = "body">
					Size 5:
				</td>
				<td>
					<input type=text 	name='ProdSize5' size = 15 maxlength=60 value = "<%=ProdSize5 %>">
				</td>
				<td class = "body">
					Size  10:
				</td>
				<td>
							<input type=text 	name='ProdSize10' size = 15 maxlength=60 value = "<%=ProdSize10 %>" >
				</td>
			</tr>
			</table>
		</td>
	</tr>
	   


	<tr>
	<td  class = "body" align = "right">
			Quantity Available:
		</td>
		<td>&nbsp;</td>
		<td>
			<input name="ProdQuantityAvailable" value="<%=ProdQuantityAvailable%>" size = "20"> 
		</td>
	</tr>

	





<tr>
		<td  class = "body"  align = "right" valign = "top">&nbsp;Description:</td>
		<td>&nbsp;</td>
		<td colspan = "2" align = "left" class = "body">

		<textarea name="ProdDescription"  cols="40" rows="30"  onKeyDown="textCounter(this.form.ProdDescription,this.form.remLentext,1000);" onKeyUp="textCounter(this.form.ProdDescription,this.form.remLentext,1000);" ><%=ProdDescription%></textarea>
		<br>Characters remaining: <input type=box readonly name=remLentext size=3 value=1000>
		</td>
	</tr>


</table>
 </td>
  <td align = "left" width = "510" valign = "top">

	    <table border = "0" width = "390" border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left">
		<tr>
				<td class = "body" bgcolor = "#D4D4D4" align = "center" colspan = "3">
					<b>Colors</b>
				</td>
			</tr>
			<tr>
				<td class = "body">
					1:<input type=text 	name='Color1' size=13 maxlength=30  class = "body" value = "<%=Color1 %>">
				</td>
				<td class = "body">
					26:<input type=text 	name='Color26' size=12 maxlength=30  class = "body" value = "<%=Color26%>">
				</td>
				<td class = "body">
					51:<input type=text 	name='Color51' size=12 maxlength=30  class = "body" value = "<%=Color51 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					2:<input type=text 	name='Color2' size=13 maxlength=30  class = "body" value = "<%=Color2%>">
				</td>
				<td class = "body">
					27:<input type=text 	name='Color27' size=12 maxlength=30  class = "body" value = "<%=Color27 %>">
				</td>
				<td class = "body">
					52:<input type=text 	name='Color52' size=12 maxlength=30  class = "body" value = "<%=Color52 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					3:<input type=text 	name='Color3' size=13 maxlength=30  class = "body" value = "<%=Color3 %>">
				</td>
				<td class = "body">
					28:<input type=text 	name='Color28' size=12 maxlength=30  class = "body" value = "<%=Color28 %>">
				</td>
				<td class = "body">
					53:<input type=text 	name='Color53' size=12 maxlength=30  class = "body" value = "<%=Color53 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					4:<input type=text 	name='Color4' size=13 maxlength=30  class = "body" value = "<%=Color4 %>">
				</td>
				<td class = "body">
					29:<input type=text 	name='Color29' size=12 maxlength=30  class = "body" value = "<%=Color29 %>">
				</td>
				<td class = "body">
					54:<input type=text 	name='Color54' size=12 maxlength=30  class = "body" value = "<%=Color54 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					5:<input type=text 	name='Color5' size=13 maxlength=30  class = "body" value = "<%=Color5 %>">
				</td>
				<td class = "body">
					30:<input type=text 	name='Color30' size=12 maxlength=30  class = "body" value = "<%=Color30 %>">
				</td>
				<td class = "body">
					55:<input type=text 	name='Color55' size=12 maxlength=30  class = "body" value = "<%=Color55 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					6:<input type=text 	name='Color6' size=13 maxlength=30  class = "body" value = "<%=Color6 %>">
				</td>
				<td class = "body">
					31:<input type=text 	name='Color31' size=12 maxlength=30  class = "body" value = "<%=Color31 %>">
				</td>
				<td class = "body">
					56:<input type=text 	name='Color56' size=12 maxlength=30  class = "body" value = "<%=Color56 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					7:<input type=text 	name='Color7' size=13 maxlength=30  class = "body" value = "<%=Color7 %>">
				</td>
				<td class = "body">
					32:<input type=text 	name='Color32' size=12 maxlength=30  class = "body" value = "<%=Color32 %>">
				</td>
				<td class = "body">
					57:<input type=text 	name='Color57' size=12 maxlength=30  class = "body" value = "<%=Color57 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					8:<input type=text 	name='Color8' size=13 maxlength=30  class = "body" value = "<%=Color8 %>">
				</td>
				<td class = "body">
					33:<input type=text 	name='Color33' size=12 maxlength=30  class = "body" value = "<%=Color33 %>">
				</td>
				<td class = "body">
					58:<input type=text 	name='Color58' size=12 maxlength=30  class = "body" value = "<%=Color58 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					9:<input type=text 	name='Color9' size=13 maxlength=30  class = "body" value = "<%=Color9 %>">
				</td>
				<td class = "body">
					34:<input type=text 	name='Color34' size=12 maxlength=30  class = "body" value = "<%=Color34 %>">
				</td>
				<td class = "body">
					59:<input type=text 	name='Color59' size=12 maxlength=30  class = "body" value = "<%=Color59 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<input type=text 	name='Color10' size=12 maxlength=30  class = "body" value = "<%=Color10 %>">
				</td>
				<td class = "body">
					35:<input type=text 	name='Color35' size=12 maxlength=30  class = "body" value = "<%=Color35 %>">
				</td>
				<td class = "body">
					60:<input type=text 	name='Color60' size=12 maxlength=30  class = "body" value = "<%=Color60 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					11:<input type=text 	name='Color11' size=12 maxlength=30  class = "body" value = "<%=Color11 %>">
				</td>
				<td class = "body">
					36:<input type=text 	name='Color36' size=12 maxlength=30  class = "body" value = "<%=Color36 %>">
				</td>
				<td class = "body">
					61:<input type=text 	name='Color61' size=12 maxlength=30  class = "body" value = "<%=Color61 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					12:<input type=text 	name='Color12' size=12 maxlength=30  class = "body" value = "<%=Color12 %>">
				</td>
				<td class = "body">
					37:<input type=text 	name='Color37' size=12 maxlength=30  class = "body" value = "<%=Color37 %>">
				</td>
				<td class = "body">
					62:<input type=text 	name='Color62' size=12 maxlength=30  class = "body" value = "<%=Color62 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					13:<input type=text 	name='Color13' size=12 maxlength=30  class = "body" value = "<%=Color13 %>">
				</td>
				<td class = "body">
					38:<input type=text 	name='Color38' size=12 maxlength=30  class = "body" value = "<%=Color38 %>">
				</td>
				<td class = "body">
					63:<input type=text 	name='Color63' size=12 maxlength=30  class = "body" value = "<%=Color63 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					14:<input type=text 	name='Color14' size=12 maxlength=30  class = "body" value = "<%=Color14 %>">
				</td>
				<td class = "body">
					39:<input type=text 	name='Color39' size=12 maxlength=30  class = "body" value = "<%=Color39 %>">
				</td>
				<td class = "body">
					64:<input type=text 	name='Color64' size=12 maxlength=30  class = "body" value = "<%=Color64 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					15:<input type=text 	name='Color15' size=12 maxlength=30  class = "body" value = "<%=Color15 %>">
				</td>
				<td class = "body">
					40:<input type=text 	name='Color40' size=12 maxlength=30  class = "body" value = "<%=Color40 %>">
				</td>
				<td class = "body">
					65:<input type=text 	name='Color65' size=12 maxlength=30  class = "body" value = "<%=Color65 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					16:<input type=text 	name='Color16' size=12 maxlength=30  class = "body" value = "<%=Color16 %>">
				</td>
				<td class = "body">
					41:<input type=text 	name='Color41' size=12 maxlength=30  class = "body" value = "<%=Color41 %>">
				</td>
				<td class = "body">
					66:<input type=text 	name='Color66' size=12 maxlength=30  class = "body" value = "<%=Color66 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					17:<input type=text 	name='Color17' size=12 maxlength=30  class = "body" value = "<%=Color17 %>">
				</td>
				<td class = "body">
					42:<input type=text 	name='Color42' size=12 maxlength=30  class = "body" value = "<%=Color42 %>">
				</td>
				<td class = "body">
					67:<input type=text 	name='Color67' size=12 maxlength=30  class = "body" value = "<%=Color67 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					18:<input type=text 	name='Color18' size=12 maxlength=30  class = "body" value = "<%=Color18 %>">
				</td>
				<td class = "body">
					43:<input type=text 	name='Color43' size=12 maxlength=30  class = "body" value = "<%=Color43 %>">
				</td>
				<td class = "body">
					68:<input type=text 	name='Color68' size=12 maxlength=30  class = "body" value = "<%=Color68 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					19:<input type=text 	name='Color19' size=12 maxlength=30  class = "body" value = "<%=Color19 %>">
				</td>
				<td class = "body">
					44:<input type=text 	name='Color44' size=12 maxlength=30  class = "body" value = "<%=Color44 %>">
				</td>
				<td class = "body">
					69:<input type=text 	name='Color69' size=12 maxlength=30  class = "body" value = "<%=Color69 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					20:<input type=text 	name='Color20' size=12 maxlength=30  class = "body" value = "<%=Color20 %>">
				</td>
				<td class = "body">
					45:<input type=text 	name='Color45' size=12 maxlength=30  class = "body" value = "<%=Color45 %>">
				</td>
				<td class = "body">
					70:<input type=text 	name='Color70' size=12 maxlength=30  class = "body" value = "<%=Color70 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					21:<input type=text 	name='Color21' size=12 maxlength=30  class = "body" value = "<%=Color21 %>">
				</td>
				<td class = "body">
					46:<input type=text 	name='Color46' size=12 maxlength=30  class = "body" value = "<%=Color46 %>">
				</td>
				<td class = "body">
					71:<input type=text 	name='Color71' size=12 maxlength=30  class = "body" value = "<%=Color71 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					22:<input type=text 	name='Color22' size=12 maxlength=30  class = "body" value = "<%=Color22 %>">
				</td>
				<td class = "body">
					47:<input type=text 	name='Color47' size=12 maxlength=30  class = "body" value = "<%=Color47 %>">
				</td>
				<td class = "body">
					72:<input type=text 	name='Color72' size=12 maxlength=30  class = "body" value = "<%=Color72 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					23:<input type=text 	name='Color23' size=12 maxlength=30  class = "body" value = "<%=Color23 %>">
				</td>
				<td class = "body">
					48:<input type=text 	name='Color48' size=12 maxlength=30  class = "body" value = "<%=Color48 %>">
				</td>
				<td class = "body">
					73:<input type=text 	name='Color73' size=12 maxlength=30  class = "body" value = "<%=Color73 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					24:<input type=text 	name='Color24' size=12 maxlength=30  class = "body" value = "<%=Color24 %>">
				</td>
				<td class = "body">
					49:<input type=text 	name='Color49' size=12 maxlength=30  class = "body" value = "<%=Color49 %>">
				</td>
				<td class = "body">
					74:<input type=text 	name='Color74' size=12 maxlength=30  class = "body" value = "<%=Color74 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					25:<input type=text 	name='Color25' size=12 maxlength=30  class = "body" value = "<%=Color25 %>">
				</td>
				<td class = "body">
					50:<input type=text 	name='Color50' size=12 maxlength=30  class = "body" value = "<%=Color50 %>">
				</td>
				<td class = "body">
					75:<input type=text 	name='Color75' size=12 maxlength=30  class = "body" value = "<%=Color75 %>">
				</td>
			</tr>
			</table>
			

 	</td>
</tr>
<tr>
		<td  colspan = "3" align = "center" valign = "middle" class = "body" >
			<input type=submit value = "Submit"  size = "310" class = "body" >
		</td>
</tr>
</table>	</form>
 </td>
</tr>
<table>

<br><br><br>
