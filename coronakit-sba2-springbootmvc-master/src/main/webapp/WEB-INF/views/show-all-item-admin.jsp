<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %> 
<%@taglib uri="http://www.springframework.org/tags/form"  prefix="spring-form"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ALL PRODUCTS LIST</title>
<jsp:include page="header.jsp"/>
<style>
      input {
        padding: 10px 10px;
        margin: 5px 2px;
        cursor: pointer;
        text-transform: uppercase;
        text-align: center;
        position: relative;
      }
      input:hover {
        opacity: 0.2;
      }
   table,th,td{
border: 1px solid green
}
#delete
{
padding: 20,20,20,20
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
<h2 style="color:blue;">List of Products</h2>
<hr>
<table>
<tr>
<th bgcolor="yellow">Product Name</th>
<th bgcolor="yellow">Product Description</th>
<th bgcolor="yellow">Price/Unit</th>
</tr>
<core:forEach var="products" items="${productList}">
<tr>
<td>${products.productName}</td>
<td>${products.cost}</td>
<td>${products.productDescription}</td>
<td><a href="${pageContext.request.contextPath}/admin/product-delete/${products.id}"><input id="delete" type="button" value="Delete"></a></td>
</tr>
</core:forEach>
</table>
<hr>
<div><a href="${pageContext.request.contextPath}/admin/home"><input type="button" value="Admin Home"></a></div>
</br>
<spring-form:form action="${pageContext.request.contextPath}/logout" method="POST">
<p align="right"><input type="submit" value="Logout" style="margin-left: 50%"> </p>
</spring-form:form>
</br>

<jsp:include page="footer.jsp"/>
</body>
</html>