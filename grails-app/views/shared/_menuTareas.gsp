
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
        <g:link class="btn btn-small btn-success" controller="dashboard" action="index">
            <i class="icon-home"></i>
        </g:link>

        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS_ADMIN, ROLE_CONVENIOS_STANDARD">
            <g:link class="btn btn-small btn-info" controller="convenio" action="list">
                <i class="icon-book"></i>
            </g:link>
        </sec:ifAnyGranted>

        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_GESTOR, ROLE_FACTURAS, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_EXTERNO">
            <g:link class="btn btn-small btn-purple" controller="poderes" action="index">
                <i class="icon-user"></i>
            </g:link>
        </sec:ifAnyGranted>

        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TURNOS_ADMIN, ROLE_TURNOS_STANDARD">
            <g:link class="btn btn-small btn-warning" controller="tarea" action="hoy">
                <i class="icon-check"></i>
            </g:link>
        </sec:ifAnyGranted>
    </div>

    <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
        <span class="btn btn-success"></span>

        <span class="btn btn-info"></span>

        <span class="btn btn-warning"></span>

        <span class="btn btn-danger"></span>
    </div>
</div><!--#sidebar-shortcuts-->

<sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TURNOS_ADMIN, ROLE_TURNOS_STANDARD">
    <ul class="nav nav-list">  
        <li class="active open">
            <a href="#" class="dropdown-toggle">
                <i class="icon-book"></i>
                <span class="menu-text">Turnos</span>
                <b class="arrow icon-angle-down"></b>
            </a>
            <ul class="submenu">
                <li>
                    <g:link controller="tarea" action="create">
                        <i class="icon-double-angle-right"></i> Nuevo
                    </g:link>
                </li>
                <li>
                    <g:link controller="tarea" action="hoy">
                        <i class="icon-double-angle-right"></i> Para hoy
                    </g:link>
                </li>
                <li>
                    <g:link controller="tarea" action="programadas">
                        <i class="icon-double-angle-right"></i> Programados
                    </g:link>
                </li>
                <li>
                    <g:link controller="tarea" action="retrasadas">
                        <i class="icon-double-angle-right"></i> Retrasados
                    </g:link>
                </li>
                <li>
                    <g:link controller="tarea" action="concluidas">
                        <i class="icon-double-angle-right"></i> Concluídos
                    </g:link>
                </li>
                <li>
                    <g:link controller="tarea" action="consultaTarea">
                        <i class="icon-double-angle-right"></i> Consulta
                    </g:link>
                </li>
            </ul>
        </li>

        <li class="active open">
            <a href="#" class="dropdown-toggle">
                <i class="icon-hdd"></i>
                <span class="menu-text"> Reportes </span>
                <b class="arrow icon-angle-down"></b>
            </a>
            <ul class="submenu">
                <li>
                    <g:link controller="reporteDeTarea" action="totalDeTurnos">
                        <i class="icon-double-angle-right"></i> Total de Turnos
                    </g:link>
                </li>
                <li>
                    <!--
                  <g:link controller="reporteDeTarea" action="turnosPorFechaInit">
                    <i class="icon-double-angle-right"></i> Turnos por Fecha
                  </g:link>-->
                </li>
            </ul>
        </li>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TURNOS_ADMIN">
            <li class="active open">
                <a href="#" class="dropdown-toggle">
                    <i class="icon-hdd"></i>
                    <span class="menu-text"> Grupos </span>
                    <b class="arrow icon-angle-down"></b>
                </a>
                <ul class="submenu">
                    <li>
                        <g:link controller="grupo" action="create">
                            <i class="icon-double-angle-right"></i> Nuevo
                        </g:link>
                    </li>
                    <li>        
                        <g:link controller="grupo" action="list">
                            <i class="icon-double-angle-right"></i> Consulta
                        </g:link>
                    </li>
                </ul>
            </li>
        </sec:ifAnyGranted>
        <!--<li>
          <g:link controller="dashboard" action="index">
            <i class="icon-exchange"></i>
            <span class="menu-text">Regresar</span>
          </g:link>          
        </li>-->
    </ul><!--/.nav-list-->
</sec:ifAnyGranted>

<div class="sidebar-collapse" id="sidebar-collapse">
    <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
</div>

<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
</script>