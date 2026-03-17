<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#Include virtual="/includefiles/globalvariables.asp"-->
     <!--#Include file="SpeciesVariables.asp"-->

<% StateIndex = request.form("StateIndex") 
   if len(StateIndex) > 0 then
   else
   StateIndex = request.querystring("StateIndex")
   end if

    if len(StateIndex) > 0 and not (StateIndex=10000) and not (StateIndex=0) then
        statesort = " and StateIndex= " & StateIndex
    else
        statesort = " "
    end if
     %>

     <% 
     current = "Transporters" 
     Icon = "https://www.globallivestocksolutions.com/icons/Transporters.svg"
     BusinessTypeID = 32
     %>


<title><%=Current%> Directory</title>
<META name="Title" content="<%=SingularBreed %>" Ranches" />
<META name="description" content="Find <%=Current%> on <%=WebSiteName %>.." />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="7"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=Current%>" Directory" />
</HEAD>
<body >

<!--#Include virtual="/Header.asp"-->

<% 'response.write("StateIndex=" & StateIndex ) %> 

<div class="container-fluid " id="grad1" align = "center" style=" min-height: 80px" >
    <div class = "row" align = "center" >
        <div class = "col body" >
            <h1><img src="<%=Icon %>" class="img-fluid" style="max-width: 70px; max-height: 70px; object-fit: contain;"><%=current%></h1>
        </div>
</div>
</div>
    
<% dim AdFooterID(100)
dim AdFooterImage(100)
dim AdFooterLink(100) %>

<div class="container-fluid d-none d-lg-block"  align = "center" >
    <div class="row justify-content-center">
        <div class="col-lg-3" style="min-width: 300px; max-width: 300px;">
   
            <!--#Include file="RanchSearchInclude.asp"-->
        </div>
        <div class="col-lg-9" style="max-width: 1000px; min-height: 67px;">
            <!--#Include file="RanchSearchResults.asp"-->
        </div>
    </div>
</div>
<div class="container-fluid d-lg-none dropshadow">
    <div class="row justify-content-center">
         <div class="col" style="min-width: 300px; max-width: 300px;">
            <!--#Include file="RanchSearchInclude.asp"-->
        </div>
      </div>
    <div class="row justify-content-center">
        <div class="col" style="max-width: 1000px; min-height: 67px;">
            <!--#Include file="RanchSearchResults.asp"-->
        </div>
    </div>
</div>


<!--#Include virtual="/Footer.asp"-->

