<% ID = request.QueryString("ID")
if len(ID) < 1 then
ID = Request.Form("ID")
end if


%>
<style type="text/css">
.blink_text {
-webkit-animation-name: blinker;
-webkit-animation-duration: 2s;
-webkit-animation-timing-function: linear;
-webkit-animation-iteration-count: 1;

-moz-animation-name: blinker;
-moz-animation-duration: 2s;
-moz-animation-timing-function: linear;
-moz-animation-iteration-count: 1;

 animation-name: blinker;
 animation-duration: 2s;
 animation-timing-function: linear;
 animation-iteration-count: 1;

 color: green;
}

@-moz-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@-webkit-keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }

@keyframes blinker {  
 0% { opacity: 1.0; }
 50% { opacity: 0.2; }
 100% { opacity: 1.0; }
 }
 </style>
 
Current3 = <%=Current3 %>
<a href = "#Top" class = "body"></a>
<br />
<div class ="container">
<div class="row" >
<% if Current3 = "Summary" then %>
 <div class="jumplinkscellCurrent">
    <a class="jumplinks" aria-current="page" href="MemberssiteDesign.asp"><b>Summary&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="MemberssiteDesign.asp">Summary&nbsp;&nbsp;</a>
  </div>
<%end if %>
 


<% if Current3 = "WebsiteSetup" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminWebsitesetup.asp"><b>Website Setup&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminWebsitesetup.asp">Website Setup&nbsp;&nbsp;</a>
  </div>
<%end if %>


<% if Current3 = "GraphicDesign" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" aria-current="page" href="MemberssiteDesign.asp"><b>Graphic Design&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="MemberssiteDesign.asp">Graphic Design&nbsp;&nbsp;</a>
  </div>
<%end if %>

<% if Current3 = "LayoutStyles" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminStandardStylesMaster.asp"><b>Layout Styles&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminStandardStylesMaster.asp">Layout Styles&nbsp;&nbsp;</a>
  </div>
<%end if %>

<% if Current3 = "LayoutImages" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminStandardStylesmaster.asp#images"><b>Layout Images&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminStandardStylesmaster.asp#images">Layout Images&nbsp;&nbsp;</a>
  </div>
<%end if %>

<% if Current3 = "FontStyles" then %>
 <div class="jumplinkscellCurrent ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminLayoutEdit.asp"><b>Font Styles&nbsp;&nbsp;</b></a>
  </div>
<% else %> 
<div class="jumplinkscell  ">
    <a class="jumplinks" aria-current="page" href="/CustSiteAdmin/AdminLayoutEdit.asp">Font Styles&nbsp;&nbsp;</a>
  </div>
<%end if %>

</div>


</div>
<span class="border-bottom-3"></span>
<% if len(Name) > 1 then %>
<table width = "100%" class="body" style = "background-color:#bacaba"><tr><td class = "body"><b><% =Name %></b></td></tr></table>
<span class="border-bottom-3"></span>
<% end if %>