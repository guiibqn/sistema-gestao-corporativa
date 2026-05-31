<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.consulta.compromisso"/></title>

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
        <a href="${urlFunc}">
            <i class="bi bi-people-fill"></i>
            <s:text name="label.menu.funcionarios"/>
        </a>

        <s:url action="todosAgendas" var="urlAgenda"/>
        <a href="${urlAgenda}">
            <i class="bi bi-calendar3"></i>
            <s:text name="label.menu.agendas"/>
        </a>

        <s:url action="todosCompromissos" var="urlComp"/>
        <a href="${urlComp}" class="active">
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
                <h2><s:text name="label.menu.compromissos"/></h2>
                <p>Visualize e gerencie os compromissos cadastrados</p>
            </div>
            <s:url action="novoCompromissos" var="novoUrl"/>
            <a href="${novoUrl}" class="btn btn-primary shadow-sm">
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
                    <div class="table-responsive">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th width="8%"><s:text name="label.id.funcionario"/></th>
                                    <th><s:text name="label.funcionario"/></th>
                                    <th width="8%"><s:text name="label.id.agenda"/></th>
                                    <th><s:text name="label.agenda"/></th>
                                    <th width="12%"><s:text name="label.data"/></th>
                                    <th width="10%"><s:text name="label.hora"/></th>
                                    <th class="text-end" width="12%"><s:text name="label.acao"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="compromissos">
                                    <tr>
                                        <td>
                                            <span class="id-pill"><s:property value="idFuncionario"/></span>
                                        </td>
                                        <td>
                                            <span class="user-name-label"><s:property value="nomeFuncionario"/></span>
                                        </td>
                                        <td>
                                            <span class="id-pill"><s:property value="idAgenda"/></span>
                                        </td>
                                        <td>
                                            <span class="user-name-label"><s:property value="nomeAgenda"/></span>
                                        </td>
                                        <td><s:property value="data"/></td>
                                        <td><s:property value="hora"/></td>
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-1">
                                                <s:url action="editarCompromissos" var="editarUrl">
                                                    <s:param name="compromissoVo.rowid" value="rowid"/>
                                                </s:url>
                                                <a href="${editarUrl}" class="btn-row-edit" title="Editar">
                                                    <i class="bi bi-pencil"></i>
                                                </a>
                                                <button class="btn-row-delete"
                                                    data-bs-toggle="modal"
                                                    data-bs-target="#confirmarExclusao"
                                                    data-rowid="<s:property value='rowid'/>"
                                                    data-nome="<s:property value='nomeFuncionario'/>"
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


    <%-- ═══ MODAL DE EXCLUSÃO ═══ --%>
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
                    <p class="mb-1 text-secondary"><s:text name="label.modal.corpo.compromisso"/></p>
                    <span id="compromissoInfo" class="fw-bold text-dark d-block mt-2"></span>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">
                        <s:text name="label.nao"/>
                    </button>
                    <s:form id="formExcluir" action="excluirCompromissos" method="POST" cssStyle="display:inline;margin:0">
                        <s:hidden id="rowidExcluir" name="compromissoVo.rowid"/>
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
        var confirmarExclusaoModal = document.getElementById('confirmarExclusao');
        if (confirmarExclusaoModal) {
            confirmarExclusaoModal.addEventListener('show.bs.modal', function(e) {
                var btn = e.relatedTarget;
                document.getElementById('rowidExcluir').value        = btn.getAttribute('data-rowid');
                document.getElementById('compromissoInfo').textContent =
                    'ID ' + btn.getAttribute('data-rowid') + '  —  ' + btn.getAttribute('data-nome');
            });
        }
    </script>
</body>
</html>
