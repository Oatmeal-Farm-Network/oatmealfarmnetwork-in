<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Oatmeal Farm Network</title>
<!--#Include file="MembersGlobalVariables.asp"-->

<link rel="stylesheet" href="/members/Membersstyle.css">
</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals" 
Current3 = "Awards" %> 
<!--#Include file="MembersHeader.asp"-->


<div class="container roundedtopandbottom">

    <form action='MembersAwardsHandleForm.asp' method="post">
        <div class="col">
            <div class="card-header">
               <!--#Include file="MembersJumpLinks.asp"-->
            </div>
            <div class="card-header">
                <h4 class="mb-0">Awards</h4>
                <%
                ' Show a success message if changes were just made.
                Dim changesmade
                changesmade = request.querystring("changesmade")
                if changesmade = "True" then
                %>
                    <div class="alert alert-success blink_text" role="alert">
                        <b>Your Awards Changes Have Been Made.</b>
                    </div>
                <% end if %>
            </div>
            <div class="card-body p-4">
                <div class="row">

                <div class="table-responsive">
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-light">
                            <tr>
                                <th class="text-center">Year</th>
                                <th class="text-center">Show</th>
                                <th class="text-center">Class</th>
                                <th class="text-center">Placing</th>
                                <th class="text-center">Comments</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%

                            Dim filledRecordClause
                            filledRecordClause = "(NOT(Len(Placing)<1) OR NOT(Len(Class)<1) OR NOT(Len(AwardYear)<2) OR NOT(Len(Awardcomments)<1) OR NOT(Len(Showname)<1) OR NOT(Len(Judge)<1))"

                            Set rs = Server.CreateObject("ADODB.Recordset")
                            sql = "SELECT * FROM awards WHERE animalid = " & animalid & " AND " & filledRecordClause & " ORDER BY AwardYear DESC, Placing DESC, Showname DESC"
                            'response.write("sql=" & sql)    
                            rs.Open sql, conn, 3, 3
                            rowcount = 0

                            While not rs.eof
                                rowcount = rowcount + 1
                            %>
                            <tr>
                                <td style="width: 15%;">
                                    <input type="hidden" name="AwardsID(<%=rowcount%>)" value="<%=rs("AwardsID")%>">
                                    <select name="AwardYear(<%=rowcount%>)" class="form-select form-select-sm">
                                        <option value="<%=rs("AwardYear")%>"><%=rs("AwardYear")%></option>
                                        <option value=""></option>
                                        <%
                                        Dim currentyear, yearv
                                        currentyear = year(date)
                                        For yearv = currentyear To 1983 Step -1
                                        %>
                                            <option value="<%=yearv%>"><%=yearv%></option>
                                        <% Next %>
                                    </select>
                                </td>
                                <td>
									<% Showname = rs("ShowName") 
									if Showname = "0" then Showname = "" %>
                                    <input name="Show(<%=rowcount%>)" value="<%=ShowName%>" class="form-control form-control-sm">
                                </td>
                                <td>
                                    <input type="text" name="AClass(<%=rowcount%>)" value="<%=rs("Type")%>" class="form-control form-control-sm">
                                </td>
                                <td>
									<% Placing = rs("Placing") 
									if Placing = "0" then Placing = "" %>
                                    <input type="text" name="Placing(<%=rowcount%>)" value="<%=Placing %>" class="form-control form-control-sm">
                                </td>
                                <td>
									<% Awardcomments = rs("Awardcomments") 
									if Awardcomments = "0" then Awardcomments = "" %>
                                    <input name="Awardcomments(<%=rowcount%>)" value="<%=Awardcomments %>" class="form-control form-control-sm">
                                </td>
                            </tr>
                            <%
                                rs.movenext
                            wend
                            rs.close
                            Set rs = nothing

                            ' Increment rowcount one last time for the new empty row
                            rowcount = rowcount + 1
                            %>

                            <tr>
                                <td style="width: 15%;">
                                     <select name="NewAwardYear" class="form-select form-select-sm">
                                        <option value="" selected>Year</option>
                                        <%
                                        currentyear = year(date)
                                        For yearv = currentyear To 1983 Step -1
                                        %>
                                            <option value="<%=yearv%>"><%=yearv%></option>
                                        <% Next %>
                                    </select>
                                </td>
                                <td><input name="NewShow" value="" class="form-control form-control-sm" placeholder="Show Name"></td>
                                <td><input type="text" name="NewAClass" value="" class="form-control form-control-sm" placeholder="Class"></td>
                                <td><input type="text" name="NewPlacing" value="" class="form-control form-control-sm" placeholder="Placing"></td>
                                <td><input name="NewAwardcomments" value="" class="form-control form-control-sm" placeholder="Comments"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <div class="card-footer text-center bg-transparent border-top-0 mt-3">
                    <input type="hidden" name="animalid" value="<%=animalid%>">
                    <input type="hidden" name="TotalCount" value="<%=rowcount%>">
                    <button type="submit" class="regsubmit2">Save All Changes</button>
                    <p class="form-text mt-2">Note: If you need more rows, save your changes and a new empty row will appear.</p>
                </div>
            </form>
        </div>
    </div>


<!--#Include file="MembersFooter.asp"-->

 </Body>
</HTML>