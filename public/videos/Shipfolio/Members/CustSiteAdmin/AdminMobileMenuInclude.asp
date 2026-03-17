	<%  sql2 = "select * from Pagelayout where PageAvailable = True and not (PageName='Farm Store (Header)')  and not (PageName='Photo Galleries') order by Pagename"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
  
	While Not rs2.eof 
	 if rs2("PageName") = "Alpacas For Sale" then 
	    ShowAlpacas = True
	end if  
	
	 if rs2("PageName") = "Articles" then 
	  ShowArticles = True
	end if  
	
	 if rs2("PageName") = "Galleries" then 
	   Showgallery = True
	 end if 	
	 if rs2("PageName") = "Farm Store" then 
	   ShowProducts = True
	end if  
	
	 if rs2("PageName") = "Blog" then
	 ShowBlog = True
	end if 
	
	if rs2("PageName") = "Coming Attractions" then 
	ShowComingattractionspage = True
	end if
	rs2.movenext
 Wend %>


<table width = "<%=Pagewidth %>" align = "center" border="0" cellspacing="0" cellpadding="0" bgcolor = "black">
<tr><td>
	<ul id="menu"><li><a href = "/ADMINISTRATION/Default.asp" >Home</a></li>
	<% if LivestockAvailable = True then %>
	<li><a href= "/ADMINISTRATION/Default.asp#Animals" >Animals</a></li>
	<% end if %>
	<li><a href = "/ADMINISTRATION/Default.asp#Pages" >Pages</a></li>
	<% if EcommerceAvailable = True then %>
	<li><a href="/ADMINISTRATION/Default.asp#Products" >Products</a></li>
	<% end if  %>	
	<li><a href="/ADMINISTRATION/AdminAccountMaintenance.asp" >Contact Info</a></li></ul>
</td></tr></table>
