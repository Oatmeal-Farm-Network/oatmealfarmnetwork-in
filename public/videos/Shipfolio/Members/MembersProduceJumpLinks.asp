 
 <% 
Set rs2 = Server.CreateObject("ADODB.Recordset")
ProduceID = request.QueryString("ProduceID")
'response.write("ProduceID!!=" & ProduceID )

'if len(ProduceID) < 1 then
'ProduceID = Request.Form("ProduceID")
'end if
'ID = Request.querystring("ID")
'if len(ID) > 0 and len(ProduceID) < 1 then
'    ProduceID = ID
'end if



'if len(ProduceID) > 0 then
'sql2 = "select  Produce.ID, Produce.FullName, NumberofProduce, SpeciesID, Category from Produce where ID = " & ProduceID & " order by trim(Fullname)"
'acounter = 1
'Set rs2 = Server.CreateObject("ADODB.Recordset")
'rs2.Open sql2, conn, 3, 3 
'if not rs2.eof then
'    NumberofProduce = rs2("NumberofProduce")
'    SpeciesID = rs2("SpeciesID")
'    Category = rs2("Category")
'    if len(NumberofProduce) > 0 then
'    else
'    NumberofProduce = 1
'    end if
'if rs.state > 0 then
'     rs.close
'end if
%>

<style>
  /* --- Responsive Wrapping Navigation Links --- */

  /* The main wrapper that controls the flow */
  .nav-wrapper-wrap {
      /* Use Flexbox to manage the link alignment and wrapping */
      display: flex;
      /* Crucial: Allows items to drop to the next line when space runs out */
      flex-wrap: wrap; 
      /* Aligns links to the start, but you can use 'center' if preferred */
      justify-content: flex-start; 
      
      background-color: #f1f1f1;
      border-bottom: 3px solid #ccc;
      padding: 5px 0; /* Add some vertical padding around the links */
  }

  /* Style for each individual link cell */
  .nav-wrapper-wrap li {
      /* Remove default list styling */
      list-style-type: none;
      /* Reset margins/padding */
      margin: 5px; 
      padding: 0;
      /* Ensures the link block takes up the whole list item, 
         making the hover effect cover the cell */
      display: inline-block; 
  }

  /* Style for the actual clickable <a> element */
  .nav-wrapper-wrap li a {
      display: block;
      color: #000;
      padding: 0px 15px; /* Adjust padding for a button-like feel */
      text-decoration: none;
      text-align: center;
      /* Make it look like a button/cell */
      border-radius: 4px; /* Slightly rounded corners */
 
      transition: background-color 0.2s; /* Smooth transition for hover */
      /* Set a minimum width for small links to avoid them being too narrow */
      min-width: 80px; 

  }

  /* Hover effect */
  .nav-wrapper-wrap li a:hover {
      background-color: #ddd;
      border-color: #aaa;
  }

  /* Current/Active link styling */
  .nav-wrapper-wrap li a.current {
      background-color: #4CAF50;
      color: white;
      border-color: #4CAF50;
  }

</style>
<div>
  <a name="Top"></a>
  
  <ul class="nav-wrapper-wrap"> 
      <li class="nav-item "><a class="body" href="MembersProduceInventory.asp?BusinessID=<%=BusinessID %>#top">Add</a></li>
      <li class="nav-item "><a class="body" href="MembersProduceInventory.asp?BusinessID=<%=BusinessID %>#inventory">Inventory</a></li>
  </ul>
  </div>
