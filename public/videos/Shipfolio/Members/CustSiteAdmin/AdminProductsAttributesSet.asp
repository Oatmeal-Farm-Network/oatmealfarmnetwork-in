<%@ Language="VBScript" %> 
<!DOCTYPE HTML>
<HTML>
<HEAD>
<!--#Include File="AdminGlobalVariables.asp"--> 
</HEAD>
<%
if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
 <!--#Include File="AdminHeader.asp"--> 
 <br>
 <% Current3 = "ProductAttributes"  %>
 <% TempCategoryType="For Sale" %>
 <%

 Set rs2 = Server.CreateObject("ADODB.Recordset")
 Dim AvailableCatIDArray(999)
Dim AvailableCatNameArray(999)
sql = "select CatID, CatName from SFCategories order by CatName Desc"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
i = 0
while not rs.eof
i = i + 1
AvailableCatIDArray(i) = rs("catID")
AvailableCatNameArray(i) = rs("CatName")
rs.movenext
wend
rs.close

Dim attrIDArray(9999)
Dim attrNameArray(9999)
Dim attrDisplayOrderArray(9999)
Dim attrControltypeArray(9999)
Dim attrRequiredArray(9999)
Dim attrAvailableToAllProdsArray(9999)
Dim attrCatagoryIdArray(9999)
Dim attrExtraCostAllowedArray(9999)

 if mobiledevice = False  then %> 
<!--#Include file="AdminProductsTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 35 %>"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Product Attributes </div></H2>
</td></tr>
<tr><td class = "roundedBottom" align = "center" height = "300" width = "100%"  valign = "top">
 <table width = "100%">
     <tr> 
     <% if screenwidth < 1000 then %>
<td width = "450" valign = "top" align = "left">
      <% else %>
   <td width = "100%" valign = "top" align = "left">
      <% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" class = "roundedtopandbottom"><tr><td  colspan = "7" align = "left">
<H2><div align = "left">Current Product Attribute </div></H2>
</td></tr>
<tr><td class = "body" align = "left" valign = "top" colspan = "7">
To change Product Attribute, change the title names and select the corresponding submit button.
<% Changesmade = request.querystring("ChangesMade")
if ChangesMade="True" then%>
<br><br><font color = "maroon"><b>Your Changes Have Been Made.</b></font>
<% end if  %>
</td>

<% sql = "select * from sfattributes "
response.write("sql=" & sql)


Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
Counter= 0
if not rs.eof then %>
 </tr>
 <form action= 'AdminProductAttributeCategoryEdit.asp' method = "post" style="margin-bottom:0;" >
 <tr><td colspan = "7">
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</td>
</tr>
<tr>
<td class = "body" align = "center" ><a class="tooltip" href="#" ><b>Name:</b><span class="custom info">This is the value that shows up on your product page (i.e. Color or Size).<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Extra Cost?</b><span class="custom info"><div align = "left">Does this attribute have an extra cost associated with it. I.e. extra-large sizes might be an extra $5.00.</div><br /></span></a></td></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Control Type</b><span class="custom info"><div align = "left">How should this be displayed? I.e. Sizes should be shown as a dropdown but image squares might be the right option for colors.</div><br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Required?</b><span class="custom info"><div align = "left">Does the user have to select this or is it optional?</div><br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>All Products?</b><span class="custom info"><div align = "left">Should this apply to all products or just one category? For instance, size might only apply to clothing.</div><br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Category</b><span class="custom info"><div align = "left">This option is only available if  <b>All Products</b> is set to no . This lists the specific category of products that this attribute applies to.</div><br /></span></a></td>
<td class = "body2" align = "center" width = "100" align = "center"><a class="tooltip" href="#"><b>Display Order</b><span class="custom info"><div align = "left">Define the order that attributes will show up on product pages.</div><br /></span></a></td>
</tr>
<% 
While Not rs.eof 
Counter = Counter + 1
attrNameArray(Counter) = rs("attrName")

attrIDArray(Counter) = rs("attrID")

attrDisplayOrderArray(Counter) = rs("attrDisplayOrder")
attrControltypeArray(Counter) = rs("attrControltype")
attrRequiredArray(Counter) = rs("attrRequired")
attrAvailableToAllProdsArray(Counter) = rs("attrAvailableToAllProds")
attrCatagoryIdArray(Counter) = rs("attrCatagoryId")
attrExtraCostAllowedArray(Counter) = rs("attrExtraCostAllowed")
rs.movenext
Wend
FinalCounter = Counter

