<%@ page import="com.app.sgpod.CargoApoderado" %>

<div class="control-group fieldcontain ${hasErrors(bean: cargoApoderadoInstance, field: 'nombreCargo', 'error')} required">
    <label for="nombreCargo" class="control-label">
        <g:message code="cargoApoderado.nombreCargo.label" default="Nombre Cargo" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="nombreCargo" class="span6" required="" value="${cargoApoderadoInstance?.nombreCargo}"/>
    </div>
</div>

<g:if test="${!cargoApoderadoInstance.categoriasDeTipoDePoder}">
    <h3 class="header smaller lighter blue">Seleccione las categorias que pertenecen a este nuevo cargo.</h3> 
    <table class="table table-bordered table-striped">
        <thead>
            <tr>            
                <th></th>
                <th>Nombre de la categoria</th>                 
            </tr>
        </thead>
        <tbody>                                                            
            <g:each in="${com.app.sgpod.CategoriaDeTipoDePoder.list()}" status="i" var="categoria">            
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td style="text-align:center"><g:checkBox id="${categoria.id}" name="categoriaList" value="${categoria.id}" checked="false"/></td>
                    <td>${categoria.nombre}</td>                                                       
                </tr>                                
            </g:each>                                   
        </tbody>
    </table>
</g:if>
<g:else>
    <table class="table table-bordered table-striped">
        <thead>
            <tr>           
                <th colspan="2">Nombre</th>                                             
            </tr>
        </thead>
        <tbody>
            <g:each in="${cargoApoderadoInstance.categoriasDeTipoDePoder}" status="i" var="categoriaActual">            
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>                                        
                        ${categoriaActual.detalles}
                    </td>                                
                    <td>
                        <g:form class="form-horizontal" controller="cargoApoderado" method="post" >                        
                            <g:hiddenField name="cargoApoderado.id" value="${cargoApoderadoInstance?.id}" />
                            <g:hiddenField name="categoria.id" value="${categoriaActual?.id}" />
                            <g:actionSubmit class="btn btn-danger btn-mini" action="removeCategoria" value=" Quitar  " onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        </g:form>
                    </td>
                </tr>            
            </g:each>  
            <g:each in="${categoriasRestantes}" status="i" var="categoriaRestante">            
                <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                    <td>                                        
                        ${categoriaRestante.detalles}
                    </td>                                
                    <td>
                        <g:form class="form-horizontal" controller="cargoApoderado" method="post" >                        
                            <g:hiddenField name="cargoApoderado.id" value="${cargoApoderadoInstance?.id}" />
                            <g:hiddenField name="categoria.id" value="${categoriaRestante?.id}" />
                            <g:actionSubmit class="btn btn-primary btn-mini" action="addCategoria" value="Agregar" />
                        </g:form>
                    </td>
                </tr>            
            </g:each>                                      
        </tbody>
    </table>
</g:else>