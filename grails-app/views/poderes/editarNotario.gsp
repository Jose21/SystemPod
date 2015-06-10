<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Notarios')}" />    
        <title>Notarios</title>
    </head>
    <body>                        
        <div class="row-fluid">
            <div class="span10">
                <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h2 class="lighter smaller">
                            <i class="icon-male green"></i>
                            Lista: Notarios
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
                                    <th>Titular de la Notaria</th>
                                    <th>Notaria</th>
                                    <th>Entidad</th>                                                                                            
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${notarios.sort{it.id}}" status="i" var="notarioInstance">            
                                    <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                        <td>                    
                                            <div id="editarNotarioModal${i}" class="modal hide" style="width:600px;">
                                                <div class="modal-header">
                                                    <button data-dismiss="modal" class="close" type="button">×</button>
                                                    <h3>Editar Datos del Notario</h3>
                                                </div>
                                                <div class="modal-body">
                                                    <g:form class="form-horizontal" controller="user" method="post">                                                                
                                                        <g:hiddenField name="notarioInstance.id" value="${notarioInstance?.id}" />
                                                        <g:hiddenField name="id" value="${notarioInstance?.id}" />
                                                        <g:hiddenField name="version" value="${notarioInstance?.version}" />
                                                        <g:render template="/user/itForm" bean="${notarioInstance}"/>            
                                                        <div class="form-actions">
                                                            <g:actionSubmit class="btn btn-primary" action="updateIt" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                                                        </div>
                                                    </g:form>
                                                </div>
                                            </div>
                                            <a href="#editarNotarioModal${i}" data-toggle="modal">
                                                <i class="icon-edit bigger-110"></i>
                                            </a>
                                            ${notarioInstance.firstName}</td>
                                        <td>${notarioInstance.lastName}</td>                                        
                                        <td>${notarioInstance.email}</td>                                                
                                        <td>${notarioInstance.notaria_titular}</td>                                                
                                        <td>${notarioInstance.notaria_numero}</td>                                                
                                        <td>${notarioInstance.notaria_entidad}</td>                                                
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
