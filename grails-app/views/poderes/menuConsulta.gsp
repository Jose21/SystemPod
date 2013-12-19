
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="mainPoderes">    
        <g:set var="entityName" value="${message(code: 'poder.label', default: 'Opciones de Consulta')}" />    
        <title>Opciones de Consulta</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>
                Buscar Poderes
                <small>
                    <i class="icon-double-angle-right"></i>
                    Elige una Opción para Realizar la Consulta
                </small>
            </h1>
        </div><!--/.page-header-->
        <br/>
        <div class="row-fluid">
            <div class="span12">

                <div class="span4">
                    <div class="widget-box pricing-box">
                        <div class="widget-header header-color-green">
                            <h5 class="bigger lighter">Otorgamiento de Poder</h5>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <ul class="unstyled spaced2">
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Busca un otorgamiento de poder. 
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Realiza una búsqueda para ver los detalles.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Elige un filtro para una búsqueda avanzada.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Exporta los resultados en formato PDF O EXCEL.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Direccionamiento a la edición de los registros.
                                    </li>
                                </ul>
                            </div>

                            <div>
                                <g:link class="btn btn-block btn-success" controller="poderes" action="otorgamientoConsulta">                                
                                    <span>Aceptar</span>
                                </g:link>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="span4">
                    <div class="widget-box pricing-box">
                        <div class="widget-header header-color-orange">
                            <h5 class="bigger lighter">Revocación De Poder</h5>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <ul class="unstyled spaced2">
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Realiza una consulta para una revocación de poder.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Elige un criterio para una búsqueda avanzada.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Busca una revocación en un periodo determinado.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Compara la información de los resultados.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Exporta las consultas a formato PDF y EXCEL.
                                    </li>
                                </ul>
                            </div>

                            <div>
                                <g:link class="btn btn-block btn-warning" controller="poderes" action="revocacionConsulta">                                
                                    <span>Aceptar</span>
                                </g:link>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="span4">
                    <div class="widget-box pricing-box">
                        <div class="widget-header header-color-blue">
                            <h5 class="bigger lighter">Búsqueda General</h5>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <ul class="unstyled spaced2">
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Busca un otorgamiento y revocación de poder.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Realiza una consulta por nombre del Apoderado.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Búsqueda por nombre del Solicitante.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Selecciona un filtro de búsqueda.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Compara datos de otorgamientos y revocaciones.
                                    </li>
                                </ul>
                            </div>

                            <div>
                                <g:link class="btn btn-block btn-info" controller="poderes" action="busquedaGeneral">                                
                                    <span>Aceptar</span>
                                </g:link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
