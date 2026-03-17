<% AssociationID = rs("AssociationID")
AssociationName = rs("AssociationName")
AssociationAcronym = rs("AssociationAcronym")
Associationwebsite = rs("Associationwebsite")
AssociationEmailaddress = rs("AssociationEmailaddress")
AssociationStreet1 = rs("AssociationStreet1")
AssociationStreet2= rs("AssociationStreet2")
AssociationCity = rs("AssociationCity")
AssociationState = rs("AssociationState")
AssociationZip = rs("AssociationZip")
AssociationCountry = rs("country_id")
AssociationPhone = rs("AssociationPhone")
AssociationFax = rs("AssociationFax")
AssociationTollFreePhone = rs("AssociationTollFreePhone")

AssociationLogo = rs("AssociationLogo")
AssociationDescription= rs("AssociationDescription")
AssociationContactName = rs("AssociationContactName")
AssociationPassword= rs("AssociationPassword")
AssociationContactPosition= rs("AssociationContactPosition")
AssociationContactEmail= rs("AssociationContactEmail")
AssociationShowaddress = rs("AssociationShowaddress")
AssociationLinkedIn= rs("AssociationLinkedIn")
AssociationFacebook= rs("AssociationFacebook")
AssociationX= rs("AssociationX")
AssociationInstagram= rs("AssociationInstagram")
AssociationPinterest= rs("AssociationPinterest")
AssociationTruthSocial= rs("AssociationTruthSocial")
AssociationBlog= rs("AssociationBlog")
AssociationYouTube= rs("AssociationYouTube")
AssociationOtherSocial1= rs("AssociationOtherSocial1")
AssociationOtherSocial2= rs("AssociationOtherSocial2")

str1 = lcase(AssociationLogo)
str2 = "livestockofamerica.com"
If InStr(str1,str2) > 0 Then
	AssociationLogo= Replace(str1, str2 , "livestockoftheworld.com")
End If

if len(AssociationCountry) > 1 then
    Set rs2 = Server.CreateObject("ADODB.Recordset")
    sql = "select Name from Country where country_id = " & AssociationCountry
     rs2.Open sql, conn, 3, 3
      if not rs2.eof then
          AssociationCountryName = rs2("Name")
    end if
    rs2.close

  end if


Set rs2 = Server.CreateObject("ADODB.Recordset")
if len(Associationstate) > 0 then
   sql = "select Name from state_province where Stateindex = " & Associationstate
   'response.write("sql=" & sql )

    rs2.Open sql, conn, 3, 3
    if not rs2.eof then
        AssociationstateName = rs2("Name")
     end if

   rs2.close
end if




'str1 = lcase(AssociationLogo)
'str2 = "https://www.livestockoftheworld.com/"
'If InStr(str1,str2) > 0 Then
	'AssociationLogo= Replace(str1, str2 , "/")
'End If


%>

<div>


    <div class="body" valign="top" height=180px style=" align-items:left; background-color: white">
        <div class="container" style="min-height: 160px; align-items:left">
            <div class="row">
                <div class="col-4 d-flex align-items-center justify-content-center" style="width: 180px;">
                <a href="/associationdirectory/associationListing.asp?AssociationID=<%=AssociationID %>#Top">
                    <% if len(AssociationLogo) > 4 then %>
                    <center><br /><img src="<%=AssociationLogo%>" style="width: 140px;" /></center>
                    <% end if %>
                </a>
            </div>

                <div class="col-8">
                    <br />
                    <a href="/associationdirectory/associationListing.asp?AssociationID=<%=AssociationID %>#Top">
                        <h3>
                            <%=AssociationName %>
                            <% if len(trim(AssociationAcronym)) > 1 then %>
                            (<%=AssociationAcronym %>)
                            <% end if %>
                        </h3>
                    </a>

                    <% if AssociationShowaddress = 1 then %>
                    <% if len(AssociationStreet1) > 1 then %>
                    <%= AssociationStreet1 %><br />
                    <% end if %>
                    <% if len(AssociationStreet2) > 1 then %>
                    <%=AssociationStreet2 %><br />
                    <% end if %>
                    <%=AssociationCity %> &nbsp;<%=AssociationstateName %>,
                    <% if len(AssociationCountryName) > 1 then %>
                    <%=AssociationCountryName%>
                    <% end if %>
                    &nbsp;<%=AssociationZip %><br />

                    <% end if %>
                 
                    <% if len(AssociationTollFreePhone) > 1 then %>
                    Toll Free: <%=AssociationTollFreePhone %><br />
                    <% end if %>
            

                    <% if len(AssociationPhone) > 1 then %>
                    Phone: <%=AssociationPhone %><br />
                    <% end if %>
                   
                    <% if len(AssociationFax) > 1 then %>
                    Fax: <%=AssociationFax %><br />
                    <% end if %>
                   
                    <a href="/associationdirectory/associationListing.asp?AssociationID=<%=AssociationID %>#Top" class="body">Profile</a><br />
                    <% if len(AssociationEmailaddress) > 1 then %>
                    <a href="/associationdirectory/associationListing.asp?AssociationID=<%=AssociationID %>#Contact" class="body">Contact Food Hub</a><br />
                    <% end if %>

                    <br />

                    <%If len(AssociationLinkedIn) > 0 then %>
                    <a href="<%=AssociationLinkedIn %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/LinkedIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationFacebook) > 0 then %>
                    <a href="<%=AssociationFacebook %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/facebook.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationX) > 0 then %>
                    <a href="<%=AssociationX %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/TwitterX.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationInstagram) > 0 then %>
                    <a href="<%=AssociationInstagram %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/instagramicon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationPinterest) > 0 then %>
                    <a href="<%=AssociationPinterest %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/PinterestLogo.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationTruthSocial) > 0 then %>
                    <a href="<%=AssociationTruthSocial %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/Truthsocial.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationBlog) > 0 then %>
                    <a href="<%=AssociationBlog %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/BlogIcon.png" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationYouTube) > 0 then %>
                    <a href="<%=AssociationYouTube %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/YouTube.jpg" height=" 20" /></a>
                    <% end if %>
                    <%If len(AssociationOtherSocial1) > 0 then %>
                    <a href="<%=AssociationOtherSocial1 %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>

                    <%If len(AssociationOtherSocial2) > 0 then %>
                    <a href="<%=AssociationOtherSocial2 %>" target="_blank" class="body"><img src="https://www.GlobalLivestocksolutions.com/icons/GeneralSocialIcon.png" height=" 20" /></a>
                    <% end if %>




                </div>
            </div>
        </div>




    </div>
</div>
<div><div colspan=2 height=1><br /></div></div>