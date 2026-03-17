<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <title>Harvest Hub Dashboard</title>
      <% MasterDashboard= True %>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<% 
pagename = "addaccount"
Current1 = "MembersHome"
Current2="MembersHome"
BladeSection = "accounts" %> 
</head>
<body>
<!--#Include virtual="/members/MembersHeader.asp"-->

<%
Current = "Home"
Current1 = "MembersHome"
Current2 = "MembersHome"
Current3="Register"
session("Confirmationsent") = False
variables = ""
missing = ""
MissingData = False
EmailsMatch = True

'======================================================================
'-- BEGIN: DATA PRE-LOADING & USER LOCATION LOGIC
'======================================================================

'-- Step 1: Simulate getting the user's location.
' In a real-world scenario, you would use an IP-to-geolocation service here.
' For this example, we will default to United States / Oregon.
userCountryID = 223 ' The country_id for United States
userStateName = "Oregon" ' The name of the state/province

'-- Step 2: Pre-load all states into a VBScript dictionary for easy lookup.
Set statesJson = Server.CreateObject("Scripting.Dictionary")
sql = "SELECT StateIndex, name, country_id FROM state_province ORDER BY country_id, name"

'response.write("sql=" & sql)
Set stateRs = Server.CreateObject("ADODB.Recordset")
stateRs.Open sql, conn, 1, 1

firstCountry = True
If Not stateRs.EOF Then
    countryIdForLoop = stateRs("country_id")
    Do While Not stateRs.EOF
        If Not statesJson.Exists(countryIdForLoop) Then
            statesJson.Add countryIdForLoop, ""
        End If

        ' Build a JSON-like string for each state
        Dim stateString
        stateString = "{""id"":" & stateRs("StateIndex") & ",""name"":""" & Replace(stateRs("name"), """", "\""") & """}"

        ' Append the state string to the corresponding country entry
        If Len(statesJson(countryIdForLoop)) > 0 Then
            statesJson(countryIdForLoop) = statesJson(countryIdForLoop) & "," & stateString
        Else
            statesJson(countryIdForLoop) = stateString
        End If

        ' Find the ID for the user's default state
        If stateRs("country_id") = userCountryID And LCase(stateRs("name")) = LCase(userStateName) Then
            userStateID = stateRs("StateIndex")
        End If

        stateRs.MoveNext
        If Not stateRs.EOF Then
            countryIdForLoop = stateRs("country_id")
        End If
    Loop
End If
stateRs.Close

'-- Step 3: Convert the VBScript dictionary to a single JavaScript object string.
Dim jsObject, key
jsObject = "{"
firstCountry = True
For Each key In statesJson.Keys
    If Not firstCountry Then
        jsObject = jsObject & ","
    End If
    jsObject = jsObject & """" & key & """:[" & statesJson(key) & "]"
    firstCountry = False
Next
jsObject = jsObject & "}"

BusinessName = request.form("BusinessName")
BusinessWebsite = request.form("BusinessWebsite")
BusinessTypeID = request.form("BusinessTypeID")
website = request.form("website")



Stepback2 = Request.querystring("Stepback2")
passwordmismatch = Request.querystring("passwordmismatch")
SpecialChecterFound = Request.querystring("SpecialChecterFound")
MissingProvince = request.querystring("MissingProvince")
StateIndexFound = Request.querystring("StateIndexFound")
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add An Organization</title>
    <!-- Add references to your CSS (like Bootstrap) here if needed -->
</head>
<body>