Counter= 0
SubCounter2 = 0
While Counter < FinalCounter
Counter= Counter +1 %>
<tr><td> 
<input name="attrID(<%=Counter%>)" value ="<%= attrIDArray(Counter) %>"  type = "hidden">
<input name="attrName(<%=Counter%>)" value ="<%= attrNameArray(Counter) %>"  size = "20" type = "text">
</td>
<td class = "body2" align = "center"> 
<% if  attrExtraCostAllowedArray(Counter)= "Yes" Or  attrExtraCostAllowedArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = True >
No<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = False checked>
<% End if%>
</td>
<td class = "body2" align = "center"> 

<select size="1" name="attrControltype(<%=Counter%>)">	
<% if len(attrControltypeArray(Counter)) > 0 then  %>
<option  value= "<%=attrControltypeArray(Counter) %>" ><%=attrControltypeArray(Counter) %></option>
<% end if %>
<option  value= "Drop-Down List" >Drop-Down List</option>
<option  value= "Checkbox" >Checkbox</option>
<option  value= "Textbox" >Textbox</option>
<option  value= "Images Squares" >Images Squares</option>
</select>
</td>
<td class = "body2" align = "center"> 
<% if attrControltypeArray(Counter)= "Yes" Or  attrControltypeArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrRequired(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrRequired(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrRequired(<%=Counter%>)"" Value = True >
No<input TYPE="RADIO" name="attrRequired(<%=Counter%>)"" Value = False checked>
<% End if%>
</td>
<td class = "body2" align = "center"> 
<% if attrAvailableToAllProdsArray(Counter)= "Yes" Or  attrAvailableToAllProdsArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)"" Value = True >
No<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)"" Value = False checked>
<% End if%>
</td>
<td class= "body2" align = "center"> 
<%
 if attrAvailableToAllProdsArray(Counter)= "Yes" Or  attrAvailableToAllProdsArray(Counter)= True Then %>
N/A
<% else %>

<select size="1" name="attrCatagoryId(<%=Counter%>)">	

<%
if len(attrCatagoryIdArray(Counter)) > 0 then 
sql2 = "select CatName from SFCategories where catID = " & attrCatagoryIdArray(Counter)
if rs2.state = 0 then
else
rs2.close
end if

rs2.Open sql2, conn, 3, 3 
if not rs2.eof then
catName = rs2("catName")
end if
%>


<option  value= "<%= attrCatagoryIdArray(Counter) %>" selected><%= catName%></option>
<% else %>
<option  value= "0" selected>N/A</option>
<% end if %>
<%	PGCounter = 0 
While PGCounter < i 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= AvailableCatIDArray(PGCounter)%>"><%=AvailableCatNameArray(PGCounter) %></option>
<% 
'end if
Wend %>
</select>
<% end if %>
</td>
<td class = "body2" align = "center">
<select size="1" name="attrDisplayOrder(<%=Counter%>)">	
<option  value= "<%= Counter %>" selected><%= Counter%></option>
<%	PGCounter = 0 
While PGCounter < (FinalCounter ) 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= PGCounter-1%>"><%= PGCounter%></option>
<% 
'end if
Wend %>
</select>
</td></tr>
<% 
wend
%>
<tr><td colspan = "7">
<input name="TotalCount" value ="<%=PGCounter %>"  type="hidden">

	<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</form>
</td>
</tr>
<% else %>
<tr><td class = "body2" align = "center"><br /><b>Currently there are not attribute  defined.</b></td></tr>
<% end if %>
</table>
		
</td>
<%if screenwidth < 1000 then %>
 </tr>
 <tr>      
<% end if %>
<% if mobiledevice = False then %> 
<%if screenwidth < 1000 then %>
  <td width = "100%" valign = "top" >
  <% else %>
   <td width = "450" valign = "top">
  <% end if %>
  <br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td class = "roundedtop" align = "left">
<% else %>
 <td width = "100%" valign = "top">
<br>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">

<% end if %>

<H2><div align = "left">Add a Product Attribute</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center" height = "110" width = "430"valign = "top">
 		<br>
			<form action= 'AdminAttributeAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
                 <tr>
