<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >
<% Current1 = "AssociationHome"
Current2 = "DirectoryListing" 
Current3 = "Summary" %> 

<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<div class="container roundedtopandbottom">
  <div class="row " valign ="top" style="vertical-align: top">
     <div class="col" > 
        
<% MemberAccessLevel= Session("MemberAccessLevel")
AssociationID = Session("AssociationID")
PeopleID = Session("PeopleID")

HSpacer = "<div class = row ><div class=col-12 body style=min-height:20px></div></div>" 
      
 Set rs = Server.CreateObject("ADODB.Recordset")   

Query= " Select distinct Associations.* "
Query= Query & " from Associations, associationMembers "
Query= Query & " where Associations.AssociationID = associationMembers.AssociationID and Associations.AssociationID = " & AssociationID

rs.Open Query, conn, 3, 3


if not rs.eof then
    AssociationID = rs("AssociationID")
    AssociationName = rs("AssociationName")
    AssociationAcronym = rs("AssociationAcronym")
    Associationwebsite = rs("Associationwebsite")
    AssociationEmailaddress = rs("AssociationEmailaddress")
    AssociationStreet1 = rs("AssociationStreet1")
    AssociationStreet2= rs("AssociationStreet2")
    AssociationCity = rs("AssociationCity")
    AssociationState = rs("AssociationState")
    AssociationZip = rs("AssociationZip")
    AssociationCountry = rs("AssociationCountry")
    AssociationPhone = rs("AssociationPhone")
    AssociationLogo = rs("AssociationLogo")
    AssociationDescription= rs("AssociationDescription")
    AssociationContactName = rs("AssociationContactName")
    AssociationPassword= rs("AssociationPassword")
    AssociationContactPosition= rs("AssociationContactPosition")
    AssociationContactEmail= rs("AssociationContactEmail")
    AssociationShowaddress = rs("AssociationShowaddress")
    country_id= rs("country_id")
    Registry = rs("Registry")
    FoodHub = rs("FoodHub")
    FarmersMarket = rs("FarmersMarket")
    CSA = rs("CSA")
    Livestock = rs("Livestock")
    FarmAg = rs("FarmAg")


    str1 = lcase(AssociationLogo)
    str2 = "livestockofamerica.com"
    If InStr(str1,str2) > 0 Then
	    AssociationLogo= Replace(str1, str2 , "livestockoftheworld.com")
    End If 
    

    str1 = AssociationName
    str2 = "''"
    If InStr(str1,str2) > 0 Then
	    AssociationName= Replace(str1,  str2, "'")
    End If 


 end if
      
      
If Left(Associationwebsite, 7) <> "http://" And Left(Associationwebsite, 8) <> "https://" Then
    Associationwebsite = "http://" & Associationwebsite
