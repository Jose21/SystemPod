

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'firstName', 'error')} required">
    <label for="firstName" class="control-label">
        <g:message code="user.firstName.label" default="Nombre" />
        <span class="required-indicator">*</span>
    </label>
    <div class="controls">
        <g:textField name="firstName" required="" value="${it?.firstName}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'lastName', 'error')} ">
    <label for="lastName" class="control-label">
        <g:message code="user.lastName.label" default="Apellidos" />
    </label>
    <div class="controls">
        <g:textField name="lastName" value="${it?.lastName}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'email', 'error')} ">
    <label for="email" class="control-label">
        <g:message code="user.email.label" default="Correo Electrónico" />
    </label>
    <div class="controls">
        <g:textField name="email" value="${it?.email}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'notaria_titular', 'error')} ">
    <label for="notaria_titular" class="control-label">
        <g:message code="user.notaria_titular.label" default="Notaria Titular" />
    </label>
    <div class="controls">
        <g:textField name="notaria_titular" value="${it?.notaria_titular}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'notaria_numero', 'error')} ">
    <label for="notaria_numero" class="control-label">
        <g:message code="user.notaria_numero.label" default="Notaria" />
    </label>
    <div class="controls">
        <g:textField name="notaria_numero" value="${it?.notaria_numero}"/>
    </div>
</div>

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'notaria_entidad', 'error')} ">
    <label for="notaria_entidad" class="control-label">
        <g:message code="user.notaria_entidad.label" default="Entidad" />
    </label>
    <div class="controls">
        <g:textField name="notaria_entidad" value="${it?.notaria_entidad}"/>
    </div>
</div>

<g:if test="${params.solicitante == true}">
    <div class="control-group fieldcontain ${hasErrors(bean: it, field: 'nombreDespachoExterno', 'error')} ">
        <label for="nombreDespachoExterno" class="control-label">
            <g:message code="user.nombreDespachoExterno.label" default="Despacho" />
        </label>
        <div class="controls">
            <g:textField name="nombreDespachoExterno" value="${it?.nombreDespachoExterno}"/>
        </div>
    </div>
</g:if>