<td class = "body" ><a class="tooltip" href="#" ><b>Name:</b><span class="custom info">This is the value that shows up on your product page (i.e. Color or Size).<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Extra Cost?</b><span class="custom info">Does this attribute have an extra cost associated with it. I.e. extra-large sizes might be an extra $5.00.<br /></span></a></td></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Control Type</b><span class="custom info">How should this be displayed? I.e. Sizes should be shown as a dropdown but image squares might be the right option for colors. <br /></span></a></td>
<td class = "body2" align = "center" width = "110"><a class="tooltip" href="#"><b>Required?</b><span class="custom info">Does the user have to select this or is it optional?<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>All Products?</b><span class="custom info">Should this apply to all products or just one category? For instance, size might only apply to clothing.<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Category</b><span class="custom info">This option is only available if  <b>All Products</b> is set to no . This lists the specific category of products that this attribute applies to.<br /></span></a></td>
<tr><td class = "body" >  
<input name="attrName" value =""  size = "20" type = "text">
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrExtraCostAllowed" Value = "Yes" >
No<input TYPE="RADIO" name="attrExtraCostAllowed" Value = "No" checked>
</td>
<td class = "body" >  
<select size="1" name="attrControltype">	
<option  value= "Drop-Down List" >Drop-Down List</option>
<option  value= "Checkbox" >Checkbox</option>
<option  value= "Textbox" >Textbox</option>
<option  value= "Images Squares" >Images Squares</option>
</select>
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrRequired" Value = "Yes" >
No<input TYPE="RADIO" name="attrRequired" Value = "No" checked>
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrAvailableToAllProds" Value = "Yes" >
No<input TYPE="RADIO" name="attrAvailableToAllProds" Value = "No" checked>
</td>
<td class = "body" >  
<select size="1" name="attrCatagoryId">	
<option  value= "<%= Counter %>" selected></option>
<%	PGCounter = 0 
While PGCounter < (i) 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= AvailableCatIDArray(PGCounter)%>"><%=AvailableCatNameArray(PGCounter) %></option>
<% 
'end if
Wend %>
		</select>
   </td>
</tr>
</tr>
<tr><td  align = "center" valign = "middle" colspan = "6" >
<center><input type=submit value = "Add Attribute"  size = "110" class = "regsubmit2"  ></center>
</td></tr></table>
</form>
</td>
</tr>
</table>
<br />
  <% if mobiledevice = False  then %> 
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  ><tr><td class = "roundedtop" align = "left">
  <% else %>
  <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  ><tr><td align = "left">
  
  <% end if %>

		<H2><div align = "left">Delete a Product Attribute</div></H2>
</td></tr>
<tr><td class = "roundedBottom body" align = "center"  valign = "top" width = "430">

<h1><center>Warning! </center></h1>
When you delete an attribute you will loose all data associated with it! Even if you create a new attribute with the same name, the old data will not automatically be reassigned!<br><br>

<form action= 'AdminProductattributesDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body2" align = "right">
							Attribute:
					</td>
					<td class = "body" >
							<select size="1" name="attrID">	
							<option  value= "" selected>select an attribute</option>
						<%	x = 0 
								While x < Counter
								x = x +1 
						%>
								 <option  value="<%= attrIDArray(x) %>"><%= attrNameArray(x) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category"  size = "110" class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>

</td>
   </tr>
</table>


</td></tr></table>
  </td></tr></table>      



</td>
</tr>
</table>
  <% else %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H2><div align = "left">Product Attributes</div></H2>
</td></tr>
<tr><td align = "center" height = "300" width = "100%"  valign = "top">
 <table width = "100%">
     <tr> 
     <% if screenwidth < 1000 then %>
<td width = "450" valign = "top" align = "left">
      <% else %>
   <td width = "100%" valign = "top" align = "left">
      <% end if %>

<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" ><tr><td  colspan = "7" align = "left">
<H2><div align = "left">Current Product Attributes</div></H2>
</td></tr>
<tr><td class = "body" align = "left" valign = "top" colspan = "7">
To change Product Attributes, change the title names and select the corresponding submit button.
<% Changesmade = request.querystring("ChangesMade")
if ChangesMade="True" then%>
<br><br><font color = "maroon"><b>Your Changes Have Been Made.</b></font>
<% end if  %>

 </td>
 </tr>
 <form action= 'AdminProductAttributeCategoryEdit.asp' method = "post" style="margin-bottom:0;" >
 <tr><td colspan = "7">
<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</td>
</tr>
 <tr>
