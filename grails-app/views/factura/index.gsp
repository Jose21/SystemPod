
<%@ page import="com.app.sgpod.Factura" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="mainPoderes">
		<g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-factura" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-factura" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nota" title="${message(code: 'factura.nota.label', default: 'Nota')}" />
					
						<th><g:message code="factura.asignadoA.label" default="Asignado A" /></th>
					
						<th><g:message code="factura.asignadoPor.label" default="Asignado Por" /></th>
					
						<g:sortableColumn property="fechaDeEnvio" title="${message(code: 'factura.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${facturaInstanceList}" status="i" var="facturaInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${facturaInstance.id}">${fieldValue(bean: facturaInstance, field: "nota")}</g:link></td>
					
						<td>${fieldValue(bean: facturaInstance, field: "asignadoA")}</td>
					
						<td>${fieldValue(bean: facturaInstance, field: "asignadoPor")}</td>
					
						<td><g:formatDate date="${facturaInstance.fechaDeEnvio}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${facturaInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
