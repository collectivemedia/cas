<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ attribute name="title" type="java.lang.String" required="true" %>
<%@ attribute name="service" type="java.lang.String" required="true" %>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <c:choose>
        <c:when test="${not fn:containsIgnoreCase(service, 'sales') and not fn:containsIgnoreCase(service, 'advertisingdemos')}">
            <title>${title} - Collective, Inc.</title>
        </c:when>
        <c:otherwise>
            <title>Advertising Demos</title>
        </c:otherwise>
    </c:choose>

    <c:choose>
        <c:when test="${not fn:containsIgnoreCase(service, 'sales') and not fn:containsIgnoreCase(service, 'advertisingdemos')}">
            <link rel="shortcut icon" href="//collective.com/wp-content/themes/okcm/images/favicon.ico" type="image/x-icon" />
        </c:when>
        <c:otherwise>
            <link rel="shortcut icon" href="/images/fan.png" type="image/png" />
        </c:otherwise>
    </c:choose>
    <link href="<c:url value="/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/css/bootstrap-responsive.min.css"/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value="/css/login.css"/>" rel="stylesheet" type="text/css"/>
	<c:if test="${fn:containsIgnoreCase(service, 'sales') or fn:containsIgnoreCase(service, 'advertisingdemos')}">
		<link href="<c:url value="/css/login-sales.css"/>" rel="stylesheet" type="text/css"/>
	</c:if>

</head>

<body class="body">
<div class="content">
    <div class="logo">
        <c:choose>
            <c:when test="${not fn:containsIgnoreCase(service, 'sales') and not fn:containsIgnoreCase(service, 'advertisingdemos')}">
                <img src="<c:url value="/images/Rich_Media_SSO-Art2.png"/>" alt="Logo">
            </c:when>
        </c:choose>
    </div>
    <div class="login-form">
        <jsp:doBody/>
    </div>
    <div class="footer"></div>
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