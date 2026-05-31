<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><s:text name="label.titulo.pagina.relatorio"/></title>

    <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
    <link rel="stylesheet" href="${cssUrl}">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <s:url value="/css/dashboard.css" var="dashboardCss" />
    <link rel="stylesheet" href="${dashboardCss}">

    <style>
        /* ── Estilos específicos do relatório ── */
        .filter-card {
            background: #fff;
            border: 1px solid var(--sidebar-border);
            border-radius: var(--radius);
            padding: 24px;
            box-shadow: var(--card-shadow);
        }

        .filter-card label {
            font-size: 0.75rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            color: var(--muted);
            margin-bottom: 6px;
            display: block;
        }

        .filter-card .form-control[type="date"] {
            background: #fff !important;
            color: var(--text-main) !important;
            border: 1.5px solid #d1d9e6;
            border-radius: 8px;
            padding: 9px 14px;
            font-size: 0.875rem;
            transition: border-color var(--transition), box-shadow var(--transition);
            box-shadow: none;
        }

        .filter-card .form-control[type="date"]:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(37,99,235,.1);
            outline: none;
        }

        .btn-gerar {
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: background var(--transition), transform var(--transition), box-shadow var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 7px;
            white-space: nowrap;
        }

        .btn-gerar:hover {
            background: var(--accent-hover);
            transform: translateY(-1px);
            box-shadow: 0 4px 14px rgba(37,99,235,.3);
        }

        .btn-exportar {
            background: #fff;
            color: #16a34a;
            border: 1.5px solid #86efac;
            border-radius: 8px;
            padding: 10px 20px;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
            white-space: nowrap;
        }

        .btn-exportar:hover {
            background: #f0fdf4;
            border-color: #4ade80;
            color: #15803d;
        }

        .results-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 0 16px;
            border-bottom: 1px solid var(--sidebar-border);
            margin-bottom: 0;
        }

        .results-header h3 {
            font-size: 0.95rem;
            font-weight: 700;
            color: var(--text-main);
            margin: 0;
        }

        .results-count {
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--muted);
            background: #f0f2f5;
            border: 1px solid #e0e4eb;
            border-radius: 20px;
            padding: 3px 12px;
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
        <a href="${urlRelat}" class="active">
            <i class="bi bi-file-earmark-bar-graph"></i>
            <s:text name="label.menu.relatorio"/>
        </a>
    </div>

    <%-- ═══ MAIN ═══ --%>
    <div class="main-content">

        <%-- Top Bar --%>
        <div class="main-topbar">
            <div>
                <h2><s:text name="label.titulo.pagina.relatorio"/></h2>
                <p>Filtre e exporte compromissos por período</p>
            </div>
        </div>

        <%-- Inner content --%>
        <div class="page-inner">

            <%-- Alert de erro --%>
            <s:if test="hasActionErrors()">
                <div class="alert alert-danger mb-3"><s:actionerror/></div>
            </s:if>

            <%-- Card de filtros --%>
            <div class="filter-card mb-4">
                <s:form action="gerarRelatorio" method="POST" cssClass="row align-items-end g-3">
                    <div class="col-md-4">
                        <label for="dataInicial"><s:text name="label.data.inicial"/></label>
                        <s:textfield type="date" cssClass="form-control" name="dataInicial" id="dataInicial"/>
                    </div>
                    <div class="col-md-4">
                        <label for="dataFinal"><s:text name="label.data.final"/></label>
                        <s:textfield type="date" cssClass="form-control" name="dataFinal" id="dataFinal"/>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn-gerar w-100">
                            <i class="bi bi-search"></i>
                            <s:text name="label.gerar"/>
                        </button>
                    </div>
                    <div class="col-md-2">
                        <s:url action="exportarRelatorio" var="exportUrl">
                            <s:param name="dataInicial" value="%{dataInicial}"/>
                            <s:param name="dataFinal"   value="%{dataFinal}"/>
                        </s:url>
                        <s:a href="%{exportUrl}" cssClass="btn-exportar w-100">
                            <i class="bi bi-file-earmark-excel"></i>
                            <s:text name="label.exportar"/>
                        </s:a>
                    </div>
                </s:form>
            </div>

            <%-- Resultados (só exibe quando há dados) --%>
            <s:if test="!compromissos.isEmpty()">
                <div class="card-custom">
                    <div class="card-body">
                        <div class="results-header">
                            <h3>
                                <i class="bi bi-table me-2 text-muted" style="font-size:0.9rem"></i>
                                <s:text name="label.resultados"/>
                            </h3>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-custom mb-0">
                                <thead>
                                    <tr>
                                        <th width="8%"><s:text name="label.id.funcionario"/></th>
                                        <th><s:text name="label.funcionario"/></th>
                                        <th width="8%"><s:text name="label.id.agenda"/></th>
                                        <th><s:text name="label.agenda"/></th>
                                        <th width="13%"><s:text name="label.data"/></th>
                                        <th width="10%"><s:text name="label.hora"/></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <s:iterator value="compromissos">
                                        <tr>
                                            <td><span class="id-pill"><s:property value="idFuncionario"/></span></td>
                                            <td><span class="user-name-label"><s:property value="nomeFuncionario"/></span></td>
                                            <td><span class="id-pill"><s:property value="idAgenda"/></span></td>
                                            <td><span class="user-name-label"><s:property value="nomeAgenda"/></span></td>
                                            <td><s:property value="data"/></td>
                                            <td><s:property value="hora"/></td>
                                        </tr>
                                    </s:iterator>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </s:if>

        </div><%-- /page-inner --%>
    </div><%-- /main-content --%>

    <s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl"/>
    <script src="${jsUrl}"></script>
</body>
</html>
