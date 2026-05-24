<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title><s:text name="label.titulo.pagina.consulta"/></title>
		<%-- Garantindo o carregamento seguro do CSS igual fizemos nas outras telas --%>
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
	
		<div class="container mt-4">
			<%-- Exibição de mensagens de sucesso/erro padronizada --%>
			<div class="row">
				<div class="col">
					<s:if test="hasActionErrors()"><div class="alert alert-danger"><s:actionerror/></div></s:if>
					<s:if test="hasActionMessages()"><div class="alert alert-success"><s:actionmessage/></div></s:if>
				</div>
			</div>

			<div class="card shadow-sm">
				<div class="card-header bg-light">
					<div class="row align-items-center">
						<div class="col-md-10"> <%-- Aumentei o espaço da barra de busca para 10 colunas --%>
							<s:form action="/filtrarFuncionarios.action" cssClass="d-flex w-100">
								<div class="input-group">
									<span class="input-group-text">
										<strong><s:text name="label.buscar.por"/></strong>
									</span>	
									<%-- Adicionado bg-white e text-dark para forçar a visibilidade --%>
									<s:select  
										cssClass="form-select bg-white text-dark" 
										name="filtrar.opcoesCombo" 
										list="listaOpcoesCombo"  
										headerKey=""  
										headerValue="%{getText('label.escolha')}" 
										listKey="%{codigo}" 
										listValueKey="%{descricao}"
										value="filtrar.opcoesCombo.codigo"									
									/>
									<s:textfield cssClass="form-control bg-white text-dark" id="nome" name="filtrar.valorBusca"/>
									<button class="btn btn-primary text-uppercase" type="submit"><s:text name="label.pesquisar"/></button>
								</div>
							</s:form>			
						</div>
						<div class="col-md-2 text-end"> <%-- Diminuí o espaço do botão para 2 colunas --%>
							<s:url action="novoFuncionarios" var="novo"/>
							<%-- Removido o w-100 para o botão ficar no tamanho normal --%>
							<a href="${novo}" class="btn btn-success text-uppercase">
								<s:text name="label.novo"/>
							</a>
						</div>
					</div>
				</div>

				<div class="card-body p-0">
					<table class="table table-striped table-hover align-middle mb-0">
						<thead class="table-dark text-uppercase">
							<tr>
								<th class="ps-3"><s:text name="label.id"/></th>
								<th><s:text name="label.nome"/></th>
								<th class="text-end pe-3"><s:text name="label.acao"/></th>
							</tr>
						</thead>
						
						<tbody>
							<s:iterator value="funcionarios" >
								<tr>
									<td class="ps-3"><s:property value="rowid"/></td>
									<td><s:property value="nome"/></td>
									<td class="text-end pe-3">
										<s:url action="editarFuncionarios" var="editar">
											<s:param name="funcionarioVo.rowid" value="rowid"></s:param>
										</s:url>

										<a href="${editar}" class="btn btn-sm btn-warning text-white text-uppercase">
											<s:text name="label.editar"/>
										</a>

										<button class="btn btn-sm btn-danger text-uppercase" data-bs-toggle="modal" 
											data-bs-target="#confirmarExclusao" 
											data-rowid="<s:property value='rowid'/>"
											data-nome="<s:property value='nome'/>">
											<s:text name="label.excluir"/>
										</button>
									</td>
								</tr>
							</s:iterator>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		
		<%-- Modal de Exclusão (Mantido original, apenas ajustei o padding/margin visual) --%>
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
		        <button type="button" class="btn btn-secondary text-uppercase" data-bs-dismiss="modal">
		        	<s:text name="label.nao"/>
		        </button>
		        <s:form id="formExcluir" action="excluirFuncionarios" method="POST" cssStyle="display: inline;">
		        	<s:hidden id="rowidExcluir" name="funcionarioVo.rowid" />
		        	<button type="submit" class="btn btn-primary text-uppercase">
		        		<s:text name="label.sim"/>
		        	</button>
		        </s:form>
		      </div>
		    </div>
		  </div>
		</div>
		
		<s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl" />
		<script src="${jsUrl}"></script>
		
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