<div class="container roundedtopandbottom mx-auto" style="max-width:450px">
    <div class="col">
        <h1>Add An Organization</h1>

        <form name="form" method="post" action="SetupAccountPlusstep3.asp?Subscription=<%=Subscription%>">

            <% '<!-- Error message display logic -->
            if StateIndexFound = "False" and Stepback2 = "True" then %><font color="maroon"><br /><b>Please select your State/Province.</b></font><% end if %>
            <% if passwordmismatch = "False" and Stepback2 = "True" then %><font color="maroon"><br /><b>Your passwords did not match.</b></font><% end if %>
            <% if SpecialChecterFound = "False" and Stepback2 = "True" then %><font color="maroon"><br /><b>Your password needs a special character.</b></font><% end if %>
            <% if MissingProvince = "True" and Stepback2 = "True" then %><br><font color="maroon"><b>Please select your State/Province.</b></font><% end if %>

            <div class="form-group"><br />
                <label for="AddressStreet">Street (Optional)</label><br />
                <input type="Text" name="AddressStreet" class="formbox" id="AddressStreet" Value="<%=AddressStreet%>"  size="50">
            </div>
            <div class="form-group"><br />
                <label for="AddressApt">Address 2 <font color="#abacab">(Optional)</font></label><br />
                <input type="Text" name="AddressApt" class="formbox" id="AddressApt" Value="<%=AddressApt%>" size="50">
            </div>
            <div class="form-group"><br />
                <label for="AddressCity">City (Optional)</label><br />
                <input type="Text" name="AddressCity" class="formbox" id="AddressCity" Value="<%=AddressCity%>"  size="50">
            </div>
            <div class="form-group"><br />
                <label for="country_id">Country</label><br />
                <select size="1" name="country_id" id="country_id" class="formbox" style="width: 430px" required>
                    <option value="">-- Select a Country --</option>
                    <%
                    sql = "SELECT country_id, name FROM country ORDER BY name"
                    Set rs = Server.CreateObject("ADODB.Recordset")
                    rs.Open sql, conn, 3, 3
                    While Not rs.eof
                        Dim selectedAttr
                        If rs("country_id") = userCountryID Then selectedAttr = "selected" Else selectedAttr = "" End If
                        Response.Write("<option value='" & rs("country_id") & "' " & selectedAttr & ">" & rs("name") & "</option>")
                        rs.movenext
                    Wend
                    rs.Close
                    %>
                </select>
            </div>
            <div class="form-group"><br />
                <label for="StateIndex" id="provinceTypeLabel">State / Province</label><br />
                <select size="1" name="StateIndex" id="StateIndex" class="formbox" style="width: 430px" required disabled>
                    <option value="">-- Select a Country First --</option>
                </select>
            </div>
            <div class="form-group"><br />
                <label for="AddressZip">Postal Code <font color="#abacab">(Optional)</font></label><br />
                <input type="Text" name="AddressZip" class="formbox" id="AddressZip" Value="<%=AddressZip%>" size="50">
            </div>
            <div class="form-group"><br />
                <label for="PeoplePhone">Phone (Optional)</label><br />
                <input type="text" id="PeoplePhone" name="PeoplePhone" class="formbox" oninput="validatePhoneInput(event)" value="<%=PeoplePhone%>"  size="50" title="Please enter a valid phone number.">
            </div>
            <br />
            <style>.custom-checkbox input[type="checkbox"] { background-color: #517031; }</style>
            <label class="custom-checkbox">
                <input type="checkbox" id="permissionCheckbox" Name="Permission" checked>
                Yes, you have my permission to share my listings in mass emails and on social media.
            </label>
            <% if IsNumeric(BusinessTypeID) and CInt(BusinessTypeID) = 8 then %>
            <br /><br />
            <label class="custom-checkbox">
                <input type="checkbox" id="disclaimerCheckbox1" Name="LivestockLegalDisclaimer" required>
                <b>Livestock Legal Disclaimer:</b> I acknowledge and agree that I am solely responsible for negotiating all livestock sales. Oatmeal Farm Network bears no legal responsibility for any facet of such sales as well as any ensuing consequences arising from said transactions.
            </label>
            <br /><br />
            <label class="custom-checkbox">
                <input type="checkbox" id="disclaimerCheckbox2" Name="SalesLegalDisclaimer" required>
                <b>Sales Legal Disclaimer:</b> I acknowledge and agree that Oatmeal Farm Network bears no legal responsibility for any facet of sales, including but not limited to the sale of livestock, eggs, fiber/wool, products, and services, as well as any ensuing consequences arising from said transactions.
            </label>
            <br /><br />
            <% end if %>
            <!-- Hidden fields -->

            <input name="BusinessName" type="hidden" value="<%=BusinessName%>"/>
            <input name="BusinessWebsite" type="hidden" value="<%=BusinessWebsite%>"/>
            <input name="BusinessTypeID" type="hidden" value="<%=BusinessTypeID%>"/>
            <br />
            <div align="center"><input type="submit" value="Next" class="regsubmit2"></div>
        </form>
        <br><br>
    </div>
</div>
<br>

<script>
    // --- JAVASCRIPT FOR DYNAMIC FUNCTIONALITY ---

    // This JS object is now created by VBScript on the server, holding all state data.
    var allStatesData = <%= jsObject %>;
    var defaultStateID = '<%= userStateID %>';

    var countryDropdown = document.getElementById('country_id');
    var stateDropdown = document.getElementById('StateIndex');
    var provinceLabel = document.getElementById('provinceTypeLabel');

    function populateStates(countryId) {
        var countryName = countryDropdown.options[countryDropdown.selectedIndex].text;

        // Update the label for State/Province based on country
        provinceLabel.textContent = (countryName === 'United States') ? 'State' : 'Province';

        // Clear and disable the state dropdown
        stateDropdown.innerHTML = '';
        stateDropdown.disabled = true;

        if (!countryId || !allStatesData[countryId]) {
            var defaultOption = document.createElement('option');
            defaultOption.value = '';
            defaultOption.textContent = '-- Select a Country First --';
            stateDropdown.appendChild(defaultOption);
            return;
        }

        // Add a default blank option
        var selectOption = document.createElement('option');
        selectOption.value = '';
        selectOption.textContent = '-- Select a ' + provinceLabel.textContent + ' --';
        stateDropdown.appendChild(selectOption);

        // Populate the dropdown with the states from our pre-loaded JS object
        var states = allStatesData[countryId];
        states.forEach(function(state) {
            var option = document.createElement('option');
            option.value = state.id;
            option.textContent = state.name;
            if (state.id.toString() === defaultStateID) {
                option.selected = true;
            }
            stateDropdown.appendChild(option);
        });

        // Enable the dropdown
        stateDropdown.disabled = false;
    }

    // Add an event listener to the country dropdown for changes
    countryDropdown.addEventListener('change', function() {
        // When the user changes the country, reset the default state ID so it doesn't auto-select
        defaultStateID = '';
        populateStates(this.value);
    });

    // Run this when the page first loads to populate the states for the default country
    document.addEventListener('DOMContentLoaded', function() {
        if (countryDropdown.value) {
            populateStates(countryDropdown.value);
        }
    });

    // --- Phone number validation ---
    function validatePhoneInput(event) {
        event.target.value = event.target.value.replace(/[^0-9\s\(\)-]/g, '');
        if (event.target.value.length > 20) {
            event.target.value = event.target.value.slice(0, 20);
        }
    }
</script>


<%
Set rs = nothing
Set conn = nothing
Set statesJson = nothing
Set stateRs = nothing
%>
<!--#Include virtual="/members/MembersFooter.asp"-->
 </body>
</HTML>