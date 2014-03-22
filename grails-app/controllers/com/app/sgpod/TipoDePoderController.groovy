package com.app.sgpod


class TipoDePoderController {
    /**
    * Método para mostrar las categorias de un tipo de poder.
    */
    def ajaxGetCategorias = {
        def tipoDePoder = TipoDePoder.get(params.tipoDePoder.id)
        //se obtienen 2 veces la listas para ordenar los objetos
        def lista1 = tipoDePoder.categorias.id.sort()
        def lista2 = CategoriaDeTipoDePoder.getAll(lista1)        
        render (template:'categoriaSelection', model: [categorias: lista2])
    } 
    /**
    * metodo para ocultar campo de poder solicitado, solo cuando el tipo de poder sea ESPECIAL
    */
    def ajaxGetIdCategoria = {
        
        def ocultarCampo = false    
        def numero = CategoriaDeTipoDePoder.get(params.categoriaDeTipoDePoder.id)        
        if(numero.id == 11){
            ocultarCampo = true            
        }        
        render (template:'ocultar', model: [ocultarCampo: ocultarCampo])        
    }
}
