<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <!-- If you delete this meta tag, Half Life 3 will never be released. -->
        <meta name="viewport" content="width=device-width" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <title>SGCon: Notificación de Poderes</title>
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
                                    <h3>Hola, ${usuarioInstance?.firstName}</h3>
                                    <p class="callout">
                                        ${message}
                                    </p>
                                    <p>
                                        <table style="font-size: medium">
                                            <tr>
                                                <td>Folio</td>
                                                <td>${otorgamientoDePoder?.id}-O</td>
                                            </tr>                                                                                        
                                            <tr>
                                                <td>Fecha de Creación</td>
                                                <td><g:formatDate format="dd-MMM-yyyy HH:mm" date="${otorgamientoDePoder?.registroDeLaSolicitud}"/></td>
                                            </tr>
                                            <tr>
                                                <td>Fecha Vigencia</td>
                                                <td><g:formatDate format="dd-MMM-yyyy HH:mm" date="${otorgamientoDePoder?.fechaVencimiento}"/></td>
                                            </tr>
                                            <tr>
                                                <td>Solicitado Por</td>
                                                <td>${otorgamientoDePoder?.creadaPor}</td>
                                            </tr>
                                        </table>
                                    </p> <br/>
                                    <table class="social" style="background-color: white" width="100%">
                                        <tr>
                                            <td>
                                                <p class="">
                                                    <a href="http://192.168.1.3:8080/sgcon" class="soc-btn fb">Ir a la aplicación</a>                                                      
                                                </p>
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