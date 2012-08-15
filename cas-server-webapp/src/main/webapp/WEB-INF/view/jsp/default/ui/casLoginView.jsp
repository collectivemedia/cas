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
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib prefix="collective_ui" tagdir="/WEB-INF/tags/ui" %>

<fmt:setLocale value="en_US"/>

<collective_ui:template title="Login">
	<div class="title">
		<c:choose>
			<c:when test="${not empty service and fn:containsIgnoreCase(service, 'sales')}">
				<h3>Advertising Demos</h3>
			</c:when>
			<c:otherwise>
				<h3>Log in to Ensemble</h3>
			</c:otherwise>
		</c:choose>
		<img src="<c:url value="/images/icon_lock.png"/>" class="lock">
	</div>
	<div class="divider"></div>
	<form:form method="post" id="fm1" cssClass="fm-v clearfix" commandName="${commandName}" htmlEscape="true">
		<spring:hasBindErrors name="${commandName}">
			<div id="error" class="alert alert-error">
				<a class="close" data-dismiss="alert">×</a>
				<h4 class="alert-heading">Error!</h4>
				<form:errors path="*" id="msg" element="span"/>
			</div>
		</spring:hasBindErrors>

		<div class="fan"></div>

		<div class="group">
			<label for="username" class="fl-label"><spring:message code="screen.welcome.label.netid"/></label>
			<c:if test="${not empty sessionScope.openIdLocalId}">
				<strong>${sessionScope.openIdLocalId}</strong>
				<input type="hidden" id="username" name="username" value="${sessionScope.openIdLocalId}"/>
			</c:if>

			<c:if test="${empty sessionScope.openIdLocalId}">
				<spring:message code="screen.welcome.label.netid.accesskey" var="userNameAccessKey"/>
				<form:input cssClass="input-large" cssErrorClass="input-large error" id="username" size="25"
				            tabindex="1"
				            accesskey="${userNameAccessKey}" path="username" autocomplete="false"
				            htmlEscape="true"/>
			</c:if>
		</div>
		<div class="group">
			<label for="password" class="fl-label"><spring:message code="screen.welcome.label.password"/></label>
				<%--
				  NOTE: Certain browsers will offer the option of caching passwords for a user.  There is a non-standard attribute,
				  "autocomplete" that when set to "off" will tell certain browsers not to prompt to cache credentials.  For more
				  information, see the following web page:
				  http://www.geocities.com/technofundo/tech/web/ie_autocomplete.html
				  --%>
			<spring:message code="screen.welcome.label.password.accesskey" var="passwordAccessKey"/>
			<form:password cssClass="input-large" cssErrorClass="input-large error" id="password" size="25" tabindex="2"
			               path="password" accesskey="${passwordAccessKey}" htmlEscape="true" autocomplete="off"/>
		</div>

		<div class="group">
			<label class="checkbox">
				<input type="checkbox" name="rememberMe" id="rememberMe" value="true" tabindex="3"/> Remember Me
			</label>
		</div>

		<div class="group">
			<input type="hidden" name="lt" value="${loginTicket}"/>
			<input type="hidden" name="execution" value="${flowExecutionKey}"/>
			<input type="hidden" name="_eventId" value="submit"/>

			<c:choose>
				<c:when test="${not empty service and (fn:containsIgnoreCase(service, 'sales') or fn:containsIgnoreCase(service, 'advertisingdemos'))}">
					<input id="submit" class="btn btn-inverse" name="submit" accesskey="l"
					       value="<spring:message code="screen.welcome.button.login" />"
					       tabindex="4" type="submit" disabled="disabled"/>
				</c:when>
				<c:otherwise>
					<input id="submit" class="btn btn-primary" name="submit" accesskey="l"
					       value="<spring:message code="screen.welcome.button.login" />"
					       tabindex="4" type="submit" disabled="disabled"/>
				</c:otherwise>
			</c:choose>
		</div>

		<div class="divider"></div>

		<div class="group">
			<a href="<c:url value="/forgot?service=${service}"/>">Forgot password?</a> or <a
				href="<c:url value="/new?service=${service}"/>">Request account</a>
		</div>

	</form:form>
	<script>
		collective = {};
		collective.callback = function () {
			var primary = function (element) {
				var value = $(element).val();
				return value !== undefined && $.trim(value) !== '';
			};
			var primary_email = function (element) {
				if (primary(element)) {
					var value = $(element).val();
					return $.trim(value).indexOf('@') !== -1;
				}
				return false;
			};
			var validate = function (event) {
				if (primary('#username') && primary('#password')) {
					$('#submit').removeAttr('disabled');
				} else {
					$('#submit').attr('disabled', 'disabled');
				}
			};
			$('#username').on('blur keyup', validate);
			$('#password').on('blur keyup', validate);

			var hideError = function (event) {
				$('#error').hide();
			};
			$('#username').on('keydown', hideError);
			$('#password').on('keydown', hideError);
		}
	</script>
</collective_ui:template>
