<!DOCTYPE HTML >

<HTML>
<HEAD>
 <title>The ANDRESEN GROUP Content Management System (AGCMS)</title>
<link rel="stylesheet" type="text/css" href="/administration/style.css">
<!--#Include file="AdminSecurityInclude.asp"-->
<!--#Include file="AdminGlobalvariables.asp"--> 
<% 
PageLayoutId=Request.Querystring("PageLayoutId") 
PageName=Request.Querystring("PageName") 
Convert=Request.Querystring("Convert") 
PageType=Request.Form("PageType") 
'response.write("PageLayoutId=" & PageLayoutId)	
if Convert="True" and len(PageType) > 2 and len(PageLayoutId) > 0   then
    Query =  " UPDATE Pagelayout Set PageType = '" & PageType & "'" 
    Query =  Query & " where PageLayoutId = " & PageLayoutId 

    'response.write(Query)	
    Set DataConnection = Server.CreateObject("ADODB.Connection")
    DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
    DataConnection.Execute(Query) 
    DataConnection.Close
    
     sql2 = "select PageLayoutID from ProdServiceReferenceTable where PageLayoutID=  " & PageLayoutID 
           ' response.write("sql2=" & sql2)	
            Set rs2 = Server.CreateObject("ADODB.Recordset")
            rs2.Open sql2, conn, 3, 3
            if not rs2.eof then
    
            Query =  " UPDATE ProdServiceReferenceTable Set ProdServiceIDType = '" & PageType & "'" 
            Query =  Query & " where PageLayoutID = " & PageLayoutID

            'response.write(Query)	
             Set DataConnection = Server.CreateObject("ADODB.Connection")
            DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
            DataConnection.Execute(Query) 
             DataConnection.Close
            end if
    
   response.write("PageType=" & PageType )	
    if PageType = "Service" then
        sql2 = "select * from Services where PageLayoutID=  " & PageLayoutId & ""
       response.Write("sql2=" & sql2)
        Set rs2 = Server.CreateObject("ADODB.Recordset")
        rs2.Open sql2, conn, 3, 3
        if  rs2.eof then
            rs2.close
            Query =  "INSERT INTO Services (ServiceTitle,  ServicePrice, PageLayoutId)" 
            Query =  Query + " Values ('" &  PageName & "'," 
            Query =  Query & " 0,"
            Query =  Query & " " & PageLayoutId  & ")"

           response.write(Query)	
            Set DataConnection = Server.CreateObject("ADODB.Connection")
            DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
            DataConnection.Execute(Query) 
            DataConnection.Close
        else
        ServicesID = rs2("ServicesID") 
        response.Write("ServicesIDx=" & ServicesID)
        rs2.close
        end if   
            sql2 = "select ServicesID from Services where ServiceTitle=  '" & PageName & "' order by ServicesID Desc"
          response.write("sql2=" & sql2)	
            Set rs2 = Server.CreateObject("ADODB.Recordset")
            rs2.Open sql2, conn, 3, 3
            if  not rs2.eof then
                ServicesID = rs2("ServicesID") 
                rs2.close

                Query =  "INSERT INTO sfShipping (ServicesID)" 
                Query =  Query + " Values (" &  ServicesID & ")"

               ' response.write(Query)	
                Set DataConnection = Server.CreateObject("ADODB.Connection")
                DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
                DataConnection.Execute(Query) 
                DataConnection.Close
            end if
            else
        rs2.close
        end if   
          response.Write("ServicesIDy=" & ServicesID)  
            sql2 = "select PageLayoutID from ProdServiceReferenceTable where PageLayoutID=  " & PageLayoutID 
            'response.write("sql2=" & sql2)	
            Set rs2 = Server.CreateObject("ADODB.Recordset")
            rs2.Open sql2, conn, 3, 3
            if rs2.eof then

                Query =  "INSERT INTO ProdServiceReferenceTable (PageLayoutID, "
                 ' if len(ServicesID) > 0 then
                 Query =  Query & " ProdServiceID, "
                ' end if
                  Query =  Query & " ProdserviceIDType)" 
                Query =  Query + " Values (" &  PageLayoutID  & ","
                'if len(ServicesID) > 0 then
        		Query = Query & " "  & ServicesID & ", " 
        		'end if
	        	Query =  Query & " '" & PageType  & "')"
               response.write(Query)	
                Set DataConnection = Server.CreateObject("ADODB.Connection")
                DataConnection.Open "DRIVER={Microsoft Access Driver (*.mdb)};DBQ=" & Server.MapPath(DatabasePath) 	& ";" 
                DataConnection.Execute(Query) 
                DataConnection.Close
            end if
            
end if
%>	
<SCRIPT LANGUAGE="JavaScript">
function verify() {
var themessage = "Please fill out the following fields: \r";
if (document.form.Name.value=="") {
themessage = themessage + " -Name \r";
}
if (document.form.Breed.value == "") {
themessage = themessage + " -Breed \r";
}
if (document.form.Category.value=="") {
themessage = themessage + " -Category \r";
}
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

</HEAD>
<body >

<!--#Include file="AdminHeader.asp"-->

 <%  Current3="AddAlpaca"   %> 
 <!--#Include file="AdminPagesTabsInclude.asp"-->
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<tr><td class = "roundedtop" align = "left">
		<H1><div align = "left">Convert Page Type</div></H1>
        </td></tr>
        <tr><td class = "roundedBottom" align = "left">
<br />
<form action= 'AdminConvertPage.asp?PageName=<%=PageName %>&Convert=True&PageLayoutId=<%= PageLayoutId %>' method = "post">
<input name="PageName"   value = "<%=PageName%>" type = "hidden">
<table border = "0" cellspacing="0" cellpadding = "0" align = "center" width = "100%">
<% sql2 = "select * from PageLayout  where PageName =  '" & PageName & "'"
'response.Write("sql2=" & sql2)
Set rs2 = Server.CreateObject("ADODB.Recordset")
rs2.Open sql2, conn, 3, 3
if not  rs2.eof then
PageType=rs2("PageType")  
PageName=rs2("PageName")%>

<tr>
<td  class = "body2" align = "right">Page Name:&nbsp;</td>
<td class = "body"><b><%=PageName %></b></td>
</tr>
<tr>
<td  class = "body2" align = "right">Page Type:&nbsp;</td>
<td class = "body"><select size="1" name="PageType">
<% if len(PageType) > 2 then %>
<option  value="<%=PageType %>">
	<%=PageType %>
</option>
<% else %>
<option  value="">--</option>
<% end if %>
<option value="Standard">Standard</option>
<option value="Service">Service</option>
<option value="Product">Product</option>
</select>

</td>
</tr>
<% 
rs2.close 
end if
%>
	<tr>
<td  colspan = "2" align = "center" valign = "middle" class = "body2" >
			<input type=submit value = "Update" class = "regsubmit2" >
<br>
	</td>
</tr>
</table>
</form>


<br>	</td>
</tr>
</table><br>
<!--#Include file="AdminFooter.asp"--></Body>
</HTML>