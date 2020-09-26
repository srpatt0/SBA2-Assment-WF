<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delivery Page</title>
<style type="text/css">
.error{
	
	font-family:sans-serif;
	font-size:x-small;
	color: red;
}
</style>
<style> 
input[type=button], input[type=submit] {
  background-color: #4CAF50;
  border: none;
  color: white;
  padding: 16px 32px;
  text-decoration: none;
  margin: 4px 2px;
  cursor: pointer;
}
</style>
<jsp:include page="header.jsp"/>
</head>
<body style="background-color:#76D7C4;">
	<spring:form action="${pageContext.request.contextPath}/user/finalize"
		method="POST" modelAttribute="ck" >

		<div>
			<div>
				<spring:label path="orderDate">Order Date : ${ck.orderDate}</spring:label>
			</div>
		</div>
		<br>
		<div>
			<div>
				<spring:label path="totalAmount">Total Kit Amount : ${ck.totalAmount}</spring:label>
			</div>
			<br>
			<div>
				<div>
					<spring:label path="deliveryAddress">Shipping address :</spring:label>
				</div>
				<br>
				<div>
					<spring:input path="deliveryAddress" />
					<spring:errors path="deliveryAddress" cssClass="error" />
				</div>
			</div>
			<br>
			<br>
			<span>
				<input type="submit" value="Submit" />
			</span>
			<span>
				<a href="${pageContext.request.contextPath}/user/show-kit"><input type="button" value="show cart" /> </a>
			</span>
		</div>
	</spring:form>
<jsp:include page="footer.jsp"/>

<body style="background-color:#76D7C4;">
</html>