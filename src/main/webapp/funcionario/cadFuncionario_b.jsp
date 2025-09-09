<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><s:text name="label.titulo.pagina.consulta"/></title>
		<link rel='stylesheet' href='webjars/bootstrap/5.1.3/css/bootstrap.min.css'>
	</head>
	<body class="bg-secondary">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
			<div class="container">
				<a class="navbar-brand" href="#"><s:text name="label.titulo.pagina"/></a>
				<div class="collapse navbar-collapse">
					<ul class="navbar-nav">
						<li class="nav-item">
							<s:url action="todosFuncionarios" var="urlFunc"/>
							<a class="nav-link active" href="${urlFunc}"><s:text name="label.menu.funcionarios"/></a>
						</li>
						<li class="nav-item">
							<s:url action="todosAgendas" var="urlAgenda"/>
							<a class="nav-link" href="${urlAgenda}"><s:text name="label.menu.agendas"/></a>
						</li>
                         <li class="nav-item">
                            <s:url action="todosCompromissos" var="urlComp"/>
                            <a class="nav-link" href="${urlComp}"><s:text name="label.menu.compromissos"/></a>
                        </li>
                        <li class="nav-item">
	                        <s:url action="indexRelatorio" var="urlRelat"/>
	                        <a class="nav-link" href="${urlRelat}"><s:text name="label.menu.relatorio"/></a>
                        </li>						
					</ul>
				</div>
			</div>
		</nav>
	
		<div class="container">
			<div class="row mt-5 mb-2">
				<div class="col-sm p-0">
					<s:form action="/filtrarFuncionarios.action">
						<div class="input-group">
							<span class="input-group-text">
								<strong><s:text name="label.buscar.por"/></strong>
							</span>	
								<s:select  
									cssClass="form-select" 
									name="filtrar.opcoesCombo" 
									list="listaOpcoesCombo"  
									headerKey=""  
									headerValue="%{getText('label.escolha')}" 
									listKey="%{codigo}" 
									listValueKey="%{descricao}"
									value="filtrar.opcoesCombo.codigo"									
								/>
								
								<s:textfield cssClass="form-control" id="nome" name="filtrar.valorBusca"/>
								<button class="btn btn-primary" type="submit"><s:text name="label.pesquisar"/></button>
						</div>
					</s:form>			
				</div>				
			</div>

			<div class="row">
				<table class="table table-light table-striped align-middle">
					<thead>
						<tr>
							<th><s:text name="label.id"/></th>
							<th><s:text name="label.nome"/></th>
							<th class="text-end"><s:text name="label.acao"/></th>
						</tr>
					</thead>
					
					<tbody>
						<s:iterator value="funcionarios" >
							<tr>
								<td><s:property value="rowid"/></td>
								<td><s:property value="nome"/></td>
								<td class="text-end">
									<s:url action="editarFuncionarios" var="editar">
										<s:param name="funcionarioVo.rowid" value="rowid"></s:param>
									</s:url>

									<a href="${editar}" class="btn btn-warning text-white">
										<s:text name="label.editar"/>
									</a>

									<button class="btn btn-danger" data-bs-toggle="modal" 
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
							<td colspan="3">
								<s:url action="novoFuncionarios" var="novo"/>
								<a href="${novo}" class="btn btn-success">
									<s:text name="label.novo"/>
								</a>
							</td>
						</tr>
					</tfoot>				
				</table>
			</div>

			<div class="row">
			</div>
		</div>
		

		<div class="modal fade" id="confirmarExclusao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
		  <div class="modal-dialog">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title"><s:text name="label.modal.titulo"/></h5>
		        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		      </div>
		      
		      <div class="modal-body">
		      	<span><s:text name="label.modal.corpo"/></span>
		      	<span id="funcionarioInfo" class="fw-bold d-block mt-2"></span>
		      </div>
		      
		      <div class="modal-footer">
		        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
		        	<s:text name="label.nao"/>
		        </button>
		        <s:form id="formExcluir" action="excluirFuncionarios" method="POST" cssStyle="display: inline;">
		        	<s:hidden id="rowidExcluir" name="funcionarioVo.rowid" />
		        	<button type="submit" class="btn btn-primary">
		        		<s:text name="label.sim"/>
		        	</button>
		        </s:form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<script src="webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
		
		<script>

			var confirmarExclusaoModal = document.getElementById('confirmarExclusao');
			confirmarExclusaoModal.addEventListener('show.bs.modal', function (event) {
				var button = event.relatedTarget;
				var rowid = button.getAttribute('data-rowid');
				var nome = button.getAttribute('data-nome');
				

				document.getElementById('rowidExcluir').value = rowid;

				document.getElementById('funcionarioInfo').textContent = 'ID: ' + rowid + ' - Nome: ' + nome;
			});
		</script>
	</body>
</html>