<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><s:text name="label.titulo.pagina.cadastro.compromisso"/></title>
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
        <s:form action="%{compromissoVo.rowid == null || compromissoVo.rowid.isEmpty() ? 'salvarCompromissos' : 'alterarCompromissos'}" method="POST">
            <div class="card">
                <div class="card-header">
                    <div class="row w-100 align-items-center">
                        <div class="col-sm-5">
                            <s:url action="todosCompromissos" var="todos"/>
                            <s:a href="%{todos}" cssClass="btn btn-success"><s:text name="label.titulo.pagina.consulta.compromisso"/></s:a>
                        </div>
                        <div class="col-sm text-center">
                            <s:if test="compromissoVo.rowid != null && !compromissoVo.rowid.isEmpty()">
                                <h5 class="card-title mb-0"><strong><s:text name="label.titulo.pagina.edicao.compromisso"/></strong></h5>
                            </s:if>
                            <s:else>
                                <h5 class="card-title mb-0"><strong><s:text name="label.novo.compromisso"/></strong></h5>
                            </s:else>
                        </div>
                        <div class="col-sm-5"></div>
                    </div>
                </div>
                
                <s:if test="hasActionErrors()">
					<div class="alert alert-danger m-3"><s:actionerror/></div>
				</s:if>

                <div class="card-body">
                    <div class="row align-items-center mb-3">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.funcionario"/>:</strong></label>
                        <div class="col-sm-10">
                            <s:select cssClass="form-select" name="compromissoVo.idFuncionario"
                                list="funcionarios" listKey="rowid" listValue="nome"
                                headerKey="" headerValue="%{getText('label.escolha')}"/>
                        </div>
                    </div>
                    <div class="row align-items-center mb-3">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.agenda"/>:</strong></label>
                        <div class="col-sm-10">
                            <s:select cssClass="form-select" name="compromissoVo.idAgenda"
                                list="agendas" listKey="rowid" listValue="nome"
                                headerKey="" headerValue="%{getText('label.escolha')}"/>
                        </div>
                    </div>
                    <div class="row align-items-center mb-3">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.data"/>:</strong></label>
                        <div class="col-sm-4">
                            <s:textfield type="date" cssClass="form-control" name="compromissoVo.data"/>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.hora"/>:</strong></label>
                        <div class="col-sm-4">
                            <s:textfield type="time" cssClass="form-control" name="compromissoVo.hora"/>
                        </div>
                    </div>
                    <s:if test="compromissoVo.rowid != null && !compromissoVo.rowid.isEmpty()">
                        <s:hidden name="compromissoVo.rowid" />
                    </s:if>
                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-sm-4 offset-sm-1">
                            <button type="submit" class="btn btn-primary w-100 text-uppercase"><s:text name="label.salvar"/></button>
                        </div>
                        <div class="col-sm-4 offset-sm-2">
                            <button type="reset" class="btn btn-secondary w-100 text-uppercase"><s:text name="label.limpar.formulario"/></button>
                        </div>
                    </div>
                </div>
            </div>
        </s:form>
    </div>
    
    <s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl" />
    <script src="${jsUrl}"></script>
</body>
</html>