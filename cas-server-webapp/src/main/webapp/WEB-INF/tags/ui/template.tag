<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="title" type="java.lang.String" required="true" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<title>${title} - Ensemble - Collective, Inc.</title>

	<link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/css/bootstrap-responsive.min.css"/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/css/login.css"/>" rel="stylesheet" type="text/css"/>
	<c:if test="${not empty service and (fn:containsIgnoreCase(service, 'sales') or fn:containsIgnoreCase(service, 'advertisingdemos'))}">
		<link href="<c:url value="/css/login-sales.css"/>" rel="stylesheet" type="text/css"/>
	</c:if>

</head>

<body class="body">
<div class="container">
	<div class="row">
		<div class="content offset4">
			<div class="logo">
				<%--<img src="<c:url value="/images/logo-ensemble.png"/>" alt="Logo">--%>
			</div>
			<div>
				<img src="<c:url value="/images/bg_login_top.png"/>" alt=""/>
			</div>
			<div class="login-form">
				<jsp:doBody/>
			</div>
			<div>
				<img src="<c:url value="/images/bg_login_bottom.png"/>" alt="" style="margin-bottom: 10px"/>
			</div>
			<div class="footer"></div>
		</div>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script src="<c:url value="/js/bootstrap.min.js"/>" type="text/javascript"></script>
<script src="<c:url value="/js/cas.js" />" type="text/javascript"></script>
<script>
	if (window.collective != null && window.collective.callback != null) {
		window.collective.callback();
	}
</script>
</body>
</html>