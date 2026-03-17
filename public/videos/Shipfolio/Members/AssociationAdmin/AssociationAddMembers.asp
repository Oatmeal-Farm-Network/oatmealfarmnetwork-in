<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<!--#Include virtual="/associationadmin/AssociationGlobalVariables.asp"-->
<%dim AuctionDutchID(40000) 
dim AuctionLevel(40000)
dim AuctionDutchTitle(40000) 
dim AnimalID1(400000)
dim ID(40000) 
dim CurrentPrice(40000)
dim	Name(40000) 
dim	ForSale(40000) 
dim	Category(40000) 
dim	Breed(40000) 
dim Price(40000)
dim	Discount(40000)
dim DiscountPrice(40000)
Dim ShowOnABH(40000)
Dim	ShowOnAC(40000)
Dim	ShowOnASZ(40000)
Dim	ShowOnAP(40000)
Dim	ShowOnAIA(40000)
Dim ShowOnWebsite(40000)
Dim ShowOnOurHerdPage(40000)
Dim PublishForSale(40000)
dim PublishStud(40000)
Dim SpeciesID(40000)
Dim Lastupdated(40000)
dim PackageID(200)
dim PackagePrice(200)
dim Value(200)
dim PackageName(200)
dim Description(200)
Dim MADLotID(200)
dim prodID(99999) 
dim prodName(99999)  
dim prodPrice(99999) 
dim ProdForSale(99999) 
dim ProdQuantityAvailable(99999)
dim catName(99999)
dim subcategoryName(99999)
dim catID(99999)
dim propID(99999) 
dim propName(99999)  
dim propPrice(99999) 
dim propForSale(99999) 
dim propQuantityAvailable(99999)
%>

    </head>
<body >

<% Current3 = "AddMember" %> 

<!--#Include virtual="/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include virtual="/AssociationAdmin/AssociationMembersAccountJumpLinks.asp"--> 

<% 
Current1 = "AssociationHome"
Current2 = "AssociationServices" %> 
<div class="container roundedtopandbottom">
  <div class="row">
    <div class="col-12">
        <H1>&nbsp;&nbsp;Add a New User</H1>

            <% 
            country_id = ""

            country_id = request.form("country_id") 
                if len(country_id)> 1 then
                else
                country_id = request.querystring("country_id")
                end if
            Message = request.querystring("Message") 
            AssociationMemberID= request.querystring("AssociationMemberID")
            MemberFirstName= request.querystring("MemberFirstName")
            MemberLastName= request.querystring("MemberLastName")
            MemberEmail= request.querystring("MemberEmail")
            MemberPosition= request.querystring("MemberPosition")
            MemberAccessLevel= request.querystring("MemberAccessLevel")
            MemberPassword = request.querystring("MemberPassword")
            MemberAccessLevel = request.querystring("MemberAccessLevel")
            Position= request.querystring("Position")
            ExistingMember = request.querystring("ExistingMember")
            UserAdded = request.querystring("UserAdded")

            if UserAdded ="True" then %>
		       <font color = "maroon"><b>The User was added.</b></font><br />
            <% end if 

            if len(Message2) > 5 then %>
		       <font color = "maroon"><b><%=Message2%></b></font>
            <% end if %>

            <% if ExistingMember="True" then %>
		       <font color = "maroon"><b>That member already exists.</b></font>
            <% end if %>


  country_id = <%=country_id %>
<% 
    if len(country_id) < 2 then %>
     <div class="row">
        <div class="col"> 
            <div class ="container border" style="max-width:460px">
                <div class="row">
                   <div class="col">  
                    <form action= 'AssociationAddMembers.asp' name = "form" method = "post">
                    Country<br />
                     <select name="country_id" width="300" style="width: 300px" class = formbox required="true">
                    <% sql = "select country_id, name from country where active = 1 order by name "
                        rs.Open sql, conn, 3, 3 
                        If Not rs.eof then %>
                        <option selected></option>
                        <% while not rs.eof %>
                         <option value ="<%=rs("country_id") %>"><%=rs("name")%></option>
                        <% rs.movenext
                        wend 
                        end if 
                          rs.close%>
                   </select>  

                    <input type=submit value = "Submit"  class = "regsubmit2">
                    </form>

                </div>

             </div>
            <br />
        </div>
            <br />
      </div>
    </div>
  </div>
<% end if %>

