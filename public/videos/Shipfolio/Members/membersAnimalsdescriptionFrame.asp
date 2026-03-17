<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Language" content="en-us"/>
<link rel="stylesheet" type="text/css" href="/Members/Membersstyle.css">
<!--#Include file="membersGlobalVariables.asp"-->
</head>
<body>
<% 
BusinessID=request.QueryString("BusinessID")
AnimalID=request.querystring("AnimalID")
ID = AnimalID

NumberofAnimals=request.querystring("NumberofAnimals")

if len(AnimalID) > 0 then
else
AnimalID = request.querystring("AnimalID")
end if
AnimalID = request.querystring("AnimalID")

SpeciesID=request.QueryString("SpeciesID")


sql = "select Description from Animals where AnimalID = " & AnimalID & ";" 
'response.write("sql=" & sql )
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 3, 3 
Description = rs("Description")
rs.close
%>

 <form action= 'MembersAnimalAdd5.asp?BusinessID=<%=BusinessID %>&AnimalID=<%=AnimalID%>&SpeciesID=<%=SpeciesID%>&NumberofAnimals=<%=NumberofAnimals%>'target ="_top" method = "post" name="myform"> 
<div class ="container" align="center">
<div class ="row">
 <div class ="Row" align = "center">
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
    // attach the editor to the textarea with the identifier 'textarea1'.
    WYSIWYG.attach("Description", mysettings);
    mysettings.Width = "100%"
    mysettings.Height = "410px"
    </script>
 

	<textarea class="form-control" id="Description" name="Description" rows="3" align ="center"></textarea>

    <br />
    <input name="ProdID" value="<%=ProdID%>" type = hidden>
    <div align = "center"><input type=submit name= "button1" value = "Next" class = "regsubmit2"  <%=Disablebutton %> ></div>
</div>
</div>
    </div>
</form>
</body>
</html>