End If 
      
      
%>
</head>
<body>
<form name=form method="post" action="AssociationFoodHubUpdate.asp" >
<h1>Assount Basics</h1>
  <div class="container">
    <div class="row">
      <div class="col-lg-6">
       <div class ="container" style="max-width: 450px">
              <div class="col" > 
                
               <div class ="row">
                    <div class ="col body">
                        Food Hub<br />
                        <input name="AssociationName" Value ="<%=AssociationName%>" size = "40" maxlength = "61" class = formbox required>
                    </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col  body">
                        Acronym <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationAcronym" Value ="<%=AssociationAcronym%>" size = "40" maxlength = "6" class = formbox>
                    </div>
                </div>
                  <%=HSpacer  %>
                      <%=HSpacer  %>
                 <div class ="row">
                    <div class ="col body">
                        <b>Livestock Association? </b><br />
                        <% If Livestock = "True" Or Livestock = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="Livestock" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="Livestock" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="Livestock" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="Livestock" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
                  

                  <div class ="row">
                    <div class ="col body">
                        
                        <b>Do You Maintain a Livestock Registry? </b><br />
                        <% If Registry = "True" Or Registry = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="Registry" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="Registry" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="Registry" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="Registry" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
                <%=HSpacer  %>
                <div class ="row">
                    <div class ="col body">
                        <b>Local Food Organization? </b><br />
                        <% If FarmAg = "True" Or FarmAg = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="FarmAg" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FarmAg" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="FarmAg" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FarmAg" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
                <div class ="row">
                    <div class ="col body">
                        
                        <b>Food Hub? </b><br />
                        <% If FoodHub = "True" Or FoodHub = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="FoodHub" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FoodHub" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="FoodHub" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FoodHub" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
               <div class ="row">
                    <div class ="col body">
                        
                        <b>Offer CSA Boxes? </b><br />
                        <% If CSA = "True" Or CSA = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="CSA" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="CSA" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="CSA" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="CSA" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
                <div class ="row">
                    <div class ="col body">
                        
                        <b>Host a Farmers Market? </b><br />
                        <% If FarmersMarket = "True" Or FarmersMarket = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="FarmersMarket" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FarmersMarket" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="FarmersMarket" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="FarmersMarket" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>


            </div>
         </div>

        </div>
      <div class="col-lg-6">
       <div class ="container" style="max-width: 450px">
              <div class="col" > 
                 <div class ="row">
                    <div class ="col  body">
                        Website <font color="#abacab">(Optional)</font><br />
                         <input name="Associationwebsite" Value ="<%=Associationwebsite%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col body">
                        Email <br />
                        <input name="AssociationEmailaddress" size = "40" maxlength = "61" value = "<%=AssociationEmailaddress%>" class = formbox required>
                    </div>
                </div>
                 <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col body">
                        Phone <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationPhone"  size = "40" value = "<%=AssociationPhone%>" class = formbox><br />
                      </div>
                </div>
                <%=HSpacer  %> 
                <div class ="row">
                    <div class ="col body">
                        Street <font color="#abacab">(Optional)</font><br />
                       <input name="AssociationStreet1" size = "40" maxlength = "61" value = "<%=AssociationStreet1%>" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row body">
                    <div class ="col">
                    Street 2 <font color="#abacab">(Optional)</font><br />
                    <input name="AssociationStreet2" size = "40" maxlength = "61" value = "<%=AssociationStreet2%>" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col body">
                       City <font color="#abacab">(Optional)</font><br />
                       <input name="AssociationCity" size = "40" maxlength = "61" value = "<%=AssociationCity%>" class = formbox>
                     </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col body">
                        Country<br />
                        <select size="1" name="AssociationCountry" class = "formbox" style="min-width:340px; min-height:40px" >
                            <% if len(AssociationCountry) > 0 then %>
                            <option value="<%=country_id %>" selected><%=AssociationCountry %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  sql = "select country_id, Name from Country"
                             'response.write("sql=" & sql)
                          Set rs = Server.CreateObject("ADODB.Recordset")
                           rs.Open sql, conn, 3, 3 
                          while not rs.eof %>
                              <option  value="<%=rs("country_id")%>"><%=rs("Name") %></option>
                           <% rs.movenext
                            wend %>
                          </select>
                    </div>
                </div>
                <%=HSpacer  %> 

                <% if country_id > 0 then %>
                 <div class ="row">
                    <div class ="col body">
                     
                       <%  
                           if len(Associationstate) > 0 then
                           sql = "select Name from state_province where Stateindex = " & Associationstate
                           response.write("sql=" & sql )

                           rs.Open sql, conn, 3, 3 
                           if not rs.eof then
                             AssociationstateName = rs("Name")
                           end if
                         
                           end if
                         rs.close
                         %>

                        State/ Province <font color="#abacab">(Optional)</font><br />
                        <select size="1" name="AssociationState" class = "formbox" style="min-width:340px; min-height:40px" >
                            <% if len(Aassociationstate) > 0 then %>
                            <option value="<%=Associationstate %>" selected><%=AssociationstateName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  sql = "select Stateindex, Name from state_province where country_id=" & country_id
                             'response.write("sql=" & sql)
                          
                           rs.Open sql, conn, 3, 3 
                          while not rs.eof %>
                              <option  value="<%=rs("Stateindex")%>"><%=rs("Name") %></option>
                           <% rs.movenext
                            wend %>



                          </select>


                    </div>
                </div>
                <%=HSpacer  %> 
                <% end if %>

                 <div class ="row">
                    <div class ="col body">
                        Postal Code <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationZip"  size = "40" value = "<%=AssociationZip%>" class = "formbox" style="min-width:340px; min-height:40px" >
                      </div>
                </div>
                     <%=HSpacer  %> 

            </div>
         </div>

 <div class ="row">
                        <div class ="col body">
                           
                        </div>
                    </div>
      <input name="AssociationID" type = "hidden"  value = "<%=AssociationID%>">
      <input type=submit value="Update" class = "regsubmit2" >
       </form>
            <br /><br />


      </div>
    </div>
  </div>
 </div>
 </div>
 </div>

        

<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 
</body>
</html>