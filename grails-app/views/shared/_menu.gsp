
<script type="text/javascript">
        try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
</script>

<div class="sidebar-shortcuts" id="sidebar-shortcuts">
  <div class="sidebar-shortcuts-large" id="sidebar-shortcuts-large">
    <button class="btn btn-small btn-success">
      <i class="icon-signal"></i>
    </button>

    <button class="btn btn-small btn-info">
      <i class="icon-pencil"></i>
    </button>

    <button class="btn btn-small btn-warning">
      <i class="icon-group"></i>
    </button>

    <button class="btn btn-small btn-danger">
      <i class="icon-cogs"></i>
    </button>
  </div>

  <div class="sidebar-shortcuts-mini" id="sidebar-shortcuts-mini">
    <span class="btn btn-success"></span>

    <span class="btn btn-info"></span>

    <span class="btn btn-warning"></span>

    <span class="btn btn-danger"></span>
  </div>
</div><!--#sidebar-shortcuts-->

<ul class="nav nav-list">
  <li>
  <g:link controller="dashboard" action="index">
    <i class="icon-dashboard"></i>
    <span class="menu-text"> Dashboard </span>
  </g:link>          
</li>
</ul><!--/.nav-list-->

<div class="sidebar-collapse" id="sidebar-collapse">
  <i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
</div>

<script type="text/javascript">
        try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
</script>