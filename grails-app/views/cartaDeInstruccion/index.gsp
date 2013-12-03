
<%@ page import="com.app.sgpod.CartaDeInstruccion" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cartaDeInstruccion.label', default: 'CartaDeInstruccion')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cartaDeInstruccion" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cartaDeInstruccion" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="registro" title="${message(code: 'cartaDeInstruccion.registro.label', default: 'Registro')}" />
					
						<g:sortableColumn property="fecha" title="${message(code: 'cartaDeInstruccion.fecha.label', default: 'Fecha')}" />
					
						<g:sortableColumn property="contenido" title="${message(code: 'cartaDeInstruccion.contenido.label', default: 'Contenido')}" />
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'cartaDeInstruccion.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'cartaDeInstruccion.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cartaDeInstruccionInstanceList}" status="i" var="cartaDeInstruccionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cartaDeInstruccionInstance.id}">${fieldValue(bean: cartaDeInstruccionInstance, field: "registro")}</g:link></td>
					
						<td>${fieldValue(bean: cartaDeInstruccionInstance, field: "fecha")}</td>
					
						<td>${fieldValue(bean: cartaDeInstruccionInstance, field: "contenido")}</td>
					
						<td><g:formatDate date="${cartaDeInstruccionInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${cartaDeInstruccionInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cartaDeInstruccionInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
