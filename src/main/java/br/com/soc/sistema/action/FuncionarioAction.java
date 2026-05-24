package br.com.soc.sistema.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import br.com.soc.sistema.business.FuncionarioBusiness;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.filter.FuncionarioFilter;
import br.com.soc.sistema.infra.Action;
import br.com.soc.sistema.infra.OpcoesComboBuscar;
import br.com.soc.sistema.vo.FuncionarioVo;

public class FuncionarioAction extends Action {
    
    private static final long serialVersionUID = 1L;
    private List<FuncionarioVo> funcionarios = new ArrayList<>();
    private FuncionarioBusiness business = new FuncionarioBusiness();
    private FuncionarioFilter filtrar = new FuncionarioFilter();
    private FuncionarioVo funcionarioVo = new FuncionarioVo();
    
    public String todos() {
        try {
            funcionarios.addAll(business.trazerTodosOsFuncionarios());    
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Erro ao carregar os funcionários: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String filtrar() {
        if(filtrar.isNullOpcoesCombo())
            return REDIRECT;
        
        try {
            funcionarios = business.filtrarFuncionarios(filtrar);
            return SUCCESS;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return SUCCESS;
        } catch (Exception e) {
            addActionError("Erro técnico ao realizar o filtro: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String novo() {
        return INPUT;
    }
    
    public String salvar() {
        try {
            business.salvarFuncionario(funcionarioVo);
            addActionMessage(getText("salvar.sucesso"));
            return REDIRECT;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT;
        } catch (Exception e) {
            addActionError("Erro interno ao salvar: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String editar() {
        if (funcionarioVo.getRowid() == null || funcionarioVo.getRowid().isEmpty()) {
            return REDIRECT;
        }
        
        try {
            funcionarioVo = business.buscarFuncionarioPor(funcionarioVo.getRowid());
            return INPUT;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return REDIRECT;
        } catch (Exception e) {
            addActionError("Erro técnico ao buscar funcionário: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String alterar() {
        try {
            business.alterarFuncionario(getFuncionarioVo());
            addActionMessage(getText("alterar.sucesso"));
            return REDIRECT;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT; 
        } catch (Exception e) {
            addActionError("Erro interno ao alterar: " + e.getMessage());
            return ERROR;
        }
    }
    
    public String excluir() {
        try {
            business.excluirFuncionario(getFuncionarioVo());
            addActionMessage(getText("excluir.sucesso"));
            return REDIRECT;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return todos(); 
        } catch (Exception e) {
            addActionError("Erro interno ao excluir: " + e.getMessage());
            return ERROR;
        }
    }
    
    public List<OpcoesComboBuscar> getListaOpcoesCombo(){
        return Arrays.asList(OpcoesComboBuscar.values());
    }
    
    public List<FuncionarioVo> getFuncionarios() {
        return funcionarios;
    }

    public void setFuncionarios(List<FuncionarioVo> funcionarios) {
        this.funcionarios = funcionarios;
    }

    public FuncionarioFilter getFiltrar() {
        return filtrar;
    }

    public void setFiltrar(FuncionarioFilter filtrar) {
        this.filtrar = filtrar;
    }

    public FuncionarioVo getFuncionarioVo() {
        return funcionarioVo;
    }

    public void setFuncionarioVo(FuncionarioVo funcionarioVo) {
        this.funcionarioVo = funcionarioVo;
    }
}