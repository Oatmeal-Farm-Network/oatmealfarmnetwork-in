<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>

<% Current1="Products"
Current2 = "SuggestCategory" %> 
<!--#Include file="MembersHeader.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth -32%>"><tr><td class = "body" align = "left">
<H1><div align = "left">Suggest New Product Categories</div></H1>
<% SuggestedCategory=request.QueryString("SuggestedCategory")
if SuggestedCategory="True" then %>
<b>Thanks for your suggestion. We will let you know if we add the category.</b><br />
<% end if %>
If you need a new category or sub-category added please use the form below to let know what you would like us to add.
<form name=form method="post" action="membersSendCategoryEmail.asp">
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=5 cellspacing=5 width = "600" align = "center">
<tr><td colspan="4" align="center"  class = "body"> 

<input type = "hidden" name="page" value="<%=pagename%>">
</td></tr>
<tr><td height="20" class = "body2" align = "right" width = "200">Your Ranch Name</td>
<td height="20" class = "body" > 
<input name="Name" size = "30" value = "<%=BusinessName %>" class = formbox>
</td></tr>
<tr><td height="20" class = "body2" align = "right"> Your E-mail Address</td>
<td height="20" class = "body"> 
<INPUT TYPE="text" NAME="Email" size="30" value = "<%=PeopleEmail %>" class = formbox>
</td></tr>
<tr><td height="20" class = "body2" align = "right" valign = "top">Suggested Categories</td>
<td height="20" class = "body">
<TEXTAREA NAME="Categories" cols="22" rows="10" wrap="file" class = formbox></textarea>
</td></tr>
<tr><td height="20" class = "body2" align = "right" valign = "top">Suggested Sub-Categories</td>
<td height="20" class = "body">
<TEXTAREA NAME="SubCategories" cols="22" rows="10" wrap="file" class = formbox></textarea>
</td></tr>
<tr><td  align = "center" colspan = "2">
<input type="Submit" value = "Send Categories" class = "regsubmit2">
</form>
</td></tr></table>
</td></tr></table>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>