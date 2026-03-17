<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Harvest Hub</title>
<!--#Include file="MembersGlobalVariables.asp"-->
<% AnimalID = request.QueryString("AnimalID")

if len(AnimalID) > 1 then
else
AnimalID = Request.Form("AnimalID")
end if


if len(AnimalID) > 1 then
else
ID = Request.querystring("ID")
AnimalID = ID
end if



if len(AnimalID) < 1 then
 Response.redirect("default.asp#Animals")
end if
if rs.state > 0 then
    rs.close
end if

sql = "select Businessid, SpeciesID, DOBMonth, DOBDay, DOBYear, Temperment, Weight, Height, Gaited, Warmblooded, BreedID, BreedID2, BreedID3, BreedID4, BreedID5, Category, FullName, BreedID, BreedID2, BreedID3, BreedID4, NumberofAnimals, Horns, Vaccinations from Animals where AnimalID=" & AnimalID	
'response.write("sql=" & sql)

rs.Open sql, conn, 3, 3

NumberofAnimals = rs("NumberofAnimals")
name = rs("FullName")
SpeciesID = rs("SpeciesID")

Category = rs("Category")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
BusinessID= rs("BusinessID")
response.write("<br>BusinessID=" & BusinessID)
SpeciesID= rs("SpeciesID")
DOBMonth = rs("DOBMonth") 
DOBDay = rs("DOBDay")
DOBYear= rs("DOBYear")

DOB = DOBMonth & "/" & DOBDay & "/" & DOBYear
Temperment= rs("Temperment") 
Weight = rs("Weight") 
Height = rs("Height") 
Gaited = rs("Gaited") 
Warmblooded= rs("Warmblooded")
BreedID= rs("BreedID")
BreedID2 = rs("BreedID2")
BreedID3= rs("BreedID3")
BreedID4 = rs("BreedID4")
Category = rs("Category")
Horns = rs("Horns")
name = rs("FullName")
BreedlookupID  = rs("BreedID")
BreedlookupID2  = rs("BreedID2")
BreedlookupID3  = rs("BreedID3")  
BreedlookupID4  = rs("BreedID4")
NumberofAnimals = rs("NumberofAnimals") 
Vaccinations = rs("Vaccinations")
if len(NumberofAnimals) > 0 then
else
NumberofAnimals = 1
end if
rs.close

if len(Category) > 0 and not (len(Category) > 8 or Category = "Experienced Female" or Category = "Experienced Male" or Category = "Inexperienced Female" or Category = "Experienced Female" or Category = "Experienced Male" or Category = "Inexperienced Female" or Category = "Inexperienced Male") then
    sql = "select QuantityType, SpeciesCategory from speciescategory where SpeciesCategoryID=" & Category
    'response.write("sql!=" & sql)
    rs.Open sql, conn, 3, 3
        QuantityType= rs("SpeciesCategory")
    SpeciesCategory = rs("SpeciesCategory")
    rs.close
end if

if SpeciesID = 2 then
SpeciesName="Alpaca" 
end if 
if SpeciesID = 3 then
SpeciesName="Dog"
end if 
if SpeciesID = 4 then
SpeciesName="Llama"
end if 
if SpeciesID = 5 then
SpeciesName="Horse"
end if 
if SpeciesID = 6 then
SpeciesName="Goat"
end if 
if SpeciesID = 7 then
SpeciesName="Donkey"
end if 
if SpeciesID = 8 then
SpeciesName="Cattle"
end if 
if SpeciesID = 9 then
SpeciesName="Bison"
end if 
if SpeciesID = 10 then
SpeciesName="Sheep"
end if 
if SpeciesID = 11 then
SpeciesName="Rabbit"
end if 
if SpeciesID = 12 then
SpeciesName="Pig"
end if 
if  SpeciesID = 13 then
SpeciesName="Chicken"
end if 
if SpeciesID = 14 then
SpeciesName="Turkey"
end if 
if SpeciesID = 15 then
SpeciesName="Duck"
end if 
if  SpeciesID = 16 then
SpeciesName="Cat"
end if 
if  speciesID = 17 then
SpeciesName="Yak"
end if 

if  speciesID = 18 then
SpeciesName="Camel"
end if 

if  speciesID = 19 then
SpeciesName="Emu"
end if 

if  speciesID = 21 then
SpeciesName="Deer"
end if 

if  speciesID = 22 then
SpeciesName="Geese"
end if 

