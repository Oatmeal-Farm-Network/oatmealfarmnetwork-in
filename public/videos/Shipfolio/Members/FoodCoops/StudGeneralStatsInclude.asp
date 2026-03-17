<%	
FullPrice = cLng(FullPrice)
discount = cLng(discount)

If Discount > 1 Then
		DiscountPrice = FullPrice - fullprice*(discount/100)
	Else
		DiscountPrice = FullPrice
	End If %>		
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    width = "430" border = "0" valign = "top" align = "left">
<tr><td>
<table cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"    width = "430" border = "0" valign = "top" align = "left">
<% If Len(StudFee) > 2 And Sold = False  Then %>
<tr><td  class = "Body" align = "right" ><b>Stud Fee:</b></td>
<td  class = "Body" align = "left" >&nbsp;<b><%=formatcurrency(StudFee,0)%></b></td></tr>
<%End If %>
<% 
If PayWhatYouCanStud = "True" And Sold = False and not HidePWYC = True Then %><form  name=form method="post" action="PlacePWYCbid.asp?ID=<%=ID%>&PeopleID=<%=PeopleID %>">
<tr><td  class = "Body" align = "left" ><% if PayWhatYouCanStud = True then %><a class="tooltip" href="#"><b><small>Pay What You Can Offer</small></b><span class="custom info"><em>About Pay What You Can</em>By offering <i>Pay What You Can</i> the owner is willing to consider any offer on this stud's breeding based upon what they can afford; however, that does not mean that that have to accept an offer, if they don't want to.</span></a>
	    <% end if %>:</td>
<td  class = "Body" align = "left" >$<INPUT TYPE="text" NAME="PWYCOffer"  size="16"><input type=Submit value="Submit" class = "regsubmit2">
</form>
</td></tr>
<%End If %>
<% If Len(ARI) > 1 Then %>
<tr><td class = "Body" align = "right">ARI#:</td>
<td class = "Body" align = "left" >&nbsp;<%=ARI%></td></tr>		
<% End If %>
<% If Len(CLAA) > 1 Then %>
<tr><td    class = "Body" align = "right" >CLAA#:</td>
<td    class = "Body" align = "left" >&nbsp;<%=CLAA%></td></tr>		
<% End If %>

<%
if len(DOBMonth) > 0  then
if DOBMonth = "0" then
 DOBMonth = ""
end if
end if

if len(DOBDay) > 0  then
if DOBDay = "0" then
 DOBDay = ""
end if
end if

if len(DOBYear) > 0  then
if DOBYear = "0" then
 DOBYear = ""
end if
end if

if len(DOBMonth) > 0 or len(DOBDay) > 0  or len(DOBYear) > 0 then%>
<tr><td  class = "Body" align = "right" > DOB:</td>
<td  class = "Body" align = "left" >&nbsp;<%=DOBMonth%>/<%=DOBDay%>/<%=DOBYear%></td></tr>	
<% end if %>
<% 
if SpeciesID = 4 then 
breedtitle = "Type:"
 else 
breedtitle = "Breed:"
 end if 
Set rsb = Server.CreateObject("ADODB.Recordset")
if len(BreedID)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID 
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed = trim(rsb("Breed"))
end if
rsb.close
end if

if len(BreedID2)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID2
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed2 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if

if len(BreedID3)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID3
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed3 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if

if len(BreedID4)> 0 then 
sqlb = "select * from SpeciesBreedLookupTable where BreedLookupID=" & BreedID4
rsb.Open sqlb, conn, 3, 3
if not rsb.eof then 
Currentbreed4 = trim(rsb("Breed"))
breedtitle = "Breeds:"
end if
rsb.close
end if
if len(BreedID)> 0 or len(BreedID2)> 0 or len(BreedID3)> 0 or len(BreedID4)> 0then 
%>
<tr><td  class = "Body" align = "right" ><%=breedtitle %></td>
<td  class = "Body" align = "left" >&nbsp;<%=Currentbreed%><% if len(BreedID2) > 0 then %>, <%=Currentbreed2%>, 
<% end if %> 
<% if len(BreedID3) > 0 then %>
 <%=Currentbreed3%>, 
