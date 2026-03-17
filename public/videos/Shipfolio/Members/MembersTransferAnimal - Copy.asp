<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="Global Grange Inc.">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<body >
<% Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Transfer"  %> 
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersJumpLinks.asp"-->

   <br /> 

<% If not rs.State = adStateClosed Then
  rs.close
End If   	%>

<div class ="container roundedtopandbottom">
<H1>Transfer Animal to Another Ranch</H1>


<!DOCTYPE html>
<html>
<head>
    <title>Ranch Name Search</title>
    <!-- Add Bootstrap CSS link here -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2>Ranch Name Search</h2>
        <form id="searchForm">
            <div class="form-group">
                <label for="ranchNameInput">Enter Ranch Name:</label>
                <input type="text" class="form-control" id="ranchNameInput" name="ranch_name" required>
            </div>
            <button type="submit" class="btn btn-primary">Search</button>
        </form>
        <div class="mt-4" id="searchResult">
            <!-- The search results will be displayed here -->
        </div>
    </div>

    <!-- Add Bootstrap and jQuery JavaScript links here -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Function to handle the form submission
        $(document).ready(function () {
            $("#searchForm").submit(function (e) {
                e.preventDefault();
                var ranchName = $("#ranchNameInput").val();
                $.ajax({
                    type: "GET",
                    url: "search_ranch.asp",
                    data: { "ranch_name": ranchName },
                    dataType: "json",
                    success: function (data) {
                        displaySearchResults(data);
                    },
                    error: function (xhr, status, error) {
                        console.log("Error: " + status + " - " + error);
                    }
                });
            });
        });

        // Function to display search results in the result div
        function displaySearchResults(data) {
            var resultDiv = $("#searchResult");
            resultDiv.empty();
            if (Object.keys(data).length === 0) {
                resultDiv.append("<p>No results found.</p>");
            } else {
                resultDiv.append("<h4>Search Results:</h4>");
                resultDiv.append("<ul>");
                for (var key in data) {
                    resultDiv.append("<li>" + data[key] + " (ID: " + key + ")</li>");
                }
                resultDiv.append("</ul>");
            }
        }
    </script>
</body>
</html>





















<table border = "0" cellspacing="0" cellpadding = "0" align = "center" >
        <tr><td  align = "center">
<br />

<% 


If Len(ID) > 0 then

			 sql2 = "select * from Photos where ID = " &  ID & ";" 
			'response.write(sql2)
			Set rs2 = Server.CreateObject("ADODB.Recordset")
			rs2.Open sql2, conn, 3, 3   
			 If rs2.eof Then

					Query =  "INSERT INTO Photos (ID)" 
					Query =  Query & " Values (" &  ID & ")"

Conn.Execute(Query) 

	End If 
End if

%>
 <table width = "920" height = "300"  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
	<tr><td class = "body" valign = "top">
<% 
 If not rs.State = adStateClosed Then
  rs.close
End If  
	sql2 = "select * from Animals where PeopleID = " & session("PeopleID") & " order by Fullname"
	acounter = 1
	Set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql2, conn, 3, 3 
	if rs.eof then %>

        Currently you do not have any alpacas entered. To add alpacas please select the <a href = "AdminAnimalAdd1.asp" class = "body">Add Alpaca</a> tab.

        
<%	else
	While Not rs.eof  
		IDArray(acounter) = rs("ID")
		alpacaName(acounter) = rs("FullName")
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing


 %>
<table  border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 width = "600">
	<tr>
		<td class = "body" align = "left">
			<a name="Add"></a>
			
			If you wish, you can transfer another alpaca: <br />
		</td>
	</tr>
</table>
			<form  action="TransferAnimal2.asp" method = "post" name = "t1">
			  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body" align = "left">
					<div align = "left"><h3>Select one of your animals:</h3>
					
					<select size="1" name="AlpacaID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
						response.write(count)
					%>
						<option name = "AID1" value="<%=IDArray(count)%>">
							<%=alpacaName(count)%>
						</option>
					<% 	count = count + 1
					wend %>
					</select>
		</div>
				</td>
			  </tr>
		    </table>
		  


<%
Dim UserIDArray(100000)
dim custCompany(100000) 
dim CustFirstName(100000)
dim custLastName(100000) 
dim Owners(100000) 
    Set rs = Server.CreateObject("ADODB.Recordset")
    
		sql2 = "select PeopleID, Businessname, People.PeopleFirstName, People.PeopleLastName, People.Owners from people, business where people.BusinessID=business.BusinessID and accesslevel > 0 and People.SubscriptionLevel > 0 order by Businessname"
		Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql2, conn, 3, 3   
 acounter = 1
While Not rs.eof  
		UserIDArray(acounter) = rs("PeopleID")
		custCompany(acounter) = rs("Businessname")
		custFirstName(acounter) = rs("PeopleFirstName")
		custLastName(acounter) = rs("PeopleLastName")
		Owners(acounter) = rs("Owners")
		
		if len(Owners(acounter)) < 2 then
		    Owners(acounter) = custFirstName(acounter) & " " & custLastName(acounter)
		end if
		'response.write (SSName(studcounter))

		acounter = acounter +1
		rs.movenext
	Wend		
	
		rs.close
		set rs=nothing

%>
  <table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0>
			   <tr>
				<td colspan ="30">
					&nbsp;
				</td>
				 <td class = "body" align = "left">
						<h3>Select the animal's new owner:</h3>
												
					<select size="1" name="NewOwnerID">
					<option name = "AID0" value= "" selected></option>
					<% count = 1
						while count < acounter
					%>
						<option name = "AID1" value="<%=UserIDArray(count)%>">
						 <%=custCompany(count)%> (<%=Owners(count)%> )
						</option>
					<% 	count = count + 1
					wend %>
					</select>
						<div valign = "bottom" align = "center">	
			<input type=submit Value = "Submit" class = "regsubmit2" ></div>
				</td>
			  </tr>
		    </table>
		  </form>
		  <% end if 
		  
		  conn.close
		  set conn = nothing
		  %>
</td>
</tr>
</table>
</td>
</tr>
</table>

</div>
<!--#Include file="membersFooter.asp"-->

 </Body>
</HTML>
