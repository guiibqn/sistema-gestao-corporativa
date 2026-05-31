<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.consulta"/></title>

    <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
    <link rel="stylesheet" href="${cssUrl}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <s:url value="/css/dashboard.css" var="dashboardCss" />
    <link rel="stylesheet" href="${dashboardCss}">
</head>
<body>

    <%-- ═══ SIDEBAR ═══ --%>
    <div class="sidebar">
        <div class="sidebar-brand">
            <i class="bi bi-box-seam-fill"></i>
            SOC <span>Admin</span>
        </div>

        <span class="sidebar-section-label">Menu</span>

        <s:url action="todosFuncionarios" var="urlFunc"/>
        <a href="${urlFunc}" class="active">
            <i class="bi bi-people-fill"></i>
            <s:text name="label.menu.funcionarios"/>
        </a>

        <s:url action="todosAgendas" var="urlAgenda"/>
        <a href="${urlAgenda}">
            <i class="bi bi-calendar3"></i>
            <s:text name="label.menu.agendas"/>
        </a>

        <s:url action="todosCompromissos" var="urlComp"/>
        <a href="${urlComp}">
            <i class="bi bi-check2-square"></i>
            <s:text name="label.menu.compromissos"/>
        </a>

        <s:url action="indexRelatorio" var="urlRelat"/>
        <a href="${urlRelat}">
            <i class="bi bi-file-earmark-bar-graph"></i>
            <s:text name="label.menu.relatorio"/>
        </a>
    </div>

    <%-- ═══ MAIN ═══ --%>
    <div class="main-content">

        <%-- Top Bar --%>
        <div class="main-topbar">
            <div>
                <h2><s:text name="label.menu.funcionarios"/></h2>
                <p>Visualize e gerencie os funcionários cadastrados</p>
            </div>
            <s:url action="novoFuncionarios" var="novo"/>
            <a href="${novo}" class="btn btn-primary shadow-sm">
                <i class="bi bi-plus-lg me-1"></i> <s:text name="label.novo"/>
            </a>
        </div>

        <%-- Inner content --%>
        <div class="page-inner">

            <%-- Alerts --%>
            <s:if test="hasActionErrors()">
                <div class="alert alert-danger mb-3"><s:actionerror/></div>
            </s:if>
            <s:if test="hasActionMessages()">
                <div class="alert alert-success mb-3"><s:actionmessage/></div>
            </s:if>

            <%-- Main Card --%>
            <div class="card-custom">
                <div class="card-body">

                    <%-- Search row --%>
                    <div class="row mb-4">
                        <div class="col-md-8 search-bar-wrapper">
                            <s:form action="/filtrarFuncionarios.action" cssClass="d-flex">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="bi bi-search"></i>
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
                                    <s:textfield
                                        cssClass="form-control"
                                        placeholder="Digite para buscar..."
                                        id="nome"
                                        name="filtrar.valorBusca"
                                    />
                                    <button class="btn btn-outline-secondary" type="submit">
                                        <s:text name="label.pesquisar"/>
                                    </button>
                                </div>
                            </s:form>
                        </div>
                    </div>

                    <%-- Table --%>
                    <div class="table-responsive">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th width="12%"><s:text name="label.id"/></th>
                                    <th><s:text name="label.nome"/></th>
                                    <th class="text-end" width="15%"><s:text name="label.acao"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="funcionarios">
                                    <tr>
                                        <td>
                                            <span class="id-pill"><s:property value="rowid"/></span>
                                        </td>
                                        <td>
                                        	<span class="user-name-label"><s:property value="nome"/></span>    
                                        </td>
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-1">
                                                <s:url action="editarFuncionarios" var="editar">
                                                    <s:param name="funcionarioVo.rowid" value="rowid"/>
                                                </s:url>
                                                <a href="${editar}" class="btn-row-edit" title="Editar">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button class="btn-row-delete"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#confirmarExclusao"
                                                    data-rowid="<s:property value='rowid'/>"
                                                    data-nome="<s:property value='nome'/>"
                                                    title="Excluir">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </s:iterator>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>

        </div><%-- /page-inner --%>
    </div><%-- /main-content --%>


    <%-- ═══ MODAL ═══ --%>
    <div class="modal fade" id="confirmarExclusao" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold text-danger">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                        <s:text name="label.modal.titulo"/>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center py-3">
                    <p class="mb-1 text-secondary"><s:text name="label.modal.corpo"/></p>
                    <span id="funcionarioInfo" class="fw-bold text-dark d-block mt-2"></span>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">
                        <s:text name="label.nao"/>
                    </button>
                    <s:form id="formExcluir" action="excluirFuncionarios" method="POST" cssStyle="display:inline;margin:0">
                        <s:hidden id="rowidExcluir" name="funcionarioVo.rowid"/>
                        <button type="submit" class="btn btn-danger px-4 fw-bold">
                            <s:text name="label.sim"/>
                        </button>
                    </s:form>
                </div>
            </div>
        </div>
    </div>


    <s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl"/>
    <script src="${jsUrl}"></script>
    <script>
        /* Modal */
        document.getElementById('confirmarExclusao').addEventListener('show.bs.modal', function(e) {
            var btn  = e.relatedTarget;
            document.getElementById('rowidExcluir').value        = btn.getAttribute('data-rowid');
            document.getElementById('funcionarioInfo').textContent =
                'ID ' + btn.getAttribute('data-rowid') + '  —  ' + btn.getAttribute('data-nome');
        });
    </script>
</body>
</html>
