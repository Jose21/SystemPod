<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <!-- If you delete this meta tag, Half Life 3 will never be released. -->
        <meta name="viewport" content="width=device-width" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>ZURBemails</title>
        <link href="${resource(dir:'css',file:'email.css')}" rel="stylesheet" />        
    </head>
    <body bgcolor="#FFFFFF">
    <!-- HEADER -->
        <table class="head-wrap" bgcolor="red">
            <tr>
                <td></td>
                <td class="header container" >
                    <div class="content">
                        <table bgcolor="red">
                            <tr>
                                <td style="font-size: x-large; color:white;">
                                    S G C o n
                                </td>
                                <td style="text-align: right; color:white; fon">
                                    Notificaciones
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td></td>
            </tr>
        </table><!-- /HEADER -->
        <!-- BODY -->
        <table class="body-wrap">
            <tr>
                <td></td>
                <td class="container" bgcolor="#FFFFFF">
                    <div class="content">
                        <table>
                            <tr>
                                <td>
                                    <h3>Hola, ${usuarioInstance?.nombre}</h3>
                                    <p class="lead">
                                        ${mensaje}
                                    </p>
                                    <table class="social" width="100%">
                                        <tr>
                                            <td>
                                                <table align="left" class="column">
                                                    <tr>
                                                        <td>				
                                                            <h5 class="">Connect with Us:</h5>
                                                            <p class=""><a href="#" class="soc-btn fb">Facebook</a> <a href="#" class="soc-btn tw">Twitter</a> <a href="#" class="soc-btn gp">Google+</a></p>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table align="left" class="column">
                                                    <tr>
                                                        <td>				
                                                            <h5 class="">Contact Info:</h5>												
                                                            <p>Phone: <strong>408.341.0600</strong><br/>
                                                                Email: <strong><a href="emailto:hseldon@trantor.com">hseldon@trantor.com</a></strong></p>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <span class="clear"></span>	
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
        <!--<table class="footer-wrap">
            <tr>
                <td></td>
                <td class="container">
                    <div class="content">
                        <table>
                            <tr>
                                <td align="center">
                                    <p>
                                        <a href="#">Terms</a> |
                                        <a href="#">Privacy</a> |
                                        <a href="#"><unsubscribe>Unsubscribe</unsubscribe></a>
                                    </p>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td></td>
            </tr>
        </table>
        -->
    </body>
</html>