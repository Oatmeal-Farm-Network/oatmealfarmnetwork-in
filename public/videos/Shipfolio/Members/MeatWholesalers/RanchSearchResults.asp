<%   
RanchName = trim(request.form("Name"))
if len(RanchName) > 0 then
else
  RanchName = request.querystring("Name")
end if

if len(RanchName) > 0  then
   namesort = " and LOWER(BusinessName) LIKE '%" & RanchName & "%' "
else
   namesort = " "
end if
'response.write("namesort=" & namesort )


Ownersearch = trim(request.form("Ownersearch"))
if len(RanchName) > 0 then
else
  RanchName = request.querystring("Name")
end if

if len(RanchName) > 0  then
   namesort = " and LOWER(BusinessName) LIKE '%" & RanchName & "%' "
else
   namesort = " "
end if

'response.write("BusinessTypeID=" & BusinessTypeID)
sql = "SELECT * from BusinessView where BusinessTypeID = " &  BusinessTypeID & " AND country_id = '" & Currentcountry_id & "' " & _
       statesort & citysort & namesort & ownersort & _
       "ORDER BY custLastAccess DESC, BusinessName, Logo ASC"

'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3

totalrecords =rs.recordcount
' Get current page number from query string



pagescount = clng(totalrecords)/10
'if len(pagescount) = 1 then
'addpage = -1
'else
'addpage = 0
'end if
totalpages = int(pagescount) 

pagenumber = request.querystring("pagenumber")
if len(pagenumber) > 0 then
else
pagenumber = 1
end if

if pagenumber = 1 then
startlimit = 0
else
startlimit = ((pagenumber-1) * 10) + 1
end if

endlimit = startlimit + 10
limit = " limit " & startlimit & " , 10 " 

' Calculate start and end indices for the current page
adstart = (PageNumber - 1) * 10 + 1
adend = PageNumber * 10



' Determine pagination range (for large totalpages, only show a few pages around the current one)
maxPageDisplay = 5 ' Number of page numbers to display at a time
startPage = CurrentPageNumber - 2
If startPage < 1 Then startPage = 1
endPage = startPage + maxPageDisplay - 1
If endPage > totalpages Then endPage = totalpages
If endPage - startPage < maxPageDisplay - 1 Then startPage = endPage - maxPageDisplay + 1
If startPage < 1 Then startPage = 1
%>
<div align = "right">
    <% if round(pagescount) > 9 then %>
        <%= adstart %> - <%= adend %> of <%= round(pagescount) %> Results &nbsp;
     <% end if %>
    </div><br>
<div  align="right">
    <% If totalpages > 10 Then %>
    <div class="row" style="justify-content: flex-end;">
        
        <% If CurrentPageNumber > 1 Then %>
        <div class="col Pagebox" style="width:13px; min-width:13px; max-width:13px">
            <a href="default.asp?State=<%= State %>&City=<%= City %>&Name=<%= Name %>&Ownersearch=<%= Ownersearch %>&pagenumber=1" class="NumLinks"><b>First</b></a>
        </div>
        <% End If %>

        <% If CurrentPageNumber > 1 Then %>
        <div class="col Pagebox" style="width:13px; min-width:13px; max-width:13px">
            <a href="default.asp?State=<%= State %>&City=<%= City %>&Name=<%= Name %>&Ownersearch=<%= Ownersearch %>&pagenumber=<%= PageNumber - 1 %>" class="NumLinks"><b><</b></a>
        </div>
        <% End If %>

        <% For i = startPage To endPage %>
        <div class="col Pagebox" style="width:23px; min-width:23px; max-width:23px">
            <% If i = CurrentPageNumber Then %>
                <span class="NumLinks active"><b><%= i %></b></span>
            <% Else %>
                <a href="default.asp?State=<%= State %>&City=<%= City %>&Name=<%= Name %>&Ownersearch=<%= Ownersearch %>&pagenumber=<%= i %>" class="NumLinks"><b><%= i %></b></a>
            <% End If %>
        </div>
        <% Next %>

         <% If CurrentPageNumber < totalpages Then %>
         <div class="col Pagebox" style="width:23px; min-width:23px; max-width:23px" >
            <a href="default.asp?State=<%= State %>&City=<%= City %>&Name=<%= Name %>&Ownersearch=<%= Ownersearch %>&pagenumber=<%= PageNumber + 1 %>" class="NumLinks"><b>></b></a>
        </div>
        <% End If %>

        <% If CurrentPageNumber < totalpages Then %>
        <div class="col Pagebox" style="width:43px; min-width:43px; max-width:43px">
            <a href="default.asp?State=<%= State %>&City=<%= City %>&Name=<%= Name %>&Ownersearch=<%= Ownersearch %>&pagenumber=<%= totalpages %>" class="NumLinks"><b>Last</b></a>
        </div>
        <% End If %>
        <div class="col" style="width:43px; min-width:43px; max-width:43px">
        </div>
    </div>
    <% End If %>

    <div class="col" width="20">
    </div>
