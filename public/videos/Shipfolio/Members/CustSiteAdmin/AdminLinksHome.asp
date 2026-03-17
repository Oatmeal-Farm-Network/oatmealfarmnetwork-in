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
    <% 
   Current3="LinksHome" %> 

<% 
Dim CatID(100,100)
Dim CategoryName(100,100)
Dim linkID2(40000)
Dim LinkImage2(40000)
Dim LinkIDArray(1000)
Dim LinkTextArray(1000)
Dim LinkArray(1000)
Dim LinkDescriptionArray(1000)
Dim LinkImageArray(1000)
Dim CatIDArray2(1000)
Dim CatNameArray(1000)
Dim LinkShowOnfooter2(1000)
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1


	
Recordcount = rs.RecordCount +1

 if mobiledevice = False  then %>
<!--#Include file="AdminPagesTabsInclude.asp"-->
 <!--#Include file="AdminLinksTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth - 33 %>">
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Link Maintenance</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
        
	</td>
    </tr>
</table>


<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" width = "100%">
	<tr>
		<td class = "roundedtop">
			<H2>Add a New Link</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom body" width = "100%">
<center>* = Required</center>
<%


Missing = request.QueryString("Missing")
LinkTextx= Request.QueryString("LinkText")
Linkx= Request.QueryString("Link")
LinkDescriptionx= Request.QueryString("LinkDescription")
CatIDx= Request.QueryString("CatID")
LinkShowOnfooterx= Request.QueryString("LinkShowOnfooter")

if len(Missing) > 3 then %>
<table width = "700" align = "center">
<tr><td class = "body"><font color = "Maroon"><b>Missing Information</b><br />Please fill in the following missing information:<ul><%=Missing %></ul></font></td></tr></table>


<% end if %>
	<form action= 'AdminLinkAddHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<%
if screenwidth > 987 then
    fieldlength = 80
end if 
if screenwidth < 987 then
    fieldlength = 77
end if
if screenwidth < 769 then
    fieldlength = 60
end if
 if screenwidth < 601 then
    fieldlength = 50
end if

%>
	<tr>
		<td width = "170" class = "body2" align = "right" height = "30">
			Title*:
		</td>
		<td class = "body">
			<input name="LinkText" class = "body" size = "<%=fieldlength %>" value = "<%= LinkTextx%>">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right" height = "30">
			Web Address*:
		</td>
		<td class = "body">
			<small>Http://</small><input name="Link" size = "<%=fieldlength -13%>" value= "<%= Linkx%>">
		</td>
	</tr>
  <tr>
      <td class = "body2" align = "right" height = "30">
	    Category:
	</td>
	<td class = "body">
<% 
if len(CatIDx) > 0 then 
 
 sql = "select * from LinkCategories where CatID =  " & CatIDx
'response.write(sql)
	Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3 
	if Not rs.eof then
	CategoryNamex = rs("CategoryName")
	end if
 rs.close
 end if
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
 %>
<select size="1" name="CatID">
<% if len(CatIDx) > 0 then %>
<option name = "ALinkID0" value= "<%=CatIDx %>" selected><%=CategoryNamex %></option>
<option name = "ALinkID0" value= "" >--</option>
<% else %>
<option name = "ALinkID0" value= "" selected></option>
<% end if %>
					
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1
					%>
						<option name = "LinkCatID" value="<%=CatID(CatCounter,0)%>">
							<%=CategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>

     </td>
  </tr>
  <tr><td class = "body2"  align = "right" height = "30"><b><a class="tooltip" href="#">Show On Footer?<span class="custom info">If a link is marked as <i>Show on Footer</i> as true then it will appear at the bottom of ever page of the website, <b>if an image is associated with it.</b></span></a></b>:&nbsp;</td>
<td class = "body" align = "left">


<% if  LinkShowOnfooterx = "Yes" Or  LinkShowOnfooterx = "True" Then %>
						Yes<input TYPE="RADIO" name="LinkShowOnfooter" Value = True checked>
						No<input TYPE="RADIO" name="LinkShowOnfooter" Value = False >
					<% Else %>
						Yes<input TYPE="RADIO" name="LinkShowOnfooter" Value = True >
						No<input TYPE="RADIO" name="LinkShowOnfooter" Value = False checked>
				<% End if%>   
		</td></tr>
	<tr>
		<td class = "body2" align = "right" valign = "top">
			Description:
		</td>
		<td class = "body">
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
		<script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		<script language="javascript1.2" type="text/javascript">
     // attach the editor to the textarea with the identifier 'textarea1'.

     WYSIWYG.attach("LinkDescription", mysettings);
      mysettings.Width =  "450px"
     mysettings.Height = "200px"
 </script>
 <textarea name="LinkDescription"  ID="LinkDescription" cols="60" rows="20"   class = "body"  ><%= LinkDescriptionx%></textarea>

		</td>
	</tr>
	
	<tr>
		<td class = "body" align = "right"  colspan = "2">
			<center><input type=submit value = "Add Link" class = "regsubmit2 body2" ></center>
			</form>
		</td>
</tr>
</table>
</td>
</tr>
</table>
<br /><br />
<a name="Existing"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" width = "100%">
	<tr>
		<td class = "roundedtop">
			<H2>Existing Links</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom body">
