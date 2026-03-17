<html>
<head>
<link rel="stylesheet" type="text/css" href="/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
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
<body>


<!--#Include file="AdminFrameGlobalVariables.asp"-->
<% ID= Request.QueryString("ID") 
screenwidth = Request.Querystring("screenwidth")
DetailType =  Request.Querystring("DetailType")
Current3 = "Preview"

%>
<!--#Include virtual="/DetailDBInclude.asp"-->
<!--#Include virtual="/administration/AdminFramestyle.asp"-->


<a name = "Top"></a><table border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "<%=screenwidth-50  %>" align = "center"><tr><td  valign = "top" align = "center" valign = "top"><table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  width = "<%=screenwidth  -50 %>" align = "center"><tr><td  valign = "top" colspan = "2"><h1><%=Name%></h1></td></tr>
<tr>
<td   valign="top" width = "<%= screenwidth  - 550 %> " class = "body">
<!--#Include virtual="/GeneralStatsInclude.asp"-->
</td>
<td class = "body2" valign = "top"  width = "500" align = "center">
<!--#Include virtual="/DetailImageInclude.asp"-->
<!--#Include virtual="/SmallImages.asp"--> 
<!--#Include virtual="/ServiceSireInclude.asp"-->
<!--#Include virtual="/ProgenyInclude.asp"-->
</td>
</tr>
</table>	
</td>
</tr>
<tr>
<td class = "PagebodyBottom body" height = "408" colspan = 2>
<!--#Include virtual="/AwardsInclude.asp"--> 
<!--#Include virtual="/FiberInclude.asp"--> 
<!--#Include virtual="/AncestryInclude.asp"--> 
<br /> 

<br />
</td></tr></table></td></tr></table>
</body>