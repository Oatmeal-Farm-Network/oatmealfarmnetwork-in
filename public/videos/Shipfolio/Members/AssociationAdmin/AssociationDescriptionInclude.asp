<!--#Include virtual="/Includefiles/conn.asp"-->
<link rel="stylesheet" href="https://www.HarvestHub.World/members/MembersStyle.css">

 <style>
    /* CSS code to set textarea width to 100% */
    textarea {
      width: 100%;
    }
  </style>


<% MemberAccessLevel= Session("MemberAccessLevel")
AssociationID = Session("AssociationID")
PeopleID = Session("PeopleID")

      
 Set rs = Server.CreateObject("ADODB.Recordset")   

Query= " Select distinct Associations.* "
Query= Query & " from Associations, associationMembers "
Query= Query & " where Associations.AssociationID = associationMembers.AssociationID and Associations.AssociationID = " & AssociationID
'response.write("Query=" & Query )
rs.Open Query, conn, 3, 3


if not rs.eof then
    AssociationID = rs("AssociationID")
    AssociationName = rs("AssociationName")
    AssociationAcronym = rs("AssociationAcronym")
   
    AssociationDescription= rs("AssociationDescription")

    country_id= rs("country_id")
  
 end if
   
    


%>

<div class ="container" style="max-width: 450px" align ="center">
     <div class ="row">
         <div class ="col body" align ="center"> 
            <h1>Description</h1>

            <form name=form method="post" action="AssociationUpdateDescription.asp" target="_parent" >
            <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
            <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
            <script language="javascript1.2" type="text/javascript">
                WYSIWYG.attach("AssociationDescription", mysettings);
                mysettings.Width = "100%"
                mysettings.Height = "470px"
            </script>
           <TEXTAREA NAME="AssociationDescription" ID="AssociationDescription" cols="60" rows="40" wrap="file"><%= AssociationDescription%></textarea>
           </div>
    </div>
    <div class ="row">
        <div class ="col body">
             <input name="AssociationID" type = "hidden"  value = "<%=AssociationID%>">
             <input type=submit value="Update" class = "regsubmit2" >
         </div>
    </div>
</form>
</div>
<br /><br />
