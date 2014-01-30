
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

        <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE">
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
    
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR, ROLE_PODERES_NOTARIO, ROLE_PODERES_SOLICITANTE">
    <li class="active open">
        <a href="#" class="dropdown-toggle">
            <i class="icon-legal"></i>
            <span class="menu-text">Poderes</span>
            <b class="arrow icon-angle-down"></b>
        </a>
        <ul class="submenu">            
            <li>
                <g:link controller="poderes" action="index">
                    <i class="icon-double-angle-right"></i> Bandeja Principal
                </g:link>
            </li>            
            <li>
                <g:link controller="poderes" action="menuConsulta">
                    <i class="icon-double-angle-right"></i> Consulta
                </g:link>
            </li>
        </ul>
    </li>
    </sec:ifAnyGranted>
    
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR, ROLE_PODERES_SOLICITANTE">
    <li class="active open">
        <a href="#" class="dropdown-toggle">
            <i class="icon-book"></i>
            <span class="menu-text">Expedientes</span>
            <b class="arrow icon-angle-down"></b>
        </a>
        <ul class="submenu">            
            <li>
                <g:link controller="expediente" action="index">
                    <i class="icon-double-angle-right"></i> Nuevo
                </g:link>
            </li>            
        </ul>
    </li>
    </sec:ifAnyGranted>
    
    <sec:ifAnyGranted roles="ROLE_ADMINISTRADOR, ROLE_PODERES, ROLE_PODERES_ADMINISTRADOR">
    <li class="active open">
        <a href="#" class="dropdown-toggle">
            <i class="icon-folder-close"></i>
            <span class="menu-text"> Catálogos </span>
            <b class="arrow icon-angle-down"></b>
        </a>
        <ul class="submenu">
            <li>
                <g:link controller="delegacion">
                    <i class="icon-double-angle-right"></i> Delegaciones
                </g:link>
            </li>
            <li>
                <g:link controller="formatoDeCartaDeInstruccion" action="show" id="1">
                    <i class="icon-double-angle-right"></i> Formato De Carta De Instrucción
                </g:link>
            </li>
            <li>
                <g:link controller="motivoDeOtorgamiento">
                    <i class="icon-double-angle-right"></i> Motivos de Otorgamiento
                </g:link>
            </li>
            <li>
                <g:link controller="motivoDeRevocacion">
                    <i class="icon-double-angle-right"></i> Motivos de Revocación
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

<div class="sidebar-collapse" id="sidebar-collapse">
    <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
</div>

<script type="text/javascript">
    try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
</script>