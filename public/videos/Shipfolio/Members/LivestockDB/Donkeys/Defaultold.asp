<!DOCTYPE html>
<html xmlns="https://www.w3.org/1999/xhtml">
<head>
<!--#Include virtual="/includefiles/GlobalVariables.asp"-->
<%  MasterDashboard= True
currentbreed="Donkeys" %>
<!--#Include virtual="/BreedsOfLivestock/AnimalsVariablesInclude.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>

<% Title = "Donkey Breeds"
Description = "  Donkeys were first domesticated around 5,000 years ago as beasts of burden and companions, most likely in Egypt or Mesopotamia. There are about 41 million donkeys in the world today; China has the most with 11 million, followed by Pakistan, Ethiopia, and Mexico.</p><p>Donkeys vary considerably in size, depending on breed and management. The height at the withers ranges from 7.3 hands (31 inches or 79 cm) to 15.3 hands (63 inches or 160 cm), and they weigh from 80 to 480 kg (180 to 1,060 lb.). Working donkeys in the poorest countries have a life expectancy of 12 to 15 years; and in more prosperous countries, they may have a lifespan of 30 to 50 years."
image = "/LivestockDB/Donkeys/DonkeyHeader.jpg"
AboutLink = "AboutDonkeys.asp"
 %>
<Title><%=Title %></Title>
<meta name="title" content="<%=Title %>" />

<meta name="description" content="<%=Description %>" />
<meta name="robots" content="follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="Googlebot" content="follow"/>
<meta name="author" content="Oatmeal Farm Network"/>

<link rel="canonical" href="<%=currenturl %>" />
<meta property="og:url" content="<%=currenturl %>" />
<meta name="Title" content="<%=Title %>"/>
<meta name="Author" content="Oatmeal Farm Network"/>
<meta property="og:locale" content="en_US" />
<meta property="og:type" content="article" />
<meta property="og:title" content="<%=Title %>" />
<meta property="og:site_name" content="Oatmeal Farm Network" />
<meta property="og:image" content="<%=image %>" />
<meta property="og:image:width" content="800" />
<meta property="og:image:height" content="400" />
<meta property="og:description" content="<%=Description %>" />


<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": <%=Title %>,
  "description": <%=Description %>,
  "author": {
    "@type": "Organization",
    "name": "Oatmeal Farm Network"
  },
  "image": <%=image %> }
</script>

</HEAD>
<% LSHeader = True
currentbreed="Donkeys" %>
<!--#Include virtual="/Members/MembersHeader.asp"-->

<% If not rs.State = adStateClosed Then
  rs.close
End If 
%>
<a name="Top"></a>

<div class="container-fluid" id="grad1">
  <div class="text-center">
    <div class="container">
      <div class="body">
        <h1>
          <img src="<%= BreedIcon %>" alt="About <%= Trim(Breed) %> <%= SpeciesNamePlural %>" height="40" border="0" />
          Donkeys
        </h1>
        <br />
      </div>
    </div>
  </div>
</div>

<div class="container-fluid">
  <div class="body text-center">
    <img src="https://www.OatmealfarmNetwork.com/members/LivestockDB/Donkeys/DonkeyHeader.jpg" class="img-fluid w-100" alt="About Donkeys" />
    <br /><br />

    <table class="table table-bordered w-100" style="background-color: white;">
      <tr>
        <td valign="top">
          <table class="table borderless mx-auto" style="height: 510px;">
            <tr>
              <td class="body text-left align-top">
                <p>
                  Donkeys were first domesticated around 5,000 years ago as beasts of burden and companions, 
                  most likely in Egypt or Mesopotamia. There are about 41 million donkeys in the world today; 
                  China has the most with 11 million, followed by Pakistan, Ethiopia, and Mexico.
                </p>

                <p>
                  Donkeys vary considerably in size, depending on breed and management. The height at the withers 
                  ranges from 7.3 hands (31 inches or 79 cm) to 15.3 hands (63 inches or 160 cm), and they weigh from 
                  80 to 480 kg (180 to 1,060 lb.). Working donkeys in the poorest countries have a life expectancy 
                  of 12 to 15 years; and in more prosperous countries, they may have a lifespan of 30 to 50 years.
                </p>

                <form name="Login" method="post" action="AboutDonkeys.asp" class="text-end">
                  <input type="submit" class="regsubmit2" value="LEARN MORE" />
                </form>

                <br />

                <% 
                Set rs2 = Server.CreateObject("ADODB.Recordset")
                sql2 = "SELECT * FROM SpeciesBreedLookupTable WHERE SpeciesID=" & SpeciesID & " ORDER BY Trim(Breed)"
                rs2.Open sql2, conn, 3, 3

                If Not rs2.EOF Then 
                %>
                  <h2>Breeds of <%= SpeciesNamePlural %></h2>
                  <p>There are the following breeds of <%= SpeciesNamePlural %>:</p>

                  <% Do While Not rs2.EOF
                    Breed2 = rs2("Breed")
                    BreedLookupID2 = rs2("BreedLookupID")
                    Breeddescription = rs2("Breeddescription")
                    BreedImage = rs2("BreedImage")
                    BreedImageCaption = rs2("BreedImageCaption")
                  %>

                  <table class="table w-100">
            
                    <tr><td colspan="2" style="background-color: #d6ceca; height: 40px;">
                      <h3>
                        <img src="https://www.OatmealfarmNetwork.com/images/px.gif" width="3" height="30" alt="<%= Breed2 %> - Breeds of <%= signularanimal %>" />
                        <%= Breed2 %>
                      </h3>
                    </td></tr>
                   

                    <tr>
                      <td class="body" style="width: 200px;" valign="top">
                        <% If Len(BreedImage) > 1 Then %>
                          <a href="Breeds.asp?BreedLookupID=<%= BreedLookupID2 %>&SpeciesID=<%= SpeciesID %>" class="body">
                            <img src="<%= BreedImage %>" width="180" align="left" hspace="20" alt="<%= BreedImageCaption %>" />
                          </a><br />
                        <% End If %>
                      </td>

                      <td class="body">
                        <blockquote>
                          <%= Left(Breeddescription, 450) %>
                          <% If Len(Breeddescription) > 450 Then %>...<% End If %>

                          <% If Len(Breeddescription) > 25 Then %>
                            <div class="text-end">
                              <form name="Login" method="post" action="Breeds.asp?BreedLookupID=<%= BreedLookupID2 %>&SpeciesID=<%= SpeciesID %>">
                                <input type="submit" class="regsubmit2" value="LEARN MORE" />
                              </form>
                            </div>
                          <% End If %>
                        </blockquote>
                      </td>
                    </tr>
                  </table>

                  <% 
                    rs2.MoveNext
                    Loop 
                    rs2.Close
                  %>

                <% End If %>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
</div>


<!--#Include virtual="/Members/MembersFooter.asp"-->
</body>
</html>
