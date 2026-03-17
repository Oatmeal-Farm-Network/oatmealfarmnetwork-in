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
<% response.redirect("AdminLinksHome.asp") %>
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

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	dim LinkID(40000)
	dim LinkText(40000)
	dim Link(40000)
	dim Linkdescription(40000)

	
Recordcount = rs.RecordCount +1
%>

<% if mobiledevice = False  then %>
 <!--#Include file="AdminLinksTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>">
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Link Maintenance</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" width = "100%">
        
	
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center" width = "100%">
	<tr>
		<td class = "roundedtop">
			<H2>Add a New Link</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom" width = "100%">

	<form action= 'AdminLinkAddHandleForm.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "90%">
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
		<td width = "110" class = "body2" align = "right">
			Title:
		</td>
		<td class = "body">
			<input name="LinkText" class = "body" size = "<%=fieldlength %>">
		</td>
	</tr>
	<tr>
		<td class = "body2" align = "right">
			Web Address:
		</td>
		<td class = "body">
			Http://<input name="Link" size = "<%=fieldlength -13%>">
		</td>
	</tr>
  <tr>
      <td class = "body2" align = "right">
	    Category:
	</td>
	<td class = "body">

<% 
 sql = "select * from LinkCategories  order by CategoryName " 
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

     </td>
  </tr>
	<tr>
		<td class = "body2" align = "right" valign = "top">
			Description:
		</td>
		<td class = "body">
			<textarea name="LinkDescription"  cols="<%=fieldlength %>" rows="4"   class = "body"  ></textarea>
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
<a name="Marketplace"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "95%">
	<tr>
		<td class = "roundedtop">
			<H2>Online Marketplace Links</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom body">
 <%    
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links, Linkcategories where Links.CatID = LinkCategories.CatID and CategoryName = 'Online Marketplaces'"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>
<form action= 'AdminLinkhandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "95%">
	<tr>
		<th class = "body2" width = "80" align = "center"><b>Image</b></th>
		<th class = "body2" width = "380" align = "center"><b>Link</b></th>
		<th  class = "body2" align = "center"><b>Description</b></th>
		
	</tr>
	<tr>
	<td height = "7"></td></tr>
	
	
<%
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
%>
<tr >
	 <td class = "body2" valign = "top" align = "center" >
	<input type = "hidden" name="CatID(<%=rowcount%>)" value= "<%= CatIDArray2( rowcount)%>" >
	 
	 
	 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If %>
<% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity" or trim(LinkTextArray(rowcount)) ="Etsy" or trim(LinkTextArray(rowcount)) ="AlpacaSeller" or trim(LinkTextArray(rowcount)) ="AlpacaStreet"  or trim(LinkTextArray(rowcount)) ="AlpacaNation" or trim(LinkTextArray(rowcount)) ="OpenHerd" then %>

    <% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity"  then %>
        <img src = "/images/AlpacaInfinityBig.jpg" width = "40">
    <% end if %>
    
      <% if trim(LinkTextArray(rowcount)) ="Etsy"  then %>
        <img src = "/images/EtsyBig.jpg" width = "40">
    <% end if %>
    
   <% if trim(LinkTextArray(rowcount)) ="AlpacaSeller"  then %>
        <img src = "/images/AlpacaSellerBig.jpg" width = "40">
    <% end if %>
    
        <% if trim(LinkTextArray(rowcount)) ="AlpacaStreet"  then %>
        <img src = "/images/AlpacaStreetBig.jpg" width = "40">
    <% end if %>  
    
  <% if trim(LinkTextArray(rowcount)) ="AlpacaNation"  then %>
        <img src = "/images/AlpacaNationBig.jpg" width = "40">
    <% end if %>
    
    <% if trim(LinkTextArray(rowcount)) ="OpenHerd"  then %>
        <img src = "/images/OpenHerdBig.jpg" width = "40">
    <% end if %>
      
      
      
<% else %>

<img src = "<%= LinkImageArray(rowcount)%>" width = "40">
<% end if %>


		
		<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" >
		 </td>
