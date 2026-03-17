<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!--#Include virtual="/shipfolio/globalvariables.asp"-->
<link rel="canonical" href="<%=currenturl %>" />
<title><%=WebSiteName %></title>
<meta name="title" content="<%=WebSiteName %>"/> 
<meta name="description" content=""/>  
<meta charset="UTF-8">

<meta name="revisit-after" content="7 Days"/>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<% homepage = true %>
</head>
<body >
<!--#Include virtual="/shipfolio/Header.asp"-->

 <% ' lg+ navigation  %>
    <div class="container-fluid" align = center style="max-width: 1000px; min-height: 600px; ">
       <div class = "row">
        <div class = "col">
         <h1>Retrieve Your Password</h1>
<table border = "0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  cellpadding=0 cellspacing=0 bordercolor = "" align = "center" width = "500" valign="top">
	<tr>
		<td class = "body" ><br /><br />
			To retrieve your password enter your account Email below:<br>
      </td>
	</tr>
	
<form action= 'SendpasswordStep2.asp' method = "post">
	<tr >
		<td  align = "center" class = "body">
			<br /><input name="Email" size = "42" value="" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"><br><br>
		</td>
	</tr>
<tr>  
		<td  valign = "middle" class = "body">
			
			<div align = "center">
			<input type=submit value = "Submit" class ="regsubmit2">
			</form>
		</td>

</tr>
</table>
<br><br>

   </div>
    </div>
    </div>
<!--#Include virtual="/shipfolio/Footer.asp"-->
</body></html>