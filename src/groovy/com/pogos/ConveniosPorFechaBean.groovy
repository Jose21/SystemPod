package com.pogos

class ConveniosPorFechaBean {
    
    //Convenios
    Integer totalConvenios = 0
    // Contraidos por el infonavit
    Integer totalConveniosContraidos = 0
    // Contraidos no por el infonavit
    Integer totalConveniosNoContraidos = 0
    // Titulo de la grafica
    String title
    //Lista de resultados para generar consultas en las graficas
    List convenios
    List conveniosContraidos
    List conveniosNoContraidos
}

