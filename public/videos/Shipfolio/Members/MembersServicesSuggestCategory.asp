<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include file="MembersGlobalVariables.asp"-->
     
</head>
<body >
<% Current1="Products"
Current2 = "SuggestCategory" 
Current3 = "Suggest"%> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include File="MembersServicesJumpLinks.asp"--> 
<div class ="container roundedtopandbottom" >
<div class ="row">
    <div class ="col" align = "left">

    <H1>Suggest A New Service Categories</H1>
    </div>
</div>

<% SuggestedCategory=request.QueryString("SuggestedCategory")
if SuggestedCategory="True" then %>
<div>
	<div style="background-color: floralwhite; min-height:60px">
        <br /><b>&nbsp;&nbsp;&nbsp;Thanks for your suggestion. We will let you know if we add the category.</b><br>
	</div>
</div>
<% end if %>

<div class ="row">
    <div class ="col" align = "left">
        If you want a new category or sub-category added please use the form below to let us know what you would like us to add.<br /><br />
        <form name=form method="post" action="membersSendServiceCategoryEmail.asp">

        <input type = "hidden" name="page" value="<%=pagename%>">
        Business Name<br />
        <input name="Name" size = "30" value = "<%=BusinessName %>" style="text-align:left" class="formbox">

</div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col" align = "left">

Email Address<br />
<td height="20" class = "body"> 
<INPUT TYPE="text" NAME="Email" size="30" value = "<%=PeopleEmail %>" class = "formbox" >

    </div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col" align = "left">

Suggested Categories<br />
<TEXTAREA NAME="Categories" cols="33" rows="3" wrap="file" class = "roundedtopandbottom"></textarea>
</div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col" align = "left">
Suggested Sub-Categories<br />
<TEXTAREA NAME="SubCategories" cols="33" rows="3" wrap="file" class = "roundedtopandbottom"></textarea>
</div>
</div>
<%=HSpacer %>
<div class ="row">
    <div class ="col-11" align = "center">
        <input type="submit" value = "Send" class = "submitbutton" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br /><br />

    <br />
    </div>
    <div class ="col-1">


</div>
</form>

</div>
</div>
<!--#Include file="membersFooter.asp"-->
</Body>
</HTML>