package com.app.sgpod

/**
* Domian class que contiene la información sobre la categoría del tipo de poder de un otorgamiento o una revocación de poder.
*/
class CategoriaDeTipoDePoder {
    /**
    * Nombre de  la categoría.
    */
    String nombre
    /**
    * Pertenece a la domain class tipoDePoder.
    */
    static belongsTo = [tipoDePoder:TipoDePoder]

    static constraints = {
    }
}
