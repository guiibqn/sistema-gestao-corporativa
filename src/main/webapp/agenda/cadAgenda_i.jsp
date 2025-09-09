<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><s:text name="label.titulo.pagina.cadastro.agenda"/></title>
    <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
    <link rel='stylesheet' href='${cssUrl}'>
</head>
<body class="bg-secondary">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        </nav>

    <div class="container mt-4">
        <s:form action="%{agendaVo.rowid == null || agendaVo.rowid.isEmpty() ? 'salvarAgendas' : 'alterarAgendas'}" method="POST">
            <div class="card">
                <div class="card-header">
                    <div class="row w-100 align-items-center">
                        <div class="col-sm-5">
                            <s:url action="todosAgendas" var="todos"/>
                            <s:a href="%{todos}" cssClass="btn btn-success"><s:text name="label.titulo.pagina.consulta.agenda"/></s:a>
                        </div>
                        <div class="col-sm text-center">
                            <s:if test="agendaVo.rowid != null && !agendaVo.rowid.isEmpty()">
                                <h5 class="card-title mb-0"><strong><s:text name="label.titulo.pagina.edicao.agenda"/></strong></h5>
                            </s:if>
                            <s:else>
                                <h5 class="card-title mb-0"><strong><s:text name="label.novo.agenda"/></strong></h5>
                            </s:else>
                        </div>
                        <div class="col-sm-5"></div>
                    </div>
                </div>
                
                <s:if test="hasActionErrors()">
					<div class="alert alert-danger m-3"><s:actionerror/></div>
				</s:if>

                <div class="card-body">
                    <s:if test="agendaVo.rowid != null && !agendaVo.rowid.isEmpty()">
                        <div class="row align-items-center mb-3">
                            <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.codigo"/>:</strong></label>	
                            <div class="col-sm-2">
                                <%-- CORREÇÃO 1: Adicionado o atributo 'value' para preencher o campo --%>
                                <s:textfield cssClass="form-control" name="agendaVo.rowid" readonly="true" value="%{agendaVo.rowid}"/>							
                            </div>	
                        </div>
                    </s:if>
                    <div class="row align-items-center mb-3">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.nome.agenda"/>:</strong></label>	
                        <div class="col-sm-10">
                            <%-- CORREÇÃO 2: Adicionado o atributo 'value' para preencher o campo --%>
                            <s:textfield cssClass="form-control" name="agendaVo.nome" value="%{agendaVo.nome}"/>							
                        </div>	
                    </div>
                    <div class="row align-items-center">
                        <label class="col-sm-2 col-form-label text-center"><strong><s:text name="label.periodo.disponivel"/>:</strong></label>
                        <div class="col-sm-4">
                            <s:select cssClass="form-select" name="agendaVo.periodo"
                                list="#{'1':getText('label.periodo.manha'), '2':getText('label.periodo.tarde'), '3':getText('label.periodo.ambos')}"
                                headerKey="" headerValue="%{getText('label.escolha')}"/>
                        </div>
                    </div>
                    

                </div>
                <div class="card-footer">
                    <div class="row">
                        <div class="col-sm-4 offset-sm-1">
                            <button type="submit" class="btn btn-primary w-100"><s:text name="label.salvar"/></button>
                        </div>
                        <div class="col-sm-4 offset-sm-2">
                            <button type="reset" class="btn btn-secondary w-100"><s:text name="label.limpar.formulario"/></button>
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