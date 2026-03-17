<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="Content-Language" content="en-us">
<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
<title>Andresen Group Content Management System</title>  
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalVariables.asp"-->

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

'response.Write("mobiledevice=" & mobiledevice )
%>	

</HEAD>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% end if %>
    <!--#Include file="AdminHeader.asp"--> 


<% If Request.Querystring("UpdatePages" ) = "True" Then
ShowPages = request.Form("ShowPages")

  		sqlp = "select * from pageLayout "

	 Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sqlp, conn, 3, 3   
			if not rs.eof then
			 Set DataConnection = Server.CreateObject("ADODB.Connection")
            DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
			 while Not rs.eof 
			 PageName = rs("PageName")
			str1 = ShowPages 
			str2 = PageName
			

			If InStr(str1, str2) > 0 or PageName = "Home Page" Then
				Query =  " UPDATE pageLayout Set "
                Query =  Query & " ShowPage = True"
                Query =  Query & " where PageName = '" & PageName & "' ;"
                DataConnection.Execute(Query) 	

	        else
				Query =  " UPDATE pageLayout Set "
                Query =  Query & " ShowPage = False"
                Query =  Query & " where  PageName = '" & PageName & "' ;" 
                DataConnection.Execute(Query) 
			End If  
			
			 rs.movenext
			wend 
			
	DataConnection.Close
	Set DataConnection = Nothing 
		 end if 
end if

sql2 = "select * from SiteDesign"
	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	if Not rs2.eof then 
		AutoTransfer= rs2("AutoTransfer")

end if
			
		rs2.close
		
								
sql2 = "select * from sfCustomers where CustID = 66;" 

'response.write(sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3   
 If Not rs2.eof Then

AIEmail = rs2("AIEmail")
AIPassword = rs2("AIPassword")
End If 
	' End Update Pages 
	

	%>
<% if mobiledevice = False  then %>
<% if screenwidth < 989 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "left" width = "<%=screenwidth  %>">
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth  %>">
<% end if %>
<tr><td class = "roundedtop" align = "left">
<H1>Administration Dashboard</H1></td></tr>
<tr><td class = "roundedBottom" align = "center" >
<% else %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "center" >
<% end if %>
<% if mobiledevice = False and ScreenWidth > 768 then %>
<table border = "0" cellspacing="0" cellpadding = "0"  ><tr>

<td class = "body" valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" >
<tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Log Into Alpaca Infinity</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" class = "body" height = "82">
        <% if mobiledevice = False or SmallMobile = True   then %>
<form action= "http://www.alpacainfinity.com/handleLogin.asp" method = "post" target = "_blank">
<% else %>
<form action= "http://www.alpacainfinity.com/handleLogin.asp" method = "post">
<% end if %>
				<table>
				<tr>
						<td Class = "body" align = "right">
							Email:
						</td>
						<td class = "body" align = "left">	
							<input type=text  name=UID value = "<%=AIEmail%>" SIZE = "36" >
						</td>
						<td rowspan= "2">
						<input type=submit value = "Login"  size = "170" class = "regsubmit2" >
						</td>
					</tr>
					<tr>
						<td Class = "body" align = "right">
							Password:
						</td>
						<td class = "body" align = "left">	
							<input type= password name=password value = "<%=AIPassword%>" SIZE = "12">
						</td>
					</tr>
				</table>
			</form>
</td>
  </tr>
</table>
</td>

<td width = "10"></td>

<td class = "body" valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" >
		<H3><div align = "left">Auto-Transfer to Alpaca Infinity</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" class = "body" height = "82">
<form  action="/Administration/Transfers/setautoupdate.asp" method = "post" name="myform">
	<center><a class="tooltip" href="#"><b>Auto-Transfer:</b><span class="custom info">If the auto-transfer is set on then your animal information will automatically be updated to Alpaca Infinity every time you make changes. <br /><br />
<em>Remember to Publish</em>After you transfer your animals to Alpaca Infinity log into your Alpaca Infinity account to confirm your animals and products are published.</span></a>
	<% if AutoTransfer = "Yes" Or AutoTransfer = True Then %>
			On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" checked>
			Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" >
		<% Else %>
			On<input TYPE="RADIO" name="AutoTransfer" Value = "Yes" >
			Off<input TYPE="RADIO" name="AutoTransfer" Value = "No" checked>
		<% End If %>	<input type=hidden name= "SendingPage" value = "/administration/Default.asp"  >
	<input type=submit value = "Set Auto-Transfer"  size = "310" class = "regsubmit2" ></center>
			</form>
