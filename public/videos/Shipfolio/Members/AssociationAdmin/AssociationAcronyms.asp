<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<meta name="robots" content="nofollow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="1"/>
<meta name="Googlebot" content="nofollow"/>
<!--#Include virtual="/members/MembersGlobalVariables.asp"-->
</head>
<body >

<% Current3 = "Acronyms" %> 
 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->
    <div class="container mx-auto roundedtopandbottom">
    <h1>Acronyms</h1>

    <div class="row mx-auto">
        <div class="col">

 <div class="container" style ="min-height:560px">
    <div class="row">
      <div class="col-lg-6 ">
           <div class ="roundedtopandbottom container" >
               <div class ="Row">
                   <div class ="col">
                <h2>Registry Acronyms</h2><br />
                <br />
                
                    </div> 
                 </div>
                <%Set rs2 = Server.CreateObject("ADODB.Recordset")
                Set rs3 = Server.CreateObject("ADODB.Recordset")
                Set rs4 = Server.CreateObject("ADODB.Recordset")

                dim AssociationSpeciesIDarray(30)
                dim AssociationSpeciesIDarray2(30)
                dim AssociationSpeciesNamearray(30)
                dim AssociationSpeciesNamearray2(30)

                sql = "select distinct SpeciesID from associationRegistryCodes where AssociationID= " & AssociationID & " order by SpeciesID "
                'response.write("sql=" & sql)
                Set rs = Server.CreateObject("ADODB.Recordset")
                rs.Open sql, conn, 3, 3 
                x1 = 1
                if not rs.eof then%>
                <div class ="row border-bottom">
                    <div class ="col-6">
                         <b>Species</b>
                    </div>
                    <div class ="col-3">
                         <b>Acronym</b>
                    </div>
                     <div class ="col-3">
                         
                    </div>
                </div>
                <%=HSpacer %>
               <% end if
                while Not rs.eof 

   
                SpeciesID = rs("SpeciesID")
                AssociationSpeciesIDarray2(x1) = SpeciesID

                if len(SpeciesID) > 0 then
                sql2 = "select distinct Species from SpeciesAvailable where SpeciesID= " & SpeciesID
                rs2.Open sql2, conn, 3, 3   
                if Not rs2.eof then
                Species = rs2("Species")
                AssociationSpeciesNamearray2(x1) = Species

                end if 
                rs2.close
                end if

                x1 = x1 + 1

                rs.movenext
                wend
                rs.close


                sql = "select distinct RegistryCode, SpeciesID, AssociationRegistryCodeId from associationRegistryCodes where AssociationID= " & AssociationID & " order by SpeciesID "
                'response.write("sql=" & sql)
                Set rs = Server.CreateObject("ADODB.Recordset")
                rs.Open sql, conn, 3, 3 
                x = 1  
                while Not rs.eof    
                x = x + 1
                RegistryCode = rs("RegistryCode")
                SpeciesID = rs("SpeciesID")
                AssociationSpeciesIDarray(x) = rs("SpeciesID")
                AssociationRegistryCodeId= rs("AssociationRegistryCodeId")

                if len(SpeciesID) > 0 then
                sql2 = "select distinct Species from SpeciesAvailable where SpeciesID= " & SpeciesID
                rs2.Open sql2, conn, 3, 3   
                if Not rs2.eof then
                CurrentSpecies = rs2("Species")

                end if 
                rs2.close
                end if

                %>
                 <div class ="row border-bottom">
                    <div class ="col-6">
                        <%=CurrentSpecies %>
                    </div>
                    <div class ="col-3">
                        <%=RegistryCode %>
                    </div>
                     <div class ="col-3">
                         
   
                    <form action="AssociationAdminDeleteRegistryCode.asp" method = "post">
                    <input name = "AssociationRegistryCodeId" value="<%= AssociationRegistryCodeId %>" type = "hidden" />
                    <input name = "AssociationID" value="<%= AssociationID %>" type ="hidden" />
                    <input name = "RegistryCode" value="<%= RegistryCode %>" type = hidden />
                    <input type=submit value = "Unassign" class = "regsubmit2" >
                </form>
                 </div>
                </div>
               <%=HSpacer %>

                <% rs.movenext
                wend 
                AssociationSpeciesTotal = x1
                %>
                
              </div>
          </div>
   
      <div class="col-lg-6 align-items-start" style="vertical-align:top">
          <div class ="roundedtopandbottom container" >
            <a name="RegistryCode"></a>
               <div class ="Row">
                   <div class ="col">
                <h2>Add a Registry Acronyms</h2><br />
         
                    </div> 
                 </div>

              <div class ="row border-bottom">
                    <div class ="col-4">
                         <b>Species</b>
                    </div>
                    <div class ="col-5">
                         <b>Acronym</b>
                    </div>
                     <div class ="col-3">
                         
                    </div>
                </div>
                      <%=HSpacer %>
                <form  action="AssociationAdminAddRegistryCode.asp" method = "post">
               <div class ="row ">
                    <div class ="col-4">
                        <select size="1" name="SpeciesID" class = "formbox" style="max-width:140px">
                        <option value="" selected></option>
                        <%  sql = "select SpeciesID, species from speciesavailable where speciesavailable = 1 "
                            'response.write("sql=" & sql)
                            Set rs = Server.CreateObject("ADODB.Recordset")
                            rs.Open sql, conn, 3, 3 
                            while not rs.eof %>
                               <option  value="<%=rs("SpeciesID")%>"><%=rs("Species") %></option>
                            <% rs.movenext
                            wend %>
                        </select>
                    </div>
                    <div class ="col-5">
                         <input name="RegistryCode" size = "15" value = "" class = formbox>
                    </div>
                     <div class ="col-3">
                          <input name="AssociationID" type="hidden" value = "<%=AssociationID %>" >
                          <input type=submit value = "Submit"  class = "regsubmit2" >
                    </div>
                </div>
                </form>
                 <%=HSpacer %>
      </div>
      </div>
    </div>
        </div>
      </div>
    </div>

<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</HTML>