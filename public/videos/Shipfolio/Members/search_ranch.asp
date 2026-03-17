<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange Inc.">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<style>
  .content-box {
      border: 1px solid #ccc;
      border-radius: 8px;
      padding: 20px;
      max-width: 550px;
      margin: 0 auto; /* Centers the box */
  }
  .header {
      display: flex;
      align-items: center;
      gap: 15px; /* Space between icon and text */
      margin-bottom: 20px;
  }
  .header h1 { font-size: 1.5em; margin: 0; }
  .animal-info {
      background-color: #f9f9f9;
      border-radius: 5px;
      padding: 15px;
      margin-bottom: 20px;
  }
  .animal-info img {
      max-width: 100px;
      border-radius: 4px;
      margin-bottom: 10px;
  }
  .result-row {
      display: flex;
      align-items: center;
      padding: 10px;
      border-bottom: 1px solid #eee;
  }
  .result-row:last-child { border-bottom: none; }
  .result-row a { text-decoration: none; color: #0056b3; font-weight: bold; }
  .result-row a:hover { text-decoration: underline; }
  .result-row img { margin-right: 15px; }
  .form-group { margin-bottom: 15px; }
  .form-group label { display: block; margin-bottom: 5px; font-weight: bold; }
  .form-control {
      width: 100%;
      padding: 8px;
      border: 1px solid #ccc;
      border-radius: 4px;
      box-sizing: border-box; /* Important for padding and width */
  }
  .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 1em;
      text-decoration: none;
      display: inline-block;
      text-align: center;
  }
  .btn-primary { background-color: #007bff; color: white; }
  .btn-secondary { background-color: #6c757d; color: white; }
  .btn-container { margin-top: 20px; }
  .notice { color: #555; }
</style>
<body >
<%
dim AnimalIDArray(100000)
dim AnimalNameArray(100000)
	
Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Transfer"  %> 
<!--#Include file="MembersHeader.asp"-->


<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

<div class="container roundedtopandbottom">
    <!--#Include file="MembersJumpLinks.asp"-->
  <h1><img src="/icons/Assoc-transfer-icon.svg" width="45"/> Transfer Animal Ownership to Another Ranch</h1>

  <div class="container border" style="max-width:450px; align-content:center">

  <%
  ' Get the ranch name input from the user
  Dim ranch_name
  ranch_name = Request.form("ranch_name")
  SearchAnimalID = Request.form("SearchAnimalID")
  'response.write("SearchAnimalID=" & SearchAnimalID )

  sql_query = "select * from animals, Photos where animals.AnimalID = Photos.AnimalID and animals.AnimalID=" & SearchAnimalID
  'response.write("sql_query=" & sql_query )
  Set rs = conn.Execute(sql_query)
  if not rs.eof then
      FullName = rs("FullName")
      Photo1= rs("Photo1")
  end if
  %>

  Animal<br>
  <% if len(Photo1) > 4 then %>
      <img src="<%=Photo1%>" width="100px"><br>
  <% end if %>
  <b><%=FullName%></b><br><br>

  <%
  sql_query = "SELECT PeopleID, peoplelastname, peopleFirstname, Businessname FROM people INNER JOIN business ON people.BusinessID = business.BusinessID WHERE People.SubscriptionLevel > 0 AND Businessname LIKE '%" & ranch_name & "%' ORDER BY Businessname"
  'response.write("sql_query=" & sql_query )
  ' Execute the SQL query
  Set rs = conn.Execute(sql_query)

  Dim result
  Set result = Server.CreateObject("Scripting.Dictionary")

  if not rs.eof then
  %>
      <b>Transfer to</b><br>
      Your ranch name search resulted in the following. Select the farm/ranch that you wish to transfer your animal's ownership to:<br>

      <%
      while not rs.eof
          recordcount = recordcount + 1
          UserID = rs("PeopleID")
          peopleID = rs("PeopleID")
          ranch_id = rs("PeopleID")
          ranch_name = rs("Businessname")
          peoplelastname = rs("peoplelastname")
          peopleFirstname = rs("peopleFirstname")
      %>
          <div class="row">
              <div class="col">
                  <b>&nbsp;&nbsp;&nbsp;&nbsp;
                      <a href="MembersTransferAnimalStep3.asp?TransferRanchID=<%=ranch_id %>&SearchAnimalID=<%=SearchAnimalID %>" class="body">
                          <img src="images/delete.svg" height="26" border="0" alt="Transfer">&nbsp;&nbsp;<b><%=ranch_name %> - <%=peoplelastname %>, <%=peopleFirstname %></b>
                      </a>
                      <br/>
                  </b>
              </div>
          </div>
          <%=HSpacer %>
      <%
          rs.movenext
      wend

      ' Close the recordset and database connection
      rs.Close
      Set rs = Nothing

  else
      %>
      Your ranch name search did not result in any results. Please try again:
      <%
      If not rs.State = adStateClosed Then
          rs.close
      End If
      sql2 = "select * from Animals where PeopleID = " & session("PeopleID") & " order by Fullname"
      acounter = 1
      Set rs = Server.CreateObject("ADODB.Recordset")
      rs.Open sql2, conn, 3, 3

      if rs.eof then
      %>
          Currently you do not have any animals entered. To add animals please select the <a href="AdminAnimalAdd1.asp" class="body">Add Alpaca</a> tab.
      <%
      else
          While Not rs.eof
              AnimalIDArray(acounter) = rs("ID")
              AnimalNameArray(acounter) = rs("FullName")
              'response.write (SSName(studcounter))
              acounter = acounter + 1
              rs.movenext
          Wend

          rs.close
          set rs=nothing
      %>
          <br />
          <form action="search_ranch.asp" method="post" name="t1">
              <div class="row">
                  <div class="col">
                      <input type="hidden" name="SearchAnimalID" value="<%=SearchAnimalID%>">
                  </div>
              </div>
              <%=HSpacer %>
              <div class="row">
                  <div class="col">
                      <label for="ranchNameInput">Ranch Name Search</label><br />
                      <input type="text" class="formbox" id="ranchNameInput" name="ranch_name" size="40" required>
                  </div>
              </div>
              <div class="row">
                  <div class="col">
                      <br>
                      <input type="submit" Value="Submit" class="regsubmit2">
                  </div>
              </div>
          </form>
      <%
      end if
      %>
      <br />
      <br />
  <%
  end if
  %>
  </div>

  <form action='MembersTransferAnimal.asp' method="post">
      <input type="hidden" name="AnimalID" value="<%=AnimalID %>">
      <input type="submit" value="Cancel" class="regsubmit2">
  </form>
  <br /><br />
  <br />
</div>

<!--#Include file="membersFooter.asp"-->

 </Body>
</HTML>