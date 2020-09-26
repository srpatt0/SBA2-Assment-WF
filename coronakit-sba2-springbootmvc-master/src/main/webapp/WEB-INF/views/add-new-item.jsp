<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Products Information</title>
<style type="text/css">
.error{
	
	font-family:sans-serif;
	font-size:x-small;
	color: red;
	
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
	<spring:form
		action="${pageContext.request.contextPath}/admin/product-save"
		method="POST" modelAttribute="product">

		<div>
			<div>
				<spring:label path="productName" style="color:Tomato;" >Product Name :</spring:label>
			</div>
			<div>
				<spring:input path="productName" />
				<spring:errors path="productName" cssClass="error" />
			</div>
		</div>
		<br>
		<div>
			<div>
				<spring:label path="cost" style="color:Tomato;">Product Price :</spring:label>
			</div>
			<div>
				<spring:input path="cost" />
				<spring:errors path="cost" cssClass="error" />
			</div>
		</div>
		<br>
		<div>
			<div>
				<spring:label path="productDescription" style="color:Tomato;">Product Description :</spring:label>
			</div>
			<div>
				<spring:input path="productDescription" />
				<spring:errors path="productDescription" cssClass="error" />
			</div>
		</div>
		<br>
		<div><input type="submit" value="Submit" /></div>
	</spring:form>

</body>
</html>