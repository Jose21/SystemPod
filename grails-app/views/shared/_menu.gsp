
<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
    <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">

        <g:link class="btn btn-small btn-success" controller="dashboard" action="index">
            <i class="icon-home"></i>
        </g:link>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS">
            <g:link class="btn btn-small btn-info" controller="convenio" action="create">
                <i class="icon-book"></i>
            </g:link>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_GESTOR">
            <g:link class="btn btn-small btn-purple" controller="poderes" action="index">
                <i class="icon-user"></i>
            </g:link>
        </sec:ifAnyGranted>
        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TAREAS">
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
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS">
    <li>
        <g:link controller="convenio" action="list">
            <i class="icon-book"></i>
            <span class="menu-text">Convenios</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_RESOLVEDOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE, ROLE_PODERES_GESTOR">
    <li>
        <g:link controller="poderes" action="index">
            <i class="icon-key"></i>
            <span class="menu-text">Poderes</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_TAREAS">
    <li>
        <g:link controller="tarea" action="hoy">
            <i class="icon-check"></i>
            <span class="menu-text">Turnos</span>
        </g:link> 
    </li>
    </sec:ifAnyGranted>
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_CONVENIOS, ROLE_PODERES, ROLE_TAREAS, ROLE_PODERES_RESOLVEDOR">
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