<td  class= "body" valign = "top">
		<% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity" or trim(LinkTextArray(rowcount)) ="Etsy" or trim(LinkTextArray(rowcount)) ="AlpacaSeller" or trim(LinkTextArray(rowcount)) ="AlpacaStreet"  or trim(LinkTextArray(rowcount)) ="AlpacaNation" or trim(LinkTextArray(rowcount)) ="OpenHerd" then %>
				   <b><%= LinkTextArray( rowcount)%></b>
				    <input type = "hidden" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" >
				    <% else %>
				       <b> <input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "48"> </b>
				      <% end if %><br />
						<small>http://</small><input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" size = "40" class = "body">
					</td>
		<td>
			<textarea name="LinkDescription(<%=rowcount%>)"  cols="70" rows="6"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea>
		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
rs.close
%>
<tr>
<td colspan = "3" align = "left" class = "body"><br />
<table width = "100%">
<tr>
<td class = "body" width = "100%"></td>
<td class = "body">
<Input type = hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes"  class = "regsubmit2" >
			</form>
</td>
</tr>

</table>
		
		</td>
</tr>
</table>
		</td>
</tr>
</table>

<br />



<%    
sql = "select * from Links, Linkcategories where Links.CatID = LinkCategories.CatID and CategoryName = 'Social Networking'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
if not rs.eof then
%>
<a name="Social"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "center">
	<tr>
		<td class = "roundedtop">
			<H2>Social Networking Links</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom" width = "100%">
 <br />

<form action= 'AdminLinkhandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 align = "left" width = "95%">
	<tr>
		<th class = "body2" width = "80" align = "center"><b>Image</b></th>
		<th class = "body2" width = "380" align = "center"><b>Link</b></th>
		<th  class = "body2" align = "center"><b>Description</b></th>
		
	</tr>
	<tr>
	<td height = "7"></td></tr>
<%
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
%>
<tr >
<td class = "body" valign = "top">
	<input type = "hidden" name="CatID(<%=rowcount%>)" value= "<%= CatIDArray2( rowcount)%>" >
 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If %>
<% if trim(LinkTextArray(rowcount)) ="Facebook" or trim(LinkTextArray(rowcount)) ="Twitter" or trim(LinkTextArray(rowcount)) ="Google+" or trim(LinkTextArray(rowcount)) ="LinkedIn" or trim(LinkTextArray(rowcount)) ="YouTube" or trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>

    <% if trim(LinkTextArray(rowcount)) ="Facebook"  then %>
        <img src = "/images/FacebookBig.jpg" width = "40">
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Twitter"  then %>
        <img src = "/images/TwitterBig.jpg" width = "40">
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Google+"  then %>
        <img src = "/images/Google+Big.jpg" width = "40">
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="LinkedIn"  then %>
        <img src = "/images/LinkedInBig.jpg" width = "40">
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>
        <img src = "/images/YahooBig.jpg" width = "40">
    <% end if %>
      <% if trim(LinkTextArray(rowcount)) ="YouTube"  then %>
        <img src = "/images/YouTubeBig.jpg" width = "40">
    <% end if %>
<% else %>
			<img src = "<%= LinkImageArray(rowcount)%>" width = "40">
			<a href = "AdminLinkPhotos.asp?LinkID=<%= LinkIDArray(rowcount)%>" class = "body" >Edit Photo</a>
			
<% end if %>
		
		<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" >
		 </td>

				    <td  class= "body">
				    <% if trim(LinkTextArray(rowcount)) ="Facebook" or trim(LinkTextArray(rowcount)) ="Twitter" or trim(LinkTextArray(rowcount)) ="Google+" or trim(LinkTextArray(rowcount)) ="LinkedIn" or trim(LinkTextArray(rowcount)) ="YouTube" or trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>
				   <b><%= LinkTextArray( rowcount)%></b>
				    <input type = "hidden" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" >
				    <% else %>
				       <b> <input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "48"> </b>
				      <% end if %><br />
						<small>http://</small><input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" size = "48" class = "body">
					</td>
		<td>
			<textarea name="LinkDescription(<%=rowcount%>)"  cols="60" rows="1"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea>
		</td>
	</tr>
	

