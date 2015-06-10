
<%@ page import="com.app.sgpod.CargoApoderado" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cargoApoderado.label', default: 'CargoApoderado')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cargoApoderado" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cargoApoderado" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="nombreCargo" title="${message(code: 'cargoApoderado.nombreCargo.label', default: 'Nombre Cargo')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cargoApoderadoInstanceList}" status="i" var="cargoApoderadoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cargoApoderadoInstance.id}">${fieldValue(bean: cargoApoderadoInstance, field: "nombreCargo")}</g:link></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cargoApoderadoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
