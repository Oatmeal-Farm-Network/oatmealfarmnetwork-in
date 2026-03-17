<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <meta charset="UTF-8">
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


   
 
%>
</head>
<body>
<form name=form method="post" action="AssociationContactsUpdateAccount.asp" >
<h1>Assount Basics</h1>
  <div class="container">
    <div class="row">
      <div class="col-lg-6">
       <div class ="container" >
              <div class="col" > 
                
               <div class ="row">
                    <div class ="col body">
                        Association Name<br />
                        <input name="AssociationName" Value ="<%=AssociationName%>" size = "40" maxlength = "61" class = formbox required>
                    </div>
                </div>

                <%=HSpacer  %> 
              <div class ="row">
                    <div class ="col body">
	                 Type<br />
                         <% if len(AssociationTypeID) > 0 then
                          sql = "select TypeName from associationtype where AssociationTypeID =" & AssociationTypeID
                          ' response.write("sql=" & sql)

                               rs.Open sql, conn, 3, 3 
                               if not rs.eof then
                                 AssociationTypeName = rs("TypeName")
                               end if
                                rs.close
                           end if
                           %>


                        <select size="1" name="AssociationTypeID" class = "formbox" style="min-width:320px; min-height:40px" required>
                            <% if len(AssociationTypeName) > 0 then %>
                            <option value="<%=AssociationTypeID %>" selected><%=AssociationTypeName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  sql = "select AssociationTypeID, TypeName from AssociationType"
                             'response.write("sql=" & sql)
                          Set rs = Server.CreateObject("ADODB.Recordset")
                           rs.Open sql, conn, 3, 3 
                          while not rs.eof %>
                              <option  value="<%=rs("AssociationTypeID")%>"><%=rs("TypeName") %></option>
                           <% rs.movenext
                            wend %>
                          </select>
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

                      <div class ="row">
                    <div class ="col body">
                        <b>Do You Wish Your Street Address to Be Shown? </b><br />
                        <% If AssociationShowaddress = "True" Or AssociationShowaddress = 1 Then %>
                            Yes&nbsp;<input TYPE="RADIO" name="AssociationShowaddress" Value = "1" checked>&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="AssociationShowaddress" Value = "0" >
                        <% Else %>
                            Yes&nbsp;<input TYPE="RADIO" name="AssociationShowaddress" Value = "1" >&nbsp;&nbsp;
                            No&nbsp;<input TYPE="RADIO" name="AssociationShowaddress" Value = "0" checked>
                        <% End If %>
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




                  <% if len(AssociationCountry_id) > 1 then 
                      sql = "select Stateindex, Name from state_province where country_id=" & AssociationCountry_id
                            ' response.write("sql=" & sql)
                      Set rs3 = Server.CreateObject("ADODB.Recordset")%>
                 <div class ="row">
                    <div class ="col body">

                            Province / State  <font color="#abacab">(Optional)</font><br />
                            <select size="1" name="AssociationStateIndex" class = "formbox" style="min-width:320px; min-height:40px" >
                            <% if len(AssociationStateIndex) > 0 then %>
                            <option value="<%=AssociationStateIndex %>" selected><%=AssociationstateName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  
                                                     
                           rs3.Open sql, conn, 3, 3 
                          while not rs3.eof %>
                              <option  value="<%=rs3("Stateindex")%>"><%=rs3("Name") %></option>
                           <% rs3.movenext
                            wend
                            %>
                          </select>
                     </div>
                </div>
                <%=HSpacer  %> 
                <% end if %>





                 <div class ="row">
                    <div class ="col body">
                        Country<br />
                       <% if len(AssociationCountry_id) > 1 then
                            if rs.state > 0 then
                                rs.close
                            end if
                            Set rs = Server.CreateObject("ADODB.Recordset")

                            sql = "select Name from Country where country_id = " & AssociationCountry_id
                             rs.Open sql, conn, 3, 3 
                            if not rs.eof then
                            AssociationCountryName = rs("Name")

                            end if
                          end if        %>


                        <select size="1" name="AssociationCountry_id" class = "formbox" style="min-width:320px; min-height:40px" required>
                            <% if len(AssociationCountry_id) > 0 then %>
                            <option value="<%=AssociationCountry_id %>" selected><%=AssociationCountryName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  sql = "select country_id, Name from Country"
                             'response.write("sql=" & sql)
                          Set rs3 = Server.CreateObject("ADODB.Recordset")
                           rs3.Open sql, conn, 3, 3 
                          while not rs3.eof %>
                              <option  value="<%=rs3("country_id")%>"><%=rs3("Name") %></option>
                           <% rs3.movenext
                            wend %>
                          </select>
                    </div>
                </div>
                <%=HSpacer  %> 

 
               <div class ="row">
                    <div class ="col body">
                        Postal Code <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationZip"  size = "40" value = "<%=AssociationZip%>" class = "formbox" style="min-width:320px; min-height:40px" >
                      </div>
                </div>
                     <%=HSpacer  %> 
            </div>
         </div>
      </div>
 
      <div class="col-lg-6">
       <div class ="container" >
              <div class="col" > 
                 <div class ="row">
                    <div class ="col body">
                        Email <br />
                        <input name="AssociationEmailaddress" size = "40" maxlength = "61" value = "<%=AssociationEmailaddress%>" class = formbox required>
                    </div>
                </div>
                 <%=HSpacer  %> 
                     <div class ="row">
                    <div class ="col body">
                        Toll Free Phone <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationTollFreePhone"  size = "40" value = "<%=AssociationTollFreePhone%>" class = formbox><br />
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
                        Fax <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationFax"  size = "40" value = "<%= AssociationFax%>" class = formbox><br />
                      </div>
                </div>
                <%=HSpacer  %> 



                 <div class ="row">
                    <div class ="col  body">
                        Website <font color="#abacab">(Optional)</font><br />
                         <input name="Associationwebsite" Value ="<%=Associationwebsite%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                  

                 <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        LinkedIn <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationLinkedIn" Value ="<%=AssociationLinkedIn%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>







                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        Facebook <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationFacebook" Value ="<%=AssociationFacebook%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        X (Twitter) <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationX" Value ="<%=AssociationX%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                        Instagram <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationInstagram" Value ="<%=AssociationInstagram%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                         Pinterest <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationPinterest" Value ="<%=AssociationPinterest%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                  <div class ="row">
                    <div class ="col  body">
                        Truth Social <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationTruthSocial" Value ="<%=AssociationTruthSocial%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                          Blog <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationBlog" Value ="<%=AssociationBlog%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 

                  <div class ="row">
                    <div class ="col  body">
                         YouTube <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationYouTube" Value ="<%=AssociationYouTube%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                  <div class ="row">
                    <div class ="col  body">
                         Other Social Media 1<font color="#abacab">(Optional)</font><br />
                         <input name="AssociationOtherSocial1" Value ="<%=AssociationOtherSocial1%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 


                 <div class ="row">
                    <div class ="col  body">
                         Other Social Media 2 <font color="#abacab">(Optional)</font><br />
                         <input name="AssociationOtherSocial2" Value ="<%=AssociationOtherSocial2%>" size = "40" maxlength = "61" class = formbox>
                    </div>
                </div>
                <%=HSpacer  %> 
                                 <%=HSpacer  %> 
                                 <%=HSpacer  %> 
              

            </div>
         </div>
   </div>
        </div>
 <div class ="row">
      <div class ="col body">
                           
           </div>
       </div>
     
      <input name="AssociationAddressID" type = "hidden"  value = "<%=AssociationAddressID%>">
      <input name="AssociationID" type = "hidden"  value = "<%=AssociationID%>">
      <input type=submit value="Update" class = "regsubmit2" >
       </form>
            <br /><br />


      </div>
    </div>
  </div>
</div>

        

<!--#Include virtual="/Members/AssociationAdmin/AssociationFooter.asp"--> 
</body>
</html>