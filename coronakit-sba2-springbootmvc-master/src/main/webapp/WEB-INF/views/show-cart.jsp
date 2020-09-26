<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Cart Details</title>
<style>
table,th,td{
border: 1px solid purple
}
#atk
{
padding: 30,30,30,30
}
</style>
<style> 
input[type=button] {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 16px 32px;
  text-decoration: none;
  margin: 4px 2px;
  cursor: pointer;
}
</style>
</head>
<body style="background-color:#76D7C4;">
<h2>Cart Items For User : <security:authentication property="principal.username"/></h2>

<hr>
<table>
<tr>
<th>Product Name</th>
<th>Qty.</th>
<th>Total Amount</th>
</tr>
<core:forEach var="item" items="${cartList}">
<tr>
<td>${item[0]}</td>
<td>${item[1]}</td>
<td>${item[2]}</td>
<td><a href="${pageContext.request.contextPath}/user/delete/${item[3]}"><input id="atk" type="button" value="remove"></a></td>
</tr>
</core:forEach>
</table>
<hr>
<span><a href="${pageContext.request.contextPath}/user/show-list"><input  type="button" value="show list"></a></span>
<span><a href="${pageContext.request.contextPath}/user/checkout"><input  type="button" value="check out"></a></span>
</body>
</html>