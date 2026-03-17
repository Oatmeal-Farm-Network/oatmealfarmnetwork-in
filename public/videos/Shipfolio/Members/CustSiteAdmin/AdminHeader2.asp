 <% Current = "Dashboard" %>
 <!--#Include file="AdminSecurityInclude.asp"--> 
<table width = "100%" bgcolor = "white" border="0" cellspacing="0" cellpadding="0" >
<tr><td><table width = "980" align = "center" border="0" cellspacing="0" cellpadding="0" >
<tr><td class = "body" height = "80">
<img src =  "/administration/images/CMSLogo.jpg" alt = "Content Management System" height = "60">
<td>
<td width= "214" align = "right">
	<a href = "/" target = "blank" class = "body" >Go To Your Website</a>&nbsp;&nbsp;&nbsp;
	<a href = "AdminLogout.asp" class = "body" >Logout</a>&nbsp;&nbsp;&nbsp;
</td>
</tr>
</table></td></tr></table>
<table width = "980" align = "center" border="0" cellspacing="0" cellpadding="0" >
<TR><TD align = "left"><!--#Include file="AdminHeaderTabsInclude.asp"--> </TD></TR>
<tr><td >

<ul id="menu">
	<li><a href = "Default.asp"  >Dashboard Home</a></li>
	<li>
		<a href="#">Animals</a>
		<ul>
			<li><a href = "AdminAnimalAdd1.asp" >Add an Animal</a></li>
			<li><a href = "AdminAnimalEdit.asp"   >Edit an Animal</a></li>
			<li><a href = "AdminAnimalDelete.asp"   >Delete an Animal</a></li>
			<li><a href = "AdminPhoto.asp"  >Upload Photos</a></li>
			<li><a href = "AdminOutsideStud.asp" >Other People's Studs</a></li>
			<li><a href = "AdminOutsidePhoto.asp" >Pics of Other People's Studs</a></li>
			<li><a href = "AdminFemaleData.asp" >Breeding Record</a></li>
		</ul>
	</li>
	<li>
		<a href="#">Your Pages</a>
		<ul>
			<%  sql2 = "select * from Pagelayout where PageAvailable = True and not (PageName='Farm Store (Header)')  and not (PageName='Photo Galleries') order by Pagename"	
	acounter = 1
	Set rs2 = Server.CreateObject("ADODB.Recordset")
	rs2.Open sql2, conn, 3, 3 
  
	While Not rs2.eof 
%> 


	<% if rs2("PageName") = "Articles" then %>
	<li>
		<a href = "<%=rs2("EditLink")%>" ><%=rs2("PageName")%></a>
		<ul>
        <li><a href = "AdminArticleAdd.asp" >Add Article</a></li>
		<li><a href = "AdminArticleEdit.asp" >Edit Articles</a></li>
		<li><a href = "AdminArticleDelete.asp" >Delete Articles</a></li>
		<li><a href = "AdminArticleCategoriesSet.asp" >Article Categories</a></li>
		<li><a href = "AdminPageMaintenance.asp?pagename=Alpaca Library" >Article Page Header</a></li>
		</ul>
	</li>
	<% else  %>
	<li ><a href = "<%=rs2("EditLink")%>" ><%=rs2("PageName")%></a></li>
	<% end if %>	
 <% 
	rs2.movenext
 Wend %>
 
 
		</ul>
	</li>
	<li>
		<a href="#">Photo Gallery</a>
		<ul>
			<li><a href = "AdminGalleryAddImage1.asp" >Add Images</a></li>
			<li><a href = "AdminGalleryEditImages.asp" >Edit Images</a></li>
			<li><a href = "AdminGallerySetCategories.asp" >Gallery Categories</b></a></li>
		</ul>
	</li>
	<li>
		<a href="#">Your User Information</a>
		<ul>
			<li><a href = "AdminAccountMaintenance.asp" >Contact Information</a></li>
			<li><a href = "AdminPasswordChange.asp" >Change Password</a></li>
		</ul>
	</li>
</ul>


</td>
</tr>
</table>
<table width="980"   border="0" cellpadding=0 cellspacing=0 bgcolor = "white" align = "center">
	<tr>
		<td >
			<br>