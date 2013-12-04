
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <meta name="layout" content="main"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Área de Trabajo</title>
    </head>
    <body>

        <div class="row-fluid">

            <div class="span9">
                <h4 class="blue">
                    <span class="middle"><sec:username/></span>

                    <span class="label label-success arrowed-in-right">
                        <i class="icon-circle smaller-80"></i>
                        En línea
                    </span>
                </h4>
                <div>
                    <div>
                        <span class="profile-picture">
                            <img src="/sgcon/static/images/profile-pic.jpg"/>
                        </span>
                        <div class="space-4"></div>
                    </div>
                    <div class="profile-user-info">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> Nombre(s) </div>

                            <div class="profile-info-value">
                                <span>${user.firstName}</span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> Apellidos </div>

                            <div class="profile-info-value">
                                <span>${user.lastName}</span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> Email </div>

                            <div class="profile-info-value">
                                <span>${user.email}</span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> Fecha de Alta </div>

                            <div class="profile-info-value">
                                <span><g:formatDate date="${user.dateCreated}" type="datetime" style="LONG"/></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> Última actualización </div>

                            <div class="profile-info-value">
                                <span><g:formatDate date="${user.lastUpdated}" type="datetime" style="LONG"/></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div><!--/span-->
        </div><!--/row-fluid-->
        <div class="space-20"></div>

        <div class="row-fluid">
            <div class="span8">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-small">
                        <h4 class="smaller">
                            <i class="icon-lightbulb bigger-120"></i>
                            Información General
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main">
                            <p>
                                Bienvenido al Sistema de Control de Gestión de Convenios, Tareas y Poderes.
                            </p>
                            <p>
                                Gestión de Convenios: Permite agregar, modificar y gestionar los convenios existentes.
                            </p>
                            <p>
                                Gestión de Tareas: Brinda la posibilidad de administrar las tareas pendientes por realizar.
                            </p>
                            <p>
                                Gestión de Poderes: A través de este módulo es posible la administración de poderes.
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="span4">
                <div class="widget-box transparent">
                    <div class="widget-header widget-header-small header-color-blue2">
                        <h4 class="smaller">              
                            <i class="icon-check bigger-110"></i>
                            Opciones
                        </h4>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main padding-16">
                            <div class="row-fluid">
                                <g:link controller="dashboard" action="changepasswd" class="btn btn-small btn-block btn-success">
                                    <i class="icon-key bigger-110"></i>
                                    Cambiar Contraseña
                                </g:link>
                                <g:link controller="dashboard" action="changeinfo" class="btn btn-small btn-block btn-primary">
                                    <i class="icon-edit bigger-110"></i>
                                    Cambiar Información
                                </g:link>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </body>
</html>
