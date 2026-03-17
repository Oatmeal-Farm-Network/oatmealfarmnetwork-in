<%@ Language="VBScript" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >

<% Current3 = "Dashboard" %> 

<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<%
' --- Declare all variables at the top for clarity and Option Explicit ---
Dim sql
Dim rs2
Dim RegistryCode, Species
Dim AssociationName, AssociationLogo, AssociationEmailaddress, AssociationPhone, Associationwebsite, AssociationStreet1, AssociationStreet2, AssociationCity, AssociationstateName, AssociationCountry, AssociationZip ' Assuming these are set from a main query elsewhere on the page
Dim PeopleID ' Assuming this is set from session or query string

' --- Basic Error Handling (for robust script execution) ---
On Error Resume Next

' --- Start of HTML structure ---
%>
<div class="container mx-auto roundedtopandbottom">
    <h1><%=AssociationName%>'s Dashboard</h1>

    <div class="row mx-auto">
        <div class="col">

            <div class="container mx-auto ">
                <div class="row mx-auto">
                    <div class="col-3" style="max-width:420px; min-width:420px;">
                        <div class="container roundedtopandbottomgrey">
                            <div class="row">
                                <div class="col" style="max-width:400px; min-width:400px;">
                                    <br />
                                    <% if Len(AssociationLogo) > 4 then %>
                                    <center><img src="<%=AssociationLogo %>" width ="180px" alt="Association Logo" /></center>
                                    <% end if %>
                                    <div align ="right"><a href="AssociationLogo.asp" class ="body"><small>Update Logo</small></a></div>

                                    <p><b><%=AssociationName %></b><br />

                                    <%
                                    ' --- Optimized SQL Query using INNER JOIN and aliases for clarity ---
                                    sql = "SELECT arc.RegistryCode, sa.Species " & _
                                          "FROM associationRegistryCodes arc " & _
                                          "INNER JOIN speciesavailable sa ON arc.SpeciesID = sa.SpeciesID " & _
                                          "WHERE arc.AssociationID = " & AssociationID & " " & _
                                          "ORDER BY sa.SpeciesID"

                                    ' response.write("sql=" & sql) ' Uncomment for debugging SQL

                                    Set rs2 = Server.CreateObject("ADODB.Recordset")

                                    ' Check for connection object before attempting to open recordset
                                    If Not IsObject(conn) Then
                                        Response.Write "<p style='color: red;'>Error: Database connection object 'conn' is not available.</p>"
                                        ' Optional: log error, redirect, or exit script
                                    Else
                                        ' --- Optimized Recordset Open: adOpenForwardOnly (0) and adLockReadOnly (1) ---
                                        ' This is faster and uses less memory if you only need to read data forward.
                                        rs2.Open sql, conn, 0, 1

                                        ' --- Check for database errors after opening the recordset ---
                                        If Err.Number <> 0 Then
                                            Response.Write "<p style='color: red;'>Error retrieving registry codes: " & Err.Description & "</p>"
                                            Err.Clear ' Clear the error to prevent it from affecting subsequent operations
                                        Else
                                            ' --- Loop through recordset to display data ---
                                            While Not rs2.EOF
                                                RegistryCode = rs2("RegistryCode")
                                                Species = rs2("Species")
                                    %>
                                                <%=RegistryCode %> (<%=Species %>)<br />
                                    <%
                                                rs2.MoveNext
                                            Wend
                                        End If ' End If Err.Number <> 0
                                    End If ' End If Not IsObject(conn)

                                    ' --- Proper Resource Cleanup for rs2 ---
                                    If Not rs2 Is Nothing Then
                                        If rs2.State = 1 Then rs2.Close ' Close only if it's open
                                        Set rs2 = Nothing
                                    End If
                                    %>

                                    <div align ="right"><a href="AssociationAcronyms.asp" class ="body"><small>Assign Acronyms</small></a></div>

                                    <% if Len(AssociationEmailaddress) > 0 then%>
                                        <%=AssociationEmailaddress%><br />
                                    <% end if %>
                                    <% if Len(AssociationPhone) > 0 then%>
                                        <%=AssociationPhone%><br />
                                    <% end if %>
                                    <% if Len(Associationwebsite) > 1 then %>
                                       <a href="<%=Associationwebsite%>" class ="body" target="_blank">Website</a><br />
                                    <% end if %>
                                    <% if Len(AssociationStreet1) > 3 then %>
                                       <%=AssociationStreet1%><br />
                                    <% end if %>
                                    <% if Len(AssociationStreet2) > 3 then %>
                                       <%=AssociationStreet2%><br />
                                    <% end if %>
                                    <% if Len(AssociationCity) > 3 then %>
                                       <%=AssociationCity%> &nbsp;
                                    <% end if %>
                                    <% if Len(AssociationstateName) > 3 then %>
                                       <%=AssociationstateName%>
                                    <% end if %>
                                    <% if Len(AssociationCountry) > 1 then %>
                                       &nbsp; <%=AssociationCountry %>
                                    <% end if %>
                                    <% if Len(AssociationZip) > 1 then %>
                                       &nbsp;<%=AssociationZip%><br />
                                    <% end if %>

                                    <div align ="right"><a href="AssociationListingEdit.asp" class ="body"><small>Update</small></a></div>
                                    <div align ="right"><a href="AssociationDeleteAccount.asp" class ="body"><small>Delete</small></a></div>

                                </p>

                            </div>
                        </div>
                    </div>
                    <%=HSpacer %>
                </div>
                <div class="col-md-1" style="max-width: 6px;"></div>
                <div class="col-md-8" style="max-width: 400px">
                    <div class="container roundedtopandbottomgrey mx-auto" style="max-width: 400px; min-width: 400px">

                        <div class ="row">
                            <div class = "col-3" style="max-width:90px; min-width:90px">
                                <font size="1px"><br /></font>

                            </div>
                            <div class = "col-9"><h2>Listing</h2>
                                <ul >
                                    <li><a class="body" href="AssociationListingEdit.asp" >Basics</a></li>
                                    <li><a class="body" href="AssociationBreeds.asp" >Breeds</a></li>
                                    <li><a class="body" href="AssociationDirectoryCountries.asp" >Countries</a></li>
                                    <li><a class="body" href="AssociationLogo.asp" >Logo</a></li>
                                    <li><a class="body" href="AssociationAcronyms.asp" >Acronyms</a></li>
                                    <li><a class="body" href="AssociationDescription.asp" >Description</a></li>
                                </ul>
                                <br />
                            </div>
                        </div>
                    </div>
                    <%=HSpacer %>

                    <% if CInt(Session("AccessLevel")) > 1 then %>
                    <div class ="container roundedtopandbottomgrey" style="max-width:400px; min-width:400px">
                        <div class ="row">
                            <div class = "col-3" style="max-width:90px; min-width:90px">
                                <font size="1px"><br /></font>

                            </div>
                            <div class = "col-9"><h2>Members</h2>
                                <ul >
                                    <li><a class="body" href="AssociationEditMembers.asp" >List</a></li>
                                    <li><a class="body" href="AssociationAddMembers.asp" >Add</a></li>
                                    <li><a class="body" href="AssociationRemoveUser.asp" >Remove Accounts</a></li>
                                </ul>
                                <br /> <br />
                            </div>
                        </div>
                    </div>
                    <% end if %>
                    <%=HSpacer %>
                </div>
            </div>
            <br /><br />
        </div>
    </div>
</div>
<br /><br />
</div>





<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body></html>