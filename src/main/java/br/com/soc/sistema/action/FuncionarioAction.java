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
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private List<FuncionarioVo> funcionarios = new ArrayList<>();
	private FuncionarioBusiness business = new FuncionarioBusiness();
	private FuncionarioFilter filtrar = new FuncionarioFilter();
	private FuncionarioVo funcionarioVo = new FuncionarioVo();
	
	public String todos() {
		funcionarios.addAll(business.trazerTodosOsFuncionarios());	

		return SUCCESS;
	}
	
	public String filtrar() {
		if(filtrar.isNullOpcoesCombo())
			return REDIRECT;
		
		funcionarios = business.filtrarFuncionarios(filtrar);
		
		return SUCCESS;
	}
	
    public String novo() {
        return INPUT;
    }
    
    public String salvar() {
        try {
            business.salvarFuncionario(funcionarioVo);
            addActionMessage(getText("salvar.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT;
        }
        return REDIRECT;
    }
	
    public String editar() {
        if (funcionarioVo.getRowid() == null || funcionarioVo.getRowid().isEmpty()) {
            return REDIRECT;
        }
        
        try {
        	funcionarioVo = business.buscarFuncionarioPor(funcionarioVo.getRowid());
        }catch(BusinessException e) {
        	addActionError(e.getMessage());
        }
        
        return INPUT;
    }
	

	public String alterar() {
	    try {
	        business.alterarFuncionario(getFuncionarioVo());
	
	        addActionMessage(getText("alterar.sucesso"));
	
	    } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT; 
        }
	

	    return REDIRECT;
	}
	
	public String excluir() {
	    try {
	        business.excluirFuncionario(getFuncionarioVo());
	        addActionMessage(getText("excluir.sucesso"));
	    } catch (BusinessException e) {
        	addActionError(e.getMessage());
        	return todos(); 
        }
	    return REDIRECT;
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
