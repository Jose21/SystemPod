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
        <link href="${resource(dir:'assets/css',file:'style.css')}" rel="stylesheet" />
        <!--[if IE 7]>
          <link rel="stylesheet" href="${resource(dir:'assets/css',file:'font-awesome-ie7.min.css')}" />
        <![endif]-->
        <!--page specific plugin styles-->
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'jquery-ui-1.10.3.custom.min.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'chosen.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'datepicker.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'bootstrap-timepicker.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'daterangepicker.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'colorpicker.css')}" />
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'ace-fonts.css')}" />   
        <link rel="stylesheet" href="${resource(dir:'assets/css',file:'validationEngine.jquery.css')}"/>
        <link href="${resource(dir:'assets/css',file:'ace.min.css')}" rel="stylesheet" />
        <link href="${resource(dir:'assets/css',file:'ace-responsive.min.css')}" rel="stylesheet" />
        <link href="${resource(dir:'assets/css',file:'ace-skins.min.css')}" rel="stylesheet" />      
<!--[if lte IE 8]>
  <link rel="stylesheet" href="${resource(dir:'assets/css',file:'ace-ie.min.css')}" />
<![endif]-->       
    <r:require module="jquery"/>
    <r:require module="jquery-ui"/>
    <script src="${resource(dir:'assets/js',file:'ace-extra.min.js')}"></script>    
    <r:layoutResources />
    <g:layoutHead/>
</head>
<body>

    <div class="navbar" id="navbar">
        <script type="text/javascript">
            try{ace.settings.check('navbar' , 'fixed')}catch(e){}
        </script>

        <div class="navbar-inner">
            <div class="container-fluid">
                <a href="#" class="brand">
                    <b>SGCon: Turnos</b>
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
                                <g:link controller="dashboard" action="index">
                                    <i class="icon-user"></i>
                                    Información
                                </g:link>
                            </li>

                            <li class="divider"></li>

                            <li>                
                                <g:link controller="logout">
                                    <i class="icon-off"></i>
                                    Salir
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
            <g:render template="/shared/menuTareas" />
        </div>

        <div class="main-content">
            <div class="breadcrumbs" id="breadcrumbs">
                <script type="text/javascript">
                    try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
                </script>

                <ul class="breadcrumb">
                    <li>
                        <i class="icon-home home-icon"></i>
                        <g:link controller="dashboard" action="index">
                            Inicio
                        </g:link>
                        <span class="divider">
                            <i class="icon-angle-right arrow-icon"></i>
                        </span>
                    </li>
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
            <div class="ace-settings-container" id="ace-settings-container">          
                <div class="ace-settings-box" id="ace-settings-box">            
                    <div>
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
                        <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
                    </div>
                    <div>
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
                        <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
                    </div>
                    <div>
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
                        <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
                    </div>
                    <div>
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
                        <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
                    </div>
                </div>
            </div><!--/#ace-settings-container-->
        </div><!--/.main-content-->
    </div><!--/.main-container-->

