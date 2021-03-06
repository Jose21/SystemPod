package com.app.sgcon

import com.pogos.ConveniosPorFechaBean
import java.text.SimpleDateFormat
import com.app.sgcon.Convenio
import com.pogos.BusquedaBean
import com.app.sgcon.Persona

class ReporteDeConvenioController {
    
    def springSecurityService
    
    def conveniosPorFechaInit () {
        render (view:"conveniosPorFecha")
    }
    /**
    * Método que genera los listados sobre convenios en el sistema. Posteriormente genera los reportes ejecutivos.
    */
    def conveniosPorFecha () {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        def conveniosPorFechaBean = new ConveniosPorFechaBean()
        def rangoDeFecha = null
        def fechaInicio = null
        def fechaFin = null
        def busquedaBean = null
        def convenioInstanceList = []
        //def totalConvenios = null
        
        if (params.rangoDeFecha != "") {
            flash.warn = null
            rangoDeFecha = params.rangoDeFecha
            fechaInicio = sdf.parse(rangoDeFecha.split("-")[0].trim())
            fechaFin = sdf.parse(rangoDeFecha.split("-")[1].trim())
            busquedaBean = new BusquedaBean()        
            busquedaBean.fechaInicio = fechaInicio
            busquedaBean.fechaFin = fechaFin
            //Total de Convenios
            def totalConvenios = Convenio.findAllByFechaDeFirmaBetween(busquedaBean.fechaInicio, busquedaBean.fechaFin,, [sort: "id", order: "asc"])
            conveniosPorFechaBean.totalConvenios = totalConvenios.size()
            log.info "Que me trae en mi consulta total " + totalConvenios
            
            //Total de Convenios contraidos por el infonavit
            def totalConveniosContraidos = Convenio.findAllByFechaDeFirmaBetweenAndInstitucionIlike(
                busquedaBean.fechaInicio, busquedaBean.fechaFin,("%infonavit%"),, [sort: "id", order: "asc"])
            //totalConveniosContraidos = Convenio.findAllByInstitucionIlike("%infonavit%", [sort: "id"])
            conveniosPorFechaBean.totalConveniosContraidos = totalConveniosContraidos.size()
            log.info "Que me trae en mi consulta contraidos" + totalConveniosContraidos
            
            //Total de Convenios NO contraidos por el Infonavit
            def c= Convenio.createCriteria()
            def totalConveniosNoContraidos = c.list{
                between("fechaDeFirma", busquedaBean.fechaInicio, busquedaBean.fechaFin)
                and{
                    not{
                        ilike("institucion", "%infonavit%")     
                    }
                }
                order("id", "asc")
            }
            conveniosPorFechaBean.totalConveniosNoContraidos = totalConveniosNoContraidos.size()
            log.info "que me trae wn mi consulta no contraidos::" + totalConveniosNoContraidos
            
            //Titulo para personalizar grafica 
            conveniosPorFechaBean.title ="Resultado Para el Periodo: " + rangoDeFecha
            
            if(params.barraConvenios == "Total"){
                conveniosPorFechaBean.convenios = totalConvenios
                conveniosPorFechaBean.conveniosContraidos = totalConveniosContraidos
                conveniosPorFechaBean.conveniosNoContraidos = totalConveniosNoContraidos
            }
            
            [ conveniosPorFechaBean : conveniosPorFechaBean, rangoDeFecha : rangoDeFecha]
            
        } else {
            flash.warn = "Debe elegir un rango de fechas válido."
        }
    }
    /**
    * Método para realizar un listado de los convenios totales.
    */
    def totalDeConvenios () {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy")
        
        def conveniosPorFechaBean = new ConveniosPorFechaBean()
        
        //Total de Convenios
        def totalConveniosQuery = Convenio
        def totalConvenios = totalConveniosQuery.list(sort:"id")
        conveniosPorFechaBean.totalConvenios = totalConvenios.size()        
        //Total de Convenios contraidos por el Infonavit
        def totalConveniosContraidos = Convenio.findAllByInstitucionIlike("%infonavit%", [sort: "id"])
        conveniosPorFechaBean.totalConveniosContraidos = totalConveniosContraidos.size()
        log.info "convenios contraidos::" + totalConveniosContraidos
        
        //Total de Convenios NO contraidos por el Infonavit
        def c= Convenio.createCriteria()
        def totalConveniosNoContraidos = c.list{
            not{
                ilike("institucion", "%infonavit%")
            }
            order("id", "asc")
        }
        conveniosPorFechaBean.totalConveniosNoContraidos = totalConveniosNoContraidos.size()
        log.info "convenios no contraidos::" + totalConveniosNoContraidos
        
        //Titulo para personalizar grafica 
        def title = "Total de Convenios"
        conveniosPorFechaBean.title = "Total de Convenios"
        log.info "titulo de la grafica::" + title
        
        if(params.barraConvenios == "Total"){
            conveniosPorFechaBean.convenios = totalConvenios
            conveniosPorFechaBean.conveniosContraidos = totalConveniosContraidos
            conveniosPorFechaBean.conveniosNoContraidos = totalConveniosNoContraidos
        }
        
        [ conveniosPorFechaBean : conveniosPorFechaBean ]
    }
    
}
