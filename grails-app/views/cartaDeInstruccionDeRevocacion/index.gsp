
<%@ page import="com.app.sgpod.CartaDeInstruccionDeRevocacion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeRevocacion.label', default: 'CartaDeInstruccionDeRevocacion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cartaDeInstruccionDeRevocacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cartaDeInstruccionDeRevocacion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="registro" title="${message(code: 'cartaDeInstruccionDeRevocacion.registro.label', default: 'Registro')}" />
					
						<g:sortableColumn property="fecha" title="${message(code: 'cartaDeInstruccionDeRevocacion.fecha.label', default: 'Fecha')}" />
					
						<g:sortableColumn property="contenido" title="${message(code: 'cartaDeInstruccionDeRevocacion.contenido.label', default: 'Contenido')}" />
					
						<th><g:message code="cartaDeInstruccionDeRevocacion.revocacionDePoder.label" default="Revocacion De Poder" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'cartaDeInstruccionDeRevocacion.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'cartaDeInstruccionDeRevocacion.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cartaDeInstruccionDeRevocacionInstanceList}" status="i" var="cartaDeInstruccionDeRevocacionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cartaDeInstruccionDeRevocacionInstance.id}">${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "registro")}</g:link></td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "fecha")}</td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "contenido")}</td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeRevocacionInstance, field: "revocacionDePoder")}</td>
					
						<td><g:formatDate date="${cartaDeInstruccionDeRevocacionInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${cartaDeInstruccionDeRevocacionInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cartaDeInstruccionDeRevocacionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