<!--basic scripts-->    
    <script type="text/javascript">
            if("ontouchend" in document) document.write("<script src='${resource(dir:'assets/js',file:'jquery.mobile.custom.min.js')}'>"+"<"+"/script>");
    </script>
    <script src="${resource(dir:'assets/js',file:'bootstrap.min.js')}"></script>
    <!--page specific plugin scripts-->
    <!--[if lte IE 8]>
      <script src="${resource(dir:'assets/js',file:'excanvas.min.js')}"></script>
    <![endif]-->

    <script src="${resource(dir:'assets/js',file:'jquery.ui.touch-punch.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'bootstrap-datepicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'moment.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'daterangepicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js/markdown',file:'markdown.min.js')}"></script>
    <script src="${resource(dir:'assets/js/markdown',file:'bootstrap-markdown.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.hotkeys.min.js')}"></script>    
    <script src="${resource(dir:'assets/js',file:'bootbox.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.validationEngine-es.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.validationEngine.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'bootstrap-wysiwyg.min.js')}"></script>   
    <script src="${resource(dir:'assets/js/ace',file:'elements.wysiwyg.js')}"></script>   

    <script src="${resource(dir:'js',file:'highcharts.js')}"></script>
    <script src="${resource(dir:'js/modules',file:'exporting.js')}"></script>

  <!--ace scripts-->
    <script src="${resource(dir:'assets/js',file:'ace-elements.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'ace.min.js')}"></script>
    <script type="text/javascript">    

        $('#editor1').ace_wysiwyg();
        
        (function($) {
        $.fn.datepicker.dates['es'] = {
        days: ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"],
        daysShort: ["Dom", "Lun", "Mar", "Mié", "Jue", "Vie", "Sáb", "Dom"],
        daysMin: ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa", "Do"],
        months: ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"],
        monthsShort: ["Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul", "Ago", "Sep", "Oct", "Nov", "Dic"],
        today: "Hoy"
        };
        $('.date-picker').datepicker({
        format: 'dd/mm/yyyy',
        language: 'es'
        }).next().on(ace.click_event, function(){
        $(this).prev().focus();
        });
        $('#rangoDeFecha').daterangepicker({ 
        format: 'DD/MM/YYYY',
        language: 'es'
        }
        ).prev().on(ace.click_event, function(){
        $(this).next().focus();
        });
        $('#rangoDeFechaRegistro').daterangepicker({ 
        format: 'DD/MM/YYYY',
        locale: 'es'
        }
        ).prev().on(ace.click_event, function(){
        $(this).next().focus();
        });
        $("#btnLimpiar").click(function() {
        $("#fechaLimite").val("");
        });

        $('#containerTotalDeTurnos').highcharts({
        chart: { type: 'column' },
        title: { text: 'Total de Turnos' },
        xAxis: { categories: [ 'Total', 'Resueltos', 'Pendientes', 'Atrasados', 'Prioridad Urgente', 'Prioridad Normal'] },
        yAxis: { min: 0, title: { text: 'Cantidad de Turnos' } },
        plotOptions: { column: { pointPadding: 0.2, borderWidth: 0,
        cursor: 'pointer',    
        point: {
        events: {
        click: function() {
        //alert ('Category: '+ this.category +', value: '+ this.y);
        $("#barra").val(this.category);
        document.getElementById("asdas").submit();
        }
        }
        }
        }  
        },
        series: [{
        name: 'Mis Turnos',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalMisTurnos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosMisTurnos:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesMisTurnos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosMisTurnos:0}
        ]
        }, {
        name: 'Compartidos',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalCompartidos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosCompartidos:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesCompartidos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosCompartidos:0}
        ]
        }, {
        name: 'Turnados',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalTurnados:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosTurnados:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesTurnados:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosTurnados:0}
        ]
        }, {
        name: 'Prioridad Urgente',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalPrioridadUrgente:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosPrioridadUrgente:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesPrioridadUrgente:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosPrioridadUrgente:0}
        ]
        }, {
        name: 'Prioridad Normal',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalPrioridadNormal:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosPrioridadNormal:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesPrioridadNormal:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosPrioridadNormal:0}
        ]
        }]
        });

        $('#containerTurnosPorFecha').highcharts({
        chart: { type: 'column' },
        title: { text: 'Turnos Por Rango de Fecha' },
        subtitle: {
        text: 'De: Hasta:'
        },
        xAxis: { categories: [ 'Total', 'Resueltos', 'Pendientes', 'Atrasados'] },
        yAxis: { min: 0, title: { text: 'Cantidad de Turnos' } },
        tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y}</b></td></tr>',
                footerFormat: '</table>',
        shared: true,
        useHTML: true
        },
        plotOptions: { column: { pointPadding: 0.2, borderWidth: 0 } },
        series: [{
        name: 'Mis Turnos',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalMisTurnos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosMisTurnos:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesMisTurnos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosMisTurnos:0}
        ]
        }, {
        name: 'Compartidos',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalCompartidos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosCompartidos:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesCompartidos:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosCompartidos:0}
        ]
        }, {
        name: 'Turnados',
                data: [ ${turnosPorFechaBean?turnosPorFechaBean?.totalTurnados:0}, ${turnosPorFechaBean?turnosPorFechaBean?.resueltosTurnados:0}, 
        ${turnosPorFechaBean?turnosPorFechaBean?.pendientesTurnados:0}, ${turnosPorFechaBean?turnosPorFechaBean?.atrasadosTurnados:0}
        ]
        }]
        });
        })(jQuery);
        $(document).ready(function() {
        // binds form submission and fields to the validation engine
        $("#myForm").validationEngine();
        });
    </script>
    <g:javascript library="application"/>
<r:layoutResources />    
</body>
</html>
