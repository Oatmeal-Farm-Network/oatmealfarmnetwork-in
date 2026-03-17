<%
oldanimalid= "0"
	roworder = "nocolor"
While Not rs.eof 
			counter = counter +1	
			
			newanimalid= rs("id")		
if rs.recordcount > 1 then		
while oldanimalid = newanimalid and not rs.eof
  rs.movenext
  if not rs.eof then
  newanimalid= rs("ID")
  end if
wend
 end if   
for x=1 to 1
DueDate	= ""
BredTo	= ""
ExternalStudID	= 0
ServiceSireID	= 0
if rs.eof then
exit for
end if 
alpacaID = rs("id")
alpacasPrice= rs("Price")
ShowPrices= rs("ShowPrices")
Discount= rs("Discount")

Category = rs("Category")
Fullname = rs("FullName")
str1 = Fullname
str2 = "''"
If InStr(str1,str2) > 0 Then
Fullname= Replace(str1, "''", "'")
End If
%>
<tr><td class = "body">
<a href = "details.asp?ID=<%=rs("ID") %>&CurrentPeopleID=<%=CurrentpeopleID %>" class = "body"><%=FullName %></a> <%=rs("Color1") %>&nbsp;  

<% 
Free= rs("Free")
if Free ="True" then %>
      Free
   <%   end if
Sold = rs("Sold")
Price = clng(rs("Price"))
Discount = clng(rs("Discount"))
if ShowPrices = 1 then

if Sold  = 1 then %>
<b>SOLD</b>
<% else
 if len(Price) > 2 then%>
        <% if len(Discount) > 1 then %>
	       <%=Formatcurrency((Price) - ((Price)*(Discount)/100),0) %>
	       <% else %>
	       <%=formatcurrency(rs("Price"),2) %>
	    <% end if %>
<% else 
if not Free ="True" then%>
Call For Price
 <%end if
 end if
  end if %>
	    <% if rs("OBO") = True then %>
	    <a class="tooltip" href="#"><b>OBO</b><span class="custom info"><img src="/images/logoTip.png" alt="About OBO" height="48" width="48" /><em>About OBO</em>By offering OBO the seller is willing to consider any offers that are made; however, that does not mean that they have to accept an offer.</span></a>
 <% end if %>
<% end if %>
</td></tr>
<%   oldanimalid= rs("id")
rs.movenext
             next 
         Wend %>