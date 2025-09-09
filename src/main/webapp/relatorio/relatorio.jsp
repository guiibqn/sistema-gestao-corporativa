<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><s:text name="label.titulo.pagina.relatorio"/></title>
    <s:url value="/webjars/bootstrap/5.1.3/css/bootstrap.min.css" var="cssUrl" />
    <link rel='stylesheet' href='${cssUrl}'>
</head>
<body class="bg-secondary">
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand text-uppercase" href="#"><s:text name="label.titulo.pagina"/></a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav">
                    <li class="nav-item"><s:url action="todosFuncionarios" var="urlFunc"/><s:a cssClass="nav-link" href="%{urlFunc}"><s:text name="label.menu.funcionarios"/></s:a></li>
                    <li class="nav-item"><s:url action="todosAgendas" var="urlAgenda"/><s:a cssClass="nav-link" href="%{urlAgenda}"><s:text name="label.menu.agendas"/></s:a></li>
                    <li class="nav-item"><s:url action="todosCompromissos" var="urlComp"/><s:a cssClass="nav-link" href="%{urlComp}"><s:text name="label.menu.compromissos"/></s:a></li>
	                <li class="nav-item"><s:url action="indexRelatorio" var="urlRelat"/><s:a cssClass="nav-link active" href="%{urlRelat}"><s:text name="label.menu.relatorio"/></s:a></li>    	
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
    	<div class="row">
			<div class="col">
				<s:if test="hasActionErrors()"><div class="alert alert-danger"><s:actionerror/></div></s:if>
			</div>
		</div>
    
        <div class="card mt-3">
            <div class="card-header"><h5 class="card-title mb-0"><strong><s:text name="label.titulo.pagina.relatorio"/></strong></h5></div>
            <div class="card-body">
                <s:form action="gerarRelatorio" method="POST">
                    <div class="row align-items-end">
                        <div class="col-md-4">
                            <label for="dataInicial" class="form-label text-uppercase"><strong><s:text name="label.data.inicial"/>:</strong></label>
                            <s:textfield type="date" class="form-control" name="dataInicial" id="dataInicial"/>
                        </div>
                        <div class="col-md-4">
                            <label for="dataFinal" class="form-label text-uppercase"><strong><s:text name="label.data.final"/>:</strong></label>
                            <s:textfield type="date" class="form-control" name="dataFinal" id="dataFinal"/>
                        </div>
                        <div class="col-md-2">
                            <button type="submit" class="btn btn-primary w-100 text-uppercase"><s:text name="label.gerar"/></button>
                        </div>
                        <div class="col-md-2">
				            <s:url action="exportarRelatorio" var="exportUrl">
				                <s:param name="dataInicial" value="%{dataInicial}" />
				                <s:param name="dataFinal" value="%{dataFinal}" />
				            </s:url>
				            <s:a href="%{exportUrl}" cssClass="btn btn-success w-100 text-uppercase"><s:text name="label.exportar"/></s:a>
                        </div>
                    </div>
                </s:form>
            </div>

            <s:if test="!compromissos.isEmpty()">
                <hr/>
                <div class="card-body">
                    <h5 class="card-title"><strong><s:text name="label.resultados"/></strong></h5>
                    <table class="table table-striped table-hover align-middle">
                        <thead class="table-dark text-uppercase">
                            <tr>
                                <th><s:text name="label.id.funcionario"/></th>
                                <th><s:text name="label.funcionario"/></th>
                                <th><s:text name="label.id.agenda"/></th>
                                <th><s:text name="label.agenda"/></th>
                                <th><s:text name="label.data"/></th>
                                <th><s:text name="label.hora"/></th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:iterator value="compromissos">
                                <tr>
                                    <td><s:property value="idFuncionario"/></td>
                                    <td><s:property value="nomeFuncionario"/></td>
                                    <td><s:property value="idAgenda"/></td>
                                    <td><s:property value="nomeAgenda"/></td>
                                    <td><s:property value="data"/></td>
                                    <td><s:property value="hora"/></td>
                                </tr>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>
            </s:if>
        </div>
    </div>
    
    <s:url value="/webjars/bootstrap/5.1.3/js/bootstrap.bundle.min.js" var="jsUrl" />
    <script src="${jsUrl}"></script>
</body>
</html>