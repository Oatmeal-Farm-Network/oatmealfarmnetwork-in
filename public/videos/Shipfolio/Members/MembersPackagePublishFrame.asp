<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/style.css" />
</HEAD>
<BODY border="0"  cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   align = "center" >
<!--#Include file="AdminGlobalVariablesNoBackground.asp"-->

<% PackageID = request.querystring("PackageID")
ShowOnAPackages= request.QueryString("ShowOnAPackages")

If ShowOnAPackages="True" then
Query =  " UPDATE Package Set  ShowOnAPackages = True" 
Query =  Query & " where PackageID = " & PackageID & ";" 
Conn.Execute(Query) 
end if

If ShowOnAPackages="False" then
Query =  " UPDATE Package Set  ShowOnAPackages = False" 
Query =  Query & " where PackageID = " & PackageID & ";" 
Conn.Execute(Query) 
end if

 sql = "select * from Package where PackageID = " & PackageID & " and PeopleID = " & Session("PeopleID") & " order by PackageID DESC"

    Set rs = Server.CreateObject("ADODB.Recordset")
    rs.Open sql, conn, 3, 3   
	rowcount = 1
ShowOnAPackages = rs("ShowOnAPackages")
rs.close

%>


<table border = "0" cellspacing="0" cellpadding = "0" align = "center" ><tr>
     <td class = "roundedtop" align = "left" >
		<H2><div align = "left">Package Status</div></H2>
        </td></tr>
        <tr><td class = "roundedBottom" align = "center" >
        <table><tr><td width = "250" class = "body">
        <% if ShowOnAPackages= "True" then %>
          <b>Published</b>
           <form  name=form method="post" action="AdminPackagePublishFrame.asp?PackageID=<%=PackageID%>&ShowOnAPackages=False">
        	<center><input type="Submit"  value="Un-Publish!"  class = "Regsubmit2" ></center>
  		</form>
          <% else %>
          <b>Draft</b>
           <form  name=form method="post" action="AdminPackagePublishFrame.asp?PackageID=<%=PackageID%>&ShowOnAPackages=True">
        	<center><input type="Submit"  value="Publish!"  class = "Regsubmit2" ></center>
  		</form>
        <%end if  %>
            
        </td>  
        </tr>
        </table>
    </td>
  </tr></table>      
   </Body>
</HTML>
