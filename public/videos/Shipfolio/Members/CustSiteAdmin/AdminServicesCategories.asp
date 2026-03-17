<!DOCTYPE HTML >
<HTML>
<HEAD>
<% 

Sort=request.form("Sort") 
If Len(Sort) < 4 Then
	Sort = "Prodname"
End if
%>
<link rel="stylesheet" type="text/css" href="/administration/style.css"> 
  <!--#Include file="AdminSecurityInclude.asp"--> 
    <!--#Include file="AdminGlobalVariables.asp"--> 
</head>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);">
<% 
    TempCategoryType="For Sale"
%>  
 
 
    <!--#Include file="AdminHeader.asp"--> 
 <%  Current3 = "Categories"   %> 
<!--#Include virtual="/Administration/AdminServicesTabsInclude.asp"-->

<% TempCategoryType=request.form("TempCategoryType") 
	If Len(TempCategoryType) < 3 then
		TempCategoryType= Request.QueryString("TempCategoryType") 
	End If

Dim Tempcategoryname
Dim Tempcategorytype
Dim TempcategoryID
Dim Categorytype


Tempcategoryname=Request.Form("categoryname" ) 
TempServicesCategoryShow=Request.Form("ServicesCategoryShow" ) 
Tempcategorytype=Request.Form("Tempcategorytype" ) 
TempcategoryID=Request.Form("CategoryID" ) 
Categorytype=Request.Form("Categorytype" ) 

	str1 = Tempcategoryname
	str2 = "'"
	If InStr(str1,str2) > 0 Then
		Tempcategoryname= Replace(str1, "'", "''")
	End If

If categorytype = "category" then
	Query =  " UPDATE ServicesCategories Set ServicesCategoryName = '" & Tempcategoryname & "' , " 
	Query =  Query & " ServicesCategoryShow = " & TempServicesCategoryShow & " " 
    Query =  Query & " where ServiceCategoryID = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT ServicesCategoryName FROM ServicesCategories WHERE ServiceCategoryID = " & TempcategoryID

End If 

If categorytype = "subcategory" then
	Query =  " UPDATE SFSubCategories Set SubCategoryname = '" &  Tempcategoryname & "' " 
    Query =  Query & " where subcatCategoryId = " & TempcategoryID & ";" 
	sLocalSQL = "SELECT SubCategoryname FROM SFSubCategories WHERE subcatCategoryId = " & TempcategoryID

End If 
'response.write("sLocalSQL=" & sLocalSQL)
'response.write("Query=" & Query)
	If Len(Query) > 3 then
    	Set DataConnection = Server.CreateObject("ADODB.Connection")
        DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) & ";" 
    	DataConnection.Execute(Query) 
    	DataConnection.Close
	    Set DataConnection = Nothing 
    end if 
	
%>

	<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "980"><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Service Pages</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" height = "300" valign = "top">

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width= "900" >
	<tr>
	    <td width = "360">
	    <% 
Dim CategoryID(100,100)
Dim CategoryName(100,100)
Dim CategoryShow(100,100)
Dim SubCategoryID(100)
Dim SubCategoryName(100)
Dim ServicesCategoryShow(100,100)

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from ServicesCategories  order by ServicesCategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CategoryID(CatCounter,0) = rs("ServiceCategoryID")
		CategoryName(CatCounter,0) = rs("ServicesCategoryName")
		ServicesCategoryShow(CatCounter,0) = rs("ServicesCategoryShow")
		'response.write(CategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0 %>

<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "400">
			<tr>
		<td  class = "body" valign = "top" colspan = "3">
		<H2>Edit Existing Categories</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "3"></td>
        </tr>	
        <tr>
        <td class = "body" align = "center"><b>Name</b></td>
         <td class = "body" align = "center"><b>Display Page</b></td>
          <td></td>
        </tr>
<% While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>

			
			<tr>
			<td class = "body"> <form action= 'AdminServicesCategories.asp' method = "post" style="margin-bottom:0;" >
			<div style="display: inline;">
			<input name="categoryname" value ="<%= CategoryName(CatCounter,0) %>"  size = "20"></div>
			</td>
			<td class = "body"> 
				<% 	
		if ServicesCategoryShow(CatCounter,0) = "Yes" Or ServicesCategoryShow(CatCounter,0) = True Then %>
			True<input TYPE="RADIO" name="ServicesCategoryShow" Value = "Yes" checked>
			False<input TYPE="RADIO" name="ServicesCategoryShow" Value = "No" >
		<% Else %>
			True<input TYPE="RADIO" name="ServicesCategoryShow" Value = "Yes" >
			False<input TYPE="RADIO" name="ServicesCategoryShow" Value = "No" checked>
		<% End If %>
			</td>
			<td class = "body"> 			
			<input name="categorytype" value ="category"  type="hidden">
			<input name="TempCategoryType" value ="<%=TempCategoryType%>"  type="hidden">
				<input name="categoryID" value ="<%=CategoryID(CatCounter,0)%>"  type="hidden">
			<input type=submit value = "submit"  class = "regsubmit2" >
			</form>
		</td>
		</tr>

<% wend %>
</table>
	    </td>

	    <td bgcolor = "#abacab" width = "1"></td>
	   <td  width = "20"></td>
	    <td width = "400" valign = "top" class = "body">
	    
	    

			<form action= 'AdminServiceCategoryAddHandleForm.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" width = "400">
		<tr>
		<td  class = "body" valign = "top" colspan = "2">
		<h2>Add a New Category</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "2"></td>
        </tr>
				<tr>
						<td width = "200" class = "body" align = "right">
							<div align = "right">New Category:</div>
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "center" valign = "middle" colspan = "2" class = "body">
						<center><input type=submit value = "Add Category" size = "110" class = "regsubmit2" ></center>
					</td>
			</tr>
			</table>
			</form>

			<b></b>
<form action= 'AdminServicesCategoryDeleteHandleForm.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
					<tr>
		<td  class = "body" valign = "top" colspan = "2">
		<h2>Delete a Category</H2>
        </td>
      </tr>
      <tr>
        <td bgcolor = "#abacab" height = "1" colspan = "2"></td>
        </tr>
              <tr>
        <td  height = "1" colspan = "2" class = "body"><h3>Warning! </h3>
<b>When you delete a category you will loose all Services with that category! Even if you create a new category with the same name, the old Services will not automatically be reassigned!</b><br><br></td>
        </tr>
			<tr>
					<td width = "140" class = "body" align = "right">
							<div align = "right">Category:</div>
					</td>
					<td class = "body" >
							<select size="1" name="CategoryID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter +1) 
								CatCounter = CatCounter +1 
						%>
								 <option  value="<%= CategoryID(CatCounter,0) %>"><%= CategoryName(CatCounter,0) %></option>
	
							<% 
							Wend %>
							</select>
					</td>
			</tr>
		
			<tr>
					<td  align = "center" valign = "middle" colspan = "2">
						<input type=submit value = "Delete a Category" size = "110" class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>


   </td>
   </tr>

</table><br><br><br>
	    </td>
	</tr>
</table>
</td>
</tr>
</table>
<br>
<!--#Include file="AdminFooter.asp"--> </Body>
</HTML>