if speciesID = 23 then
SpeciesName="Bees"
end if 

if speciesID = 25 then
SpeciesName="Crocodile / Alligator"
end if 

if speciesID = 26 then
SpeciesName="Guinea Fowl"
end if 

if speciesID = 27 then
SpeciesName="Musk Ox"
end if 

if speciesID = 28 then
SpeciesName="Ostriche"
end if 

if speciesID = 29 then
SpeciesName="Pheasant"
end if 

if speciesID = 30 then
SpeciesName="Pigeon"
end if 

if speciesID = 31 then
SpeciesName="Quail"
end if 

if speciesID = 33 then
SpeciesName="Snail"
end if 

if speciesID = 34 then
SpeciesName="Buffalo"
end if 


'response.write("len SpeciesID=" & len(SpeciesID) & "!")
if len(SpeciesID) >0 then
else
SpeciesID = 2
SpeciesName="Alpaca" 
end if

sql = "select * from SpeciesAvailable where SpeciesID=  " & SpeciesID &""
rs.Open sql, conn, 3, 3   
if not rs.eof then
SpeciesSalesType = rs("SpeciesSalesType")
'response.write("SpeciesSalesType=" & SpeciesSalesType )
end if
rs.close

sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where AnimalID=" & AnimalID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO AncestryPercents (animalID)" 
Query =  Query & " Values (" &  AnimalID & ")"
Conn.Execute(Query) 
rs.close

sql = "select PercentBolivian, PercentChilean, PercentUnknownOther, PercentAccoyo, PercentPeruvian from AncestryPercents where AnimalID=" & AnimalID
rs.Open sql, conn, 3, 3
End If 
PercentPeruvian = rs("PercentPeruvian")
PercentAccoyo = rs("PercentAccoyo")
PercentBolivian = rs("PercentBolivian")
PercentChilean = rs("PercentChilean")
PercentUnknownOther = rs("PercentUnknownOther") 

rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where AnimalID=" & AnimalID
rs.Open sql, conn, 3, 3
If rs.eof then
Query =  "INSERT INTO Colors (AnimalID)" 
Query =  Query & " Values (" &  AnimalID & ")"
Conn.Execute(Query) 
rs.close

sql = "select Color1, Color2, Color3, Color4, Color5 from Colors where AnimalID=" & AnimalID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
End If 
Color1 = rs("Color1")
Color2 = rs("Color2")
Color3 = rs("Color3")
Color4 = rs("Color4")
Color5 = rs("Color5")
rs.close

BusinessID=Request.querystring("BusinessID")

if len(BusinesssID) < 2 then
else
sql = "select BusinessName from Business where BusinessID=" & BusinessID
response.write("sql=" & sql)
rs.Open sql, conn, 3, 3
    BusinessName = rs("BusinessName")
rs.close
end if


%>

</head>
<body >
<% Current1="Animals"
Current2 = "EditAnimals"
Current3 = "Basics"
BladeSection = "accounts"
pagename = BusinessName
%> 
<!--#Include file="MembersHeader.asp"-->

