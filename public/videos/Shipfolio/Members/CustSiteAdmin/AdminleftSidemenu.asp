<base target="_parent"> 
<br /><table border = 0 cellspacing = 0 cellpadding = 0 width = 200 >
<tr><td width = '200'valign = "top">
<% 
FoundCurrent3 =  False
if Current3="AlpacaEdit" then
FoundCurrent3 = True %>
<!--#Include virtual="/administration/AdminleftsidemenuAnimalsInclude.asp"-->
<!--#Include virtual="/administration/AdminleftsidemenuPagesInclude.asp"-->
<!--#Include virtual="/administration/Adminleftsidemenuproductsinclude.asp"-->
<% end if %>

<% if Current3 = "EditProduct" then 
FoundCurrent3 = True %>
<!--#Include virtual="/administration/Adminleftsidemenuproductsinclude.asp"-->
<!--#Include virtual="/administration/AdminleftsidemenuPagesInclude.asp"-->
<!--#Include virtual="/administration/AdminleftsidemenuAnimalsInclude.asp"-->
<% end if %>

<% if Current3 = "PageContent" or Current3="LinkHeading" or len(Current3) = 0 or FoundCurrent3 =  False then %>
<!--#Include virtual="/administration/AdminleftsidemenuPagesInclude.asp"-->
<!--#Include virtual="/administration/AdminleftsidemenuAnimalsInclude.asp"-->
<!--#Include virtual="/administration/Adminleftsidemenuproductsinclude.asp"-->
<% end if %>
</td></tr></table>