</td>
  </tr>
</table>
</td>
<td width = "10"></td>
<td valign = "top">

<table border = "0" cellspacing="0" cellpadding = "0" align = "right" ><tr><td class = "roundedtop" align = "left">
		<H3><div align = "left">Key</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height ="57">
<table border = "0" cellpadding = "0" cellspacing="0"  align = "right">
 <tr>
 
  <td class = "body" width = "30" align = "right"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></td>
 <td class = "body" width=  "35">Edit</td>
 
   <td class = "body" width = "30" align = "right"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></td>
 <td class = "body" width=  "40" align = "left">Photos</td>
   
    <td></td>

    </tr>
</table><br />
</td>
      </tr>
</table>
</td>
<td width = "13"></td>
      </tr>
      <tr><td colspan = "3" height = "16"></td></tr>
</table>
 <% end if %>  
 	<% if mobiledevice = False  then %> 
<table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<% else %>
<table width = "100%"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
<% end if %>
	<tr>	 
<% if LivestockAvailable = True then %>
 	<% if mobiledevice = False  then 
 	 if ScreenWidth > 768 then%> 
 	 <td width = "50%" valign = "top" class = "body">
 	 <% else %>
 	  	 <td width = "100%" valign = "top" class = "body">
 	  <% end if %>
	 <a name="Animals"></a>
	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td class = "roundedtop" align = "left"><H3>Your Animals</H3></td></tr>
        <tr><td class = "roundedBottom" align = "center"  height = "55">
<% else %>
 <td width = "100%" valign = "top" class = "body">

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%"><tr><td  align = "left"> <a name="Animals"></a><H1>Animals</H1></td></tr>
        <tr><td  align = "center"  height = "55">
<% end if %>

<% sql = "select distinct animals.*, Pricing.* from animals, Pricing  where Animals.ID = Pricing.ID order by FullName"

	'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim ID(40000) 
	dim Name(40000) 
	dim ForSale(40000) 
	dim ARI(40000) 
	dim DOBday(40000) 
	dim DOBMonth(40000) 
	dim DOBYear(40000) 
	dim Color(40000) 
	dim Category(40000) 
	dim Breed(40000) 
	dim CLAA(40000) 
	dim Price(40000)
	dim Discount(40000)
	dim DiscountPrice(40000)

Recordcount = rs.RecordCount +1
%>

<% if rs.eof Then %>
<blockquote>Currently you do not have any animals listed. To add animals please us the <a href = "AdminAnimalAdd1.asp" class = "body"><b>Add an Animal wizard.</b></a></blockquote>
<% else %>
<table border = "0" bordercolor = "#e6e6e6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">


	<% if mobiledevice = False  then %>
	<tr ><td class = "body" align = "center" height = "23" width = "345"><b>Name</b></td>
		<td class = "body" align = "center" width = "100"><b>Options</b></td>	</tr>
	<% else %>
	
 <% end if 
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ID(rowcount) =   rs("ID")
	 Name(rowcount) =   rs("FullName")
	 DOBday(rowcount) =   rs("DOBday")
	 DOBmonth(rowcount) =   rs("DOBmonth")
	 DOByear(rowcount) =   rs("DOByear")
	Category(rowcount) =   rs("Category")
	 Price(rowcount)=   rs("Price")
	Discount(rowcount)=   rs("Discount")
	DiscountPrice(rowcount) = Price(rowcount) - (Price(rowcount) * (Discount(rowcount)/100))

 If row = "even" Then %>
		<tr bgcolor = "white">
<% Else %>

<tr bgcolor = "#e6e6e6">
<%	End If %>
	<% if mobiledevice = False  then %>
<td class = "body"  height = "25" align = "left">&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><%= Name( rowcount)%></a></td>
	
		<td class = "body"   align = "center"><a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><img src= "images/edit.gif" alt = "edit" height = "18" width = "18" border = "0"></a> &nbsp;|
		<a href = "AdminPhotos.asp?ID=<%= ID( rowcount)%>" class = "body"><img src = "images/Photo.gif" height = "18" width = "18" border = "0" alt = "Upload Photos"></a></td>
		
	<%else %>
	<% if SmallMobile = False then %>
	<td class = "body"  height = "55" align = "left">&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><font size = 8><%= Name( rowcount)%></a></font></td>	
		<% else %>
		<td class = "body"  height = "55" align = "left">&nbsp; <a href = "AdminAnimalEdit.asp?ID=<%= ID( rowcount)%>" class = "body"><font size = 3><%= Name( rowcount)%></a></font></td>		
		
		<% end if %>
		<% end if %>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close