<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing

%>
<tr>
<td colspan = "3" align = "left" class = "body"><br />
<table width = "100%">
<tr>
<td class = "body" width = "100%"></td>
<td class = "body">
<Input type = hidden name='TotalCount' value = <%=TotalCount%> >
<input type=submit value = "Submit Changes"  class = "regsubmit2" >
</form>
</td>
</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<% end if %>
<br />
<a name="Other"></a>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  align = "left" width = "95%">
	<tr>
		<td class = "roundedtop">
			<H2>Other Links</H2>
		</td>
	</tr>
	<tr>
		<td class = "roundedBottom" width = "100%">
 <%    
sql = "select * from Links, Linkcategories where not (CategoryName = 'Social Networking') and not (CategoryName = 'Online Marketplaces') and Links.CatID = LinkCategories.CatID"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
rowcount = 1
Recordcount = rs.RecordCount +1
%>
<form action= 'AdminLinkhandleform.asp' method = "post">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "100%" align = "center">
<%
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
%>
<tr >
	 <td class = "body" valign = "top">
	 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If %>

			<img src = "<%= LinkImageArray(rowcount)%>" width = "40"><br>
		   <a href = "AdminLinkPhotos.asp?LinkID=<%= LinkIDArray(rowcount)%>" class = "body" >Edit Photo</a>


		<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" >
		 
		 
		 <% 		CatCounter= 0
					SubCatCounter2 = 0 %>
		          <select size="1" name="CatID(<%=rowcount%>)">
					<option name = "ALinkID0" value= "<%= CatIDArray2(rowcount)%>" selected><%= CatNameArray(rowcount)%></option>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1
					%>
						<option value="<%=CatID(CatCounter,0)%>">
							<%=CategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
		 
		 </td>

		<td nowrap>
		    <table>
			    <tr>
				    <td colspan = "2" class= "body">Title: <input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "56">
					</td>
				</tr>
				<tr>
					<td width = "200" valign = "top">
						http://<input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" >
					</td>
					<td>
						<textarea name="LinkDescription(<%=rowcount%>)"  cols="45" rows="7"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea>
					</td>
				</tr>
			</table>
		
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
		<td colspan = "8" align = "right" valign = "middle">
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<input type=submit value = "Submit Changes"  class = "regsubmit2" >
			</form>
		</td>
</tr>
</table>
		</td>
</tr>
</table><br />
		</td>
</tr>
</table>
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

<a name="Marketplace"></a>
			<H2>Online Marketplace Links</H2>
<%    



conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links, Linkcategories where Links.CatID = LinkCategories.CatID and CategoryName = 'Online Marketplaces'"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>
<form action= 'AdminLinkhandleform.asp' method = "post">
<%
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


%>
<input type = "hidden" name="CatID(<%=rowcount%>)" value= "<%= CatIDArray2( rowcount)%>" >
	 
	 
	 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If %>
<% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity" or trim(LinkTextArray(rowcount)) ="Etsy" or trim(LinkTextArray(rowcount)) ="AlpacaSeller" or trim(LinkTextArray(rowcount)) ="AlpacaStreet"  or trim(LinkTextArray(rowcount)) ="AlpacaNation" or trim(LinkTextArray(rowcount)) ="OpenHerd" then %>

    <% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity"  then %>
        <center><img src = "/images/AlpacaInfinityBig.jpg" width = "150"></center>
    <% end if %>
    
      <% if trim(LinkTextArray(rowcount)) ="Etsy"  then %>
       <center> <img src = "/images/EtsyBig.jpg" width = "150"></center>
    <% end if %>
    
   <% if trim(LinkTextArray(rowcount)) ="AlpacaSeller"  then %>
        <center><img src = "/images/AlpacaSellerBig.jpg" width = "150"></center>
    <% end if %>
    
        <% if trim(LinkTextArray(rowcount)) ="AlpacaStreet"  then %>
        <center><img src = "/images/AlpacaStreetBig.jpg" width = "150"></center>
    <% end if %>  
    
  <% if trim(LinkTextArray(rowcount)) ="AlpacaNation"  then %>
        <center><img src = "/images/AlpacaNationBig.jpg" width = "150"></center>
    <% end if %>
    
    <% if trim(LinkTextArray(rowcount)) ="OpenHerd"  then %>
        <center><img src = "/images/OpenHerdBig.jpg" width = "150"></center>
    <% end if %>
      
      
      
