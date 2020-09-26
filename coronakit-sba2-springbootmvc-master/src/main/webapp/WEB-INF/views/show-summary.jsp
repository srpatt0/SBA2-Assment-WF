<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %> 
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@taglib uri="http://www.springframework.org/tags/form"  prefix="spring-form"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
.error{
	
	font-family:sans-serif;
	font-size:x-small;
	color: red;
}
</style>
<style>
table,th,td{
border: 1px solid green
}
#delete
{
padding: 20,20,20,20
}
</style>
<style> 
input[type=submit] {
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
<br>
<spring-form:form action="${pageContext.request.contextPath}/logout" method="POST">
<input type="submit" value="Logout">
</spring-form:form>
<br>
<hr>
<h2> Order Summary</h2>
<hr>
<div><label>Customer Name : <security:authentication property="principal.username"/> </label></div>
<br>
<div><label>Delivery Address : ${address} </label>
</div>
<br>
<div><label>Order Date : ${date}</label></div>
<br>
<div><label>Total Order Amount : ${amount}</label></div>
<br>
<hr>
<h3>Detailed Summary</h3>
<hr>
<table>
<tr>
<th>No.</th>
<th>Product Name</th>
<th>Qty.</th>
<th>Amount</th>
</tr>
<core:forEach var="item" items="${cartList}">
<tr>
<td>${item[0]}</td>
<td>${item[1]}</td>
<td>${item[2]}</td>
<td>${item[3]}</td>
</tr>
</core:forEach>
</table>
<hr>
<div><b><i><h3>Thank you for shopping!!! Track your order</h3></i></b></div>
</body>
</html>