%>

</table><br />

<% End If %>
</td>
	</tr>
</table>
</td>
<% if mobiledevice = True  or ScreenWidth < 800 then %>
</tr><tr>
 <% else %> 
 <td width = "10"><img src = "images/px.gif" width = "1" height = "1" /></td>
 <% End If %> 
 
 <% End If %>  

  <td class = "body" valign = "top">

<% if mobiledevice = False  then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
	<H3><div align = "left">Pages</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<% else %>
<% if LivestockAvailable = True then %>
<!--#Include file="AdminMobileMenuInclude.asp"-->
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td  align = "left">
	<br /><H1><div align = "left">Pages</div></H1>
        </td></tr>
        <tr><td  align = "center">
<% end if %>

	

    <form  name=UpdatePagesform method="post" action="Default.asp?UpdatePages=True">
	 <table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%" align = "center">
 
<tr>
  <td class = "body" valign = "top">
<table border = "0" bordercolor = "#CEBD99" width = "100%" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "center">
	<tr >
	   	<td class = "body2" align = "center" height = "23" >
	      <a name="Pages"></a>	 <% if mobiledevice = False   then %>
	      	 	<b>Page</b></td>
	   	<td class = "body2" align = "center" height = "23" >
       	<b>Display Page</b></td>
	   	<td class = "body2" align = "center" height = "23" ><b>Options</b></td>
	   	<% end if %>
	</tr>

		
<% 
order = "odd"	
sql2 = "select * from Pagelayout where  PageAvailable = True order by pagename"	
	'response.write(sql2)
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
	
	While Not rs2.eof 
	 PageFound = False
		ShowPage = rs2("ShowPage")
	 if order = "even" then
	  	order = "odd" %>
	  	<tr bgcolor = "#e6e6e6">
	  	
	 <% else
	     order = "even" %>
	 	<tr bgcolor = "White">    
	<% end if 
	 
	 
 if rs2("PageName") ="Photo Galleries" then
	    PageFound = True	%> 
  <td class = "body" height = "23">&nbsp;Photo Galleries</td>
	 <td class = "body2" align = "center">
 	 	<% if ShowPage  = True then %>
 	 	    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked>Yes
 	 	<% else %>
 	 	    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" >No
 	 	<% end if %>
</td>
	 <td class = "body" align = "center"></td>
	 </tr>
	  <% if order = "even" then %>
	  		<tr bgcolor = "white">
	 <% else %>
	     	<tr bgcolor = "#efefef">
	<% end if  %>
			   <% if mobiledevice = True   then %>
	   <td colspan = "3" align = "center">
	 	    <a href = "AdminGalleryAddImage1.asp" class = "body"><small>Add Images</small></a>
		<a href = "AdminGalleryEditImages.asp" class = "body" ><small>Edit Images</small></a>
        <a href = "AdminGallerySetCategories.asp" class = "body" ><small>Gallery Categories</small></b></a>
	   </td>
	   <% end if %>
	 </tr>
	 <% end if %>
	 
	
	<% if rs2("PageName") ="Farm Store (Header)" then
	    PageFound = True	%> 
  <td class = "body" height = "23">&nbsp;Farm Store</td>
	 <td class = "body2" align = "center">
 	 	<% if ShowPage  = True then %>
 	 	    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked>Yes
 	 	<% else %>
 	 	    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" >No
 	 	<% end if %>
</td>
	 <td class = "body" align = "center"></td>
	 </tr>
	  <% if order = "even" then %>
	  		<tr bgcolor = "white">
	 <% else %>
	     	<tr bgcolor = "#efefef">
	<% end if  %>
	   <td colspan = "3" align = "center">
	 
	 
	 <a href = "AdminClassifiedAdPlace.asp" class= "body" >&nbsp;<small>Add&nbsp;</small></a>
