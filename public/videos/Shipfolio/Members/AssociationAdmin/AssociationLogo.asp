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

<% Current1 = "AssociationHome"
Current2 = "DirectoryListing" 
Current3 = "Logo" %> 
 
<!--#Include virtual="/members/AssociationAdmin/AssociationMembersHeader.asp"-->
<!--#Include file="AssociationDirectoryJumpLinks.asp"-->

<%  

sql = "select AssociationLogo  from Associations where AssociationID = " & session("AssociationID")
if rs.state > 0 then
    rs.close
end if

rs.Open sql, conn, 3, 3 
If Not rs.eof then
	AssociationLogo = rs("AssociationLogo")
    'Response.write("AssociationLogo=" & AssociationLogo )


	str1 = lcase(AssociationLogo) 
	str2 = "http://www.alpacainfinity.com"
	If InStr(str1,str2) > 0 Then
		AssociationLogo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
	End If  
	rs.close
end if

if rs.state = 0 then
else
rs.close
end if

%>

<div class ="container roundedtopandbottom">
<a name="Logo"></a>
<H1>Logo</H1>

<div class ="row" >
    <div class ="col">
        <div class="container border" style="max-width:450px; align-content:center">
            <div class ="row" >
                <div class ="col">
               
        <% If Len(AssociationLogo) > 2 Then %>
        <center><img src = "<%=AssociationLogo%>" width = "200" align ="center"></center>
        <% Else %>
        <b>No Image</b>
        <% End If %>
       <% If Len(AssociationLogo) > 2 Then %>

                <form name="frmSend" method="POST" enctype="multipart/form-data" action="AssociationLogouploadImage.asp?AssociationID=<%=AssociationID%>" >
                Replace <br>
                <input name="attach1" type="file" size=40 >
                <input  type=submit value="Upload" class = "regsubmit2" >
                    <br />
                    <small><font color="#abacab" >Images must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</font></small><br />
                </form>

            <br />



                <form action= 'RemoveAssociationLogo.asp?AssociationID=<%=AssociationID%>' method = "post">
                <input type = "hidden" name="BusinessID" value= "<%=BusinessID%>" >
                <input type = "hidden" name="PeopleID" value= "<%=PeopleID%>" >
                <input name="ReturnPage" Value ="AssociationListingEdit.asp?AssociationID=<%=AssociationID%>" type="hidden">
                <center><input type=submit class = "regsubmit2"  value="Remove"></center>
                </form>
                <br />


        <% Else %>


            
            Upload Logo<br />
            <form name="frmSend" method="POST" enctype="multipart/form-data" action="AssociationLogouploadImage.asp?AssociationID=<%=AssociationID%>" >
               <input name="attach1" type="file" size=40 class = "formbox" style="min-height:40px">
            <input  type=submit value="Upload" class = "regsubmit2" >
            </form>

            <br><font color="#abacab"><small>Images must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</small></font>

            <br /><br />

             <% End If %>

            <br />

            </div>
        </div>
        </div>
        <br />
    </div>
</div>
</div>
<br />
<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</html>