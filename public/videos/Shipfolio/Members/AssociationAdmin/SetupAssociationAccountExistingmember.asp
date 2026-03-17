<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

</head>
<body >
    
<% Current3 = "Create" %> 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->


<% Set rs4 = Server.CreateObject("ADODB.Recordset")
Set rs5 = Server.CreateObject("ADODB.Recordset")
%>

<% Current = "CreateAccount"
Current3 = "JoinLOA" 
CurrentWebsite = "LivestockofAmerica" 
session("LoggedIn") = False%>

<% Set rs2 = Server.CreateObject("ADODB.Recordset")

PeopleEmail=Trim(Request.Form("PeopleEmail")) 
PeoplePassword=Trim(Request.Form("PeoplePassword")) 

if len(PeopleEmail) > 0 then
else
PeopleEmail = request.querystring("PeopleEmail")
end if


if len(PeoplePassword) > 0 then
else
PeoplePassword = request.querystring("PeoplePassword")
end if
'response.write("PeopleEmail=" & PeopleEmail)
'response.write("PeoplePassword=" & PeoplePassword)


'if len(peopleid) > 0 then
'else

if len(Email) < 5 or len(password) < 8 then
  fail = "True"
  'response.Redirect("SetupAssociationAccountStep1.asp?AssociationError=True")
else
  fail = "False"
end if 

	
sql2 = "select * from  People where people.accesslevel > 0 and trim(lower(PeopleEmail)) = '" & trim(lcase(PeopleEmail)) & "'  and peoplePassword = '" & PeoplePassword & "'"
'response.write("slq2=" & sql2 )
acounter = 1
rs2.Open sql2, Conn, 3, 3 

if rs2.eof Then
	
   Session("WebsiteAccess")=False
fail ="True"
	else 

	'	response.write("custemail=" & rs2("Email") & " ")
	'response.write("custPasswd=" & rs2("Password"))
PeopleID = rs2("PeopleID")
Session("PeopleID")= rs2("PeopleID")
Session("WebsiteAccess")=True

'end if

rs2.close

'response.write("fail=" & fail )

end if


If fail ="True" then
'response.Redirect("SetupAssociationAccountStep1.asp?AssociationError=True")
End If
 %>

 <div class="container-fluid roundedtopandbottom"  >
<h1>Create an Association Account</h1>
   <div class="row">
    <div class="col" >

<% 
existing = request.querystring("existing")
SpeciesID = Request.querystring("SpeciesID")

PeopleFirstName = Request.querystring("PeopleFirstName")
PeopleLastName = Request.querystring("PeopleLastName")
'PeopleEmail = Request.querystring("PeopleEmail")
'ConfirmEmail = Request.querystring("PeopleEmail")

AssociationContactPosition = Request.Form("AssociationContactPosition")
if len(AssociationContactPosition) < 1 then
AssociationContactPosition = Request.querystring("AssociationContactPosition")
end if

AssociationName = Request.Form("AssociationName")
if len(AssociationName) < 1 then
AssociationName = Request.querystring("AssociationName")
end if

Associationwebsite = Request.Form("Associationwebsite") 
if len(Associationwebsite) < 1 then
Associationwebsite = Request.querystring("Associationwebsite")
end if

AssociationEmailaddress = Request.Form("AssociationEmailaddress")
if len(AssociationEmailaddress) < 1 then
AssociationEmailaddress = Request.querystring("AssociationEmailaddress")
end if
 
AssociationAcronym = request.form("AssociationAcronym")
if len(AssociationAcronym) < 1 then
AssociationAcronym = Request.querystring("AssociationAcronym")
end if

AssociationStreet = Request.Form("AssociationStreet")
if len(AssociationStreet) < 1 then
AssociationStreet = Request.querystring("AssociationStreet")
end if
 
AssociationApt = Request.Form("AssociationApt")
if len(AssociationApt) < 1 then
AssociationApt = Request.querystring("AssociationApt")
end if
 
AssociationCity  = Request.Form("AssociationCity")
if len(AssociationCity) < 1 then
AssociationCity = Request.querystring("AssociationCity")
end if

AssociationstateIndex  = Request.Form("AssociationstateIndex")
if len(AssociationstateIndex) < 1 then
AssociationstateIndex = Request.querystring("AssociationstateIndex")
end if

Associationcountry_id  = Request.Form("Associationcountry_id ")
if len(Associationcountry_id) < 1 then
Associationcountry_id  = Request.querystring("Associationcountry_id ")
end if


AssociationZip  = Request.Form("AssociationZip")
if len(AssociationZip) < 1 then
AssociationZip = Request.querystring("AssociationZip")
end if

AssociationPhone  = Request.Form("AssociationPhone")
if len(AssociationPhone) < 1 then
AssociationPhone = Request.querystring("AssociationPhone")
end if

PeopleWebsite = request.form("PeopleWebsite")
if len(PeopleWebsite) < 1 then
PeopleWebsite = Request.querystring("PeopleWebsite")
end if
AddressStreet = Request.querystring("AddressStreet") 
AddressApt = Request.querystring("AddressApt") 

AssociationPhone  = Request.querystring("AssociationPhone")
AssociationTypeID  = Request.querystring("AssociationTypeID")

