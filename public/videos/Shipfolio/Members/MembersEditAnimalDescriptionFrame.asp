<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Harvest Hub</title>
<!--#Include file="Membersglobalvariables.asp"-->
      <link rel="stylesheet" href="/members/MembersStyle.css">
<% animalid = request.QueryString("animalid")
if len(animalid) < 1 then
animalid = Request.Form("animalid")
end if

if len(animalid) < 1 then
Response.redirect("default.asp#Animals")
end if
%>



<% category = request.QueryString("category")


sql = "select SpeciesID, NumberOfAnimals, Description, StudDescription from Animals where animalid=" & animalid
rs.Open sql, conn, 3, 3
Description  = rs("Description")
StudDescription  = rs("StudDescription")  
    SpeciesID  = rs("SpeciesID")
    NumberOfAnimals = rs("NumberOfAnimals")
rs.close



if len(Description) > 1 then
For loopi=1 to Len(Description)
    spec = Mid(Description, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	Description= Replace(Description,  spec, " ")
   end if
 Next
end if

str1 = Description
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1, str2 , vbCrLf)
	
End If  


str1 = Description
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, " ")
End If 

str1 = Description
str2 = "''"
If InStr(str1,str2) > 0 Then
	Description= Replace(str1,  str2, "'")
End If 

%>


</head>
<body >

<div class = "rows">
    <div class = "col-12" >
      <form action= 'MembersDescriptionHandleForm.asp' method = "post">
        <a name="Description"></a>

     <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg.js"></script>
    <script type="text/javascript" src="/openwysiwyg/scripts/wysiwyg-settings.js"></script>
		
    <script language="javascript1.2" type="text/javascript">
        // attach the editor to the textarea with the identifier 'textarea1'.
        WYSIWYG.attach("Description", mysettings);
        mysettings.Width = "450px"
        mysettings.Height = "400px"
    </script>

        <% changesmade = request.querystring("changesmade")
        if changesmade = "True" then %>
            <div align = "left"><font class="blink_text"><b>Your Description Changes Have Been Made.</b></font></div>
            <% end if %>

        <TEXTAREA NAME="Description" ID="Description" cols="75" rows="12" wrap="file"><%=Description%></textarea>
        <br /><small><b>Copy and Paste</b> - Copy and pasting does not work with some browsers; however, the hotkeys CTL + C (Copy) and CTL + V (Paste) will work.</small><br /><br />
	
        <input type = "hidden" name="category" Value = "<%=category%>">
		<input type = "hidden" name="animalid" Value = "<%=animalid%>">
		<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> >
		<div align = "center"><input type="submit" class = "regsubmit2" value="Submit" ></div>
		<BR>
    </form>
   </div>
</div>


<% showstuddescription = false
if showstuddescription = True then

str1 = StudDescription
str2 = "</br>"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1, str2 , vbCrLf)
End If  

if len(StudDescription) > 1 then
For loopi=1 to Len(StudDescription)
    spec = Mid(StudDescription, loopi, 1)
    specchar = ASC(spec)
    if specchar < 32 or specchar > 126 then
    	StudDescription= Replace(StudDescription,  spec, " ")
   end if
 Next
end if


str1 = StudDescription
str2 = "&nbsp;"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, " ")
End If 

str1 = StudDescription
str2 = "''"
If InStr(str1,str2) > 0 Then
	StudDescription= Replace(str1,  str2, "'")
End If 

StudServicesPage = True
If StudServicesPage = True And category = "Experienced Male" Or category = "Inexperienced Male" then%>

<div class = "row">
 <div class = "col-12" >
    <a name="studdescription"></a>
    <h2>Stud Breeding Description (Appears only on Your Stud Services Page) </h2>
    <% studchangesmade = request.querystring("studchangesmade")
    if studchangesmade = "True" then %>
        <div align = "left"><font class="blink_text"><b>Your Stud Description Changes Have Been Made.</b></font></div>
    <% end if %>

	<form action= 'MembersStudDescriptionHandleForm.asp' method = "post">

    <textarea name="StudDescription"  ID="StudDescription" cols="127" rows="20"   class = "body"  ><%= StudDescription%></textarea>

    <br />
    <input type = "hidden" name="category" Value = "<%=category%>">
	<Input type = Hidden name='TotalCount' Value = <%=TotalCount%> ><br /><br />
	<input type="submit" class = "regsubmit2" value="Submit" >
		<br />	
</div>
</div>
</form>
<% End If 
end if
%>

<%conn.close
set Conn = nothing %>

 </Body>
</HTML>
