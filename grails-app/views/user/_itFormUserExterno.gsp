
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

<div class="control-group fieldcontain ${hasErrors(bean: it, field: 'nombreDespachoExterno', 'error')}">
    <label for="nombreDespachoExterno" class="control-label">
        <g:message code="convenio.nombreDespachoExterno.label" default="Despacho" />        
    </label>
    <div class="controls">
        <g:textArea class="span8" name="nombreDespachoExterno" maxlength="5000" value="${it?.nombreDespachoExterno}" autocomplete="off"/>
    </div>
</div>