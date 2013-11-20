
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="mainPoderes">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard de Poderes</title>
    </head>
    <body>
        <div class="page-header position-relative">
            <h1>
                Crear Nuevo Expediente
                <small>
                    <i class="icon-double-angle-right"></i>
                    Elige el Tipo de Poder
                </small>
            </h1>
        </div><!--/.page-header-->
        <br/>
        <div class="row-fluid">
            <div class="span12">

                <div class="span6">
                    <div class="widget-box pricing-box">
                        <div class="widget-header header-color-green">
                            <h5 class="bigger lighter">Otorgamiento de Poder</h5>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <ul class="unstyled spaced2">
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Crea un nuevo otorgamiento de poder.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Anota los datos del apoderado.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Describe el poder solicitado.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Selecciona la delegación a la que pertenece.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Adjunta los archivos asociados al poder.
                                    </li>
                                </ul>
                            </div>

                            <div>
                                <g:link class="btn btn-block btn-success" controller="otorgamientoDePoder" action="create">                                
                                    <span>Aceptar</span>
                                </g:link>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="span6">
                    <div class="widget-box pricing-box">
                        <div class="widget-header header-color-orange">
                            <h5 class="bigger lighter">Revocación De Poder</h5>
                        </div>

                        <div class="widget-body">
                            <div class="widget-main">
                                <ul class="unstyled spaced2">
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Crea una nueva solicitud para revocación de poder.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Escribe los datos del Notario.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Anota los datos del apoderado.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Selecciona la delegación a la que pertenece.
                                    </li>
                                    <li>
                                        <i class="icon-ok green"></i>
                                        Adjunta los archivos asociados a la revocación de poder.
                                    </li>
                                </ul>
                            </div>

                            <div>
                                <g:link class="btn btn-block btn-warning" controller="revocacionDePoder" action="create">                                
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