<%    
 sql = "select * from Links, Linkcategories where Links.CatID = LinkCategories.CatID order by CategoryName,  LinkText"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
	<tr>
		<th class = "body2" width = "80" align = "center"><b>Image</b></th>
		<th class = "body2" width = "450" align = "center"><b>Link</b></th>
		<th  class = "body2" align = "center"><b>Title</b></th>
		<th  class = "body2" align = "left"><b><a class="tooltip" href="#">Show On Footer?<span class="custom info">If a link is marked as <i>Show on Footer</i> as true then it will appear at the bottom of ever page of the website, <b>if an image is associated with it.</b></span></a></b></th>
		<th  class = "body2" align = "center"><b>Options</b></th>
	</tr>
	<tr>
	<td height = "7"></td></tr>
<%
OldCategoryName = ""
 While  Not rs.eof         
CatNameArray(rowcount) =   rs("CategoryName")
LinkIDArray(rowcount) =   rs("LinkID")
LinkTextArray(rowcount) =   rs("LinkText")
LinkdescriptionArray(rowcount) =   rs("LinkDescription")
CatIDArray2(rowcount) =   rs("Linkcategories.CatID")
LinkArray(rowcount) =   rs("Link")
LinkImageArray(rowcount) =   rs("LinkImage")
LinkID2(rowcount) =   rs("LinkID")
LinkImage2(rowcount) =   rs("LinkImage")
LinkShowOnfooter2(rowcount) = rs("LinkShowOnfooter") 
NewCategoryName =rs("CategoryName")
if not(NewCategoryName = OldCategoryName) then
%>
<tr><td class = "body" bgcolor = "#d6d6d6" colspan = "6" height = "50"><b><%=rs("CategoryName") %></b></td></tr>
<tr><td class = "body" bgcolor = "white" colspan = "6" height = "2">&nbsp;</td></tr>
 <%
 end if
OldCategoryName =rs("CategoryName")
  If row = "even" Then 
 row = "odd" %>
		<tr >
<% Else 
row = "even"%>
<tr bgcolor = "#e6e6e6">
<%	End If %>
	 <td class = "body2" valign = "top" align = "center" >
	<input type = "hidden" name="CatID(<%=rowcount%>)" value= "<%= CatIDArray2( rowcount)%>" >
	<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" >
	<% if len(LinkImage2(rowcount)) > 3 then
	else
	LinkImage2(rowcount) = "/uploads/ImageNotAvailable.jpg"	
	end if%>
	<a href = "http://<%=LinkArray(rowcount)%>" target = "blank"><img src = "<%=LinkImage2(rowcount)%>" width = "50" border = "0">  </a>
	
</td>
<td  class= "body" valign = "top">
		
						<small>http://</small><%= LinkArray( rowcount)%>
					</td>
		<td>
			<% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity" or trim(LinkTextArray(rowcount)) ="Etsy" or trim(LinkTextArray(rowcount)) ="AlpacaSeller" or trim(LinkTextArray(rowcount)) ="AlpacaStreet"  or trim(LinkTextArray(rowcount)) ="AlpacaNation" or trim(LinkTextArray(rowcount)) ="OpenHerd" then %>
				   <b><%= LinkTextArray( rowcount)%></b>
				    <input type = "hidden" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" >
				    <% else %>
				       <b> <%= LinkTextArray( rowcount)%></b>
				      <% end if %><br />
		</td>
		<td class = "body" align = "center"><%=LinkShowOnfooter2(rowcount) %></td>
		
		<td>
		<a href = "AdminLinkEdit.asp?LinkID=<%= LinkIDArray(rowcount) %>" class = "body">&nbsp;&nbsp;<img src= "/images/edit.gif" alt = "edit" height ="12" border = "0"></a>|&nbsp;<a href = "AdminLinkDelete.asp?LinkID=<%= LinkIDArray(rowcount) %>" class = "body"><img src= "/images/Delete.gif" alt = "edit" height ="14" border = "0"></a>
		
		
		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<tr>
<td colspan = "3" align = "left" class = "body"><br />
<table width = "100%">

</table>
		
		</td>
</tr>
</table>
		</td>
</tr>
</table>

<br />

<% else %>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width ="100%">
<tr><td class = "body">
		<H1><div align = "left">Link Maintenance</div></H1>
   
			<H2>Add a New Link</H2>
		

	<form action= 'AdminLinkAddHandleForm.asp' method = "post">
		<b>Title:</b><br />
			<input name="LinkText" class = "body" size = "40"><br />
		<b>Web Address:</b><br />
		Http://<input name="Link" size = "40"><br />
	   <b>Category:</b><br />
<% conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
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
 %>
  
<select size="0" name="CatID" class = "regsubmit2 bady">
					<option name = "ALinkID0" value= "" selected></option>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1
					%>
						<option name = "LinkCatID" value="<%=CatID(CatCounter,0)%>">
							<%=CategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
<br />
	<b>Description:</b><br />
	<textarea name="LinkDescription"  cols="30" rows="4"   class = "body"  ></textarea><br />
	<center><input type=submit value = "Add Link" class = "regsubmit2 body" ></center>
			</form>


<% end if %>
<br><br>

    <!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>