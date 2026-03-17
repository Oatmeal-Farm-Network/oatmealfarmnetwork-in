<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<title>The Andresen Group Content Management System</title>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<link rel="shortcut icon" href="/infinityknot.ico" /> 
<link rel="icon" href="http://www.alpacainfinity.com/alpacachamps/infinityknot.ico" /> 
<meta name="author" content="The Andresen Group"/>
<link rel="stylesheet" type="text/css" href="/administration/style.css">


<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
</HEAD>
<body >

<!--#Include file="AdminHeader.asp"-->
<% Current3="LinkCategories" %> 
<!--#Include file="AdminPagesTabsInclude.asp"-->
 <!--#Include file="AdminLinksTabsInclude.asp"-->
 
 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Link Categories</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "960">

<br>
<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top"  width = "940" >
	<tr>
		<td width = "470"  class = "body" valign = "top">
		 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Existing Categories</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left" width = "450">
        To rename an existing category - make the changes below and select the corresponding submit button.<br /><br />
<% 
Dim CatID(100,100)
Dim CategoryName(100,100)


conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
						"Data Source=" & server.mappath(databasepath) & ";" & _
						"User Id=;Password=;" 

			 sql = "select * from LinkCategories  order by CategoryName " 
			'response.write(sql2)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	CatCounter= 0
	 While Not rs.eof 
		CatCounter = CatCounter + 1
		CatID(CatCounter,0) = rs("CatID")
		CategoryName(CatCounter,0) = rs("CategoryName")
		'response.write(CategoryName(CatCounter,0))
		rs.movenext
	Wend
		FinalCatCounter = CatCounter

CatCounter= 0
SubCatCounter2 = 0
While CatCounter < FinalCatCounter
	CatCounter= CatCounter +1 %>
   
			<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "430"><tr><td align = "left"> 
			<form action= 'AdminLinkEditCategory.asp' method = "post"  >
		
			<% 	if len(CategoryName(CatCounter,0)) > 0 and not (CategoryName(CatCounter,0) = "Social Networking") and not (CategoryName(CatCounter,0) = "Online Marketplaces")  then%>
			<input name="categoryname" value ="<%= CategoryName(CatCounter,0) %>"  size = "20">
			<% else %>
           <div align = "left"><%= CategoryName(CatCounter,0) %>*</div>
    <% end if %>
			<input name="categorytype" value ="category"  type="hidden">
			
				<input name="CatID" value ="<%=CatID(CatCounter,0)%>"  type="hidden">
				
				<% 	if len(CategoryName(CatCounter,0)) > 0 and not (CategoryName(CatCounter,0) = "Social Networking") and not (CategoryName(CatCounter,0) = "Online Marketplaces")  then%>
			<input type=submit value = "submit"  class = "regsubmit2" >
			<% end if %>
			</form>
			
			
		</td>
		</tr>
		</table>
		

	<% 
	
wend


%>

<center><i>Note: The Social Networking and Online Marketplaces<br /> categories may not be renamed.</i></center><br /><br />
        </td>
        </tr>
        </table>
		</td>
		<td width = "5"></td>
		<td width = "470"  class = "body" valign = "top">
		 <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Add Categories</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "450">
        <br>
			<form action= 'AdminLinkAddCategory.asp' method = "post">
				<table   border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				<tr>
						<td width = "200" class = "body2" align = "right">
							New Category:
					</td>
					<td class = "body">
							<input name="NewCategory" size = "30">
							<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
					</td>
			</tr>
			<tr>
					<td  align = "right" colspan = "2" class = "body2">
						<input type=submit value = "Add Category" class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>
			
        </td>
        </tr>
        </table>
        <br />
         <table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H2><div align = "left">Delete Categories</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom body"  width = "450">
        

<h1><center>Warning! </center></h1>
<b>When you delete a category  you will loose all Links with that category! Even if you create a new category with the same name, the old Links will not automatically be reassigned!</b><br><br>

<form action= 'AdminLinkdeleteCategory.asp' method = "post">
	<input name="CategoryType" type = "hidden" Value = "<%=TempCategoryType%>">
	<input   name="DeleteCategoryType" type = "hidden" value = "Category">	
				<table  width = "450" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center"  valign ="top" >
				
			<tr>
					<td width = "100" class = "body2" align = "right">
							Category:
					</td>
					<td class = "body" align = "left">
							<select size="1" name="CatID">	
							<option  value= "" selected>select a category</option>
						<%	CatCounter = 0 
								While CatCounter < (FinalCatCounter +1) 
								CatCounter = CatCounter +1 
								if len(CategoryName(CatCounter,0)) > 0 and not (CategoryName(CatCounter,0) = "Social Networking") and not (CategoryName(CatCounter,0) = "Online Marketplaces")  then
						%>
								 <option  value="<%= CatID(CatCounter,0) %>"><%= CategoryName(CatCounter,0) %></option>
	
							<% 
							end if
							Wend %>
							</select>
					</td>
			</tr>
			<tr>
					<td  align = "right" colspan = "2">
						<input type=submit value = "Delete Category"  class = "regsubmit2" >
					</td>
			</tr>
			</table>
			</form>
			<center><i>Note: The Social Networking and Online Marketplaces<br /> categories may not be deleted.</i></center><br /><br />
        </td>
        </tr>
        </table>
		
		
		
		</td>
  </tr>
</table>


<br>
</td>
</tr>
</table><br><br>
<!--#Include file="AdminFooter.asp"--> 
</Body>
</HTML>