</div>





<br><br />

<%

if rs.eof then %>
We currently do not have any listings that fit that criteria.
<%
end if
X =1
'response.write("adstart =" & adstart )
if rs.eof then
else
    rs.MoveFirst

rs.Move adstart - 1
end if


 while not rs.eof  and x < endlimit

 X = X +1 


Logo = rs("Logo")


BusinessID = rs("BusinessID")
'response.write("BusinessID = " & BusinessID)
Owners= rs("Owners")
weblink = rs("weblink")
BusinessName = rs("BusinessName")
PeopleShowAddress = rs("PeopleShowAddress")
PeopleShowMap = rs("PeopleShowMap")
PeopleShowPhone = rs("PeopleShowPhone")
PeopleFirstName = rs("PeopleFirstName")
PeopleMiddleInitial= rs("PeopleMiddleInitial")
PeopleLastName = rs("PeopleLastName")
PeoplePhone = rs("PeoplePhone")
PeopleCell = rs("PeopleCell")
PeopleFax = rs("PeopleFax")
PeopleEmail = rs("PeopleEmail")
AddressStreet = rs("AddressStreet")
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")

WebsitesID= rs("WebsitesID")
BusinessFacebook = rs("BusinessFacebook") 
BusinessX = rs("BusinessX") 
BusinessInstagram = rs("BusinessInstagram")
BusinessPinterest= rs("BusinessPinterest")
BusinessTruthSocial = rs("BusinessTruthSocial")
BusinessBlog = rs("BusinessBlog")
BusinessYouTube = rs("BusinessYouTube")
BusinessOtherSocial1 = rs("BusinessOtherSocial1")
BusinessOtherSocial2 = rs("BusinessOtherSocial2")



str1 = lcase(Logo)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "https://www.livestockofamerica.com")
End If  


if len(Currentcountry_id) > 0 then
 sql2 = "select  * from Country where country_id = " & Currentcountry_id
  

    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
 if  Not rs2.eof then 
AddressCountry = rs2("name")
end if
rs2.close
end if


if len(WebsitesID) > 0 then
 sql2 = "select distinct * from Websites where WebsitesID = " & WebsitesID
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    rs2.Open sql2, conn, 3, 3   
 if  Not rs2.eof then 
PeopleWebsite = rs2("Website")
end if
rs2.close
end if

ShowRanchLinks = False
if ShowRanchlinks = True then
    LinkText= "View Listing"
    RanchProfileLink = "/Farms/FarmListing.asp.asp?BusinessID=" & BusinessID 
else
    RanchLink = "/Farms/FarmListing.asp?CurrentBusinessID=" & BusinessID 
    RanchProfileLink = "/Farms/FarmListing.asp?BusinessID=" & BusinessID
    LinkText= "Contact"
end if

If Len(Logo) > 2 then

str1 = lcase(Logo)
str2 = "http://www.alpacainfinity.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "https://www.livestockoftheworld.com")
End If  

str1 = lcase(Logo)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
Logo= Replace(str1, str2 , "livestockoftheworld.com")
End If  


str1 = lcase(Logo)
str2 = "http:"
If InStr(str1,str2) > 0 Then
	Logo= Replace(str1, str2 , "https:")
End If  
    end if
%>

