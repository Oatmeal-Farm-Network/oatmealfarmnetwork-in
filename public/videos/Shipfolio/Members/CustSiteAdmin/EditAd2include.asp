

<% 
ProdID=request.form("ProdID") 
'response.write(ProdID)
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

sql = "select * from sfProducts where sfProducts.ProdID = " & ProdID & ";" 
'response.write(sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
	
CurrentCategoryID  = rs("prodCategoryId")
SubCurrentCategoryID  = rs("prodSubCategoryId")
currentsubcatid  = rs("prodSubCategoryId")
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




	
ProdWeight =rs("ProdWeight")
ProdQuantityAvailable  = rs("ProdQuantityAvailable")
prodImageLargePath  = rs("prodImageLargePath")
ProdDescription = rs("ProdDescription")
ProdSellStore =request.form("ProdSellStore")
ProdForSale = rs("ProdForSale")


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
SubCatCounter2 = -1
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
		Varieties  = Varieties & """"  & CatName(CatCounter,SubCatCounter)  
		
		rs.movenext
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
		<td class = "body" valign = "top"  ><h1>Edit Your Product- Step 2: Make Changes 
<a name="Add"></a>
			<img src = "images/underline.jpg" width = "600"></h1>
			To make your changes, edit your text  in the boxes below and then select the "submit" changes button.
		</td>
	</tr>
</table>


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


				

<form action="EditAd2.asp" method = "post">
		<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"    width = "650" bgcolor = "antiquewhite" align = "center">
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

<form action= 'Editad3.asp' method = "post" name="myform">
<input name="Subject" type = "hidden" value = "<%=Subject%>">
<input name="ProdID" type = "hidden" value = "<%=ProdID%>">
<input name="AdType" type = "hidden" value = "<%=AdType%>">


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "800">


		<tr>
			<td  class = "body" align = "right" width = "500" valign = "top">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "500">
	
		<tr>
<td  class = "body" align = "right">
	Item Name:
</td>
<td>&nbsp;</td>
<td>
	<input name="ProdName" value="<%=ProdName %>" size = "50">
</td>
<tr><tr>
			<td  class = "body" align = "right" >
			Category:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			<div>

<div>

<select name="box1" onchange="Box2(this.selectedIndex)">
    <% 
	CatCounter = 0 %>
		<option value="<%=CurrentCategoryID%>"><%=CurrentCategoryName%></option>
	<%	While   CatCounter  < FinalCatCounter 
		CatCounter = CatCounter+ 1 %>
		<option value="<%=CategoryID(CatCounter,0)%>"><%=CatName(CatCounter,0)%></option>
	<% Wend %>
</select>

<select name="box2" onchange="Box2IDpick(this.selectedIndex)">	</select>
</div>
	<input name="box2ID" size = "30" value = "<%=currentsubcatid%>" type = "hidden">
</div>

	
		</td>
	</tr>

	
	<td  class = "body" align = "right" >
			Price:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
			$<input name="ProdPrice" value="<%=formatnumber(ProdPrice ,2)%>" size = "20"><i>Must be a number.</i>
		</td>
	</tr>
		<tr>
	<td  class = "body" align = "right" >
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
	<tr>
	<td  class = "body" align = "right" valign = "top">
			Weight:
		</td>
		<td>&nbsp;</td>
		<td class = "body">
		<input type=text onBlur="checkNumeric(this,-5,5000,',','.','-');"
	name='prodweight' size=10 maxlength=10 value = "<%=Prodweight %>"> lbs <br>
	<i>Must be a number. <br>
	Round to the pound.<br>
	Necessary to determine shipping costs.</i><br>
			<br>
		</td>
	</tr>	
<% If CurrentCategoryName = "Clothing" Then %>
	<tr>
	<td></td>
	<td  class = "body" align = "left" colspan = "2">
	    <table>
			<tr>
				<td class = "body">
					Size 1:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize1' size=20 maxlength=60 value = "<%=ProdSize1 %>">
				</td>
				<td class = "body">
					Size 6:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize6' size=20 maxlength=60 value = "<%=ProdSize6 %>">
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 2:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize2' size=20 maxlength=60 value = "<%=ProdSize2 %>">
				</td>
				<td class = "body">
					Size 7:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize7' size=20 maxlength=60 value = "<%=ProdSize7 %>">
				</td>
			</tr>

	<tr>
				<td class = "body">
					Size 3:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize3' size=20 maxlength=60 value = "<%=ProdSize3 %>">
				</td>
				<td class = "body">
					Size 8:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize8' size=20 maxlength=60 value = "<%=ProdSize8 %>" >
				</td>
			</tr>
			<tr>
				<td class = "body">
					Size 4:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize4' size=20 maxlength=60 value = "<%=ProdSize4 %>">
				</td>
				<td class = "body">
					Size  9:
				</td>
				<td>&nbsp;</td>
				<td>
							<input type=text 	name='ProdSize9' size=20 maxlength=60 value = "<%=ProdSize9 %>" >
				</td>
			</tr>
				<tr>
				<td class = "body">
					Size 5:
				</td>
				<td>&nbsp;</td>
				<td>
					<input type=text 	name='ProdSize5' size=20 maxlength=60 value = "<%=ProdSize5 %>">
				</td>
				<td class = "body">
					Size  10:
				</td>
				<td>&nbsp;</td>
				<td>
							<input type=text 	name='ProdSize10' size=20 maxlength=60 value = "<%=ProdSize10 %>" >
				</td>
			</tr>
			</table>
			
		</td>
	</tr>
	<% Else %>
	<tr>
	<td  class = "body" align = "right" >
			Dimensions:
		</td>
		<td>&nbsp;</td>
		<td>
		<% str1 = ProdDimensions
str2 = "''"
If InStr(str1,str2) > 0 Then
	ProdDimensions= Replace(str1, "''", "'")
End If

str1 = ProdDimensions
str2 = Chr(34)
If InStr(str1,str2) > 0 Then
	ProdDimensions= Replace(str1, Chr(34), "''")
End If %>
		<input type=text 	name='ProdDimensions' size=40 maxlength=60 value = "<%=ProdDimensions %>">
			
		</td>
	</tr>
	<% End If %>
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

		<textarea name="ProdDescription"  cols="60" rows="30"  onKeyDown="textCounter(this.form.ProdDescription,this.form.remLentext,1000);" onKeyUp="textCounter(this.form.ProdDescription,this.form.remLentext,1000);" ><%=ProdDescription%></textarea>
		<br>Characters remaining: <input type=box readonly name=remLentext size=3 value=1000>
		</td>
	</tr>


</table>
 </td>
  <td width = "130" class = "body" valign = "top">

	    <table border = "1">
		<tr>
				<td class = "body" bgcolor = "antiquewhite" align = "center" colspan = "3">
					<b>Colors</b>
				</td>
			</tr>
			<tr>
				<td class = "body">
					1:<input type=text 	name='Color1' size=13 maxlength=20 class = "body" value = "<%=Color1 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					2:<input type=text 	name='Color2' size=13 maxlength=20 class = "body" value = "<%=Color2%>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					3:<input type=text 	name='Color3' size=13 maxlength=20 class = "body" value = "<%=Color3 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					4:<input type=text 	name='Color4' size=13 maxlength=20 class = "body" value = "<%=Color4 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					5:<input type=text 	name='Color5' size=13 maxlength=20 class = "body" value = "<%=Color5 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					6:<input type=text 	name='Color6' size=13 maxlength=20 class = "body" value = "<%=Color6 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					7:<input type=text 	name='Color7' size=13 maxlength=20 class = "body" value = "<%=Color7 %>">
				</td>
			</tr>
			<tr>
				<td class = "body">
					8:<input type=text 	name='Color8' size=13 maxlength=20 class = "body" value = "<%=Color8 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					9:<input type=text 	name='Color9' size=13 maxlength=20 class = "body" value = "<%=Color9 %>">
				</td>
			</tr>
				<tr>
				<td class = "body">
					10:<input type=text 	name='Color10' size=12 maxlength=20 class = "body" value = "<%=Color10 %>">
				</td>
			</tr>
</table>
			


 	</td>
</tr>
<tr>
		<td  colspan = "3" align = "center" valign = "middle" class = "body" bgcolor = "antiquewhite">
			<input type=submit value = "Submit"  size = "310" class = "body" >
		</td>
</tr>
</table>	</form>
 
<br><br><br>