<td class = "body" align = "center" ><a class="tooltip" href="#" ><b>Name:</b><span class="custom info">This is the value that shows up on your product page (i.e. Color or Size).<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Extra Cost?</b><span class="custom info">Does this attribute have an extra cost associated with it. I.e. extra-large sizes might be an extra $5.00.<br /></span></a></td></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Control Type</b><span class="custom info">How should this be displayed? I.e. Sizes should be shown as a dropdown but image squares might be the right option for colors. <br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Required?</b><span class="custom info">Does the user have to select this or is it optional?<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>All Products?</b><span class="custom info">Should this apply to all products or just one category? For instance, size might only apply to clothing.<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Category</b><span class="custom info">This option is only available if  <b>All Products</b> is set to no . This lists the specific category of products that this attribute applies to.<br /></span></a></td>
<td class = "body2" align = "center" width = "100" align = "center"><a class="tooltip" href="#"><b>Display Order</b><span class="custom info">Define the order that attributes will show up on product pages.<br /></span></a></td>
</tr>
<% 
sql = "select * from sfattributes order by attrDisplayOrder " 
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
Counter= 0
While Not rs.eof 
Counter = Counter + 1
attrIDArray(Counter) = rs("attrID")
attrNameArray(Counter) = rs("attrName")
attrDisplayOrderArray(Counter) = rs("attrDisplayOrder")
attrControltypeArray(Counter) = rs("attrControltype")
attrRequiredArray(Counter) = rs("attrRequired")
attrAvailableToAllProdsArray(Counter) = rs("attrAvailableToAllProds")
attrCatagoryIdArray(Counter) = rs("attrCatagoryId")
attrExtraCostAllowedArray(Counter) = rs("attrExtraCostAllowed")
rs.movenext
Wend
FinalCounter = Counter

Counter= 0
SubCounter2 = 0
While Counter < FinalCounter
Counter= Counter +1 %>
<tr><td> 
<input name="attrID(<%=Counter%>)" value ="<%= attrIDArray(Counter) %>"  type = "hidden">
<input name="attrName(<%=Counter%>)" value ="<%= attrNameArray(Counter) %>"  size = "20" type = "text">
</td>
<td class = "body2" align = "center"> 
<% if  attrExtraCostAllowedArray(Counter)= "Yes" Or  attrExtraCostAllowedArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = True >
No<input TYPE="RADIO" name="attrExtraCostAllowed(<%=Counter%>)" Value = False checked>
<% End if%>
</td>
<td class = "body2" align = "center"> 

<select size="1" name="attrControltype(<%=Counter%>)">	
<% if len(attrControltypeArray(Counter)) > 0 then  %>
<option  value= "<%=attrControltypeArray(Counter) %>" ><%=attrControltypeArray(Counter) %></option>
<% end if %>
<option  value= "Drop-Down List" >Drop-Down List</option>
<option  value= "Checkbox" >Checkbox</option>
<option  value= "Textbox" >Textbox</option>
<option  value= "Images Squares" >Images Squares</option>
</select>
</td>
<td class = "body2" align = "center"> 
<% if attrControltypeArray(Counter)= "Yes" Or  attrControltypeArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrRequired(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrRequired(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrRequired(<%=Counter%>)"" Value = True >
No<input TYPE="RADIO" name="attrRequired(<%=Counter%>)"" Value = False checked>
<% End if%>
</td>
<td class = "body2" align = "center"> 
<% if attrAvailableToAllProdsArray(Counter)= "Yes" Or  attrAvailableToAllProdsArray(Counter)= True Then %>
Yes<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)" Value = True checked>
No<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)" Value = False >
<% Else %>
Yes<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)"" Value = True >
No<input TYPE="RADIO" name="attrAvailableToAllProds(<%=Counter%>)"" Value = False checked>
<% End if%>
</td>
<td class= "body2" align = "center"> 
<%
 if attrAvailableToAllProdsArray(Counter)= "Yes" Or  attrAvailableToAllProdsArray(Counter)= True Then %>
N/A
<% else %>

<% response.write("attrCatagoryIdArray(Counter)=" & attrCatagoryIdArray(Counter) ) %>
<select size="1" name="attrCatagoryId(<%=Counter%>)">	

<% if len(attrCatagoryIdArray(Counter)) > 0 then 
sql2 = "select CatName from SFCategories where catID = " & attrCatagoryIdArray(Counter)
response.write("sql2=" & sql2)
rs2.Open sql2, conn, 3, 3 
if rs2.eof then
catName = rs2("catName")
end if
%>
<option  value= "<%= attrCatagoryIdArray(Counter) %>" selected><%= catName%></option>
<% else %>
<option  value= "0" selected>N/A</option>
<% end if %>
<%	PGCounter = 0 
While PGCounter < i 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= AvailableCatIDArray(PGCounter)%>"><%=AvailableCatNameArray(PGCounter) %></option>
<% 
'end if
Wend %>
</select>
<% end if %>
</td>
<td class = "body2" align = "center">
<select size="1" name="attrDisplayOrder(<%=Counter%>)">	
<option  value= "<%= Counter %>" selected><%= Counter%></option>
<%	PGCounter = 0 
While PGCounter < (FinalCounter ) 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= PGCounter-1%>"><%= PGCounter%></option>
<% 
'end if
Wend %>
</select>
</td></tr>
<% 
wend
%>
<tr><td colspan = "7">
<input name="TotalCount" value ="<%=PGCounter %>"  type="hidden">

	<div align = "right"><input type=submit value = "Submit"  class = "regsubmit2" ></div>
