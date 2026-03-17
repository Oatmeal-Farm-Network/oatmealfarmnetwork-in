<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<!--#Include file="Membersglobalvariables.asp"-->


<link rel="stylesheet" type="text/css" href="MembersStyle.css">

</head>
<body >


<%

NumberofAnimals= request.querystring("NumberofAnimals")
AnimalID = request.querystring("AnimalID")
'response.write("AnimalID=" & AnimalID)
SetStudLive= request.QueryString("SetStudLive")
If SetStudLive="True" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishStud = 1"
Query =  Query & " where AnimalID = " & AnimalID & ";" 
Conn.Execute(Query) 
end if

If SetStudLive="False" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishStud = 0"
Query =  Query & " where AnimalID = " & AnimalID & ";" 
Conn.Execute(Query) 
end if

SetForSaleLive= request.QueryString("SetForSaleLive")
If SetForSaleLive="True" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishForSale = 1"
Query =  Query & " where AnimalID = " & AnimalID & ";" 
Conn.Execute(Query) 
end if

If SetForSaleLive="False" then
Query =  " UPDATE Animals Set "
Query =  Query & " PublishForSale = 0"
Query =  Query & " where AnimalID = " & AnimalID & ";" 
Conn.Execute(Query) 
end if

 Set rs2 = Server.CreateObject("ADODB.Recordset")
 sql2 = "select PublishForSale, PublishStud, Category, speciesid  from Animals  where AnimalID = " & AnimalID 