<% else %>




<img src = "<%= LinkImageArray(rowcount)%>" width = "40">
<% end if %>
	 <center> <br /> <a href = "AdminLinkPhotos.asp?LinkID=<%= LinkIDArray(rowcount)%>" class = "body" ><b>Edit Photo</b></a><br /></center>
<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" >
		<% if trim(LinkTextArray(rowcount)) ="Alpaca Infinity" or trim(LinkTextArray(rowcount)) ="Etsy" or trim(LinkTextArray(rowcount)) ="AlpacaSeller" or trim(LinkTextArray(rowcount)) ="AlpacaStreet"  or trim(LinkTextArray(rowcount)) ="AlpacaNation" or trim(LinkTextArray(rowcount)) ="OpenHerd" then %>
				   <b><%= LinkTextArray( rowcount)%></b>
				    <input type = "hidden" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" class = "regsubmit2 body" ><br />
				    <% else %>
<b><input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "48" class = "regsubmit2 body" > </b><br />
				      <% end if %><br />
						<small>http://</small><input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" size = "25" class = "regsubmit2 body" ><br />
			<b>Description:</b><br />
			<textarea name="LinkDescription(<%=rowcount%>)"  cols="30" rows="10"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea><br />
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>

<Input type = hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes"  class = "regsubmit2 body" ></center>
			</form>

<br />
<a name="Social"></a>
<H2>Social Networking Links</H2>

<%    
conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links, Linkcategories where Links.CatID = LinkCategories.CatID and CategoryName = 'Social Networking'"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>
<form action= 'AdminLinkhandleform.asp' method = "post">
<%
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


%>

	<input type = "hidden" name="CatID(<%=rowcount%>)" value= "<%= CatIDArray2( rowcount)%>" ><br />
	 
	 
	 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If %>
<% if trim(LinkTextArray(rowcount)) ="Facebook" or trim(LinkTextArray(rowcount)) ="Twitter" or trim(LinkTextArray(rowcount)) ="Google+" or trim(LinkTextArray(rowcount)) ="LinkedIn" or trim(LinkTextArray(rowcount)) ="YouTube" or trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>

    <% if trim(LinkTextArray(rowcount)) ="Facebook"  then %>
        <center><img src = "/images/FacebookBig.jpg"  width = "150"></center><br />
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Twitter"  then %>
         <center><img src = "/images/TwitterBig.jpg"  width = "150"></center><br />
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Google+"  then %>
         <center><img src = "/images/Google+Big.jpg"  width = "150"></center><br />
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="LinkedIn"  then %>
         <center><img src = "/images/LinkedInBig.jpg"  width = "150"></center><br />
    <% end if %>
        <% if trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>
         <center><img src = "/images/YahooBig.jpg"  width = "150"></center><br />
    <% end if %>
      <% if trim(LinkTextArray(rowcount)) ="YouTube"  then %>
        <center> <img src = "/images/YouTubeBig.jpg"  width = "150"></center><br />
    <% end if %>
<% else %>

<center><img src = "<%= LinkImageArray(rowcount)%>" width = "150"></center><br>
<% end if %>
	 <center> <br /> <a href = "AdminLinkPhotos.asp?LinkID=<%= LinkIDArray(rowcount)%>" class = "body" ><b>Edit Photo</b></a><br /></center>

		
