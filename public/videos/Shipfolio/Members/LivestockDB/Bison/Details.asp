<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
 <!--#Include virtual="/globalvariables.asp"-->
 <% 
ID= Request.QueryString("ID") 
if len(ID) > 0 then
else
response.redirect("default.asp")
end if 

sql = "select People.PeopleID, animals.FullName, animals.speciesid from People, animals where People.PeopleID= animals.PeopleID and id = " & ID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
if not rs.eof then
CurrentPeopleID = rs("PeopleID")
Name = trim(rs("FullName"))
Name = Trim(Name)
if len(Name) > 1 then
For y=1 to Len(Name)
spec = Mid(Name, y, 1)
specchar = ASC(spec)
if specchar < 32 or specchar > 126 then
Name= Replace(Name,  spec, " ")
end if
Next
end if
str1 = Name
str2 = "''"
If InStr(str1,str2) > 0 Then
Name= Replace(str1, "''", "'")
End If
CurrentanimalName = Name
SpeciesID = rs("speciesID")

if SpeciesID = 2 then
signularanimal = "Alpaca"
end if 
if SpeciesID = 3 then
signularanimal = "Dog"
end if 
if SpeciesID = 4 then
signularanimal = "Llama"
end if 
if SpeciesID = 5 then
signularanimal = "Horse"
end if 
if SpeciesID = 6 then
signularanimal = "Goat"
end if 
if SpeciesID = 7 then
signularanimal = "Donkey"
end if 
if SpeciesID = 8 then
signularanimal = "Cattle"
end if 
if SpeciesID = 9 then
signularanimal = "Bison"
end if 
if SpeciesID = 10 then 
signularanimal = "Sheep"
end if 
if SpeciesID = 11 then
signularanimal = "Rabbit"
end if 
if SpeciesID = 12 then
signularanimal = "Pig"
end if 
if SpeciesID = 13 then
signularanimal = "Chicken"
end if 
if SpeciesID = 14 then
signularanimal = "Turkey"
end if 
if SpeciesID = 15 then
signularanimal = "Duck"
end if 
else
end if 
rs.close
if len(CurrentPeopleID) > 0 then
else
response.Redirect("Default.asp")
end if
sql = "select  * from People where PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessID   = rs("BusinessID")
AddressID  = rs("AddressID")
Logo = rs("Logo")
end if 
rs.close
sql = "select  BusinessName from Business where BusinessID= " & BusinessID
rs.Open sql, conn, 3, 3
If not rs.eof then
BusinessName = rs("BusinessName")
end if 
rs.close
sql = "select  * from Address where AddressID= " & AddressID
rs.Open sql, conn, 3, 3
If not rs.eof then
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
end if 
rs.close
if len(AddressState) > 1 then
sql = "SELECT * from States where StateAbbreviation =  '" & AddressState & "'"
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql, conn, 3, 3   
if not rs2.eof then
StateName = trim(rs2("StateName"))
end if
rs2.close
end if
 %>
<title><%=signularanimal %> For Sale - <%=Name%> at <%= BusinessName %></title>
<meta name="Title" content="<%=Name%> - <%= BusinessName %>"/>
<meta name="description" content="<%=Name%> - <%=signularanimal %> For Sale by <%=BusinessName%> . <%=BusinessName%> is a <%=StateName%> <%=signularanimal %> ranch." />
<meta name="robots" content="index, follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1 day"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=Category %> Animals " />
<link rel="stylesheet" type="text/css" href="/style.css">

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

<%Set rs = Server.CreateObject("ADODB.Recordset")
Set rs2 = Server.CreateObject("ADODB.Recordset")
Set rs3 = Server.CreateObject("ADODB.Recordset")
dim RegistrationType(100)
dim RegistrationNumber(100)

sql = "select  People.* from People where People.PeopleID= " & CurrentPeopleID
rs.Open sql, conn, 3, 3
If not rs.eof then
WebLink = rs("WebLink")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial  = rs("PeopleMiddleInitial")
PeopleLastName= rs("PeopleLastName")
rs.close
End If 

viewstud = request.querystring("viewstud")
%>
<link rel="canonical" href="<%=currenturl %>?ID=<%=ID %>&viewstud=<%=viewstud %>" />
<!--#Include file="DetailDBInclude.asp"--> 
</HEAD>
<% if mobiledevice = True or is_iPad = true then %>
<body >
<% else %>
<body onresize="window.location.replace(window.location.href.split('?')[0]  + '?ScreenWidth=' + self.innerWidth + '&viewstud=<%=viewstud %>&ID=<%=ID %>'    );" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >
<% end if %>


<a name = "top"></a>
<%
current = "Livestock" 
Current3 = "Animals" 
CurrentBreed = "Bison" %>
<!--#Include virtual="/Header.asp"-->
<% 
if viewstud =True then %>
<font size = 1><br /></font><a href = "Studs.asp?screenwidth=<%=screenwidth %>" class = "body"><b>&nbsp;View More Listings</b></a>
<% else %>
<font size = 1><br /></font><a href = "default.asp?screenwidth=<%=screenwidth %>" class = "body"><b>&nbsp;View More Listings</b></a>
<% end if %>
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width= "<%=screenwidth %>" >
<tr><td height = 10 ></td></tr>
<tr><td bgcolor = "#314159" height = 1 ></td></tr>
<tr><td align = "left" bgcolor=#BEC9BE>
<H1><div align = "left"><%=CurrentanimalName%></div></H1>
</td></tr>
<tr><td  bgcolor = "#314159" height = 1 ></td></tr>
<tr><td  align = "center">
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top" width= "<%=screenwidth - 20  %>">
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "left"  valign ="top"  >
<tr><td><table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  align = "center" width= "<%=screenwidth -30 %>" border = "0">

