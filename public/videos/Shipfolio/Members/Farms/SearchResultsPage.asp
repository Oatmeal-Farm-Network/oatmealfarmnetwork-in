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

<title>Farms</title>
<META name="Title" content="<%=SingularBreed %>" Ranches" />
<META name="description" content="Find <%=SingularBreed %> Ranches on <%=WebSiteName %>. Buy <%=CurrentBreed %> directly from <%=CSingularBreed %> ranchers across <%=sitecountry %>." />
<meta name="robots" content="index,follow"/>
<meta name="rating" content="Safe for kids"/>
<meta name="revisit-after" content="7"/>
<meta name="Googlebot" content="index, follow"/>
<meta name="robots" content="All"/>
<meta name="subject" content="<%=singularbreed %>" Ranches" />
</HEAD>
<body >
<% current = "Ranches" %>
<!--#Include virtual="/Header.asp"-->

<% 
BusinessTypeID=request.querystring("BusinesstypeID")

'response.write("StateIndex=" & StateIndex ) %> 

<div class="container-fluid " id="grad1" align = "center" style=" min-height: 80px" >
    <div class = "row" align = "center" >
        <div class = "col body" >
            <h1>&nbsp;Farms / Ranches</h1>
             <br />
        </div>
</div>
</div>

<%dim AdFooterID(100)
dim AdFooterImage(100)
dim AdFooterLink(100) %>

<div class="container-fluid d-none d-lg-block"  align = "center" >
    <div class="row justify-content-center">
        <div class="col-lg-3" style="min-width: 300px; max-width: 300px;">
            <!--#Include virtual="/Farms/RanchSearchInclude.asp"-->
        </div>
        <div class="col-lg-9" style="max-width: 1000px; min-height: 67px;">
            <!--#Include virtual="/Farms/RanchSearchResults.asp"-->
        </div>
    </div>
</div>
<div class="container-fluid d-lg-none dropshadow">
    <div class="row justify-content-center">
         <div class="col" >
            <!--#Include virtual="/Farms/MobileRanchSearchInclude.asp"-->
        </div>
      </div>
    <div class="row justify-content-center">
        <div class="col" >
            <!--#Include virtual="/Farms/RanchSearchResults.asp"-->
        </div>
    </div>
</div>


<!--#Include virtual="/Footer.asp"-->

