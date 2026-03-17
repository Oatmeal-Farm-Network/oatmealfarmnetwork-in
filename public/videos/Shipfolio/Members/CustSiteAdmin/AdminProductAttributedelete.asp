<%@ Language=VBScript %><HTML>
<HEAD>
<% TempattrDetailID = request.QueryString("TempattrDetailID") 
ProdID= request.QueryString("ProdID")%>
<!--#Include file="AdminGlobalVariables.asp"-->
<title>Photo attribute value</title>


<%
Query =  " delete from sfattributeDetail where attrDetailID = " & TempattrDetailID  & ";" 
response.write(Query)
Conn.Execute(Query) 

%>

<script>
    function func() {
        top.location = "AdminAdEdit2.asp?prodId=" + <%=ProdID %>
    }
</script>
</HEAD>
<body onLoad="func()">
</BODY>
</HTML>

