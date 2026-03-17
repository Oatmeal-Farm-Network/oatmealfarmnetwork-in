<!DOCTYPE HTML>
<html>
<head>
<%  Pagelayoutid=19
Products = True %>
<!--#Include virtual="/GlobalVariables.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta http-equiv="Content-Language" content="en-us">
<title><%= SEOTitle %> </title>
<META name="description" content="<%= SEODescription %> ">
<link rel="stylesheet" type="text/css" href="/style.css" />
<script src="/js/jquery-1.8.2.min.js"></script>
<script src="/js/zoomsl-3.0.min.js"></script>

<script>
    jQuery(function () {
        if (!$.fn.imagezoomsl) {

            $('.msg').show();
            return;
        }
        else $('.msg').hide();

        $('.my-foto').imagezoomsl({

            innerzoommagnifier: true,
            classmagnifier: window.external ? window.navigator.vendor === 'Yandex' ? "" : 'round-loope' : "",
            magnifierborder: "5px solid #F0F0F0",
            zoomrange: [2, 3],
            zoomstart: 2,
            magnifiersize: [200, 200]
        });
    });
</script>

<style>
.round-loope{
   border-radius: 175px;
   border: 5px solid #F0F0F0;
}
</style>
</head>
<% if mobiledevice = True  then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&catID=' + CatId);" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>
<% Current = "Products" %>
<!--#Include virtual="Header.asp"-->
 <!--#Include file="ProdDetailDBInclude.asp"--> 

<table border="0"   cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "center" width = "<%=screenwidth -30 %>">
<tr>
<td class = "body"  valign = "top">
<table  valign = "top">
<tr><td valign = "top">
<%
if not rsA.eof And foundimagecount > 1 Then
%>
<table border="0" cellspacing="0" align = "left" valign = "top" >
<tr><%rsA.movefirst
counter = 0
counttotal = rsA.recordcount
counttotal = 8
'response.write("counttotal=" & counttotal)
While counter < counttotal
counter = counter +1
If counter = 5 Then
%>
</tr>
<tr><%
End if
if Len(buttonimages(counter)) > 10  then
%><td valign = "top" align = "center">
<font 
onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "75" alt = "<%=buttontitle(counter)%>" border = "0">
<% If Len(buttontitle(counter)) > 1 Then %>
<br>
<small><%=buttontitle(counter)%></small></font>
<% End If %>
</td>
<%
end if
if counter< counttotal then
'rsA.movenext
end if
Wend %>
</tr>
</table>
<% end if%>
</td></tr>
<tr><td valign = "top" >
<% if foundimagecount < 1 then%>
<table valign = "top" border = "0"   leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 >
<tr><td  valign = "top">
<%=click%>
</td></tr></table>
<% else %>
<table border = "0"  valign = "top" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0  >
<tr><td valign = "top">
<IMG alt="main image" class = "pictures my-foto" border=0  name='but1' src="<%=buttonimages(1)%>" align = "center" width = "400">
</td></tr></table>
<% end if%>
</td></tr></table>
</td>
<td width = "5"><img src = "images/px.gif" width = "1" height = "1" alt = "Products for Sale"/></td>
<td valign = "top">
<!--#Include file="ProdDetailFactspaypal.asp"--> 
</td></tr></table>
</td></tr></table>
<% screenwidth = screenwidth - 145 %>
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>