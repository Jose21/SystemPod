
<%@ page import="com.app.sgpod.ConfigurarParametro" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'configurarParametro.label', default: 'ConfigurarParametro')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-configurarParametro" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-configurarParametro" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="estadoCriticoPoder" title="${message(code: 'configurarParametro.estadoCriticoPoder.label', default: 'Estado Critico Poder')}" />
					
						<g:sortableColumn property="estadoSemiPoder" title="${message(code: 'configurarParametro.estadoSemiPoder.label', default: 'Estado Semi Poder')}" />
					
						<g:sortableColumn property="estadoNormalPoder" title="${message(code: 'configurarParametro.estadoNormalPoder.label', default: 'Estado Normal Poder')}" />
					
						<g:sortableColumn property="estadoCriticoSolicitud" title="${message(code: 'configurarParametro.estadoCriticoSolicitud.label', default: 'Estado Critico Solicitud')}" />
					
						<g:sortableColumn property="estadoSemiSolicitud" title="${message(code: 'configurarParametro.estadoSemiSolicitud.label', default: 'Estado Semi Solicitud')}" />
					
						<g:sortableColumn property="estadoNormalSolicitud" title="${message(code: 'configurarParametro.estadoNormalSolicitud.label', default: 'Estado Normal Solicitud')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${configurarParametroInstanceList}" status="i" var="configurarParametroInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${configurarParametroInstance.id}">${fieldValue(bean: configurarParametroInstance, field: "estadoCriticoPoder")}</g:link></td>
					
						<td>${fieldValue(bean: configurarParametroInstance, field: "estadoSemiPoder")}</td>
					
						<td>${fieldValue(bean: configurarParametroInstance, field: "estadoNormalPoder")}</td>
					
						<td>${fieldValue(bean: configurarParametroInstance, field: "estadoCriticoSolicitud")}</td>
					
						<td>${fieldValue(bean: configurarParametroInstance, field: "estadoSemiSolicitud")}</td>
					
						<td>${fieldValue(bean: configurarParametroInstance, field: "estadoNormalSolicitud")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${configurarParametroInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
