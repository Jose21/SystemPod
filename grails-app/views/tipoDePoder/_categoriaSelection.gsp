<g:select name="categoria.id" from="${categorias}" optionValue="nombre" optionKey="id" name="categoriaDeTipoDePoder.id"
            value="${otorgamientoDePoderInstance?.categoriaDeTipoDePoder?.id}" required=""
            onchange="${remoteFunction(
            controller:'tipoDePoder', 
            action:'ajaxGetIdCategoria', 
            params:'\'categoriaDeTipoDePoder.id=\' + this.value', 
            update:'ocultar'
            )}"/>
