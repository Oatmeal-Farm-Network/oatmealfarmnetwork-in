<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="generator" content="Oatmeal AI">
    <title>Harvest Hub Dashboard</title>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->
<% 

' V A R I A B L E S
Dim BusinessID, sql, rs, BusinessEmail, BusinessPhone, AddressApt, AddressCity
Dim StateIndex, AddressZip, AddressCountry, AddressStreet, BusinessWebsite, BusinessCell
Dim BusinessFax, Contact1PeopleID, Query, BusinessFirstName, BusinessLastName
Dim BusinessName, BusinessLogo, WebsitesID, Current1, Current2, BladeSection, pagename
Dim lngSelectedCountryID, lngSelectedStateID, strSelected, strSQL, objRS

Const USA_COUNTRY_ID    = 1228
Const CANADA_COUNTRY_ID = 1039

' Initialize variables to prevent runtime errors if values are empty/null from the database
AddressCountry = ""
StateIndex = ""
BusinessID = Request.QueryString("BusinessID")

' --- 1. Fetch Business, Address, Phone, Website, and Contact Data ---
sql = "select distinct Business.*, address.*, Phone.*, website from Business, Address, Phone, Websites where Websites.WebsitesID = Business.WebsitesID and Business.PhoneID = Phone.PhoneID and Business.AddressID = Address.AddressID and Business.BusinessID = " & BusinessID

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  

If Not rs.eof Then  
    BusinessEmail = rs("BusinessEmail")
    BusinessPhone = rs("Phone")
    AddressApt = rs("AddressApt")
    AddressCity= rs("AddressCity")
    StateIndex = rs("StateIndex")
    AddressZip = rs("AddressZip")
    AddressCountry = rs("AddressCountry") ' <<< This holds the database CountryID (e.g., "1228" or "1039")
    AddressStreet = rs("AddressStreet")
    BusinessWebsite = rs("Website")
    BusinessCell = rs("CellPhone")
    BusinessFax= rs("Fax")
    Contact1PeopleID = rs("Contact1PeopleID")
End If
rs.Close 

' --- 2. Fetch Contact Name (Existing logic) ---
If Len(Contact1PeopleID) > 1 Then
    Query = "SELECT PeopleFirstName, PeopleLastName FROM People WHERE PeopleID = " & Contact1PeopleID
    Set rs = Server.CreateObject("ADODB.Recordset") ' Recreate rs for new query
    rs.Open Query, conn, 3, 3  
    If Not rs.eof Then  
        BusinessFirstName = rs("PeopleFirstName")
        BusinessLastName = rs("PeopleLastName")
    End If
    rs.Close
End If


' --- 3. Fetch Business Name, Logo, and WebsitesID (Existing logic) ---
sql = "select BusinessName, BusinessLogo, BusinessID, WebsitesID from Business where Business.BusinessID = " & BusinessID 

Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3  
If Not rs.eof Then 
    BusinessName = rs("BusinessName")
    BusinessLogo = rs("BusinessLogo")
    BusinessID = rs("BusinessID")
    WebsitesID = rs("WebsitesID") 
End If
rs.Close


' --- 4. Fetch Website if needed (Existing logic) ---
If Len(WebsitesID) > 0 And Len(BusinessWebsite) < 1 Then
    sql = "select Website from Websites where WebsitesID = " & WebsitesID
    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3  
    If Not rs.eof Then 
        BusinessWebsite = rs("Website")
    End If
    rs.Close
End If


' --- 5. Logic for Country/State Dropdowns (Setup) ---

' 5a. Determine selected Country ID
If Request.Form("ddlCountry") <> "" Then
    ' 1. Priority: Value posted from the form submission (for cascading/reload)
    lngSelectedCountryID = CLng(Request.Form("ddlCountry"))
ElseIf Len(AddressCountry) > 0 And IsNumeric(AddressCountry) Then
    ' 2. Next Priority: Value loaded from the database (for initial page load)
    lngSelectedCountryID = CLng(AddressCountry)
Else
    ' 3. Default: USA
    lngSelectedCountryID = USA_COUNTRY_ID 
End If

' 5b. Determine selected State Index
If Request.Form("ddlState") <> "" Then
    ' 1. Priority: Value posted from the form submission
    lngSelectedStateID = CLng(Request.Form("ddlState"))
ElseIf Len(StateIndex) > 0 And IsNumeric(StateIndex) Then
    ' 2. Next Priority: Value loaded from the database (for initial page load)
    lngSelectedStateID = CLng(StateIndex)
Else
    ' 3. Default: None
    lngSelectedStateID = 0
End If

' ... (Existing BladeSection / pagename settings) ...
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" 
pagename = BusinessName 
%>
 <!DOCTYPE html>
<html>
<head>
    <title>Account Update</title>
    <script language="JavaScript">
    </script>
</head>
<body>

