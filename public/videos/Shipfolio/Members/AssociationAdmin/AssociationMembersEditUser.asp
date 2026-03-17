<!DOCTYPE HTML >
<HTML>
<HEAD>
<title>Edit Users</title>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->

<SCRIPT LANGUAGE="JavaScript">
    function verify() {
        var themessage = "Please fill out the following fields: \r";



        //alert if fields are empty and cancel form submit
        if (themessage == "Please fill out the following fields: \r") {
            document.form.submit();
        }
        else {
            alert(themessage);
            return false;
        }
    }
    //  End -->
</script>

<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
</head>
<body >
<% Current1="Account"
Current2 = "AccountInfo" %>
<!--#Include virtual="/members/MembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

 <% If not rs.State = adStateClosed Then
rs.close
End If   	
    UserID= Request.QueryString("UserID") 
    If Len(UserID) < 2 then
        UserID= Request.Form("UserID") 
    End If

If Len(UserID) < 1 Then
 else 
Session("UserID")  = UserID
sql = "select  * from people, AssociationMembers where people.PeopleID = AssociationMembers.PeopleID and People.PeopleID = " & UserID
'response.write("sql=" & sql)
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3   
if  Not rs.eof then  
AssociationID = rs("AssociationID") 
MemberPosition = rs("MemberPosition")
PeoplePassword = rs("PeoplePassword")
PeopleEmail = rs("PeopleEmail")
PeopleFirstName = rs("PeopleFirstName")
PeoplelastName = rs("PeoplelastName")
PeoplePhone = rs("PeoplePhone")
accesslevel = rs("accesslevel")
AddressID = rs("AddressID")
PeopleCell = rs("PeopleCell")
end if
rs.close

sql = "select  * from Address where AddressID = " & AddressID
'response.write("sql=" & sql)
rs.Open sql, conn, 3, 3   
if  Not rs.eof then  
AddressStreet = rs("AddressStreet") 
AddressApt = rs("AddressApt")
AddressCity = rs("AddressCity")
AddressState = rs("AddressState")
AddressZip = rs("AddressZip")
AddressCountry = rs("AddressCountry")

end if
rs.close

sql = "select  AssociationName, associations.AssociationID from Associationmembers, associations where Associationmembers.AssociationID = associations.AssociationID and Associationmembers.AssociationMemberID  = " & UserID & " order by associations.AssociationID Asc"
'response.write (sql)
rs.Open sql, conn, 3, 3   
if  Not rs.eof then 
 AssociationName = rs("AssociationName")
 AssociationID = rs("AssociationID")
end if


   %>



 <div class="container roundedtopandbottom"  >
 <div class="container"  >
 <a name="Add"></a>
	<H1>Edit Association User Account</H1>
    

<% Message = request.querystring("Message")
if len(Message) > 1 then %>
<div align = "left"><font ><b><%=Message %></b></font></div>
<% end if %>

<% Updated = request.querystring("Updated")
if Updated = "True" then %>
<div align = "left"><font ><b>Your Changes Have Been Made.</b></font></div>
<% end if %>

</div>
<form name=form method="post" action="AssociationMembersEditUserhandleform.asp">

 <div class="container" width ="100%">
        <div class="row">
            <div class="col-md-6">
             <div class ="row">
                <div class="col form-group">
             
                Access Level<br />
                <select size="1" name="AccessLevel" class = "formbox" size = "30" >
                <% if Accesslevel = 1 then %>
                <option name = "AID0" value= "1" selected>Basic User</option>
                <option name = "AID0" value= "3" >Administrator</option>
                <% else %>
                <option name = "AID0" value= "3" selected>Administrator</option>
                <option name = "AID0" value= "1" >Basic User</option>
                <% end if %>			
                </select>
                <br />
           
                </div>
            </div>
                 <%= HSpacer %>
             <div class ="row">
                <div class="col">
                    First Name<br />
                    <input name="PeopleFirstName"  size = "30" value = "<%=PeopleFirstName%>" class = "formbox"><br />
                </div>
            </div>

             <%= HSpacer %>
            <div class ="row">
                <div class="col">
                    Last Name<br />
                    <input name="PeoplelastName" size = "30" value = "<%=PeoplelastName%>" class = "formbox"><br />
                </div>
            </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
                    Street Address<br />
                    <input name="AddressStreet" size = "30"  value = "<%=AddressStreet%>" class = "formbox"><br />
                 </div>
              </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
            Address 2<br />
            <input name="AddressApt" size = "30"  value = "<%=AddressApt%>" class = "formbox"><br />
                        </div>
            </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
            City<br />
            <input name="AddressCity" size = "30"  value = "<%=AddressCity%>" class = "formbox"><br />
                        </div>
            </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
            State / Province<br />
            <input name="AddressState" size = "30"  value = "<%=AddressState%>" class = "formbox"><br />
                        </div>
            </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
            Country<br />
            <input name="AddressCountry" size = "30"  value = "<%=AddressCountry%>" class = "formbox"><br />
                        </div>
            </div>
             <%= HSpacer %>
            <div class ="row">
                <div class="col">
            Postal Code<br />
            <input name="AddressZip" size = "30"  value = "<%=AddressZip%>" class = "formbox"><br /> 

                    <br /> 

                </div>
            </div>

            </div>
            <div class="col-md-6">
                 <div class ="row">
                    <div class="col">
                        Position<br />
                        <input name="MemberPosition" size = "30"  value = "<%=MemberPosition%>" class = "formbox"><br />
                    </div>
                </div> 
                <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                        Cell<br />
                        <input name="PeopleCell" size = "30"  value = "<%=PeopleCell%>" class = "formbox"><br />
                    </div>
                </div>
                 <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                Phone<br />
                <input name="PeoplePhone" size = "30"  value = "<%=PeoplePhone%>" class = "formbox"><br />
                            </div>
                </div>
                 <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                Email<br />
                <input name="PeopleEmail" size = "30"  value = "<%=PeopleEmail%>" class = "formbox"><br />
                            </div>
                </div>
                 <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                Password<br />
                <input name="PeoplePassword" size = "30" type = "Password" value = "<%=PeoplePassword%>" class = "formbox"><br />
                            </div>
                </div>
                 <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                Confirm Password<br />
                <input name="ConfirmPassword" size = "30" type = "Password" value = "<%=PeoplePassword%>" class = "formbox"><br />
                            </div>
                </div>
                 <%= HSpacer %>
                <div class ="row">
                    <div class="col">
                <input type="hidden" value = "<%=WebsitesID%>"  name = "WebsitesID" >
                <input type="hidden" value = "<%= UserID%>" name = "PeopleID" >
                <input type="hidden" value = "<%= AssociationID%>" name = "AssociationID" >
                <input type="hidden" value = "<%= addressID%>" name = "AddressID" >
               <input type=button value = "Update"  onclick="verify();" class = "submitbutton">
                <br /><br />

                <br /><br />
                </div></div>
                </form>
            </div>
        </div>
    </div>
        </div>

<% End if %>



<!--#Include virtual ="/Members/MembersFooter.asp"--> 

</Body>
</HTML>