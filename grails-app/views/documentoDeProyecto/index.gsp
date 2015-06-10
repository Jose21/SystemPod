
<%@ page import="com.app.sgpod.DocumentoDeProyecto" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'documentoDeProyecto.label', default: 'DocumentoDeProyecto')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-documentoDeProyecto" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-documentoDeProyecto" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="descripcion" title="${message(code: 'documentoDeProyecto.descripcion.label', default: 'Descripcion')}" />
					
						<g:sortableColumn property="motivosDeRechazo" title="${message(code: 'documentoDeProyecto.motivosDeRechazo.label', default: 'Motivos De Rechazo')}" />
					
						<g:sortableColumn property="fechaDeEnvio" title="${message(code: 'documentoDeProyecto.fechaDeEnvio.label', default: 'Fecha De Envio')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'documentoDeProyecto.dateCreated.label', default: 'Date Created')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${documentoDeProyectoInstanceList}" status="i" var="documentoDeProyectoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${documentoDeProyectoInstance.id}">${fieldValue(bean: documentoDeProyectoInstance, field: "descripcion")}</g:link></td>
					
						<td>${fieldValue(bean: documentoDeProyectoInstance, field: "motivosDeRechazo")}</td>
					
						<td><g:formatDate date="${documentoDeProyectoInstance.fechaDeEnvio}" /></td>
					
						<td><g:formatDate date="${documentoDeProyectoInstance.dateCreated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${documentoDeProyectoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
