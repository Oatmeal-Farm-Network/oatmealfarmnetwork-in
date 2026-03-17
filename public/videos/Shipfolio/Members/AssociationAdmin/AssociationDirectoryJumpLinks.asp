<a href = "#Top" class = "body"></a>
<div class="nav">
<div>
     <a href="AssociationHome.asp"><img src= "https://www.GlobalLivestockSolutions.com/icons/Assoc-administration-icon.svg" alt = "Website" height ="46" border = "0" style="margin-top: 16px; margin-bottom: 16px;"></a>
</div>

<% if Current3 = "Create" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/SetupAssociationAccountExistingmember.asp"><b>Create</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/SetupAssociationAccountExistingmember.asp">Create</a>
  </div>
<%end if %>


<% if len(Session("AssociationID")) > 0 then %>

<% if Current3 = "Dashboard" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationHome.asp?AssociationID=<%=AssociationID %>"><b>Dashboard</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationHome.asp?AssociationID=<%=AssociationID %>"">Dashboard</a>
  </div>
<%end if %>

<% if Current3 = "Members" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationEditMembers.asp?AssociationID=<%=AssociationID %>""><b>Members</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationEditMembers.asp?AssociationID=<%=AssociationID %>"">Members</a>
  </div>
<%end if %>



<% if Current3 = "Summary" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationListingEdit.asp?AssociationID=<%=AssociationID %>""><b>Basics</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationListingEdit.asp?AssociationID=<%=AssociationID %>"">Basics</a>
  </div>
<%end if %>

<% if Current3 = "Logo" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationLogo.asp?AssociationID=<%=AssociationID %>""><b>Logo</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationLogo.asp?AssociationID=<%=AssociationID %>"">Logo</a>
  </div>
<%end if %>


<% if Current3 = "Description" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationDescription.asp?AssociationID=<%=AssociationID %>""><b>Description</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationDescription.asp?AssociationID=<%=AssociationID %>"">Description</a>
  </div>
<%end if %>



<% 
if FoodHub = 1 then    
    if Current3 = "FoodHub" then %>
  <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationFoodHub.asp?AssociationID=<%=AssociationID %>""><b>Food Hub</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationFoodHub.asp?AssociationID=<%=AssociationID %>"">Food Hub</a>
  </div>
<%end if 
end if %>





<% if Livestock = 1 then  
    if Current3 = "Breeds" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationBreeds.asp?AssociationID=<%=AssociationID %>""><b>Breeds</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationBreeds.asp?AssociationID=<%=AssociationID %>"">Breeds</a>
  </div>
<%end if 
 end if%>

<% if Registry = 1 then %>
<% if Current3 = "Countries" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationDirectoryCountries.asp?AssociationID=<%=AssociationID %>""><b>Countries</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationDirectoryCountries.asp?AssociationID=<%=AssociationID %>"">Countries</a>
  </div>
<%end if %>
<% end if %>






<% if Registry = 1 then %>
<% if Current3 = "Acronyms" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationAcronyms.asp?AssociationID=<%=AssociationID %>""><b>Acronyms</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationAcronyms.asp?AssociationID=<%=AssociationID %>"">Acronyms</a>
  </div>
<%end if %>

<% end if %>

<% if Current3 = "Delete" then %>
 <div class="jumplinkscellCurrent" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" href="/Members/AssociationAdmin/AssociationDeleteAccount.asp?AssociationID=<%=AssociationID %>"><b>Delete</b></a>
  </div>
<% else %> 
<div class="jumplinkscell" style="vertical-align:bottom; min-height:58px;" ><br />
    <a class="jumplinks" aria-current="page" href="/Members/AssociationAdmin/AssociationDeleteAccount.asp?AssociationID=<%=AssociationID %>">Delete</a>
  </div>
<%end if %>

<% end if %>

</div>

