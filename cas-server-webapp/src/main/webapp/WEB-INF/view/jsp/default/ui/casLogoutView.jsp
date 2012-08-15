<!DOCTYPE html>

<%--

    Licensed to Jasig under one or more contributor license
    agreements. See the NOTICE file distributed with this work
    for additional information regarding copyright ownership.
    Jasig licenses this file to you under the Apache License,
    Version 2.0 (the "License"); you may not use this file
    except in compliance with the License. You may obtain a
    copy of the License at:

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on
    an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied. See the License for the
    specific language governing permissions and limitations
    under the License.

--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="collective_ui" tagdir="/WEB-INF/tags/ui" %>

<fmt:setLocale value="en_US"/>

<collective_ui:template title="Logout">
	<div id="msg" class="success">
		<h3><spring:message code="screen.logout.header" /></h3>
		<div class="divider"></div>
		<p><spring:message code="screen.logout.success" /></p>
		<p><spring:message code="screen.logout.security" /></p>
	</div>
</collective_ui:template>