<div class="container">

    <div class="row">
        <div class="col-2 body" style="width: 100%; height: 45px; background-color:#441c15">
             <img src ="https://www.livestockofamerica.com/images/px.gif" height="1px" width ="100%" />
            <a href="<%=RanchLink %>" class = "AnimalListname" >
                <%=BusinessName %></a>
        </div>
    </div>

    <div class="row">
        <div class="col" style="max-width: 200px; text-align: center;">
            <% if len(logo) > 4 then %>
               <br /> <a href="<%=RanchLink %>"><img src="<%=Logo%>" width="180" /></a>
            <% end if %>
        </div>
        <div class="col body" style="vertical-align: top;">

            <% if len(Owners) > 2 then %>
                <%=Owners %><br />
            <% end if %>

            <% if len(AddressCity) > 1 or len(AddressState) > 1 or len(AddressCountry) > 0 then %>
                <% if len(AddressCity) > 1 then %>
                    <%=AddressCity %>, 
                <% end if %>
                <% if len(AddressState) > 1 then %>
                <%=AddressState %>
                <% end if %>
                &nbsp;<%=AddressCountry %>&nbsp;<br />
            <% end if %>

            <% if len(PeoplePhone) > 1 then %>
                <%=PeoplePhone %><br />
            <% end if %>

            <% if len(PeopleWebsite) > 4 then %>
                <a href="http://<%=PeopleWebsite%>" class="body" target="_blank"><%=PeopleWebsite  %></a><br />
            <% end if %>
            <a href="<%=RanchLink %>" class="body2"><%=LinkText%></a>
            <br />

              <%If len(BusinessLinkedIn) > 0 then %>
                    <a href="<%=BusinessLinkedIn %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/LinkedIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessFacebook) > 0 then %>
                    <a href="<%=BusinessFacebook %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/facebook.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessX) > 0 then %>
                    <a href="<%=BusinessX %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/TwitterX.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessInstagram) > 0 then %>
                    <a href="<%=BusinessInstagram %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/instagramicon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessPinterest) > 0 then %>
                    <a href="<%=BusinessPinterest %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/PinterestLogo.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessTruthSocial) > 0 then %>
                    <a href="<%=BusinessTruthSocial %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/Truthsocial.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessBlog) > 0 then %>
                    <a href="<%=BusinessBlog %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/BlogIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessYouTube) > 0 then %>
                    <a href="<%=BusinessYouTube %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/YouTube.jpg" height=" 20" /></a>
                    <% end if %>
                    <%If len(BusinessOtherSocial1) > 0 then %>
                    <a href="<%=BusinessOtherSocial1 %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>

                    <%If len(BusinessOtherSocial2) > 0 then %>
                    <a href="<%=BusinessOtherSocial2 %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>
            <br /></br>
            <form  name=Details method="post" action="<%=RanchProfileLink %>">
                <input type="submit" value="Profile" class = "regsubmit2">
            </form>

            <br />

        </div>
    </div>

</div>

<% rs.movenext
wend
rs.close
 %>




<% showpagenumbers = True
if showpagenumbers then
 
 if totalpages > 1 then
%>

 <table width = "100%" border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" align = "right" valign = "top">
<tr><td class = "NumLinks" valign = "top" align = "right">
<table><tr>
<td align = left>
<% if cint(Currentpagenumber) > 1 and cint(totalpages) > 3 then %>
<td class = "Pagebox" width = "12"><a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber - 1 %>" class = "NumLinks"><b><</b></a></td>
<% end if %>

<% 
'************************************************
' If Less then 11 pages
'************************************************
if screenwidth < 700 then
endnum = 5
else
endnum = 10
end if

if totalpages < (endnum + 1) then %>
<td>
<% for pagenumber = 1 to totalpages %>

<% if cint(pagenumber) = cint(currentpagenumber) then %>
 <td class = "PageboxCurrent" width = "36">
 <a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber %>" class = "NumLinksCurrent"><b><center><%=pagenumber %></center></b></a></td>
 <% else %>
<td class = "Pagebox" width = "18">
<a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber %>" class = "NumLinks"><b><center><%=pagenumber %></center></b></a></td>
<% end if %>



<% next %>
</td>

<% else %>

<% if Currentpagenumber < (endnum + 1) then 
    start = 1
   else
    start = Currentpagenumber - 5
   end if
%>
<% for pagenumber = Start to (Start + endnum) %>

<% if cint(pagenumber) = cint(currentpagenumber) then %>
 <td class = "PageboxCurrent" width = "12">
 <a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber %>" class = "NumLinksCurrent"><b><%=pagenumber %></b></a></td>
 <% else %>
 <% if pagenumber > 0 and pagenumber < (totalpages + 2) then %>
<td class = "Pagebox" width = "12">
<a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber %>" class = "NumLinks"><b><%=pagenumber %></b></a></td>
<% end if %>
<% end if %>



<% next %>

<% end if %>
<% if cint(Currentpagenumber) < cint(totalpages) and cint(totalpages) > 3 and (not cint(totalpages) < 11) then %>
<td class = "Pagebox" width = "12"><a href = "default.asp?State=<%=State %>&City=<%=City %>&Name=<%=Name %>&Ownersearch=<%=Ownersearch %>&pagenumber=<%=pagenumber + 1 %>" class = "NumLinks"><b>></b></a></td>
<% end if %>
<td width = 20></td>

</tr>
</table>

<% end if %>
<% end if %>

</td></tr></table>

