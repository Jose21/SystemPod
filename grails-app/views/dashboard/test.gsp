<!--
  To change this template, choose Tools | Templates
  and open the template in the editor.
-->

<%@ page contentType="text/html;charset=UTF-8" %>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Sample title</title>

    <link href="${resource(dir:'assets/css',file:'bootstrap.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'bootstrap-responsive.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'font-awesome.min.css')}" rel="stylesheet" />
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

    <link href="${resource(dir:'assets/css',file:'ace.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'ace-responsive.min.css')}" rel="stylesheet" />
    <link href="${resource(dir:'assets/css',file:'ace-skins.min.css')}" rel="stylesheet" />
    <!--[if lte IE 8]>
      <link rel="stylesheet" href="${resource(dir:'assets/css',file:'ace-ie.min.css')}" />
    <![endif]-->            
    <script src="${resource(dir:'assets/js',file:'ace-extra.min.js')}"></script>
  </head>
  <body>
    <div class="main-container container-fluid">
      <div class="main-content">
        <div class="page-content">

          <div class="row-fluid">
            <div class="span12">
              <!--PAGE CONTENT BEGINS-->


              <div class="row-fluid">
                <label for="id-date-picker-1">Date Picker</label>
              </div>

              <div class="control-group">
                <div class="row-fluid input-append">
                  <input class="span10 date-picker" id="id-date-picker-1" type="text" data-date-format="dd-mm-yyyy" />
                  <span class="add-on">
                    <i class="icon-calendar"></i>
                  </span>
                </div>
              </div>

              <hr />
              <div class="row-fluid">
                <label for="id-date-range-picker-1">Date Range Picker</label>
              </div>

              <div class="control-group">
                <div class="row-fluid input-prepend">
                  <span class="add-on">
                    <i class="icon-calendar"></i>
                  </span>

                  <input class="span10" type="text" name="date-range-picker" id="id-date-range-picker-1" />
                </div>
              </div>

              <hr />
              <div class="row-fluid">
                <label for="timepicker1">Time Picker</label>
              </div>

              <div class="control-group">
                <div class="input-append bootstrap-timepicker">
                  <input id="timepicker1" type="text" class="input-small" />
                  <span class="add-on">
                    <i class="icon-time"></i>
                  </span>
                </div>
              </div>


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
    <!--[if lte IE 8]>
      <script src="${resource(dir:'assets/js',file:'excanvas.min.js')}"></script>
    <![endif]-->
    <script src="${resource(dir:'assets/js',file:'jquery-ui-1.10.3.custom.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.ui.touch-punch.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'chosen.jquery.min.js')}"></script>
    <script src="${resource(dir:'assets/js/fuelux',file:'fuelux.spinner.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'bootstrap-datepicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'bootstrap-timepicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'moment.min.js')}"></script>
    <script src="${resource(dir:'assets/js/date-time',file:'daterangepicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'bootstrap-colorpicker.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.knob.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.autosize-min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.inputlimiter.1.3.1.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'jquery.maskedinput.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'bootstrap-tag.min.js')}"></script>
    <!--ace scripts-->
    <script src="${resource(dir:'assets/js',file:'ace-elements.min.js')}"></script>
    <script src="${resource(dir:'assets/js',file:'ace.min.js')}"></script>
    <!--inline scripts related to this page-->
    <script type="text/javascript">
      jQuery(function($) {
        $('.date-picker').datepicker().next().on(ace.click_event, function(){
          $(this).prev().focus();
        });
	$('#id-date-range-picker-1').daterangepicker().prev().on(ace.click_event, function(){
          $(this).next().focus();
	});
	$('#timepicker1').timepicker({
          minuteStep: 1,
          showSeconds: true,
          showMeridian: false
	})
      });
    </script>
  </body>
</html>