<a href = "AdminAdEdit.asp" class= "body"  ><small>Edit&nbsp;</small></a>
<a href = "AdminListingDelete.asp" class= "body"  ><small>Delete&nbsp;</small></a>
<a href = "AdminProductPhotos.asp" class= "body" ><small>Photos&nbsp;</small></a>
<a href = "AdminSetSaleCategories.asp" class= "body" ><small>Categories&nbsp;</small></a>
<a href = "AdminStoreShippingRates.asp" class= "body" ><small>Shipping&nbsp;</small></a>
<a href = "AdminStoreMaintenance.asp" class= "body" ><small>Settings&nbsp;</small></a>
			
					  
	   </td>
	 </tr>
	 <% end if %>

	<% if  PageFound = False then %>
 <% if mobiledevice = False  then %>

 <% if rs2("LinkName")  = "Home" then%>
 	 <td class = "body" height = "23" >&nbsp;&nbsp;<a href = " AdminHomePage.asp" class= "body" ><%=rs2("LinkName")%></a></td>
 <% else %>
 	 <td class = "body" height = "23" >&nbsp;&nbsp;<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class= "body" ><%=rs2("LinkName")%></a></td>
 
 <% end if %>

<% else %>
<% if SmallMobile = False then %>
	 <td class = "body" height = "55" >&nbsp;&nbsp;<a href = "AdminPagedata.asp?PageLayoutID=<%= rs2("PageLayoutID") %>#BasicFacts" class= "body" ><font size="8"><%=rs2("LinkName")%></font></a><% if rs2("LinkName")  = "Packages" then%>	
		<a href = "<%=rs2("EditLink")%>" class = "body">&nbsp;&nbsp;&nbsp;&nbsp;- <font size = "8">Edit</font></a>&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminPackagesAdd.asp" class = "body"><font size = "8">Add</font></a>	
<% end if %>	
 
	 <% if rs2("LinkName")  = "Photo Galleries" then%>
		 &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryAddImage1.asp" class = "body"><font size = "8">Add</font></a>
		&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryEditImages.asp" class = "body" ><font size = "8">Edit</font></a>
        &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGallerySetCategories.asp" class = "body" ><font size = "8">Categories</font></b></a>
<% end if %>	
</td>
	 <% else %>
	 
	 <td class = "body" height = "55" >&nbsp;&nbsp;<a href = "<%=rs2("EditLink")%>" class= "body" ><font size="3"><%=rs2("LinkName")%></font></a>
	 
	 <% if rs2("LinkName")  = "Packages" then%><br />		
		&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminAdEdit2.asp?ProdID=<%= rs2("LinkName")%>" class = "body"><font size = "3">Edit</font></a>&nbsp;&nbsp;&nbsp;&nbsp;-  <a href = "AdminPackagesAdd.asp" class = "body"><font size = "3">Add</font></a>	
<% end if %>	
	 
	 
	 
	 <% if rs2("LinkName")  = "Photo Galleries" then%><br />	
		 &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryAddImage1.asp" class = "body"><font size = "3">Add</font></a>
		&nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGalleryEditImages.asp" class = "body" ><font size = "3">Edit</font></a>
        &nbsp;&nbsp;&nbsp;&nbsp;- <a href = "AdminGallerySetCategories.asp" class = "body" ><font size = "3">Categories</font></b></a>
<% end if %>	
	 </td>
	 <% end if %>
<% end if %> 
<% if mobiledevice = False then %>
	 <td  align = "center" >
	 <% if rs2("PageName") ="Home Page" then %>
 	 	        Always
 	 	    <% else %>   
 	 	<% if ShowPage  = True then %>
 	 	    <input type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>" checked>Yes
 	 	<% else %>
 	 	    <input type="checkbox" type="checkbox" name="ShowPages" value="<%=rs2("PageName") %>"  >No
 	 	<% end if %>
 	 	<% end if %></td>



	 	 <td class = "body2" align = "center">
	 	 
	 	 <% if rs2("LinkName")  = "Home" then%>
 	 <a href = " AdminHomePage.asp" class= "body" >
 <% else %>
    <a href = "<%=rs2("EditLink")%>" class= "body" >
 <% end if %>
<img src= "images/edit.gif" alt = "edit" height = "18" width = "16" border = "0"></a></td>
	 <% end if  %>
	 
	 </tr>
	
 <%
 end if  
	rs2.movenext
 Wend %>
  <% if mobiledevice = False   then %>
<tr>
	<td class = "body" colspan = "3" align = "center">
	<center><input type="submit"  value="Submit" class = "Regsubmit2" ></center><br>

	</td>
	</tr>
