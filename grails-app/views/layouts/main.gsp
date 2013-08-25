<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="${resource(dir:'assets/css',file:'bootstrap.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'bootstrap-responsive.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'font-awesome.min.css')}" rel="stylesheet" />

    <!--[if IE 7]>
      <link rel="stylesheet" href="${resource(dir:'assets/css',file:'font-awesome-ie7.min.css')}" />
    <![endif]-->

    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300" />
    <link href="${resource(dir:'assets/css',file:'ace.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'ace-responsive.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'ace-skins.min.css')}" rel="stylesheet" />
    
    <!--[if lte IE 8]>
      <link rel="stylesheet" href="${resource(dir:'assets/css',file:'ace-ie.min.css')}" />
    <![endif]-->
    
    <script src="${resource(dir:'assets/js',file:'ace-extra.min.js')}"></script>

    <g:layoutHead/>
    <r:layoutResources />
  </head>
  <body>

  <div class="navbar" id="navbar">
    <script type="text/javascript">
            try{ace.settings.check('navbar' , 'fixed')}catch(e){}
    </script>

    <div class="navbar-inner">
      <div class="container-fluid">
        <a href="#" class="brand">
          <b>I N F O N A V I T</b>
        </a><!--/.brand-->

        <ul class="nav ace-nav pull-right">
          
          <li class="light-orange">
            <a data-toggle="dropdown" href="#" class="dropdown-toggle">
              <span class="user-info">
                <small>Bienvenido</small>
                <sec:username/>
              </span>

              <i class="icon-caret-down"></i>
            </a>

            <ul class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-closer">
              <li>
                <a href="#">
                  <i class="icon-cog"></i>
                  Settings
                </a>
              </li>

              <li>
                <a href="#">
                  <i class="icon-user"></i>
                  Profile
                </a>
              </li>

              <li class="divider"></li>

              <li>                
                <g:link controller="logout">
                  <i class="icon-off"></i>
                  Logout
                </g:link>
              </li>
            </ul>
          </li>
        </ul><!--/.ace-nav-->
      </div><!--/.container-fluid-->
    </div><!--/.navbar-inner-->
  </div>

  <div class="main-container container-fluid">
    <a class="menu-toggler" id="menu-toggler" href="#">
      <span class="menu-text"></span>
    </a>
    
    <div class="sidebar" id="sidebar">
    <g:render template="/shared/menu" />
    </div>

    <div class="main-content">
      <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
                try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
        </script>

        <ul class="breadcrumb">
          <li>
            <i class="icon-home home-icon"></i>
            <a href="#">Home</a>

            <span class="divider">
              <i class="icon-angle-right arrow-icon"></i>
            </span>
          </li>

          <li>
            <a href="#">Other Pages</a>

            <span class="divider">
              <i class="icon-angle-right arrow-icon"></i>
            </span>
          </li>
          <li class="active">Blank Page</li>
        </ul><!--.breadcrumb-->

        <!--
        <div class="nav-search" id="nav-search">
          <form class="form-search">
            <span class="input-icon">
              <input type="text" placeholder="Buscar ..." class="input-small nav-search-input" id="nav-search-input" autocomplete="off" />
              <i class="icon-search nav-search-icon"></i>
            </span>
          </form>
        </div>
        -->
      </div>

      <div class="page-content">
        <div class="row-fluid">
          <div class="span12">
            <!--PAGE CONTENT BEGINS-->
              <g:layoutBody/>
            <!--PAGE CONTENT ENDS-->
          </div><!--/.span-->
        </div><!--/.row-fluid-->
      </div><!--/.page-content-->
    </div><!--/.main-content-->
  </div><!--/.main-container-->

  
  <!--[if !IE]>-->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
  <!--<![endif]-->
  <!--[if IE]>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <![endif]-->
  
  <!--[if !IE]>-->
  <script type="text/javascript">
          window.jQuery || document.write("<script src='${resource(dir:'assets/js',file:'jquery-2.0.3.min.js')}'>"+"<"+"/script>");
  </script>
  <!--<![endif]-->
  <!--[if IE]>
    <script type="text/javascript">
      window.jQuery || document.write("<script src='${resource(dir:'assets/js',file:'jquery-1.10.2.min.js')}'>"+"<"+"/script>");
    </script>
  <![endif]-->

  <script type="text/javascript">
          if("ontouchend" in document) document.write("<script src='${resource(dir:'assets/js',file:'jquery.mobile.custom.min.js')}'>"+"<"+"/script>");
  </script>
  <script src="${resource(dir:'assets/js',file:'bootstrap.min.js')}"></script>

  <!--page specific plugin scripts-->

  <!--ace scripts-->

  <script src="${resource(dir:'assets/js',file:'ace-elements.min.js')}"></script>
  <script src="${resource(dir:'assets/js',file:'ace.min.js')}"></script>

  <!--inline scripts related to this page-->

  <g:javascript library="application"/>
  <r:layoutResources />
</body>
</html>