<div class="container roundedtopandbottom">

    <form action='MembersGeneralStatsHandle.asp?Businessid=<%=Businessid%>&AnimalID=<%=AnimalID%>' method="post" name="g1">
        <div class="col">
            <div class="card-header">
               <!--#Include file="MembersJumpLinks.asp"-->
            </div>
            <div class="card-header">
                <h4 class="mb-0">Edit Animal Details</h4>
            </div>
            <div class="card-body p-4">
                <div class="row">
                    <!-- =================================== -->
                    <!--          LEFT COLUMN                -->
                    <!-- =================================== -->
                    <div class="col-md-6">
                        <h5>Basic Facts</h5>
                        <hr>

                        <!-- Name / Title -->
                        <div class="mb-3">
                            <label for="animalName" class="form-label required-field">Name / Title</label>
                            <%
                            str1 = name
                            str2 = """"
                            If InStr(str1, str2) > 0 Then
                                name = Replace(str1, """", "''")
                            End If
                            name = Replace(name, "''", "'")
                            %>
                            <input type="text" id="animalName" name="Name" value="<%=Name%>" class="formbox" style="width:400px" required>
                            <div class="form-text">
                                This can be a full name like <i>XYZ Ranch's MagaStud</i>
                                <% if Subscriptionlevel > 1 then %>
                                or a title like <i>5 Registered Brown Boars</i>.
                                <% end if %>
                            </div>
                        </div>

                        <!-- Species & Number -->
                        <div class="row mb-3">
                            <div class="col">
                                <label class="form-label">Species</label>
                                <p class="form-control-plaintext"><%=SpeciesName%></p>
                            </div>
                            <div class="col">
                                <label class="form-label"># Animals in Listing</label>
                                <p class="form-control-plaintext"><%=NumberofAnimals%></p>
                            </div>
                        </div>

                        <!-- Date of Birth -->
                        <% if NumberofAnimals = 1 and not(speciesID = 33 or Category = "Preborn Male" or Category = "Preborn Female" or Category = "Preborn Baby") then %>
                        <div class="mb-3">
                            <label for="dob" class="form-label">Date of Birth</label>
                            <%
                            DOBArray = Split(DOB, "/")
                            DOBmonth = DOBArray(0)
                            DOBday = DOBArray(1)
                            DOByear = DOBArray(2)
                            formattedDOB = DOByear & "-" & Right("0" & DOBmonth, 2) & "-" & Right("0" & DOBday, 2)
                            %>
                            <input type="date" id="dob" name="DOB" value="<%= formattedDOB %>" class="formbox" style="max-width: 200px;">
                        </div>
                        <% end if %>

                        <!-- Temperament -->
                        <% if NumberofAnimals < 2 and not( SpeciesID ="23" or SpeciesID ="33" or species = 22 or speciesis = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13) then %>
                        <div class="mb-3">
                            <label for="temperment" class="form-label">Temperament</label>
                            <select id="temperment" name="Temperment" class="form-select">
                                <% if len(Temperment) > 0 and Temperment <> "0" then %>
                                    <option value="<%=Temperment%>" selected><%=Temperment%></option>
                                    <option value="">-</option>
                                <% else %>
                                    <option value="" selected>-</option>
                                <% end if %>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                                <option value="8">8</option>
                                <option value="9">9</option>
                                <option value="10">10</option>
                            </select>
                            <div class="form-text">1=Very Calm, 10=Very High-Spirited</div>
                        </div>
                        <% end if %>

                        <!-- Category -->
                        <% if not ( SpeciesID =23 or SpeciesID =33 ) then %>
                        <div class="mb-3">
                            <label for="category" class="form-label">Category</label>
                            <%
                            sql2 = "select * from speciescategory where speciesID=" & speciesID & QuantityTypeScrtipt & " Order by SpeciesCategoryOrder"
                            Set rs2 = Server.CreateObject("ADODB.Recordset")
                            rs2.Open sql2, conn, 3, 3
                            if not rs2.eof then
                            %>
                                <select id="category" name="Category" class="form-select" required>
                                    <option value="<%=Category%>" selected><%=SpeciesCategory%></option>
                                    <%
                                    Set rs2 = Server.CreateObject("ADODB.Recordset")
                                    rs2.Open sql2, conn, 3, 3
                                    if not rs2.eof then
                                        i = 0
                                        while not rs2.eof
                                            i = i + 1
                                    %>
                                            <option value="<%=rs2("SpeciesCategoryID")%>"><%=rs2("SpeciesCategory")%></option>
                                    <%
                                            rs2.movenext
                                        wend
                                    end if
                                    %>
                                </select>
                            <% end if %>
                        </div>
                        <% end if %>
                        
                        <!-- Breed/Type Dropdowns -->
                        <%
                        if SpeciesId > 0 then
                        else
                            SpeciesID = 2
                        end if
                        speciesIDfound = false
                        sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by Breed"
                        Set rs2 = Server.CreateObject("ADODB.Recordset")
                        rs2.Open sql2, conn, 3, 3
                        if not rs2.eof then
                            speciesIDfound = True
                        end if
                        rs2.close
                        if speciesIDfound = True then
                        %>
                            <div class="mb-3">
                                <label for="breed1" class="form-label required-field">
                                    <% if SpeciesID = 4 or SpeciesID = 23 then %>Type<% else %>Breed<% end if %>
                                </label>
                                <!-- ASP logic for Breed 1 -->
                                <%
                                Set rsb = Server.CreateObject("ADODB.Recordset")
                                sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and  SpeciesID=" & speciesID & " Order by trim(Breed)"
                                rs2.Open sql2, conn, 3, 3
                                if not rs2.eof then
                                    if len(BreedLookupID) > 0 then
                                        sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedlookupID=" & BreedlookupID
                                        rsb.Open sqlb, conn, 3, 3
                                        if not rsb.eof then
                                            Currentbreed = rsb("Breed")
                                        end if
                                        rsb.close
                                    end if
                                %>
                                <select id="breed1" name="BreedID" class='form-select' required>
                                    <% if len(Currentbreed) > 0 then %>
                                        <option value="<%=BreedlookupID %>" selected><%=Currentbreed %></option>
                                        <option value="">-</option>
                                    <% elseif len(PreferedSpeciesBreed) > 0 then %>
                                        <option value="<%=PreferedSpeciesBreed %>" selected><%=PreferedSpeciesBreed %></option>
                                    <% else %>
                                        <option value="" selected>Select a breed...</option>
                                    <% end if %>
                                    <% while not(rs2.eof)
                                        Breed = rs2("Breed")
                                        BreedID = rs2("BreedLookupID")
                                        if not( Breed = PreferedSpeciesBreed) and not(trim(Breed) = trim(Currentbreed)) then %>
                                            <option value="<%= BreedID %>"><%= trim(Breed) %></option>
                                    <%
                                        end if
                                        rs2.movenext
                                    wend
                                    end if
                                    rs2.close
                                    %>
                                </select>
                            </div>

                            <!-- Additional Breed Dropdowns -->
                            <% if not(speciesID= 2 or speciesID= 9 or speciesID = 23 or speciesID = 34 or SpeciesID =33) then%>
                                <% for i = 2 to 4 %>
                                <div class="mb-3">
                                    <label for="breed<%=i%>" class="form-label">Breed</label>
                                    <!-- ASP Logic for Breed <%=i%> -->
                                    <%
                                    Dim currentBreedLookupID, currentBreedName
                                    Select Case i
                                        Case 2: currentBreedLookupID = BreedlookupID2
                                        Case 3: currentBreedLookupID = BreedlookupID3
                                        Case 4: currentBreedLookupID = BreedlookupID4
                                    End Select

                                    sql2 = "select * from SpeciesBreedLookupTable where breedavailable = 1 and SpeciesID=" & speciesID & " Order by trim(Breed)"
                                    rs2.Open sql2, conn, 3, 3
                                    if not rs2.eof then
                                        if len(currentBreedLookupID) > 0 and currentBreedLookupID <> 0 then
                                            sqlb = "select * from SpeciesBreedLookupTable where breedavailable = 1 and BreedlookupID=" & currentBreedLookupID
                                            rsb.Open sqlb, conn, 3, 3
                                            if not rsb.eof then
                                                currentBreedName = rsb("Breed")
                                            end if
                                            rsb.close
                                        end if
                                    %>
                                    <select id="breed<%=i%>" name="BreedID<%=i%>" class='form-select'>
                                        <% if len(currentBreedName) > 0 then %>
                                            <option value="<%=currentBreedLookupID%>" selected><%=currentBreedName%></option>
                                            <option value="">-</option>
                                        <% else %>
                                            <option value="" selected>-</option>
                                        <% end if %>
                                        <% while not(rs2.eof)
                                            Breed = rs2("Breed")
                                            BreedID = rs2("BreedLookupID")
                                            if not(trim(Breed) = trim(currentBreedName)) then %>
                                                <option value="<%= BreedID %>"><%= trim(Breed) %></option>
                                        <%
                                            end if
                                            rs2.movenext
                                        wend %>
                                    </select>
                                    <% end if
                                    rs2.close %>
                                </div>
                                <% next %>
                            <% end if %>
                        <% end if %>
          

                        <!-- Color Dropdowns -->
                        <% if len(SpeciesName) > 0 and not( speciesID = 26 or speciesID = 18 or speciesID = 21 or speciesID = 33 or speciesID = 28 or speciesID = 31 or speciesID = 23 or speciesID = 25 or speciesid = 22 or speciesid = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13 or speciesid = 27) then %>
                            <div class="row">
                                <!-- ASP Logic for Colors -->
                                <%
                                Dim colorFields(5)
                                colorFields(1) = Color1
                                colorFields(2) = Color2
                                colorFields(3) = Color3
                                colorFields(4) = Color4
                                colorFields(5) = Color5
                                
                                Dim maxColors
                                If speciesid = 9 Then maxColors = 3 Else maxColors = 5

                                For i = 1 to maxColors
                                %>
                                <div class="col-sm-6 mb-3">
                                    <label for="color<%=i%>" class="form-label">Color <%=i%></label>
                                    <%
                                    sqlc = "select * from SpeciesColorlookupTable where SpeciesID = " & SpeciesID & " order by SpeciesColor "
                                    Set rsc = Server.CreateObject("ADODB.Recordset")
                                    rsc.Open sqlc, conn, 3, 3
                                    %>
                                    <select id="color<%=i%>" name="Color<%=i%>" class='form-select'>
                                        <% if len(colorFields(i)) > 0 then %>
                                            <option value="<%=colorFields(i)%>" selected><%=colorFields(i)%></option>
                                            <option value="">--</option>
                                        <% else %>
                                            <option value="" selected>--</option>
                                        <% end if %>
                                        <% while not rsc.eof %>
                                            <option value="<%=rsc("SpeciesColor")%>"><%=rsc("SpeciesColor")%></option>
                                        <%
                                            rsc.movenext
                                        wend
                                        %>
                                    </select>
                                </div>
                                <% next %>
                            </div>
                        <% end if %>

                        <!-- Registrations -->
                        <% if NumberofAnimals = "1" and not(SpeciesID = 23 or speciesID = 34 or species = 22 or speciesis = 19 or speciesid = 15 or speciesid = 14 or speciesid = 13) then %>
                            <%
                            dim RegistrationType(100)
                            dim RegistrationNumber(100)
                            x = 0
                            Set rs3 = Server.CreateObject("ADODB.Recordset")
                            if len(SpeciesID) > 0 then
                                sql2 = "select * from SpeciesRegistrationTypeLookupTable where SpeciesID=" & speciesID & " order by SpeciesRegistrationType"
                                Set rs2 = Server.CreateObject("ADODB.Recordset")
                                rs2.Open sql2, conn, 3, 3
                                x = 0
                                if not rs2.eof then
                            %>
                                    <h5>Registrations</h5>
                                    <hr>
                                    <%
                                    while not(rs2.eof)
                                        RegNumber = ""
                                        SpeciesRegistrationType = rs2("SpeciesRegistrationType")
                                        sql3 = "select * from Animalregistration where RegType = '" & SpeciesRegistrationType & "' and AnimalID = " & AnimalID
                                        rs3.Open sql3, conn, 3, 3
                                        if not rs3.eof then
                                            RegNumber = rs3("Regnumber")
                                        else
                                            rs3.close
                                            Query = "INSERT INTO Animalregistration (RegType, AnimalID) "
                                            Query = Query & " Values ('" & SpeciesRegistrationType & "' ,"
                                            Query = Query & " " & AnimalID & " )"
                                            Conn.Execute(Query)
                                        end if
                                        if rs3.state <> 0 then rs3.close
                                    %>
                                        <div class="mb-3">
                                            <label for="reg_<%=x%>" class="form-label"><%=SpeciesRegistrationType%></label>
                                            <input type="hidden" name="SpeciesRegistrationType(<%=x%>)" value="<%=SpeciesRegistrationType %>">
                                            <input type="text" id="reg_<%=x%>" name="RegistrationNumber(<%=x%>)" value="<%=RegNumber%>" class='form-control'>
                                        </div>
                                    <%
                                        X = X + 1
                                        rs2.movenext
                                    wend
                                    rs2.close
                                    %>
                                    <input type='hidden' name="totalregistrations" value="<%=x%>">
                                <%
                                end if
                            end if
                            %>
                        <% end if %>

                        <!-- Vaccinations -->
                        <% if not SpeciesID = 23 then %>
                            <div class="mb-3">
                                <label for="vaccinations" class="form-label">Vaccinations</label>
                                <textarea name="Vaccinations" id="vaccinations" cols="45" rows="8" class="form-control"><%= Vaccinations%></textarea>
                           </div>
                        <% end if %>
                        
                    </div>
                    <div class="col-md-6">
                     </div>
                </div>
            </div>
             <div class=" text-center">
                <input type="hidden" name="FormID" value="GeneralStats">
                <input type="hidden" name="AnimalID" value="<%=AnimalID%>">
                <button type="submit" class="regsubmit2">Save Changes</button>
            </div>
     </div>
    </form>
</div>

<%conn.close
set Conn = nothing %>


<!--#Include file="MembersFooter.asp"-->

 </Body>
</HTML>
