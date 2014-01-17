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

<collective_ui:template title="Forgot RM Password?" service="${service}">
	<h3>Forgot Password?</h3>

	<div class="divider"></div>
	<form method="post" id="fm1" style="min-height: 172px">
		<c:if test="${not empty error}">
			<div id="error" class="alert alert-error">
				<a class="close" data-dismiss="alert">×</a>
				<h4 class="alert-heading">Problem!</h4>
				<c:out value="${error}"/>
			</div>
		</c:if>
		<div class="fan fan-forgot"></div>
		<div class="group">
			<label for="email" class="fl-label">Email:</label>
            <input type="email" id="email" name="email" class="input-large" tabindex="1" placeholder="Required"/>
		</div>
		<div class="group">
			<c:choose>
				<c:when test="${not empty service and (fn:containsIgnoreCase(service, 'sales') or fn:containsIgnoreCase(service, 'advertisingdemos'))}">
					<input id="submit" class="btn btn-inverse" name="submit" value="Retrieve"
					       tabindex="2" type="submit" disabled="disabled"/>
				</c:when>
				<c:otherwise>
					<input id="submit" class="btn btn-primary" name="submit" value="Retrieve"
					       tabindex="2" type="submit" disabled="disabled"/>
				</c:otherwise>
			</c:choose>
			<input class="btn" name="cancel" accesskey="l" value="Cancel" tabindex="3" type="submit" formnovalidate/>
		</div>
	</form>
	<div class="divider"></div>
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
				if (primary_email('#email')) {
					$('#submit').removeAttr('disabled');
				} else {
					$('#submit').attr('disabled', 'disabled');
				}
			};
			$('#email').on('blur keyup', validate);

			var hideError = function (event) {
				$('#error').hide();
			};
			$('#email').on('keydown', hideError);
		}
	</script>
</collective_ui:template>