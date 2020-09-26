<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ALL PRODUCTS-USER</title>
<style type="text/css">
			.error{
				color : red;
			}
		</style>
<style>
table,th,td{
border: 2px solid green
}
#atk
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

</head>
<body style="background-color:#76D7C4;">
<jsp:include page="header.jsp"/>
<h2 style="color:green;">Products List For <security:authentication property="principal.username"/></h2>
<hr>
<table>
<tr>
<th>Product Name</th>
<th>Product Description</th>
<th>Price/Unit</th>
</tr>
<core:forEach var="products" items="${productList}">
<tr>
<td>${products.productName}</td>
<td>${products.productDescription}</td>
<td>${products.cost}</td>
<td><a href="${pageContext.request.contextPath}/user/add-to-cart/${products.id}"><input id="atk" type="button" value="Add to Kit"></a></td>
</tr>
</core:forEach>
</table>
<jsp:include page="footer.jsp"/>
</body>
</html>