<% if mobiledevice = False and screenwidth > 700 then %>
<tr><td valign="top"  align = "left" class = "body">
<!--#Include file="GeneralStatsInclude.asp"-->
</td><td class = "body" valign = "top"  width = "460">
<% else %>
<tr><td valign="top"  align = "left" class = "body">
<!--#Include file="GeneralStatsInclude.asp"-->
</td></tr>
<tr><td valign="top"  align = "center" class = "body" >
<% end if %>
<% if screenwidth > 460 then %>
<table width = 460 cellpadding = 0 cellspacing = 0 border = 0>
<% else %>
<table width = 100% cellpadding = 0 cellspacing = 0>
<% end if %>
<% if len(ARIPhoto) > 1 or len(HistogramPhoto) > 1 or len(FiberAnalysisPhoto) > 1then %>
<tr><td colspan = 2>
<% if len(ARIPhoto) > 1  then %>
<a href = "<%=ARIPhoto%>" class= "body" target = "_blank"><img src = "/images/ARIThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(HistogramPhoto) > 1 then %>
<a href = "<%=HistogramPhoto%>" class= "body" target = "_blank"><img src = "/images/HistogramThumb.jpg" border = "0" height = "50"></a>
<% end if %>
<% if len(FiberAnalysisPhoto) > 1 then %>
<a href = "<%=FiberAnalysisPhoto%>" class= "body" target = "_blank"><img src = "/images/FiberAnalysisThumb.jpg" border = "0" height = "50"></a>
<% end if %>
</td></tr>
<% end if %>

<tr><td align = "center" valign = top width = 320>
<% if noimage = true then%>
<%=click%>
<% else %>
<IMG alt="main image" class = "pictures my-foto" border=0  name=but1 src="<%=buttonimages(1)%>" align = "center" width = "300">
<% end if%>
</td>
<td valign = top>
<% if not rsA.eof then 
rsA.movefirst
counter = 0
counttotal = 16 %>
<table border = 0 cellpadding = 3 cellspacing=3 border = 0 >
<% if screenwidth > 700 and mobiledevice = false then %>
<td width = 80 valign = top>
<% While counter < counttotal and TotalPics > 1
counter = counter +1
If Len(buttonimages(counter)) > 11 then
if counter = 1 or counter = 5 then %>
<tr>
<% end if %>
<td valign = "top" align = "center" class = "small">


<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">

<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>
</td>

<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>
</tr>

<% end if %>
<% wend %>
<% else %>
</tr>
<tr><td>
<% While counter < counttotal and TotalPics > 1
counter = counter +1
If Len(buttonimages(counter)) > 11 then
if counter = 1 or counter = 5 then %>
<tr>
<% end if %>
<td valign = "top" align = "center" class = "small">
<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">

<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br><% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>
</td>

<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>


<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>


<% counter = counter +1 %>
<td valign = "top" align = "center" class = "small">
<% if len(buttonimages(counter)) > 4 then%>

<font onMouseOver="img<%=counter%>('but1'), this.style.cursor = 'hand'" 
onMouseOut="img<%=counter%>('but1')"  class = "menu">
<img src="<%=buttonimages(counter)%>" width = "70" alt = "<%=buttontitle(counter)%>" border = "0"><br>
<% If Len(buttontitle(counter)) > 2 Then %>
<small><%=buttontitle(counter)%></small>
<% End If %></font>

<% End If %>
</td>



</tr>

<% end if %>
<% wend %>

</td></tr>

<% end if %>


</table>
<% end if %>

<% if len(AnimalVideo) > 1  then 
str1 = AnimalVideo
str2 = "width"
If InStr(str1,str2) > 0 Then
AnimalVideo= Replace(str1, "width", "width = 460 widthx") %>

<tr><td colspan = 2 align = right>
<%=AnimalVideo %>
</td>
</tr>
<% End If %>

</table>

</td></tr>
<% end if %>


<% if len(Financeterms) > 6 then %>
<tr><td class = body>
<br />
<br />
<b>Financial Terms</b><br>
<%=Financeterms %>
</td></tr>
<% end if %>
</table>
</td></tr></table>

<!--#Include file="ServiceSireInclude.asp"-->
</td>
</tr></table>

<% if mobiledevice = False and screenwidth > 700 then %>
<table width = "<%=screenwidth %>" cellpadding = 0 cellspacing = 0 align = center>
<% else %>
<table border = 0 width = "<%=screenwidth -30 %>" align = center cellpadding = 0 cellspacing = 0>
<% end if %>
<tr><td valign = "top" align = left>
<!--#Include file="AwardsInclude.asp"-->
</td></tr>
<tr><td valign = "top" align = left>
<!--#Include file="FiberInclude.asp"--> 
</td></tr>
<% if screenwidth > 640 then %>
<tr><td valign = "top"  align = left>
<!--#Include file="ProgenyInclude.asp"--> 
</td></tr>
<% end if %>
<tr><td valign = "top"  align = left>
<% if screenwidth > 640 then %>
<!--#Include file="AncestryInclude.asp"-->
<% else %>
<!--#Include file="AncestryIncludemobile.asp"-->
<% end if %>

</td></tr>
<tr><td class = body valign = top> 
<br> 
<% if len(Lastupdated) > 0 then %>
<font class = body color = "#777777">Last Updated: <%=formatdatetime(Lastupdated, 2) %></font><br>
<% end if %>

</td></tr></table>

</td></tr></table> 
</td></tr></table>

</td></tr></table>

<!--#Include virtual="/AnimalCount.asp"--> 
<!--#Include virtual="/Footer.asp"--> 
</body>
</html>