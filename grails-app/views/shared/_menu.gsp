
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">

        <g:link class="btn btn-small btn-success" controller="dashboard" action="index">
            <i class="icon-home"></i>
        </g:link>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS_STANDARD, ROLE_CONVENIOS_ADMIN">
            <g:link class="btn btn-small btn-info" controller="convenio" action="list">
                <i class="icon-book"></i>
            </g:link>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_GESTOR, ROLE_FACTURAS, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_EXTERNO, ROLE_PODERES_ENLACE, ROLE_SOLICITANTE_ESPECIAL">
            <g:link class="btn btn-small btn-purple" controller="poderes" action="index">
                <i class="icon-user"></i>
            </g:link>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TURNOS_STANDARD, ROLE_TURNOS_ADMIN">
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

<ul class="nav nav-list">
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS_STANDARD, ROLE_CONVENIOS_ADMIN">
    <li>
        <g:link controller="convenio" action="list">
            <i class="icon-book"></i>
            <span class="menu-text">Convenios</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_GESTOR, ROLE_FACTURAS, ROLE_GESTOR_EXTERNO, ROLE_SOLICITANTE_EXTERNO,ROLE_PODERES_ENLACE, ROLE_SOLICITANTE_ESPECIAL">
    <li>
        <g:link controller="poderes" action="index">
            <i class="icon-key"></i>
            <span class="menu-text">Poderes</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TURNOS_ADMIN, ROLE_TURNOS_STANDARD">
    <li>
        <g:link controller="tarea" action="hoy">
            <i class="icon-check"></i>
            <span class="menu-text">Turnos</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES_GESTOR, ROLE_CONVENIOS_ADMIN, ROLE_TURNOS_ADMIN">
    <li>
        <g:link controller="user">
            <i class="icon-lock"></i>
            <span class="menu-text">Seguridad</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
</ul><!--/.nav-list-->

<div class="sidebar-collapse" id="sidebar-collapse">
    <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
</div>

<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
</script>