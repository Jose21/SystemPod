
<%@ page import="com.app.sgpod.Apoderado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'apoderado.label', default: 'Apoderado')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-apoderado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-apoderado" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombre" title="${message(code: 'apoderado.nombre.label', default: 'Nombre')}" />
					
						<g:sortableColumn property="puesto" title="${message(code: 'apoderado.puesto.label', default: 'Puesto')}" />
					
						<g:sortableColumn property="institucion" title="${message(code: 'apoderado.institucion.label', default: 'Institucion')}" />
					
						<g:sortableColumn property="email" title="${message(code: 'apoderado.email.label', default: 'Email')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${apoderadoInstanceList}" status="i" var="apoderadoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${apoderadoInstance.id}">${fieldValue(bean: apoderadoInstance, field: "nombre")}</g:link></td>
					
						<td>${fieldValue(bean: apoderadoInstance, field: "puesto")}</td>
					
						<td>${fieldValue(bean: apoderadoInstance, field: "institucion")}</td>
					
						<td>${fieldValue(bean: apoderadoInstance, field: "email")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${apoderadoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
