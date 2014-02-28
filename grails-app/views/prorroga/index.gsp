
<%@ page import="com.app.sgpod.Prorroga" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'prorroga.label', default: 'Prorroga')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-prorroga" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-prorroga" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<th><g:message code="prorroga.asignadoA.label" default="Asignado A" /></th>
					
						<th><g:message code="prorroga.creadoPor.label" default="Creado Por" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'prorroga.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="dias" title="${message(code: 'prorroga.dias.label', default: 'Dias')}" />
					
						<g:sortableColumn property="fechaDeEnvio" title="${message(code: 'prorroga.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
					
						<g:sortableColumn property="motivos" title="${message(code: 'prorroga.motivos.label', default: 'Motivos')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${prorrogaInstanceList}" status="i" var="prorrogaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${prorrogaInstance.id}">${fieldValue(bean: prorrogaInstance, field: "asignadoA")}</g:link></td>
					
						<td>${fieldValue(bean: prorrogaInstance, field: "creadoPor")}</td>
					
						<td><g:formatDate date="${prorrogaInstance.dateCreated}" /></td>
					
						<td>${fieldValue(bean: prorrogaInstance, field: "dias")}</td>
					
						<td><g:formatDate date="${prorrogaInstance.fechaDeEnvio}" /></td>
					
						<td>${fieldValue(bean: prorrogaInstance, field: "motivos")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${prorrogaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
