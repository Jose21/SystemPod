<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainTareas">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Compartir Turno</title>
    </head>
    <body>
        <h1>Turno: ${tareaInstance?.id}</h1>
        <br/>
        <g:render template="/shared/alerts" />
        <g:form class="form-horizontal" controller="tarea" method="post">
            <g:hiddenField name="id" value="${tareaInstance?.id}" />
            <div class="control-group required">
                <label for="compartirCon" class="control-label">
                    Compartir con:
                </label>
                <div class="controls">
                    <g:select id="compartidoCon" name="compartidoCon.id" 
                    from="${usuariosTurnosList}" optionKey="id" 
                        required="" value="" noSelection="['':'-Elige un usuario-']" class="many-to-one"/>
                </div>
            </div>            
            <div class="form-actions">
                <g:actionSubmit class="btn btn-mini btn-primary" action="addUsuarioToTarea" value="Aceptar" />        
            </div>
        </g:form>

        <table class="table table-bordered table-striped">

        </table>
        <table class="table table-bordered table-striped">
            <thead>
                <tr>          
                    <th>Usuario</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Creador del Turno</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <g:if test="${tareaInstance?.usuariosDeTarea}">
                    <g:each in="${tareaInstance?.usuariosDeTarea}" var="usuarioDeTarea" status="i">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                            <td>
                                <g:hiddenField name="usuario" value="${usuarioDeTarea.usuario.id}"/>
                                ${usuarioDeTarea.usuario.username}
                            </td>
                            <td>${usuarioDeTarea.usuario.firstName} ${usuarioDeTarea.usuario.lastName}</td>
                            <td>${usuarioDeTarea.usuario.email}</td>
                            <td style="text-align:center;">
                                <g:if test="${usuarioDeTarea.owner}">
                                    <span class="label label-large label-purple arrowed-in-right arrowed-in">Si</span>
                                </g:if>
                                <g:else>
                                    <span class="label label-large label-grey arrowed-in-right arrowed-in">No</span>
                                </g:else>              
                            </td>
                            <td>
                                <g:if test="${!usuarioDeTarea.owner}">
                                    <g:form name="removeUserFromTarea" controller="tarea" action="removeUsuarioFromTarea">
                                        <g:hiddenField name="tareaId" value="${tareaInstance.id}"/>
                                        <g:hiddenField name="usuarioId" value="${usuarioDeTarea.usuario.id}"/>
                                        <g:submitButton class="btn btn-danger btn-mini" name="btnRemove" value="Quitar"/>
                                    </g:form>
                                </g:if>
                            </td>
                        </tr>
                    </g:each>
                </g:if>
                <g:else>
                    <tr>
                        <td colspan="4" style="text-align:center;">El turno aún no ha sido compartido.</td>
                    </tr>
                </g:else>
            </tbody>
        </table>
        <div class="form-actions">
            <g:link class="btn btn-primary btn-mini" action="regresar" id="${tareaInstance?.id}">Regresar</g:link>
            </div>
        </body>
    </html>