<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>" class = "regsubmit2 body" >
    <% if trim(LinkTextArray(rowcount)) ="Facebook" or trim(LinkTextArray(rowcount)) ="Twitter" or trim(LinkTextArray(rowcount)) ="Google+" or trim(LinkTextArray(rowcount)) ="LinkedIn" or trim(LinkTextArray(rowcount)) ="YouTube" or trim(LinkTextArray(rowcount)) ="Yahoo!"  then %>
 <b><%= LinkTextArray( rowcount)%></b>
 <input type = "hidden" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" class = "regsubmit2 body"  ><br />
  <% else %>
      <b> <input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "20" class = "regsubmit2 body" /> </b>
 <% end if %><br />
<small>http://</small><input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" size = "25" class = "regsubmit2 body" ><br />
<b>Description:</b><br />
			<textarea name="LinkDescription(<%=rowcount%>)"  cols="40" rows="10"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea><br />
<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
<Input type = hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes"  class = "regsubmit2 body" ></center>
			</form>


<br />

<a name="Other"></a>
<H2>Other Links</H2>
 
<%    

conn = "Provider=Microsoft.Jet.OLEDB.4.0;" & _
"Data Source=" & server.mappath(DatabasePath) & ";" & _
						"User Id=;Password=;" '& _ 
 sql = "select * from Links, Linkcategories where not (CategoryName = 'Social Networking') and not (CategoryName = 'Online Marketplaces') and Links.CatID = LinkCategories.CatID"

'response.write (sql)
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
	
	
Recordcount = rs.RecordCount +1
%>
		<form action= 'AdminLinkhandleform.asp' method = "post">
<%
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
%>

	 <% If Len(LinkImageArray(rowcount)) < 2 Then
	         LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg"
		End If 
 if LinkImageArray(rowcount) = "/uploads/ImageNotAvailable.jpg" then
 else %>
			<center><img src = "<%= LinkImageArray(rowcount)%>" width = "150"></center><br>
			<% end if %>
		 <center> <br /> <a href = "AdminLinkPhotos.asp?LinkID=<%= LinkIDArray(rowcount)%>" class = "body" ><b>Edit Photo</b></a><br /><br /></center>


		<input type = "hidden" name="LinkID(<%=rowcount%>)" value= "<%= LinkIDArray( rowcount)%>"  >

		 
		 <% 		CatCounter= 0
					SubCatCounter2 = 0 %>
		          <select size="1" name="CatID(<%=rowcount%>)" class = "regsubmit2 body">
					<option name = "ALinkID0" value= "<%= CatIDArray2(rowcount)%>" selected><%= CatNameArray(rowcount)%></option>
					<% count = 1
						While CatCounter < FinalCatCounter
						CatCounter= CatCounter +1
					%>
						<option value="<%=CatID(CatCounter,0)%>">
							<%=CategoryName(CatCounter,0)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select><br />


	<b>Title:</b> <input type = "Text" name="LinkText(<%=rowcount%>)" value= "<%= LinkTextArray( rowcount)%>" size = "20" class = "regsubmit2 body" /><br />
	http://<input type = "Text" name="Link(<%=rowcount%>)" value= "<%= LinkArray( rowcount)%>" size="20" class = "regsubmit2 body" ><br />
	<b>Description:</b><br />
	<textarea name="LinkDescription(<%=rowcount%>)"  cols="30" rows="7"   class = "body"  ><%= LinkDescriptionArray( rowcount)%></textarea><br />
					


<%
		rowcount = rowcount + 1
	   rs.movenext
	Wend
TotalCount=rowcount 
	rs.close
  set rs=nothing
  set conn = nothing
%>
			<Input type = Hidden name='TotalCount' value = <%=TotalCount%> >
			<center><input type=submit value = "Submit Changes"  class = "regsubmit2 body" ></center>
			</form>
		</td>
</tr>
</table>

<br><br>

<% end if %>
<br><br>

    <!--#Include file="AdminFooter.asp"-->

</Body>
</HTML>