<div class="container my-5">
    <div class="row">
        <div class="col-md-6">
            <form name="form" method="post" action="ContactsUpdateAccount.asp">
                <div class="row mb-3 align-items-center">
                    <label for="firstName" class="col-sm-4 col-form-label text-md-end">First Name:*</label>
                    <div class="col-sm-8">
                        <input type="text" name="BusinessFirstName" value="<%=BusinessFirstName%>" class="form-control" id="firstName" maxlength="61">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="lastName" class="col-sm-4 col-form-label text-md-end">Last Name:*</label>
                    <div class="col-sm-8">
                        <input type="text" name="BusinessLastName" value="<%=BusinessLastName%>" class="form-control" id="lastName" maxlength="61">
                    </div>
                </div>
                
                <div class="row mb-3 align-items-center">
                    <label for="businessName" class="col-sm-4 col-form-label text-md-end">Business Name:*</label>
                    <div class="col-sm-8">
                        <input type="text" name="BusinessName" value="<%=BusinessName%>" class="form-control" id="businessName" maxlength="61">
                    </div>
                </div>
                
                <div class="row mb-3 align-items-center">
                    <label for="website" class="col-sm-4 col-form-label text-md-end">Website:</label>
                    <div class="col-sm-8">
                        <input type="text" name="BusinessWebsite" value="<%=BusinessWebsite%>" class="form-control" id="website" maxlength="61">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="email" class="col-sm-4 col-form-label text-md-end">Email:*</label>
                    <div class="col-sm-8">
                        <input type="email" name="BusinessEmail" value="<%=BusinessEmail%>" class="form-control" id="email">
                    </div>
                </div>
                
                <div class="row mb-3 align-items-center">
                    <label for="address" class="col-sm-4 col-form-label text-md-end">Mailing Address:</label>
                    <div class="col-sm-8">
                        <input type="text" name="AddressStreet" value="<%=AddressStreet%>" class="form-control" id="address">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="aptSuite" class="col-sm-4 col-form-label text-md-end">Apartment / Suite:</label>
                    <div class="col-sm-8">
                        <input type="text" name="AddressApt" value="<%=AddressApt%>" class="form-control" id="aptSuite">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="city" class="col-sm-4 col-form-label text-md-end">City:</label>
                    <div class="col-sm-8">
                        <input type="text" name="AddressCity" value="<%=AddressCity%>" class="form-control" id="city">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="ddlCountry" class="col-sm-4 col-form-label text-md-end">Country:</label>
                    <div class="col-sm-8">
                        <select name="ddlCountry" id="ddlCountry" class="form-control" onchange="submitCountryChange()">
                            <option value="">-- Select Country --</option>
                            <% 
                            ' Option 1: USA (ID: 1228)
                            strSelected = ""
                            If lngSelectedCountryID = USA_COUNTRY_ID Then
                                strSelected = " selected"
                            End If
                            Response.Write "<option value=""" & USA_COUNTRY_ID & """ " & strSelected & ">USA</option>"
                            
                            ' Option 2: Canada (ID: 1039)
                            strSelected = ""
                            If lngSelectedCountryID = CANADA_COUNTRY_ID Then
                                strSelected = " selected"
                            End If
                            Response.Write "<option value=""" & CANADA_COUNTRY_ID & """ " & strSelected & ">Canada</option>"
                            %>
                        </select>
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="ddlState" class="col-sm-4 col-form-label text-md-end">State/Province:</label>
                    <div class="col-sm-8">
                        <select name="ddlState" id="ddlState" class="form-control">
                            <option value="">-- Select State/Province --</option>
                            
                            <%
                            Set objRS = Server.CreateObject("ADODB.Recordset")
                            strSQL = "SELECT StateIndex, name, abbreviation FROM state_province WHERE country_id = " & lngSelectedCountryID & " ORDER BY name ASC"
                            objRS.Open strSQL, conn, 3, 1 
                            
                            If Not objRS.EOF Then
                                Do Until objRS.EOF
                                    strSelected = ""
                                    If CLng(objRS("StateIndex")) = lngSelectedStateID Then
                                        strSelected = " selected" 
                                    End If
                                    Response.Write "<option value=""" & objRS("StateIndex") & """ " & strSelected & ">" & objRS("name") & " (" & objRS("abbreviation") & ")</option>"
                                    objRS.MoveNext
                                Loop
                            Else
                                Response.Write "<option value="""">No States/Provinces Found</option>"
                            End If
                            
                            If objRS.State = 1 Then objRS.Close
                            Set objRS = Nothing
                            %>
                        </select>
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="postalCode" class="col-sm-4 col-form-label text-md-end">Postal Code:</label>
                    <div class="col-sm-8">
                        <input type="text" name="AddressZip" value="<%=AddressZip%>" class="form-control" id="postalCode" maxlength="8">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="phone" class="col-sm-4 col-form-label text-md-end">Phone:</label>
                    <div class="col-sm-8">
                        <input type="tel" name="BusinessPhone" value="<%=BusinessPhone%>" class="form-control" id="phone">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="cell" class="col-sm-4 col-form-label text-md-end">Cell:</label>
                    <div class="col-sm-8">
                        <input type="tel" name="BusinessCell" value="<%=BusinessCell%>" class="form-control" id="cell">
                    </div>
                </div>

                <div class="row mb-3 align-items-center">
                    <label for="fax" class="col-sm-4 col-form-label text-md-end">Fax:</label>
                    <div class="col-sm-8">
                        <input type="tel" name="BusinessFax" value="<%=BusinessFax%>" class="form-control" id="fax">
                    </div>
                </div>
                
                <input name="BusinessID" type="hidden" value="<%=BusinessID%>">

                <div class="row mb-3">
                    <div class="col-12 text-center">
                        <button type="submit" class="btn btn-primary">Update Account</button>
                    </div>
                </div>
            </form>
        </div>
        
        </div>
</div>
 
<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>