<% end if %>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
 <% if LivestockAvailable = False then %>
 </td>
 <td valign = "top">
<% end if %>
 <% 
 if EcommerceAvailable = True then
  if mobiledevice = False  then %>
 </tr><tr>

 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
 <tr><td class = "roundedtop" align = "left">
		<a name="Products"></a><H3><div align = "left">Products</div></H3>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
 <% else %>
 <!--#Include file="AdminMobileMenuInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%" >
<tr><td  align = "left"><br />
		<a name="Products"></a><H1><div align = "left">Products</div></H1><br />
        </td></tr>
        <tr><td align = "center">
 <% end if %>

 <table  border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" width = "100%" align = "center">
 <tr>
  <td  class = "body" valign = "top">
<%
 Dim ProdName(10000)
	 Dim AdType(10000)
	 Dim CategoryID(10000)
	 Dim ProdPrice(10000) 
	 Dim ProdQuantityAvailable(10000)
	 Dim ProdCity(10000) 
	 Dim ProdState(10000)
	 Dim ProdZip(10000) 
	 Dim ProdPartofTown(10000)
	 Dim ProdYear(10000) 
	 Dim ProdMake(10000) 
	 Dim ProdModel(10000) 
	 Dim ProdCondition(10000) 
	 Dim ProdColor(10000)  
	 Dim ProdStartDate(10000)  
	 Dim ProdEndDate(10000)  
	  Dim ProdWeight(10000)  
	 Dim ProdID(10000) 


Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
  SortName = Sort
			If Sort = "ProdName" Then
				SortName = "Name"
			End If 
			If Sort = "CatName" Then
				SortName = "Category"
			End If 
			If Sort = "ProdPrice" Then
				SortName = "Price"
			End If 
				If Sort = "ProdQuantityAvailable" Then
				SortName = "QTY Available"
			End If 
			
	sql = "select distinct ProdName, ProdPrice, ProdID from sfProducts "
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1


Recordcount = rs.RecordCount +1
 if rs.eof Then %>
<blockquote>Currently you do not have any products listed. To add products please select <a href = "AdminClassifiedAdPlace.asp" class = "body"><b>Add a product.</b></a></blockquote>

<% else %>
<table border = "0" bordercolor = "#e6e6e6" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
 <% if mobiledevice = False then %><tr >
	<td class = "body" align = "center" height = "23"><b>Name</b></td>
	
	<td class = "body" align = "center"><b>Options</b></td>

	</tr>	<% end if %>
<%
row = "odd"
 While  Not rs.eof  
    If row = "even" Then
		row = "odd"
	Else
		row = "even"
	End if
	ProdName(rowcount)=rs("ProdName") 
	ProdPrice(rowcount) =rs("ProdPrice")
	ProdID(rowcount) =rs("ProdID")


 If row = "even" Then %>
		<tr bgcolor = "white">
<% Else %>

<tr bgcolor = "#e6e6e6">
<%	End If %>
 <% if mobiledevice = False  then %>
<td class = "body" valign = "top" height = "25">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><%= ProdName(rowcount)%></a></td>

		<td class = "body" valign = "top" width = "180" align = "center"><a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><img src= "images/edit.gif" alt = "edit" height = "18"  border = "0"></a> &nbsp;|
		<a href = "AdminProductPhotos.asp?ID=<%= ProdID( rowcount)%>" class = "body"><img src = "images/Photo.gif" height = "18" border = "0" alt = "Upload Photos"></a></td>
		<% else %>
		<% if SmallMobile = False then %>
		<td class = "body" valign = "top" height = "55">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><font size = 8><%= ProdName(rowcount)%></font></a></td>
		<% else %>
				<td class = "body" valign = "top" height = "55">&nbsp;&nbsp;<a href = "AdminAdEdit2.asp?ProdID=<%= ProdID( rowcount)%>" class = "body"><font size = 3><%= ProdName(rowcount)%></font></a></td>
		
		<% end if %>
		<% end if  %>
		</tr>
<% 

		rowcount = rowcount + 1
	   rs.movenext

	Wend
TotalCount=rowcount 
	rs.close

%>

</table>
<% end if %>
</td>
	</tr>
<tr>
 </table>
<% end if %>
     </td>
</tr>
</table> 
  </td>
</tr>
</table> 
  </td>
</tr>
</table> 
   <br>

<br>
 <!--#Include file="AdminFooter.asp"--> 
</BODY>
</HTML>