<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />    
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>

        <div class="page-header position-relative">
            <h1>
                <g:message code="default.list.label" args="[entityName]" />
            </h1>
            <div class="btn-group">
                <g:link class="btn btn-small tip-bottom" action="create">
                    <i class="icon-file"></i>
                    <g:message code="default.new.label" args="[entityName]" />
                </g:link>
            </div>
        </div><!--/.page-header-->


        <div class="container-fluid">
            <br/>
            <g:if test="\${flash.message}">
                <div class="alert">
                    <strong>¡Atención!</strong> \${flash.message}
                </div>
            </g:if>
            <br/>
            <div class="widget-content nopadding">
                <table class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
                          allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
                          props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
                          Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
                          props.eachWithIndex { p, i ->
                              if (i < 6) {
        if (p.isAssociation()) { %>
                            <th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
                                <%      } else { %>
                                <g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
                                <%  }   }   } %>
                        </tr>
                    </thead>
                    <tbody>
                        <g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
                            <tr class="\${(i % 2) == 0 ? 'even' : 'odd'}">
                                <%  props.eachWithIndex { p, i ->
            if (i == 0) { %>
                                <td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
                                <%      } else if (i < 6) {
                if (p.type == Boolean || p.type == boolean) { %>
                                <td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
                                <%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
                                <td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>
                                <%          } else { %>
                                <td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
                                <%  }   }   } %>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>        
            <div class="pagination pull-right no-margin">
                <g:paginate total="\${${propertyName}Total}" />
            </div>
        </div>
    </body>
</html>
