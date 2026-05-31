<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.consulta.agenda"/></title>

    <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
    <link rel="stylesheet" href="${cssUrl}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <s:url value="/css/dashboard.css" var="dashboardCss" />
    <link rel="stylesheet" href="${dashboardCss}">

    <style>
        /* ── Badge de período ── */
        .periodo-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            font-size: 0.76rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
        }
        .periodo-manha {
            background: #fef9c3;
            color: #854d0e;
            border: 1px solid #fde68a;
        }
        .periodo-tarde {
            background: #fff7ed;
            color: #9a3412;
            border: 1px solid #fed7aa;
        }
        .periodo-ambos {
            background: #eff5ff;
            color: #1e40af;
            border: 1px solid #bfdbfe;
        }
    </style>
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
        <a href="${urlAgenda}" class="active">
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
                <h2><s:text name="label.menu.agendas"/></h2>
                <p>Visualize e gerencie as agendas cadastradas</p>
            </div>
            <s:url action="novoAgendas" var="novoUrl"/>
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

                    <%-- Table --%>
                    <div class="table-responsive">
                        <table class="table table-custom mb-0">
                            <thead>
                                <tr>
                                    <th width="10%"><s:text name="label.id"/></th>
                                    <th><s:text name="label.nome"/></th>
                                    <th width="20%"><s:text name="label.periodo.disponivel"/></th>
                                    <th class="text-end" width="12%"><s:text name="label.acao"/></th>
                                </tr>
                            </thead>
                            <tbody>
                                <s:iterator value="agendas">
                                    <tr>
                                        <td>
                                            <span class="id-pill"><s:property value="rowid"/></span>
                                        </td>
                                        <td>
                                            <span class="user-name-label"><s:property value="nome"/></span>
                                        </td>
                                        <td>
                                            <s:if test="periodo == 1">
                                                <span class="periodo-badge periodo-manha">
                                                    <i class="bi bi-brightness-high"></i>
                                                    <s:text name="label.periodo.manha"/>
                                                </span>
                                            </s:if>
                                            <s:elseif test="periodo == 2">
                                                <span class="periodo-badge periodo-tarde">
                                                    <i class="bi bi-sunset"></i>
                                                    <s:text name="label.periodo.tarde"/>
                                                </span>
                                            </s:elseif>
                                            <s:elseif test="periodo == 3">
                                                <span class="periodo-badge periodo-ambos">
                                                    <i class="bi bi-clock-history"></i>
                                                    <s:text name="label.periodo.ambos"/>
                                                </span>
                                            </s:elseif>
                                        </td>
                                        <td class="text-end">
                                            <div class="d-flex justify-content-end gap-1">
                                                <s:url action="editarAgendas" var="editarUrl">
                                                    <s:param name="agendaVo.rowid" value="rowid"/>
                                                </s:url>
                                                <a href="${editarUrl}" class="btn-row-edit" title="Editar">
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
                    <p class="mb-1 text-secondary"><s:text name="label.modal.corpo.agenda"/></p>
                    <span id="agendaInfo" class="fw-bold text-dark d-block mt-2"></span>
                </div>
                <div class="modal-footer justify-content-center">
                    <button type="button" class="btn btn-light px-4" data-bs-dismiss="modal">
                        <s:text name="label.nao"/>
                    </button>
                    <s:form id="formExcluir" action="excluirAgendas" method="POST" cssStyle="display:inline;margin:0">
                        <s:hidden id="rowidExcluir" name="agendaVo.rowid"/>
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
        document.getElementById('confirmarExclusao').addEventListener('show.bs.modal', function(e) {
            var btn = e.relatedTarget;
            document.getElementById('rowidExcluir').value     = btn.getAttribute('data-rowid');
            document.getElementById('agendaInfo').textContent =
                'ID ' + btn.getAttribute('data-rowid') + '  —  ' + btn.getAttribute('data-nome');
        });
    </script>
</body>
</html>
