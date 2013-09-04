
<script type="text/javascript">
        try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
  <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
    <g:link class="btn btn-small btn-success" controller="dashboard" action="index">
      <i class="icon-home"></i>
    </g:link>

    <g:link class="btn btn-small btn-info" controller="convenio" action="create">
      <i class="icon-book"></i>
    </g:link>

    <g:link class="btn btn-small btn-warning" controller="tarea" action="create">
      <i class="icon-check"></i>
    </g:link>

    <g:link class="btn btn-small btn-danger" controller="user">
      <i class="icon-lock"></i>
    </g:link>
  </div>

  <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
    <span class="btn btn-success"></span>

    <span class="btn btn-info"></span>

    <span class="btn btn-warning"></span>

    <span class="btn btn-danger"></span>
  </div>
</div><!--#sidebar-shortcuts-->

<ul class="nav nav-list">  
  <li class="active open">
    <a href="#" class="dropdown-toggle">
      <i class="icon-book"></i>
      <span class="menu-text">Tareas</span>
      <b class="arrow icon-angle-down"></b>
    </a>
    <ul class="submenu">
      <li>
        <g:link controller="tarea" action="create">
          <i class="icon-double-angle-right"></i> Nueva
        </g:link>
      </li>
      <li>
        <g:link controller="tarea" action="hoy">
          <i class="icon-double-angle-right"></i> Para hoy
        </g:link>
      </li>
      <li>
        <g:link controller="tarea" action="programadas">
          <i class="icon-double-angle-right"></i> Programadas
        </g:link>
      </li>
      <li>
        <g:link controller="tarea" action="retrasadas">
          <i class="icon-double-angle-right"></i> Retrasadas
        </g:link>
      </li>
      <!--<li>
        <g:link controller="tarea" action="asignadas">
          <i class="icon-double-angle-right"></i> Asignadas
        </g:link>
      </li>-->
    </ul>
  </li>
  
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