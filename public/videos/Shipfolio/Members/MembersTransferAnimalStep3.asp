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
<%
dim AnimalIDArray(100000)
dim AnimalNameArray(100000)
	
Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Transfer"  %> 
<!--#Include file="MembersHeader.asp"-->

<div class="container ">
    <!--#Include file="MembersJumpLinks.asp"-->
        <div class="card mx-auto" >
            <div class="card-header d-flex align-items-center gap-3">
                <img src="/icons/Assoc-transfer-icon.svg" width="40" alt="Transfer Icon"/>
                <h4 class="mb-0">Transfer Animal to Another Ranch</h4>
            </div>

            <div class="card-body p-4">
                <p class="card-text mb-4">Please review the details below and confirm the transfer.</p>

                <div class="row">
                    <div class="col-md-6 border-end">
                        <h5 class="mb-3">Animal:</h5>
                        <%
                        ' --- ASP Logic to get Animal Details ---
                        SearchAnimalID = Request.querystring("SearchAnimalID")
                        sql_query = "select * from animals, Photos where animals.AnimalID = Photos.AnimalID and animals.AnimalID=" & SearchAnimalID
'Response.write("sql_query=" & sql_query)

                        Set rs = conn.Execute(sql_query)
                        if not rs.eof then
                            FullName = rs("FullName")
                            Photo1= rs("Photo1")
                        end if
                        %>
                        <% if len(Photo1) > 4 then %>
                            <img src="<%=Photo1%>" class="img-fluid rounded mb-2" style="max-height: 150px;" alt="Photo of <%=FullName%>">
                        <% end if %>
                        <p class="fw-bold fs-5 mb-0"><%=FullName%></p>
                    </div>

                    <div class="col-md-6">
                        <h5 class="mb-3">Transfer Ownership To:</h5>
                        <%
                        ' --- ASP Logic to get New Owner Details ---
                        TransferRanchID = Request.querystring("TransferRanchID")
                        sql_query = "SELECT PeopleID, peoplelastname, peopleFirstname, Businessname FROM people INNER JOIN business ON people.BusinessID = business.BusinessID WHERE People.PeopleID=" & TransferRanchID
                        Set rs = conn.Execute(sql_query)
                        if not rs.eof then
                            ranch_name = rs("Businessname")
                            peoplelastname = rs("peoplelastname")
                            peopleFirstname = rs("peopleFirstname")
                        %>
                            <p class="fw-bold fs-5 mb-0"><%=ranch_name%></p>
                            <p class="text-muted"><%=peopleFirstname%> <%=peopleLastname%></p>
                        <% end if %>
                    </div>
                </div>
            </div>

            <div class="card-footer text-end d-flex justify-content-end gap-2">
                <form action='MembersTransferAnimal.asp' method="post" class="d-inline">
                    <input type="hidden" name="ID" value="<%=ID%>">
                    <button type="submit" class="regsubmit2">Cancel</button>
                </form>

                <form action='MembersTransferAnimalStep4.asp' method="post" class="d-inline">
                    <input type="hidden" name="TransferRanchID" value="<%=TransferRanchID%>">
                    <input type="hidden" name="SearchAnimalID" value="<%=SearchAnimalID%>">
                    <button type="submit" class="regsubmit2">Confirm Transfer</button>
                </form>
            </div>
        </div>
    </div>
<!--#Include file="membersFooter.asp"-->

 </Body>
</HTML>
