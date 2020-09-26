<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome Page</title>
</head>
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
<body style="background-color:#76D7C4;">
<jsp:include page="header.jsp"/>
<h1 style="color:blue;">Welcome to Corona-Kit Home...</h1>
<hr/>
<a href="${pageContext.request.contextPath}/custom-login"><input type="button" value="Login" /></a>
<hr/>
<jsp:include page="footer.jsp"/>
</body>
</html>