<% if len(country_id) > 2 then %>
  <form action= 'MembersAddUserhandleform.asp' name = "form" method = "post">
  <div class="row">
    <div class="col-md-6">
      
        
        <div class =" Container">
        <div class="row">
                <div class="col">
                    Access Level<br />

                    <select size="1" name="AccessLevel" width="300" style="width: 300px" class = formbox>
                    <% if tempAccesslevel = 1 or tempAccesslevel = 0 then %>
                    <option name = "AID0" value= "1" selected>Basic User</option>
                    <option name = "AID0" value= "2" >Account Administrator</option>
                    <% end if %>

                    <% if tempAccesslevel = 2 then %>
                    <option name = "AID0" value= "1" >Basic User</option>
                    <option name = "AID0" value= "2" selected>Account Administrator</option>
                    <% end if %>
                    </select>
                </div>
            </div>
               <%=HSpacer %>
            <div class="row">
                <div class="col">
                    First Name<br />
                    <input name="PeopleFirstName"  width="300" style="width: 300px"  class = formbox Required><br />
                </div>
            </div>
          <%=HSpacer %>
            <div class="row">
                <div class="col">
                    Last Name <br />
                    <input name="PeopleLastName"  width="300" style="width: 300px"  class = formbox Required><br />
                </div>
            </div>
           <%=HSpacer %>
            <div class="row">
                <div class="col">
                    Street Address <font color="#ABACAB">(Optional)</font><br />
                    <input name="AddressStreet" width="300" style="width: 300px"  class = formbox><br />
                </div>
            </div>
             <%=HSpacer %>
            <div class="row">
                <div class="col">
                    Address 2 <font color="#ABACAB">(Optional)</font><br />
                    <input name="AddressApt" width="300" style="width: 300px"  class = formbox><br />
                </div>
            </div>
             <%=HSpacer %>
            <div class="row">
                <div class="col">
                    City <font color="#ABACAB">(Optional)</font><br />
                    <input name="AddressCity" width="300" style="width: 300px"  class = formbox><br />
                </div>
            </div>
                  <%=HSpacer %>
            <div class="row">
                <div class="col">
                    State <font color="#ABACAB">(Optional)</font><br />
                         <select name="country" width="300" style="width: 300px" class = formbox>
                    <% sql = "select StateIndex, name from state_province where country_id= " & country_id
                        

                        rs.Open sql, conn, 3, 3 
                        If Not rs.eof then %>
                        <option selected>State / Province</option>

                        <% while not rs.eof %>
                         <option value ="<%=StateIndex %>"><%=rs("name")%></option>


                        <% rs.movenext
                        wend 
                        end if 
                            rs.close%>
                   </select>  
                </div>
            </div>

            <%=HSpacer %>

               <div class="row">
                <div class="col"> 
                    
                    <form action= 'AssociationAddMembers.asp' name = "form" method = "post">
                    Country <br />
                     <select name="country_id" width="300" style="width: 300px" class = formbox required>
                    <% sql = "select country_id, name from country where active = 1 order by name "
                        rs.Open sql, conn, 3, 3 
                        If Not rs.eof then %>
                        <option selected>Country / Region</option>

                        <% while not rs.eof %>
                         <option value ="<%=rs("country_id") %>"><%=rs("name")%></option>


                        <% rs.movenext
                        wend 
                        end if 
                            rs.close%>
                   </select>  

                    <br />
                </div>
            </div>
 
                <%=HSpacer %>
          </div>
       </div>
    <div class="col-md-6">
          <div class =" Container">

              
            <div class="row">
                <div class="col">

                Position <font color="#ABACAB">(Optional)</font><br />
                <input name="Position" width="300" style="width: 300px" class = formbox><br />
                </div>
            </div>
                <%=HSpacer %>

               <div class="row">
                <div class="col">

                Postal Code <font color="#ABACAB">(Optional)</font><br />
                <input name="AddressZip" width="300" style="width: 300px"  class = formbox><br />
                </div>
            </div>

            <%=HSpacer %>

               <div class="row">
                <div class="col"> 

                Phone <font color="#ABACAB">(Optional)</font><br />
                <input name="PeoplePhone"  width="300" style="width: 300px" size = "50" class = formbox><br />
                 </div>
            </div>

            <%=HSpacer %>

               <div class="row">
                <div class="col"> 
                Cell <font color="#ABACAB">(Optional)</font><br />
                <input name="PeopleCell"width="300" style="width: 300px"  class = formbox><br />
                 </div>
            </div>

            <%=HSpacer %>

               <div class="row">
                <div class="col"> 
                Email<br />
                <input name="PeopleEmail" width="300" style="width: 300px"  class = formbox Required><br />
                 </div>
            </div>

            <%=HSpacer %>

               <div class="row">
                <div class="col"> 
                Confirm Email<br />
                <input name="ConfirmEmail" width="300" style="width: 300px"  class = formbox Required><br />
                
                </div>
              </div>
          </div>
        <br />
        <div valign ="bottom">
            After you submit this form, an email will be <br />sent to the new user with a temporary password.<br />
<br />
            </div>

        </div>
      </div>
  </div>



<br />
 
<br />
   <center><input type=submit value = "Add User" class = "regsubmit2"></center>

</form>



  <% end if %>
       <br /><br /><br />
    <br />
  </div>
  </div>
<br />


<!--#Include virtual="/associationadmin/associationFooter.asp"-->

</Body>
</HTML>