</form>
</td>
</tr>
</table>
		
</td>
 </tr>
 <tr>      
 
 <td width = "100%" valign = "top">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td align = "left">
		<H2><div align = "left">Add a Product Attribute</div></H2>
</td></tr>
<tr><td class = "body" align = "center" height = "110" width = "430"valign = "top">
 		<br>
			<form action= 'AdminAttributeAddHandleform.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
                 <tr>
<td class = "body" ><a class="tooltip" href="#" ><b>Name:</b><span class="custom info">This is the value that shows up on your product page (i.e. Color or Size).<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Extra Cost?</b><span class="custom info">Does this attribute have an extra cost associated with it. I.e. extra-large sizes might be an extra $5.00.<br /></span></a></td></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Control Type</b><span class="custom info">How should this be displayed? I.e. Sizes should be shown as a dropdown but image squares might be the right option for colors. <br /></span></a></td>
<td class = "body2" align = "center" width = "110"><a class="tooltip" href="#"><b>Required?</b><span class="custom info">Does the user have to select this or is it optional?<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>All Products?</b><span class="custom info">Should this apply to all products or just one category? For instance, size might only apply to clothing.<br /></span></a></td>
<td class = "body2" align = "center" width = "100"><a class="tooltip" href="#"><b>Category</b><span class="custom info">This option is only available if  <b>All Products</b> is set to no . This lists the specific category of products that this attribute applies to.<br /></span></a></td>
<tr><td class = "body" >  
<input name="attrName" value =""  size = "20" type = "text">
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrExtraCostAllowed" Value = "Yes" >
No<input TYPE="RADIO" name="attrExtraCostAllowed" Value = "No" checked>
</td>
<td class = "body" >  
<select size="1" name="attrControltype">	
<option  value= "Drop-Down List" >Drop-Down List</option>
<option  value= "Checkbox" >Checkbox</option>
<option  value= "Textbox" >Textbox</option>
<option  value= "Images Squares" >Images Squares</option>
</select>
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrRequired" Value = "Yes" >
No<input TYPE="RADIO" name="attrRequired" Value = "No" checked>
</td>
<td class = "body2" align = "center"> 
Yes<input TYPE="RADIO" name="attrAvailableToAllProds" Value = "Yes" >
No<input TYPE="RADIO" name="attrAvailableToAllProds" Value = "No" checked>
</td>
<td class = "body" >  
<select size="1" name="attrCatagoryId">	
<option  value= "<%= Counter %>" selected></option>
<%	PGCounter = 0 
While PGCounter < (i) 
PGCounter = PGCounter +1 
'if PGCounter =  ArticleCategoryOrder(Counter,0) then
'else %>
<option  value="<%= AvailableCatIDArray(PGCounter)%>"><%=AvailableCatNameArray(PGCounter) %></option>
<% 
'end if
Wend %>
		</select>
   </td>
</tr>
</tr>
<tr><td  align = "center" valign = "middle" colspan = "6" >
<center><input type=submit value = "Add Attribute"  size = "110" class = "regsubmit2"  ></center>
</td></tr></table>
</form>
</td>
</tr>
</table>
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"  ><tr><td align = "left">
<H2><div align = "left">Delete a Product Attribute</div></H2>
</td></tr>
<tr><td class = " body" align = "center"  valign = "top" width = "430">

<h1><center>Warning! </center></h1>
When you delete an attribute you will loose all data associated with it! Even if you create a new attribute with the same name, the old data will not automatically be reassigned!<br><br>

<form action= 'AdminProductattributesDeleteHandleform.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" >
				
			<tr>
					<td width = "140" class = "body2" align = "right">
							Attribute Category:
					</td>
					<td class = "body" >
							<select size="1" name="attrID">	
							<option  value= "" selected>Select an Attribute Category</option>
						<%	x = 0 
								While x < Counter
								x = x +1 
						%>
								 <option  value="<%= attrIDArray(x) %>"><%= attrNameArray(x) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category"  size = "110" class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>

</td>
   </tr>
</table>


</td></tr></table>
  </td></tr></table>      



</td>
</tr>
</table>
  <% end if %> 
  <br><br>
<br>
<!--#Include file="AdminFooter.asp"--> 
</Body>
</HTML>