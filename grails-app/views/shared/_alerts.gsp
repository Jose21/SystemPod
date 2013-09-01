<g:if test='${flash.message}'>
  <div class="alert alert-block alert-success">
    <button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button>
    <p> <i class="icon-ok"></i> ${flash.message} </p>
  </div>
</g:if>
<g:if test='${flash.warn}'>
  <div class="alert alert-block alert-warning">
    <button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button>
    ${flash.warn}
  </div>
</g:if>
<g:if test='${flash.info}'>
  <div class="alert alert-block alert-info">
    <button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button>
    ${flash.info}
  </div>
</g:if>
<g:if test='${flash.error}'>
  <div class="alert alert-error">
    <button type="button" class="close" data-dismiss="alert"><i class="icon-remove"></i></button>
    <p> <i class="icon-remove"></i> ${flash.error} </p>
  </div>
</g:if>