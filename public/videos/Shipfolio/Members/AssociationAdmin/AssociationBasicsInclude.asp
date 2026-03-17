<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!--#Include virtual="/Includefiles/conn.asp"-->
<link rel="stylesheet" href="https://www.HarvestHub.World/members/MembersStyle.css">
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

    str1 = lcase(AssociationLogo)
    str2 = "livestockofamerica.com"
    If InStr(str1,str2) > 0 Then
	    AssociationLogo= Replace(str1, str2 , "livestockoftheworld.com")
    End If  
 end if
      
      
If Left(Associationwebsite, 7) <> "http://" And Left(Associationwebsite, 8) <> "https://" Then
    Associationwebsite = "http://" & Associationwebsite
End If 
      
      
%>
</head>
<body>
<form name=form method="post" action="AssociationContactsUpdateAccount.asp" target="_blank">
        <div class ="container" style="max-width: 450px">
              <div class="col" > 
                <div class ="row">
                    <div class ="col body">
                        <h1>Basics</h2>
                        <b>Maintains a Livestock Registry? </b>
                        <% If Registry = "True" Or Registry = 1 Then %>
                            Yes<input TYPE="RADIO" name="Registry" Value = "1" checked>
                            No<input TYPE="RADIO" name="Registry" Value = "0" >
                        <% Else %>
                            Yes<input TYPE="RADIO" name="Registry" Value = "1" >
                            No<input TYPE="RADIO" name="Registry" Value = "0" checked>
                        <% End If %>
                    </div>
                </div>
                <%=HSpacer  %>
               <div class ="row">
                    <div class ="col body">
                        Association Name<br />
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
                        <select size="1" name="AssociationCountry" class = "formbox" style="min-width:300px; max-width:300px;  min-height:45px" >
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
                        <select size="1" name="AssociationState" class = "formbox" style="min-width:300px; max-width:300px;  min-height:45px" >
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
                        <input name="AssociationZip"  size = "40" value = "<%=AssociationZip%>" class = formbox>
                      </div>
                </div>
                <%=HSpacer  %> 
                 <div class ="row">
                    <div class ="col body">
                        Phone <font color="#abacab">(Optional)</font><br />
                        <input name="AssociationPhone"  size = "40" value = "<%=AssociationPhone%>" class = formbox><br />
                      </div>
                </div>

                <div class ="container">
                    <%=HSpacer  %> 
                     <div class ="row">
                        <div class ="col body">

                        <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
                        <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
                        Description<br />
                        <script language="javascript1.2" type="text/javascript">
                            // attach the editor to the textarea with the identifier 'textarea1'.

                            WYSIWYG.attach("AssociationDescription", mysettings);
                            mysettings.Width = "470px"
                            mysettings.Height = "260px"
                        </script>


                        <TEXTAREA NAME="AssociationDescription" ID="AssociationDescription" cols="60" rows="16" wrap="file"><%= AssociationDescription%></textarea>
                        </div>
                    </div>
                    <%=HSpacer  %> 
                    



                </div>

            </div>
         </div>

 <div class ="row">
                        <div class ="col body">
                            <input name="AssociationID" type = "hidden"  value = "<%=AssociationID%>">
                            <input type=submit value="Update" class = "regsubmit2" >
                        </div>
                    </div>


</form>

</body>
</html>