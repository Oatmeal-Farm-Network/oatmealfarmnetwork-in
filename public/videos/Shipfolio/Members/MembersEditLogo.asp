<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="John Andresen">
    <meta name="generator" content="LOTW">
    <title>Global Grange</title>
<!--#Include file="MembersGlobalVariables.asp"-->

</head>
<body >
<% Current3 = "Logo" %>
<!--#Include file="MembersHeader.asp"-->
<!--#Include file="MembersAccountJumpLinks.asp"-->
<br />
<div class = "container roundedtopandbottom">

        <H1>Logo</H1>
          <div class = "row">
            <div class = "col">
              <div class="container border" style="max-width:450px; align-content:center">
                <div class ="row" >
                    <div class ="col">

                <br />
                <% 
                sql = "select  Business.*, address.*  from Business, Address where  Business.AddressID = Address.AddressID and Business.AddressID = Address.AddressID  and Business.BusinessID = " & BusinessID
             ' response.write("sql=" & sql )
                Set rs = Server.CreateObject("ADODB.Recordset")
                rs.Open sql, conn, 3, 3   
                if  Not rs.eof then 

                Logo= rs("Logo")
                'if len(Logo) < 5 then
                'Logo = rs("BusinessLogo")
                'end if
               'response.write("Logo=" & Logo )

                'str1 = lcase(Logo) 
                'str2 = "http://www.alpacainfinity.com"
                'If InStr(str1,str2) > 0 Then
                'Logo=  Replace(str1, str2 , "http://www.livestockofamerica.com")
                'End If  
               ' Owners= rs("Owners")
                 rs.close
                  end if
 
                if Logo = "http://www.livestockoftheworld.com/uploads/0" then
                  Logo = ""
                end if

                %>
         
                <% If Len(Logo) > 2 Then %>


                <center><img src = "<%=Logo%>" width = "200" align ="center"></center>
                <% Else %>
                <b>No Image</b>
                <% End If %>

                <form name="frmSend" method="POST" enctype="multipart/form-data" action="membersLogouploadImageUser.asp?BusinessID=<%=BusinessID%>" >
                Upload Logo <br>
                <input name="filename2" type="file" size=45 >
                <input  type=submit value="Upload" class = "regsubmit2" >
                    <br />
                    <small><font color="#abacab" >Images must be in JPG, JPEG, GIF, or PNG format and under 1MB in size.</font></small><br /><br>
                </form>
                </div>
                 <div class = "col d-flex align-items-end" style="">
                <% If Len(Logo) > 2 Then %>
                <form action= 'membersRemoveLogo.asp' method = "post">
                <input type = "hidden" name="BusinessID" value= "<%=BusinessID%>" >
                <input name="ReturnPage" Value ="membersAccountContactsEdit.asp?BusinessID=<%=BusinessID%>" type="hidden">
                <center><input type=submit class = "regsubmit2"  value="Remove"></center>
                </form>

                <% End If %>

                <br />
     
     
     <br /><br />

 </div>
 </div>

  <br /> 
 </div>
 </div>
 </div>


 <br />
<!--#Include file="MembersFooter.asp"--> </Body>
</HTML>