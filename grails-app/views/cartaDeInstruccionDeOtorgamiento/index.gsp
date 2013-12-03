
<%@ page import="com.app.sgpod.CartaDeInstruccionDeOtorgamiento" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'cartaDeInstruccionDeOtorgamiento.label', default: 'CartaDeInstruccionDeOtorgamiento')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-cartaDeInstruccionDeOtorgamiento" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-cartaDeInstruccionDeOtorgamiento" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
			<thead>
					<tr>
					
						<g:sortableColumn property="registro" title="${message(code: 'cartaDeInstruccionDeOtorgamiento.registro.label', default: 'Registro')}" />
					
						<g:sortableColumn property="fecha" title="${message(code: 'cartaDeInstruccionDeOtorgamiento.fecha.label', default: 'Fecha')}" />
					
						<g:sortableColumn property="contenido" title="${message(code: 'cartaDeInstruccionDeOtorgamiento.contenido.label', default: 'Contenido')}" />
					
						<th><g:message code="cartaDeInstruccionDeOtorgamiento.otorgamientoDePoder.label" default="Otorgamiento De Poder" /></th>
					
						<g:sortableColumn property="dateCreated" title="${message(code: 'cartaDeInstruccionDeOtorgamiento.dateCreated.label', default: 'Date Created')}" />
					
						<g:sortableColumn property="lastUpdated" title="${message(code: 'cartaDeInstruccionDeOtorgamiento.lastUpdated.label', default: 'Last Updated')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${cartaDeInstruccionDeOtorgamientoInstanceList}" status="i" var="cartaDeInstruccionDeOtorgamientoInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${cartaDeInstruccionDeOtorgamientoInstance.id}">${fieldValue(bean: cartaDeInstruccionDeOtorgamientoInstance, field: "registro")}</g:link></td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeOtorgamientoInstance, field: "fecha")}</td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeOtorgamientoInstance, field: "contenido")}</td>
					
						<td>${fieldValue(bean: cartaDeInstruccionDeOtorgamientoInstance, field: "otorgamientoDePoder")}</td>
					
						<td><g:formatDate date="${cartaDeInstruccionDeOtorgamientoInstance.dateCreated}" /></td>
					
						<td><g:formatDate date="${cartaDeInstruccionDeOtorgamientoInstance.lastUpdated}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${cartaDeInstruccionDeOtorgamientoInstanceCount ?: 0}" />
			</div>
		</div>
	</body>
</html>
