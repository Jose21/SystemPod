package com.app.sgpod


class TipoDePoderController {

    def ajaxGetCategorias = {
        def tipoDePoder = TipoDePoder.get(params.tipoDePoder.id)
        render (template:'categoriaSelection', model: [categorias: tipoDePoder.categorias])
    }       
}
