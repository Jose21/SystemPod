
<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Poderes')}" />    
        <title>Bitacora</title>
    </head>
    <body>                        
        <div class="row-fluid">
            <div class="span10">
                <div class="widget-box transparent" id="recent-box">
                    <div class="widget-header">
                        <h4 class="lighter smaller">
                            <i class="icon-archive orange"></i>
                            REGISTROS
                        </h4>
                        <div class="container-fluid">
                            <br/>
                            <g:render template="/shared/alerts" />
                            <g:form method="post">
                                <label for="objeto" class="control-label">
                                    Rango de Fechas:
                                </label>
                                <div class="control-group">
                                    <div class="row-fluid input-prepend">
                                        <span class="add-on">
                                            <i class="icon-calendar"></i>
                                        </span>
                                        <input class="span5" type="text" name="rangoDeFechaBitacora" id="rangoDeFechaBitacora" value="${rangoDeFechaBitacora?:""}" readonly="true" />
                                        <g:actionSubmit class="btn btn-primary" action="rangoDeFechaBitacora" value="Buscar" />
                                    </div>
                                </div>
                            </g:form>                          

                            <div class="widget-toolbar no-border">
                                <ul class="nav nav-tabs" id="recent-tab">                                    
                                    <li class="active">
                                        <a data-toggle="tab" href="#otorgamientos-tab">Otorgamientos de Poder</a>
                                    </li>
                                    <li>
                                        <a data-toggle="tab" href="#revocaciones-tab">Revocaciones de Poder</a>
                                    </li>
                                </ul>
                            </div>
                        </div> 
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-4">
                            <div class="tab-content padding-8 overflow-visible">                                    
                                <div id="otorgamientos-tab" class="tab-pane in active">
                                    <div class="comments">
                                        <g:if test="${otorgamientoDePoderInstanceList}">
                                            <g:each in="${otorgamientoDePoderInstanceList.sort{it.id}.reverse()}" status="o" var="otorgamientoInstance">
                                                <div class="itemdiv commentdiv">
                                                    <div class="user">
                                                        <g:link controller="otorgamientoDePoder" action="show" id="${otorgamientoInstance.id}">
                                                            <span class="label label-purple arrowed-in">
                                                                ${otorgamientoInstance?.id}-O
                                                            </span>
                                                        </g:link>
                                                    </div>
                                                    </br>
                                                    <g:each in="${otorgamientoInstance.bitacoras.sort{it.cuando}}" status="b" var="bitacora">
                                                        <div class="body">
                                                            <div class="name">
                                                                <a>${bitacora?.quien}</a>
                                                            </div>
                                                            <div class="time">
                                                                <i class="icon-calendar"></i>
                                                                <span class="green"><g:formatDate date="${bitacora?.cuando}" type="datetime" style="MEDIUM"/></span>
                                                            </div>
                                                            <div class="text">
                                                                <i class="icon-quote-left"></i>
                                                                Evento: ${bitacora?.que}
                                                            </div>
                                                        </div>
                                                    </g:each>
                                                </div>
                                                <div class="hr hr-double hr8"></div>
                                            </g:each>
                                        </g:if>
                                    </div>                                                                               
                                </div><!--member-tab-->

                                <div id="revocaciones-tab" class="tab-pane">
                                    <div class="comments">   
                                        <g:if test="${revocacionDePoderInstanceList}">
                                            <g:each in="${revocacionDePoderInstanceList.sort{it.id}.reverse()}" status="r" var="revocacionInstance">
                                                <div class="itemdiv commentdiv">
                                                    <div class="user">
                                                        <g:link controller="revocacionDePoder" action="show" id="${revocacionInstance.id}">
                                                            <span class="label label-purple arrowed-in">
                                                                ${revocacionInstance?.id}-R
                                                            </span>
                                                        </g:link>
                                                    </div>
                                                    </br>
                                                    <g:each in="${revocacionInstance.bitacoras.sort{it.cuando}}" status="b" var="bitacora">
                                                        <div class="body">
                                                            <div class="name">
                                                                <a>${bitacora?.quien}</a>
                                                            </div>
                                                            <div class="time">
                                                                <i class="icon-calendar"></i>
                                                                <span class="green"><g:formatDate date="${bitacora?.cuando}" type="datetime" style="MEDIUM"/></span>
                                                            </div>
                                                            <div class="text">
                                                                <i class="icon-quote-left"></i>
                                                                Evento: ${bitacora?.que}
                                                            </div>
                                                        </div>
                                                    </g:each>
                                                </div>
                                                <div class="hr hr-double hr8"></div>
                                            </g:each>
                                        </g:if>
                                    </div>
                                </div>
                            </div><!--/widget-main-->
                        </div><!--/widget-body-->
                    </div><!--/widget-box-->
                </div><!--/span-->                        
            </div>        
        </div>
    </body>
</html>
