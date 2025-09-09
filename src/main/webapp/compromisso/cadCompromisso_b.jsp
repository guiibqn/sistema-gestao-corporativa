<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><s:text name="label.titulo.pagina.consulta.compromisso"/></title>
        <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
        <link rel='stylesheet' href='${cssUrl}'>
    </head>
    <body class="bg-secondary">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand text-uppercase" href="#"><s:text name="label.titulo.pagina"/></a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <s:url action="todosFuncionarios" var="urlFunc"/>
                            <s:a cssClass="nav-link" href="%{urlFunc}"><s:text name="label.menu.funcionarios"/></s:a>
                        </li>
                        <li class="nav-item">
                            <s:url action="todosAgendas" var="urlAgenda"/>
                            <s:a cssClass="nav-link" href="%{urlAgenda}"><s:text name="label.menu.agendas"/></s:a>
                        </li>
                         <li class="nav-item">
                            <s:url action="todosCompromissos" var="urlComp"/>
                            <s:a cssClass="nav-link active" href="%{urlComp}"><s:text name="label.menu.compromissos"/></s:a>
                        </li>
                        <li class="nav-item">
	                        <s:url action="indexRelatorio" var="urlRelat"/>
	                        <s:a cssClass="nav-link" href="%{urlRelat}"><s:text name="label.menu.relatorio"/></s:a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
	
		<div class="container mt-4">
			<div class="row">
				<div class="col">
					<s:if test="hasActionMessages()"><div class="alert alert-success"><s:actionmessage/></div></s:if>
					<s:if test="hasActionErrors()"><div class="alert alert-danger"><s:actionerror/></div></s:if>
				</div>
			</div>
		
			<div class="card mt-3">
                <div class="card-header"><h5 class="card-title mb-0"><strong><s:text name="label.titulo.pagina.consulta.compromisso"/></strong></h5></div>
                <div class="card-body">
					<table class="table table-striped table-hover align-middle">
						<thead class="table-dark text-uppercase">
							<tr>
                                <th><s:text name="label.id.funcionario"/></th>
                                <th><s:text name="label.funcionario"/></th>
                                <th><s:text name="label.id.agenda"/></th>
                                <th><s:text name="label.agenda"/></th>
                                <th><s:text name="label.data"/></th>
                                <th><s:text name="label.hora"/></th>
                                <th class="text-end"><s:text name="label.acao"/></th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="compromissos">
								<tr>
									<td><s:property value="idFuncionario"/></td>
									<td><s:property value="nomeFuncionario"/></td>
									<td><s:property value="idAgenda"/></td>
									<td><s:property value="nomeAgenda"/></td>
									<td><s:property value="data"/></td>
									<td><s:property value="hora"/></td>
									<td class="text-end">
										<s:url action="editarCompromissos" var="editarUrl">
											<s:param name="compromissoVo.rowid" value="rowid"/>
										</s:url>
										<s:a href="%{editarUrl}" class="btn btn-warning text-white btn-sm text-uppercase"><s:text name="label.editar"/></s:a>

										<button type="button" class="btn btn-danger btn-sm text-uppercase" data-bs-toggle="modal" 
											data-bs-target="#confirmarExclusao" 
											data-rowid="<s:property value='rowid'/>"
											data-nome="<s:property value='nomeFuncionario'/>">
											<s:text name="label.excluir"/>
										</button>
									</td>
								</tr>
							</s:iterator>
						</tbody>
						<tfoot class="table-secondary">
							<tr>
								<td colspan="7">
									<s:url action="novoCompromissos" var="novoUrl"/>
									<s:a href="%{novoUrl}" class="btn btn-success text-uppercase"><s:text name="label.novo"/></s:a>
								</td>
							</tr>
						</tfoot>				
					</table>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="confirmarExclusao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title"><s:text name="label.modal.titulo"/></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		      <div class="modal-body">
		      	<span><s:text name="label.modal.corpo.compromisso"/></span>
		      	<span id="compromissoInfo" class="fw-bold d-block mt-2"></span>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary text-uppercase" data-bs-dismiss="modal"><s:text name="label.nao"/></button>
		        <s:form id="formExcluir" action="excluirCompromissos" method="POST" cssStyle="display: inline;">
		        	<s:hidden id="rowidExcluir" name="compromissoVo.rowid" />
		        	<button type="submit" class="btn btn-danger text-uppercase"><s:text name="label.sim"/></button>
		        </s:form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl" />
        <script src="${jsUrl}"></script>
		<script>
			var confirmarExclusaoModal = document.getElementById('confirmarExclusao');
			if(confirmarExclusaoModal) {
				confirmarExclusaoModal.addEventListener('show.bs.modal', function (event) {
					var button = event.relatedTarget;
					var rowid = button.getAttribute('data-rowid');
					var nome = button.getAttribute('data-nome');
					document.getElementById('rowidExcluir').value = rowid;
					document.getElementById('compromissoInfo').textContent = nome;
				});
			}
		</script>
	</body>
</html>