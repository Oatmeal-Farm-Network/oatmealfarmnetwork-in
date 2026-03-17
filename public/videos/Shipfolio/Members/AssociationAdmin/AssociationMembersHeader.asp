<%

' --- Initialize HSpacer and get IDs ---
HSpacer = "<div class = row ><div class=col-12 body style=min-height:20px></div></div>"

MemberAccessLevel = Session("MemberAccessLevel")
AssociationID = Request.QueryString("AssociationID")

If Len(AssociationID) < 1 Then
    AssociationID = Session("AssociationID")
End If

Session("AssociationID") = AssociationID
PeopleID = Session("PeopleID")

' --- Main Query to fetch all Association, Address, Country, and State/Province data in one go ---
If Len(AssociationID) > 0 Then ' Only proceed if AssociationID is available

    sqlMainQuery = " SELECT " & _
                   " A.*, " & _
                   " AD.AddressStreet, AD.AddressApt, AD.AddressCity, AD.AddressZip, " & _
                   " AD.StateIndex AS AddressStateIndex, " & _
                   " AD.country_id AS AddressCountryID, " & _
                   " C.Name AS AssociationCountryName, " & _
                   " SP.Name AS AssociationStateProvinceName " & _
                   " FROM Associations A " & _
                   " LEFT JOIN address AD ON A.AddressID = AD.AddressID " & _
                   " LEFT JOIN Country C ON AD.country_id = C.country_id " & _
                   " LEFT JOIN state_province SP ON AD.StateIndex = SP.StateIndex " & _
                   " WHERE A.AssociationID = " & AssociationID

    ' response.write("sqlMainQuery=" & sqlMainQuery ) ' Uncomment for debugging

    Set rs = Server.CreateObject("ADODB.Recordset")

    ' Check for connection object before attempting to open recordset
    If Not IsObject(conn) Then
        Response.Write "<p style='color: red;'>Error: Database connection object 'conn' is not available.</p>"
        ' Optional: log error, redirect, or exit script
    Else
        ' --- Use adOpenForwardOnly (0) and adLockReadOnly (1) for efficiency ---
        rs.Open sqlMainQuery, conn, 0, 1

        ' --- Check for database errors after opening the recordset ---
        If Err.Number <> 0 Then
            Response.Write "<p style='color: red;'>Error retrieving association data: " & Err.Description & "</p>"
            Err.Clear ' Clear the error to prevent it from affecting subsequent operations
        Else
            If Not rs.EOF Then
                ' --- Populate variables from the single, comprehensive recordset ---
                AssociationTypeID = rs("AssociationTypeID")
                AssociationName = rs("AssociationName")
                AssociationAcronym = rs("AssociationAcronym")
                Associationwebsite = rs("Associationwebsite")
                AssociationEmailaddress = rs("AssociationEmailaddress")

                ' Prefer address data from address table if available
                If Len(rs("AddressStreet")) > 0 Then AssociationStreet1 = rs("AddressStreet") Else AssociationStreet1 = rs("AssociationStreet1") End If
                If Len(rs("AddressApt")) > 0 Then AssociationStreet2 = rs("AddressApt") Else AssociationStreet2 = rs("AssociationStreet2") End If
                If Len(rs("AddressCity")) > 0 Then AssociationCity = rs("AddressCity") Else AssociationCity = rs("AssociationCity") End If
                If Len(rs("AddressZip")) > 0 Then AssociationZip = rs("AddressZip") Else AssociationZip = rs("AssociationZip") End If

                AssociationStateIndex = rs("AddressStateIndex") ' Using alias from query
                Country_id = rs("AddressCountryID") ' Using alias from query
                AssociationPhone = rs("AssociationPhone")
                AssociationLogo = rs("AssociationLogo")
                AssociationDescription = rs("AssociationDescription")
                AssociationContactName = rs("AssociationContactName")
                AssociationPassword = rs("AssociationPassword")
                AssociationContactPosition = rs("AssociationContactPosition")
                AssociationContactEmail = rs("AssociationContactEmail")
                AssociationShowaddress = rs("AssociationShowaddress")
                Registry = rs("Registry")
                FoodHub = rs("FoodHub")
                FarmersMarket = rs("FarmersMarket")
                CSA = rs("CSA")
                Livestock = rs("Livestock")
                FarmAg = rs("FarmAg")

                ' --- Populate Country and State Name directly from the joined query results ---
                AssociationCountry = rs("AssociationCountryName")
                AssociationstateName = rs("AssociationStateProvinceName")

                ' --- Handle AssociationLogo domain replacement ---
                str1 = LCase(AssociationLogo)
                str2 = "livestockofamerica.com"
                If InStr(str1, str2) > 0 Then
                    AssociationLogo = Replace(str1, str2, "livestockoftheworld.com")
                End If

            End If ' End if not rs.eof
        End If ' End If Err.Number <> 0
    End If ' End If Not IsObject(conn)

    ' --- Proper Resource Cleanup for rs ---
    If Not rs Is Nothing Then
        If rs.State = 1 Then rs.Close ' Close only if it's open
        Set rs = Nothing
    End If

    ' --- Remaining String/URL manipulation ---
    str1 = AssociationName
    str2 = "''"
    If InStr(str1,str2) > 0 Then
      AssociationName= Replace(str1, str2, "'")
    End If

    If Left(Associationwebsite, 7) <> "http://" And Left(Associationwebsite, 8) <> "https://" Then
        Associationwebsite = "http://" & Associationwebsite
    End If

    ' --- Access Level Query (kept separate as it's a different table/context) ---
    Set rs = Server.CreateObject("ADODB.Recordset") ' Re-create rs for the new query
    Dim sqlAccessLevel
    sqlAccessLevel = " SELECT AccessLevel FROM AssociationMembers " & _
                     " WHERE PeopleID = " & Session("PeopleID") & " AND AssociationID = " & AssociationID

    ' response.write("sqlAccessLevel=" & sqlAccessLevel ) ' Uncomment for debugging

    ' Use adOpenForwardOnly (0) and adLockReadOnly (1) for efficiency
    rs.Open sqlAccessLevel, conn, 0, 1

    If Err.Number <> 0 Then
        Response.Write "<p style='color: red;'>Error retrieving access level: " & Err.Description & "</p>"
        Err.Clear
        AccessLevel = 0 ' Default to no access on error
    Else
        If Not rs.EOF Then
            AccessLevel = rs("AccessLevel")
            Session("AccessLevel") = AccessLevel
        Else
            AccessLevel = 0 ' Default to no access if no record found
            Session("AccessLevel") = AccessLevel
        End If
    End If

    ' --- Proper Resource Cleanup for rs after AccessLevel query ---
    If Not rs Is Nothing Then
        If rs.State = 1 Then rs.Close
        Set rs = Nothing
    End If

End If ' End If Len(AssociationID) > 0

' --- Reset Error Handling to default ---
On Error GoTo 0
%>


<!--#Include virtual="/members/MembersHeader.asp"-->