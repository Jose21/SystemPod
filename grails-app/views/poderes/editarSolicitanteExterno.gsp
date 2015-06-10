<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Notarios')}" />    
        <title>Solicitantes Externos</title>
    </head>
    <body>                        
        <div class="row-fluid">
            <div class="span10">
                <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h2 class="lighter smaller">
                            <i class="icon-male green"></i>
                            Lista: Solicitantes Externos
                        </h2>
                        <div class="container-fluid">
                            <br/>
                            <g:render template="/shared/alerts" />
                        </div> 
                    </div>
                    <div class="container-fluid">
                        </br>
                        <table class="table table-bordered table-striped">
                            <thead>
                                <tr>                                                                                        
                                    <th>Nombre</th>                
                                    <th>Apellidos</th>                                    
                                    <th>Correo Electrónico</th>
                                    <th>Despacho</th>                                                                                                                                
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${solicitantesExternos.sort{it.id}}" status="i" var="solicitanteInstance">            
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td style="width:15%">                    
                                            <div id="editarNotarioModal${i}" class="modal hide" style="width:800px;">
                                                <div class="modal-header">
                                                    <button data-dismiss="modal" class="close" type="button">×</button>
                                                    <h3>Editar Datos del Solicitante Externo </h3>
                                                </div>
                                                <div class="modal-body">
                                                    <g:form class="form-horizontal" controller="user" method="post">                                                                
                                                        <g:hiddenField name="notarioInstance.id" value="${solicitanteInstance?.id}" />
                                                        <g:hiddenField name="id" value="${solicitanteInstance?.id}" />
                                                        <g:hiddenField name="version" value="${solicitanteInstance?.version}" />                                                        
                                                        <g:render template="/user/itFormUserExterno" bean="${solicitanteInstance}"/>            
                                                        <div class="form-actions">
                                                            <g:actionSubmit class="btn btn-primary" action="updateItUserExterno" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                                        </div>
                                                    </g:form>
                                                </div>
                                            </div>
                                            <a href="#editarNotarioModal${i}" data-toggle="modal">
                                                <i class="icon-edit bigger-110"></i>
                                            </a>
                                            ${solicitanteInstance.firstName}</td>
                                        <td style="width:20%">${solicitanteInstance.lastName}</td>                                        
                                        <td style="width:15%">${solicitanteInstance.email}</td>                                                
                                        <td style="width:40%">${solicitanteInstance.nombreDespachoExterno}</td>                                                                                                                                     
                                    </tr>            
                                </g:each>                                                
                            </tbody>
                        </table>
                    </div>
                </div><!--/span-->                        
            </div>        
        </div>
    </body>
</html>