<% end if %> 
<% if len(BreedID4) > 0 then %>
 <%=Currentbreed4%>, 
<% end if %> 
</td></tr>	
<% end if %>
<tr><td  class = "Body" align = "right" width = "140">Category:</td>
<td  class = "Body" align = "left" >&nbsp;<%=Category%></td></tr>
<% If Len(color1) > 1 or Len(color2) > 1 or Len(color3) > 1 or Len(color4) > 1 Then %>
<tr><td  class = "Body" valign = "top"align = "right">
Color:</td>
<% end if %>
<td  class = "Body" align = "left" >&nbsp;<% If Len(color1) > 1 Then %>
		<%=Color1%><% end if %>
<% If Len(color2) > 1 Then %>/<%=Color2%>
<% end if %>
<% If Len(color3) > 1 Then %>
		<br>/<%=Color3%>
<% end if %>
<% If Len(color4) > 1 Then %>
		<br>/<%=Color4%>
<% end if %>
<% If Len(color5) > 1 Then %>
		<br>/<%=Color5%>
 <% end if %>	
</td>
</tr>
<% if len(CoOwnerBusiness1) > 1 or len(CoOwnerName1) > 1 or len(CoOwnerLink1) > 1 or len(CoOwnerBusiness2) > 1 or len(CoOwnerName2) > 1 or len(CoOwnerLink2) > 1 or len(CoOwnerBusiness3) > 1 or len(CoOwnerName3) > 1 or len(CoOwnerLink1) > 3 then %>
<tr>
		<td  align = "right" class = "body" valign = "top">
        C0-Owned by:</td>
        <td  align = "left" class = "body" valign = "top">
        
        <% if len(CoOwnerBusiness1) > 1 or len(CoOwnerName1) > 1 or len(CoOwnerLink1) > 1 then %>
        <% if len(CoOwnerLink1) > 1 then%>
                <a href = "http://<%=CoOwnerLink1 %>" class = "body" target = "blank">
        <% end if %>
           <%=CoOwnerBusiness1%>
           <%if len(CoOwnerName1) > 1 then%>
                   ,  <%=CoOwnerName1%>
            <% end if %>
      
       <% if len(CoOwnerLink1) > 1 then%>
                </a>
        <% end if %>
        <br />
          <% end if %>
        
         <% if len(CoOwnerBusiness2) > 1 or len(CoOwnerName2) > 1 or len(CoOwnerLink2) > 1 then %>
        <% if len(CoOwnerLink2) > 1 then%>
                <a href = "http://<%=CoOwnerLink2 %>" class = "body" target = "blank">
        <% end if %>
           <%=CoOwnerBusiness2%>
           <%if len(CoOwnerName2) > 1 then%>
                   ,  <%=CoOwnerName2%>
            <% end if %>
       
       <% if len(CoOwnerLink2) > 1 then%>
                </a>
        <% end if %>
        <br />
         <% end if %>
           <% if len(CoOwnerBusiness3) > 1 or len(CoOwnerName3) > 1 or len(CoOwnerLink3) > 1 then %>
        <% if len(CoOwnerLink3) > 1 then%>
                <a href = "http://<%=CoOwnerLink3 %>" class = "body" target = "blank">
        <% end if %>
           <%=CoOwnerBusiness3%>
           <%if len(CoOwnerName3) > 1 then%>
                   ,  <%=CoOwnerName3%>
            <% end if %>
     
       <% if len(CoOwnerLink3) > 1 then%>
                </a>
        <% end if %>
           <% end if %>
    </td>
 </tr>
<% end if %>

<tr>
<td colspan = "2" class = "body">
<% 

StudDescription = trim(StudDescription)


str1 = StudDescription
str2 = vbtab
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1, str2 , "&nbsp;&nbsp;&nbsp;&nbsp;")
End If  

if len(StudDescription) > 1 then
For loopi=1 to Len(StudDescription)
    spec = Mid(StudDescription, loopi, 1)
    specchar = ASC(spec)

    
    if specchar < 32 or specchar > 126 then
    	StudDescription= Replace(StudDescription,  spec, " ")

   end if
  
 Next
end if
%>
<br><%=trim(StudDescription) %>
									


</td></tr></table>


</td></tr>
</table>