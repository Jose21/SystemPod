<%@ page import="com.app.sgtask.Tarea;java.text.SimpleDateFormat" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <g:set var="entityName" value="${message(code: 'tarea.label', default: 'Tarea')}" />    
        <title><g:message code="default.detalles.label" args="[entityName]" /></title>
    </head>
    <body onload="actualizaReloj()">
        <table  WIDTH="100%">
            <td WIDTH="20%" style="text-align:right">                  
                <img src="/sgcon/static/images/infonavit.jpg" width="64px" height="64px" />
            </td>
            <td WIDTH="60%"> 
                <h2 style="text-align:center">Datos del Turno</h2>
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
                <th style="text-align: right"><g:message code="tarea.id.label"  default="Número de Turno: " /></th>
                <td style="text-align: left">${tareaInstance?.id}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.nombre.label" default="Nombre: " /></th>
                <td style="text-align: left">${tareaInstance?.nombre}</td
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.grupo.label" default="Compartida Con: " /></th>
                <td style="text-align: left">${tareaInstance?.grupo}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.dateCreated.label" default="Fecha de Registro: " /></th>
                <td style="text-align: left">${tareaInstance?.dateCreated}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.responsable.label" default="Responsable: " /></th>
                <td style="text-align: left">${tareaInstance?.responsable}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.descripcion.label" default="Descripción: " /></th>
                <td style="text-align: left">${tareaInstance?.descripcion}</td>
            </tr>
            <tr>
                <th style="text-align: right"><g:message code="tarea.fechaLimite.label" default="Fecha Limite del Turno: "  /></th>
                <td style="text-align: left">${tareaInstance?.fechaLimite}</td>
            </tr>
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
