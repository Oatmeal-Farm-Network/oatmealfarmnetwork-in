<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>

</head>
<body border="0"  marginwidth="0" marginheight="0"  align = "center" >
    <!--#Include file="MembersGlobalVariables.asp"-->
<% Current2="MembersHome" %> 
<!--#Include file="MembersHeader.asp"-->
<% If not rs.State = adStateClosed Then
rs.close
End If

Returnpage = "Advertisinghomebannerads.asp"
%>
<!--#Include file="SiteMembersTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "<%=screenwidth %>"><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Advertising</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center">
<br />
<a href = "Advertisinghomebannerads.asp" class= "body">Banner Ads</a> | <a href = "AdvertisinghomeSearchads.asp" class= "body">Search Ads</a>




<form action= 'AdvertisingAddAd.asp' method = "post"  >
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden">
<br />
<br />
<b><center>Add an Ad</center></b>
<table   border = "0" width = "300" class = "roundedtopandbottom" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0><tr >
<td class = "body2" align = "center" ><b>Enter Date & submit</b></td>
</tr>
<tr>
<td class = "body" align = "center">
Month: <select size="1" name="NewAdDateMonth" >
<option value="" selected></option>
<option value="1">1</option>
<option  value="2">2</option>
<option  value="3">3</option>
<option  value="4">4</option>
<option  value="5">5</option>
<option  value="6">6</option>
<option  value="7">7</option>
<option  value="8">8</option>
<option  value="9">9</option>
<option  value="10">10</option>
<option  value="11">11</option>
<option  value="12">12</option>
</select>/ 
Year: 	<select size="1" name="NewAdDateYear" >
	<option value="" selected></option>
			/		
<% currentyear = year(date) 
For yearv=currentyear To (year(date) + 2)  %>
<option value="<%=yearv%>"><%=yearv%></option>		
<% Next %></select>
</td>

</tr>

<br>
</td></tr>
<tr><td colspan = "2" align = "center">
<input name="AdType" value="Banner Ad" type = "hidden">
<input type=submit Name="Submit Auction"  value = "Add Ad" class=  "regsubmit2">
</form>
</td></tr>
</table>



<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "920">
<tr><td class = "body" align = "left" colspan = "3">	

<% 

monthcounter =1
BannerAdsExisting = 0
currentdate = dateadd("m", -1, now )
while Monthcounter < 13
currentdate = dateadd("m", 1, currentdate )

Query =  "Select AdID from Ads  where AdType='Banner Ad'" 
	rs.Open Query, conn, 3, 3
	if not rs.eof then 
	 BannerAdsExisting = BannerAdsExisting + 1
	end if
rs.close
Monthcounter  = Monthcounter  + 1
wend


if BannerAdsExisting > 0 then %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Banner Ads</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom body" align = "center" >
<br />
<table border = "0" cellspacing="0" cellpadding = "0" align = "center"  width = "900">


<% 
if PeopleID = 1016 then
Query =  "Select * from Ads  where AdType='Banner Ad' order by adYear Desc, Admonth desc"  
rs.Open Query, conn, 3, 3
x = 0
while not rs.eof 
 x = x + 1
AdID = rs("AdID")
AdImage  = rs("AdImage") 
AdLink = rs("AdLink")
Link1=""
Link2 = ""
if len(AdLink) > 3 then
Link1=  AdLink
Link2= "http://" & AdLink
else
 Link2 = "/Ranches/RanchHome.asp?CurrentPeopleID=" & PeopleID
end if

if even = True then
even = False %>
<tr bgcolor = "orange">
<% else
even = True %>
<tr>
<% end if %>
<td class = "body" valign = "top">
<h2>Ad Month: <%= rs("AdMonth") %>/<% = rs("AdYear") %></h2><br />
<% If Len(AdImage) > 1 and Len(AdImage) < 131 then%>
<% If Len(Link2) > 1  then%>
 <a href = "<%=Link2 %>" target = "blank">
 <% end if %>
<img src = "<%= AdImage%>" width ="400" height = "100" border = "0">
<% If Len(Link2) > 1  then%>
 <a>
 <% end if %>
<% End If %>

<form action= "MembersAdsDeletad.asp?PeopleID=<%=PeopleID%>&AdType=Banner Ad&AdID=<%=AdID%>" method = "post">

<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >

<center><input type=submit value="DELETE ENTIRE AD!" class = "regsubmit2"></center>
</form>
 &nbsp;
<br />
</td>
<td>
<b><a class="tooltip" href="#"><b>Banner Ad (400px X 100px):</b><span class="custom info"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><div align = "left"><em>Banner Ad</em>Banner Ads are <b>400 pixels wide by 100 pixels high</b>. They appears on major pages throughout Alpaca Infinity and are displayed in a <b>pool of only 40 ads</b>.</div></span></a></b>
<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadAdImagehandle.asp?Returnpage=<%=Returnpage %>&PeopleID=<%=PeopleID%>&AdType=Banner Ad&AdID=<%=AdID%>" >
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >			
<% If AdImage = "ImageNotAvailable.jpg" Then %>
Current Ad Image Name: Not Defined<br>
<% End If %>
<input name="attach1" type="file" size=65 class = "regsubmit2" >
<input  type=submit value="  Upload " class = "regsubmit2"></form>
<% If Len(AdImage) > 1 then%>
<form action= "MembersAdsRemoveImage.asp?PeopleID=<%=PeopleID%>&AdType=Banner Ad&AdID=<%=AdID%>" method = "post">
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >
<center><input type=submit value="Remove Image" class = "regsubmit2"></center>
</form>
<% end if %> &nbsp;
<a class="tooltip" href="#">Advertisement link:<span class="custom info body"><img src="/images/logoTip.png" alt="Alpaca Infinity Screen Tip" height="48" width="48" /><div align = "left"><em>Advertisement link:</em>You can link your advertisement to another website if you wish. If you don't specify a link then your ad will link to your Alpaca Infinity Farm Home Page.</b></div></span></a>

<form name="Members Add Ad Link" method="POST"  action="MembersAddAdLink.asp?PeopleID=<%=PeopleID%>&AdID=<%=AdID%>&adType=Banner Ad" >

Http://<input type = "text" name='AdLink' size=56  align = "right" Value= "<%= Link1 %>" >
<center><input type=submit value="Add Link" class = "regsubmit2"></center>
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >
</form>
<% If Len(Link1) > 1 then%><br />
<form action= "MembersAdsRemoveLink.asp?PeopleID=<%=PeopleID%>&AdID=<%=AdID%>&AdType=Banner Ad" method = "post">
<center><input type=submit value="Remove Link" class = "regsubmit2"></center>
<input name="Returnpage" value="<%=Returnpage %>" type = "hidden" >
</form>
	<% end if %> &nbsp
</td>
</tr>
<% rs.movenext
wend 
rs.close
end if

%>
</table>
<% end if %>

</td>
</tr>
</table>

</td>
</tr>
</table>
<br>

 <!--#Include virtual="/Footer.asp"--> 

</BODY>
</HTML>