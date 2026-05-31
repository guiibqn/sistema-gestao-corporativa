<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.cadastro.compromisso"/></title>

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
                <s:if test="compromissoVo.rowid != null && !compromissoVo.rowid.isEmpty()">
                    <h2><s:text name="label.titulo.pagina.edicao.compromisso"/></h2>
                    <p>Altere os dados do compromisso e salve</p>
                </s:if>
                <s:else>
                    <h2><s:text name="label.novo.compromisso"/></h2>
                    <p>Preencha os dados para cadastrar um novo compromisso</p>
                </s:else>
            </div>
            <s:url action="todosCompromissos" var="todos"/>
            <a href="${todos}" class="btn-voltar">
                <i class="bi bi-arrow-left"></i>
                <s:text name="label.titulo.pagina.consulta.compromisso"/>
            </a>
        </div>

        <%-- Inner content --%>
        <div class="page-inner">

            <s:form action="%{compromissoVo.rowid == null || compromissoVo.rowid.isEmpty() ? 'salvarCompromissos' : 'alterarCompromissos'}" method="POST" cssClass="form-card">

                <div class="form-card-header">
                    <h5>
                        <i class="bi bi-check2-square me-2" style="color:var(--accent)"></i>
                        Dados do Compromisso
                    </h5>
                </div>

                <div class="form-card-body">

                    <%-- Alerts --%>
                    <s:if test="hasActionErrors()">
                        <div class="alert alert-danger mb-0"><s:actionerror/></div>
                    </s:if>

                    <%-- Funcionário --%>
                    <div class="field-group">
                        <label><s:text name="label.funcionario"/></label>
                        <s:select cssClass="form-select" name="compromissoVo.idFuncionario"
                            list="funcionarios" listKey="rowid" listValue="nome"
                            headerKey="" headerValue="%{getText('label.escolha')}"/>
                    </div>

                    <%-- Agenda --%>
                    <div class="field-group">
                        <label><s:text name="label.agenda"/></label>
                        <s:select cssClass="form-select" name="compromissoVo.idAgenda"
                            list="agendas" listKey="rowid" listValue="nome"
                            headerKey="" headerValue="%{getText('label.escolha')}"/>
                    </div>

                    <%-- Data e Hora lado a lado --%>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="field-group">
                                <label><s:text name="label.data"/></label>
                                <s:textfield type="date" cssClass="form-control" name="compromissoVo.data"/>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="field-group">
                                <label><s:text name="label.hora"/></label>
                                <s:textfield type="time" cssClass="form-control" name="compromissoVo.hora"/>
                            </div>
                        </div>
                    </div>

                    <%-- Hidden rowid na edição --%>
                    <s:if test="compromissoVo.rowid != null && !compromissoVo.rowid.isEmpty()">
                        <s:hidden name="compromissoVo.rowid"/>
                    </s:if>

                </div>

                <div class="form-card-footer">
                    <button type="submit" class="btn-salvar">
                        <i class="bi bi-check-lg me-1"></i>
                        <s:text name="label.salvar"/>
                    </button>
                    <button type="reset" class="btn-limpar">
                        <i class="bi bi-arrow-counterclockwise me-1"></i>
                        <s:text name="label.limpar.formulario"/>
                    </button>
                </div>

            </s:form>

        </div>
    </div>

    <s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl"/>
    <script src="${jsUrl}"></script>
</body>
</html>