rs2.Open sql2, conn, 3, 3   
PublishForSale= rs2("PublishForSale")
PublishStud= rs2("PublishStud")
Category = rs2("Category")
'response.write("Category=" & Category )
Speciesid = rs2("Speciesid")
rs2.close
%><style>
  /* * Modern CSS for a Responsive Status Bar 
   * Replaces the use of <table> for layout.
   */
  
  /* 1. Main Container (Replacing the Table) */
  .status-bar-wrapper {
      /* Use Flexbox to align child items in a row */
      display: flex;
      /* Center the groups horizontally */
      justify-content: center;
      /* Allow items to wrap onto a new line if the width is too small */
      flex-wrap: wrap; 
      
      width: 100%;
      min-height: 100px; /* Ensure a minimum height for visual clarity */
      background-color: white;
      padding: 10px 0; /* Add some vertical padding */
  }
  
  /* 2. Individual Status Group (e.g., Sales Listing or Stud Listing) */
  .status-group {
      /* Set a minimum width for the group to look like a cell */
      min-width: 280px; 
      /* Max width to prevent it from getting too wide on desktop */
      max-width: 50%;
      /* Add padding/margin to separate the cells */
      padding: 0px;
      margin: 5px;
      
      /* Center the content inside the group */
      text-align: center;
      
  }
  
  /* 3. Button/Input Styling (Assuming 'regsubmit2' is styled elsewhere) */
  .status-group form div {
      /* Ensure the text and button are on the same line and easily readable */
      display: flex; 
      align-items: center;
      justify-content: center;
      gap: 10px; /* Space between the label/status and the button */
  }
  
  /* 4. Formatting for Restriction Messages */
  .restriction-message {
      padding: 10px;
      border: 1px dashed #dc3545; /* Bootstrap danger color */
      background-color: #fff3f4; /* Light red background */
      margin: 10px 0;
      text-align: left;
  }
  .restriction-message b {
      color: #dc3545;
  }
  </style>
  
  <div class="status-bar-wrapper">
  
  <% 
  ' --- CLASSIC ASP VARIABLE SETUP FOR LOGIC SIMPLIFICATION ---
  
  ' Determine Max Animals for Sale
  Dim maxNumAnimals, MaxnumPublishedStuds
  maxNumAnimals = 0
  MaxnumPublishedStuds = 0
  
  Select Case subscriptionlevel
      Case 3
          maxNumAnimals = 3
          MaxnumPublishedStuds = 3
      Case 4
          maxNumAnimals = 20000
          MaxnumPublishedStuds = 20000
      Case 5
          maxNumAnimals = 25
          MaxnumPublishedStuds = 25
      Case Else ' Includes subscriptionlevel 0 and < 2
          If subscriptionlevel < 2 Then
              maxNumAnimals = 5
              MaxnumPublishedStuds = 5
          End If
  End Select
  
  ' Override for accesslevel=0 or subscriptionlevel=0 (Should be covered above, but good check)
  If accesslevel = 0 Or subscriptionlevel = 0 Then
      maxNumAnimals = 0
      MaxnumPublishedStuds = 0
  End If
  
  ' Define Flags for Restriction Checks
  Dim salesRestricted, studRestricted, showStudSection
  salesRestricted = False
  studRestricted = False
  
  If PublishForSale <> 1 Then ' Only check limits if currently Draft
      If (subscriptionlevel < 2 And numPublishedAnimals > 4) Or _
         (subscriptionlevel = 5 And numPublishedAnimals > 24) Or _
         (subscriptionlevel = 0 And numPublishedAnimals > 0) Or _
         (subscriptionlevel = 4 And numPublishedAnimals >= 20000) Then ' >= since 20000 is essentially unlimited
          salesRestricted = True
      End If
  End If
  
  ' Check if the Stud section should even appear
  showStudSection = True
  If speciesid = 13 Or speciesid = 14 Or speciesid = 15 Or (speciesid = 20 And NumberofAnimals < 2) Then
      showStudSection = False
  ElseIf InStr("3,4,47, 50, 52, 83, 81, 92,93,9,18,27,108,334,341, 7, 9, 16, 50, 64, 65, 99, 600 ", category) = 0 Then
      showStudSection = False
  End If
  
  If showStudSection AND PublishStud <> 1 Then ' Only check limits if currently Draft
      If (accesslevel = 0) Or _
         (subscriptionlevel = 3 And numPublishedStuds > 4) Or _
         (subscriptionlevel = 0 And numPublishedStuds > 0) Or _
         (subscriptionlevel = 5 And numPublishedStuds > 24) Or _
         (subscriptionlevel = 4 And numPublishedStuds >= 2000) Then ' >= since 2000 is essentially unlimited
          studRestricted = True
      End If
  End If
  %>
  
      <div class="status-group">
          <% If PublishForSale = 1 Then %>
              <form name="formSale" method="post" action="membersAnimalPublishFrame.asp?AnimalID=<%=AnimalID%>&SetForSaleLive=False">
                  <div>Sales Listing: &nbsp;<b>Published</b><input type="Submit" value="Un-Publish" class="regsubmit2" ></div>
              </form>
          <% ElseIf salesRestricted Then %>
              <div class="restriction-message">
                  <b>Cannot be Published.</b><br>
                  Your membership prevents you from publishing more than <%=maxNumAnimals %> animals.<br>
                  <center><a href="MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class="regsubmit2" target="_top">Renew or Upgrade Your Membership</a></center>
              </div>
          <% Else %>
              <form name="formSale" method="post" action="MembersAnimalPublishFrame.asp?AnimalID=<%=AnimalID%>&SetForSaleLive=True">
                  <div>Sales Listing: &nbsp;<b>Draft</b> <input type="Submit" value="Publish" class="regsubmit2" ></div>
              </form>
          <% End If %>
      </div>
      
      <% If showStudSection Then %>
      <div class="status-group">
          <% If PublishStud = 1 Then %>
              <form name="formStud" method="post" action="membersAnimalPublishFrame.asp?AnimalID=<%=AnimalID%>&SetStudLive=False">
                  <div>Stud Listing: &nbsp;<b>Published</b> <input type="Submit" value="Un-Publish" class="regsubmit2" ></div>
              </form>
          <% ElseIf studRestricted Then %>
               <div class="restriction-message">
                  <b>This Stud Cannot be Published.</b><br>
                  Your current membership prevents you from publishing more than <%=MaxnumPublishedStuds %> Studs.<br>
                  <center><a href="MembersRenewSubscription.asp?PeopleID=<%=peopleID %>" class="regsubmit2" target="_top">Renew or Upgrade Your Membership</a></center>
               </div>
          <% Else %>
              <form name="formStud" method="post" action="membersAnimalPublishFrame.asp?AnimalID=<%=AnimalID%>&SetStudLive=True">
                  <div>Stud Listing: &nbsp;<b>Draft</b> <input type="Submit" value="Publish" class="regsubmit2" ></div>
              </form>
          <% End If %>
      </div>
      <% End If %>
  
  </div>

</body>
</html>
