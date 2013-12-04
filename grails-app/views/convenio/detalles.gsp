<%@ page import="com.app.sgcon.Convenio;java.text.SimpleDateFormat" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <g:set var="entityName" value="${message(code: 'convenio.label', default: 'Convenio')}" />    
        <title><g:message code="default.detalles.label" args="[entityName]" /></title>
    </head>
    <body onload="actualizaReloj()">
        <table  WIDTH="100%">
            <td WIDTH="20%" style="text-align:right">                  
                
            </td>
            <td WIDTH="60%"> 
                <h2 style="text-align:center">Datos del Convenio</h2>
            </td>
            <td WIDTH="20%">
                <h2 style="text-align:center">SGCon</h2>
            </td>                
        </table>
        <HR SIZE=5 WIDTH="100%" COLOR="#ff0000" ALIGN = left>
        <table WIDTH="100%">
            <tr id="Fecha_Reloj" style="text-align:right"></tr> 
        </table>
        <table>
            <tr>
                <th style="text-align: right"><g:message code="convenio.id.label"  default="Identificador Interno:" /></th>
                <td style="text-align: left">${convenioInstance?.id}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.numeroDeConvenio.label" default="Número de Convenio:" /></th>
                <td style="text-align: left">${convenioInstance?.numeroDeConvenio}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.objeto.label" default="Objeto:" /></th>
                <td style="text-align: left">${convenioInstance?.objeto}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.sustentoNormativo.label" default="Sustento Normativo:" /></th>
                <td style="text-align: left">${convenioInstance?.sustentoNormativo}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.dateCreated.label" default="Fecha de Registro:" /></th>
                <td style="text-align: left">${convenioInstance?.dateCreated}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.vigencia.label" default="Fecha de Vigencia:" /></th>
                <td style="text-align: left">${convenioInstance?.vigencia}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.fechaDeFirma.label" default="Fecha De Firma:" /></th>
                <td style="text-align: left">${convenioInstance?.dateCreated}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.status.label" default="Status:" /></th>
                <td style="text-align: left">${convenioInstance?.status}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.tipoDeConvenio.label" default="Tipo Del Convenio:" /></th>
                <td style="text-align: left">${convenioInstance?.tipoDeConvenio}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.institucion.label" default="Institucion:" /></th>
                <td style="text-align: left">${convenioInstance?.institucion}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.compromisos.label" default="Compromisos:" /></th>
                <td style="text-align: left">${convenioInstance?.compromisos}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="convenio.nombreDeCopiaElectronica.label" default="Firma Del Convenio:" /></th>
                <td style="text-align: left">${convenioInstance?.nombreDeCopiaElectronica}</td>
            </tr>
            <th style="text-align: right"><g:message code="convenio.firmantes.label" default="Responsables:" /></th>
                <g:if test="${convenioInstance.responsables}">
                <tr>
                    <th></th>
                    <th style="text-align:left"><g:message code="convenio.responsables.label" default="Nombre" /></th>
                    <th style="text-align:left"><g:message code="convenio.responsables.label" default="Institución" /></th>
                </tr>
                <g:each in ="${convenioInstance.responsables}" var="responsable">
                    <g:if test="${responsable.institucion && responsable.institucion.toUpperCase().contains("INFONAVIT")}">
                        <tr>
                <td></td>
                            <td>${responsable.nombre}</td>
                            <td>${responsable.institucion}</td>
                        </tr>
                    </g:if>
                </g:each>
                <g:each in ="${convenioInstance.responsables}" var="responsable">
                    <g:if test="${!responsable.institucion  || !responsable.institucion.toUpperCase().contains("INFONAVIT")}">
                        <tr>
                <td></td>
                            <td>${responsable.nombre}</td>
                            <td>${responsable.institucion}</td>
                        </tr>
                    </g:if>
                </g:each>
            </g:if>
            <tr><th style="text-align: right"><g:message code="convenio.firmantes.label" default="Firmantes:" /></th></tr>
                <g:if test="${convenioInstance.firmantes}">
                    <tr>
                    <th></th>
                    <th style="text-align:left"><g:message code="convenio.responsables.label" default="Nombre" /></th>
                    <th style="text-align:left"><g:message code="convenio.responsables.label" default="Institución" /></th>
                </tr>
                    <g:each in ="${convenioInstance.firmantes}" var="firmante">
                        <g:if test="${firmante.institucion && firmante.institucion.toUpperCase().contains("INFONAVIT")}">
                        <tr>
                            <td></td>
                            <td>${firmante.nombre}</td>
                            <td>${firmante.institucion}</td>
                        </tr>
                    </g:if>
                </g:each>
                <g:each in ="${convenioInstance.firmantes}" var="firmante">
                    <g:if test="${!firmante.institucion || !firmante.institucion.toUpperCase().contains("INFONAVIT")}">
                        <tr>
                            <td></td>
                            <td>${firmante.nombre}</td>
                            <td>${firmante.institucion}</td>
                        </tr>
                    </g:if>
                </g:each>
            </g:if>
            <tr>
                <td></td>
                <td></td>
                <td style="text-align: right">
                    <form><input id="printpagebutton" type="button" value=" Imprimir los datos "
                        onclick="printpage()" />
                    </form>
                </td>
            </tr>
        </table>
        <script type="text/javascript">
            function printpage() {
            var printButton = document.getElementById("printpagebutton");
            printButton.style.visibility = 'hidden';
            window.print()
            printButton.style.visibility = 'visible';
            }
            /* Funcion para mostrar fecha y hora actual*/
            function actualizaReloj(){ 
            marcacion = new Date() 
            Hora = marcacion.getHours() 
            Minutos = marcacion.getMinutes() 
            Segundos = marcacion.getSeconds() 
            if (Hora<=9)
            Hora = "0" + Hora
            if (Minutos<=9)
            Minutos = "0" + Minutos
            if (Segundos<=9)
            Segundos = "0" + Segundos
            var Dia = new Array("Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
            var Mes = new Array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");
            var Hoy = new Date();
            var Anio = Hoy.getFullYear();
            var Fecha = Dia[Hoy.getDay()] + " " + Hoy.getDate() + " de " + Mes[Hoy.getMonth()] + " de " + Anio + ", ";
            var Inicio, Script, Final, Total
            Inicio = ""
            Script = Fecha + Hora + ":" + Minutos + ":" + Segundos
            Final = "</font>"
            Total = Inicio + Script + Final
            document.getElementById('Fecha_Reloj').innerHTML = Total 
            }
        </script>
    </body>
</html>
