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
Current3 = "Countries" %> 
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

<div class="container roundedtopandbottom">
  <h1>Countries</h1>
 Provide Suppport in These Countries:
  <a name="Countries"></a>
  
  <div class="table-responsive">
    <table class="table">
     
      <tbody>
        <% Set rs2 = Server.CreateObject("ADODB.Recordset")
        sql = "SELECT DISTINCT country.country_id, country.name FROM country, associationcountries WHERE country.country_id = associationcountries.country_id AND AssociationID = " & AssociationID
        'response.write("sql=" & sql)
        Set rs = Server.CreateObject("ADODB.Recordset")
        rs.Open sql, conn, 3, 3
        if not rs.eof then%>
             <thead>
        <tr>
          <th scope="col">Countries</th>
          <th scope="col"></th>
        </tr>
      </thead>


       <%end if
           While Not rs.EOF    
          Country = rs("name")
          country_id = rs("country_id")
        %>
        <tr>
          <td><%= Country %></td>
          <td>
            <form action="AssociationAdminDeleteCountry.asp" method="post">
              <input name="AssociationID" value="<%= AssociationID %>" type="hidden" />
              <input name="country_id" value="<%= country_id %>" type="hidden" />
              <input type="submit" value="Unassign" class="submitbutton" />
            </form>
          </td>
        </tr>
        <% rs.MoveNext
        Wend %>
        <tr>
          <th colspan="2"><br /><b>Add</b></th>
        </tr>
        </tbody>
    </table>
   
      <div class="form-group">
        <form action="AssociationAdminAddCountry.asp" method="post">
        <label for="country_id">Select Country:</label>
        <select name="country_id" class="formbox">
          <% sql = "SELECT * FROM country WHERE active = 1 ORDER BY name"
          Set rs = Server.CreateObject("ADODB.Recordset")
          rs.Open sql, conn, 3, 3   
          While Not rs.EOF 
            name = rs("name") 
            Tempcountry_id = rs("country_id") 
            selected = ""
            If LCase(name) = LCase(AddressCountry) Then
              selected = "selected"
            End If
          %>
          <option value="<%= Tempcountry_id %>" <%= selected %>><%= name %></option>
          <% rs.MoveNext
          Wend %>
        </select>
        <input name="AssociationID" type="hidden" value="<%= AssociationID %>" />&nbsp;
      
        <input type="submit" value="Add" class="submitbutton" />
     
    </form>
          <br />
  </div>
</div>
</div>


<!--#Include virtual ="/Members/MembersFooter.asp"--> 
</body>
</HTML>