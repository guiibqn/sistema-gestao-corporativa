<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><s:text name="label.titulo.pagina.consulta.agenda"/></title>
		<link rel='stylesheet' href="webjars/bootstrap/5.1.3/css/bootstrap.min.css">
    </head>
    <body class="bg-secondary">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand text-uppercase" href="#"><s:text name="label.titulo.pagina"/></a>
                <div class="collapse navbar-collapse">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <s:url action="todosFuncionarios" var="urlFunc"/>
                            <s:a class="nav-link" href="%{urlFunc}"><s:text name="label.menu.funcionarios"/></s:a>
                        </li>
                        <li class="nav-item">
                            <s:url action="todosAgendas" var="urlAgenda"/>
                            <s:a class="nav-link active" href="%{urlAgenda}"><s:text name="label.menu.agendas"/></s:a>
                        </li>
                         <li class="nav-item">
                            <s:url action="todosCompromissos" var="urlComp"/>
                            <s:a class="nav-link" href="%{urlComp}"><s:text name="label.menu.compromissos"/></s:a>
                        </li>
                        <li class="nav-item">
	                        <s:url action="indexRelatorio" var="urlRelat"/>
	                        <s:a class="nav-link" href="%{urlRelat}"><s:text name="label.menu.relatorio"/></s:a>
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
                <div class="card-header"><h5 class="card-title mb-0"><strong><s:text name="label.titulo.pagina.consulta.agenda"/></strong></h5></div>
                <div class="card-body">
					<table class="table table-striped table-hover align-middle">
						<thead class="table-dark text-uppercase">
							<tr>
								<th><s:text name="label.id"/></th>
								<th><s:text name="label.nome"/></th>
								<th><s:text name="label.periodo.disponivel"/></th>
								<th class="text-end"><s:text name="label.acao"/></th>
							</tr>
						</thead>
						<tbody>
							<s:iterator value="agendas">
								<tr>
									<td><s:property value="rowid"/></td>
									<td><s:property value="nome"/></td>
									<td>
									    <s:if test="periodo == 1"><s:text name="label.periodo.manha"/></s:if>
									    <s:elseif test="periodo == 2"><s:text name="label.periodo.tarde"/></s:elseif>
									    <s:elseif test="periodo == 3"><s:text name="label.periodo.ambos"/></s:elseif>
									</td>
									<td class="text-end">
										<s:url action="editarAgendas" var="editarUrl">
											<s:param name="agendaVo.rowid" value="rowid"/>
										</s:url>
										<s:a href="%{editarUrl}" class="btn btn-warning text-white btn-sm text-uppercase"><s:text name="label.editar"/></s:a>

										<button type="button" class="btn btn-danger btn-sm text-uppercase" data-bs-toggle="modal" 
											data-bs-target="#confirmarExclusao" 
											data-rowid="<s:property value='rowid'/>"
											data-nome="<s:property value='nome'/>">
											<s:text name="label.excluir"/>
										</button>
									</td>
								</tr>
							</s:iterator>
						</tbody>
						<tfoot class="table-secondary">
							<tr>
								<td colspan="4">
									<s:url action="novoAgendas" var="novoUrl"/>
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
		      	<span><s:text name="label.modal.corpo.agenda"/></span>
		      	<span id="agendaInfo" class="fw-bold d-block mt-2"></span>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"><s:text name="label.nao"/></button>
		        <s:form id="formExcluir" action="excluirAgendas" method="POST" cssStyle="display: inline;">
		        	<s:hidden id="rowidExcluir" name="agendaVo.rowid" />
		        	<button type="submit" class="btn btn-danger"><s:text name="label.sim"/></button>
		        </s:form>
		      </div>
		    </div>		    
		  </div>
		</div>
		
		<script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
		
		<script>
			var confirmarExclusaoModal = document.getElementById('confirmarExclusao');
			if(confirmarExclusaoModal) {
				confirmarExclusaoModal.addEventListener('show.bs.modal', function (event) {
					var button = event.relatedTarget;
					var rowid = button.getAttribute('data-rowid');
					var nome = button.getAttribute('data-nome');
					document.getElementById('rowidExcluir').value = rowid;
					document.getElementById('agendaInfo').textContent = nome;
				});
			}
		</script>
	</body>
</html>