if existing = "True" then
%>
<h2><center><font color = maroon>Account Already Exists</font></center></h2><center><font color = maroon>An association account with the email address <b><%=PeopleEmail  %></b> already exists. Please select</font> <a href = "/memberlogin.asp" class = "body"><b>sign in</b></a><font color = maroon> to log into your account.</font><br><br /></center>
<% end if %>

<%
Message = request.querystring("Message")
if len(Message) > 1 then
%>
<h2><center><font color = maroon><b><%=Message  %></b> </font></h2><br></center>
<% end if %>


<form name=form method="post" action="SetupAssociationAccountExistingmemberStep2.asp?ReturnFileName=<%=ReturnFileName%>">
<b>As the creator of the associations account, you will have administrative rights to the account.</b><br /><br />


 <div class="container">
    <div class="row">
      <div class="col-lg-6">
       <div class ="container" style="max-width: 450px">
            <div class ="row">
              <div class="col" > 
        
                Association's Name<br />
                <input name="AssociationName" size = "40" value = "<%=AssociationName %>" class = formbox required><br />
             </div>
            </div>
            <%=HSpacer  %> 
              <div class ="row">
                    <div class ="col body">
	                 Type<br />
                        <select size="1" name="AssociationTypeID" class = "formbox" style="min-width:320px; min-height:40px" required>
                            <% if len(AssociationTypeID ) > 0 then %>
                            <option value="<%=AssociationTypeID %>" selected><%=AssociationType %></option>
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
                    <div class ="col body">
	        Acronym <font color="#abacab">(Optional)</font> <br />
                <input name="AssociationAcronym" size="40" value = "<%=AssociationAcronym %>" class = formbox><br />
             </div>
            </div>
            <%=HSpacer  %> 
            <div class ="row">
                    <div class ="col body">
	                Your Position <font color="#abacab">(Optional)</font><br />
                <input name="AssociationContactPosition" Value ="<%=AssociationContactPosition%>"  size = "40" maxlength = "61" class = formbox><br />
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

                        <% if len(Associationcountry_id ) < 1 then
                             Associationcountry_id = country_id
                            end if

                            if rs.state > 0 then rs.close
                            
                            if len(Associationcountry_id) > 0 then
                                sql = "select * from country where country_id = " & Associationcountry_id  & ""
                                rs.Open sql, conn, 3, 3
                                    Associationcountry = rs("name")
                                rs.close
                            end if


                        
                        %>

                        <select size="1" name="Associationcountry_id" class = "formbox" style="min-width:320px; min-height:40px" >
                            <% if len(AssociationCountry) > 0 then %>
                            <option value="<%=Associationcountry_id %>" selected><%=AssociationCountry %></option>
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

                <% if Associationcountry_id > 0 then %>
                 <div class ="row">
                    <div class ="col body">
                       <%  if rs.state > 0 then rs.close 

                           if len(Associationcountry_id) > 0 then
                           sql = "select Name from state_province where country_id = " & Associationcountry_id
                          
                           rs.Open sql, conn, 3, 3 
                           if not rs.eof then
                             AssociationstateName = rs("Name")
                           end if
                         
                           end if
                         rs.close
                         %>

                        State/ Province <font color="#abacab">(Optional)</font><br />
                        <select size="1" name="AssociationstateIndex" class = "formbox" style="min-width:320px; min-height:40px" >
                            <% if len(Aassociationstate) > 0 then %>
                            <option value="<%=AssociationstateIndex %>" selected><%=AssociationstateName %></option>
                            <% else %>
                             <option value="" selected></option>
                            <% end if %>
                          <%  sql = "select Stateindex, Name from state_province where country_id=" & Associationcountry_id
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
                        <input name="AssociationZip"  size = "40" value = "<%=AssociationZip%>" class = "formbox" style="min-width:320px; min-height:40px" >
                      </div>
                </div>
                     <%=HSpacer  %> 

             </div>
         </div>
        <div class="col-lg-6">
       <div class ="container" style="max-width: 450px">
          
          <div class ="row">
             <div class ="col body">

			Email<br />
		<input name="AssociationEmailaddress"  size = "40" value = "<%=AssociationEmailaddress%>" class = formbox required><br />
			    </div>
           </div>
           <%=HSpacer  %> 
          <div class ="row">
             <div class ="col body">
			Phone <font color="#abacab">(Optional)</font><br />
		<input name="AssociationPhone"  size = "40" value = "<%=AssociationPhone%>" class = formbox ><br />
			    </div>
           </div>
           <%=HSpacer  %> 
         
            <div class ="row">
             <div class="col" > 

               Website <br />
		        <input name="Associationwebsite" Value ="<%=Associationwebsite%>" size = "40" maxlength = "61" class = formbox><br />
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
                         Pinterest<font color="#abacab">(Optional)</font><br />
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
         <div class ="col body">



<br />

<input name="PeopleEmail" type= "hidden" value = "<%=PeopleEmail%>">
<input name="PeoplePassword" type= "hidden" value = "<%=PeoplePassword%>">

<input name="PeopleID" type = "hidden"  value = "<%=PeopleID%>">
<input name="Update"  type= "hidden" value = "<%=Update%>">
<input name="Membership" type= "hidden" value = "<%=Membership%>">
</center>
	<input type=submit value="NEXT" class = "regsubmit2">


</form>
<br>
<br /><br />
</div>
       </div>
<br /><br />
<!--#Include virtual ="/Members/MembersFooter.asp"-->  </body>
</HTML>