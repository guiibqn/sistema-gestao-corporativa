<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.cadastro.agenda"/></title>

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
                <s:if test="agendaVo.rowid != null && !agendaVo.rowid.isEmpty()">
                    <h2><s:text name="label.titulo.pagina.edicao.agenda"/></h2>
                    <p>Altere os dados da agenda e salve</p>
                </s:if>
                <s:else>
                    <h2><s:text name="label.novo.agenda"/></h2>
                    <p>Preencha os dados para cadastrar uma nova agenda</p>
                </s:else>
            </div>
            <s:url action="todosAgendas" var="todos"/>
            <a href="${todos}" class="btn-voltar">
                <i class="bi bi-arrow-left"></i>
                <s:text name="label.titulo.pagina.consulta.agenda"/>
            </a>
        </div>

        <%-- Inner content --%>
        <div class="page-inner">

            <s:form action="%{agendaVo.rowid == null || agendaVo.rowid.isEmpty() ? 'salvarAgendas' : 'alterarAgendas'}" method="POST" cssClass="form-card">

                <div class="form-card-header">
                    <h5>
                        <i class="bi bi-calendar3 me-2" style="color:var(--accent)"></i>
                        Dados da Agenda
                    </h5>
                </div>

                <div class="form-card-body">

                    <%-- Alerts --%>
                    <s:if test="hasActionErrors()">
                        <div class="alert alert-danger mb-0"><s:actionerror/></div>
                    </s:if>

                    <%-- Código (somente na edição) --%>
                    <s:if test="agendaVo.rowid != null && !agendaVo.rowid.isEmpty()">
                        <div class="field-group" style="max-width:140px">
                            <label><s:text name="label.codigo"/></label>
                            <s:textfield cssClass="form-control" name="agendaVo.rowid" readonly="true" value="%{agendaVo.rowid}"/>
                        </div>
                    </s:if>

                    <%-- Nome --%>
                    <div class="field-group">
                        <label><s:text name="label.nome.agenda"/></label>
                        <s:textfield cssClass="form-control" name="agendaVo.nome" value="%{agendaVo.nome}" placeholder="Nome da agenda"/>
                    </div>

                    <%-- Período Disponível --%>
                    <div class="field-group" style="max-width:280px">
                        <label><s:text name="label.periodo.disponivel"/></label>
                        <s:select cssClass="form-select" name="agendaVo.periodo"
                            list="#{'1':getText('label.periodo.manha'), '2':getText('label.periodo.tarde'), '3':getText('label.periodo.ambos')}"
                            headerKey="" headerValue="%{getText('label.escolha')}"/>
                    </div>

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
