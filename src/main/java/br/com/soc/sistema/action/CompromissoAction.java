package br.com.soc.sistema.action;

import java.util.ArrayList;
import java.util.List;
import br.com.soc.sistema.business.AgendaBusiness;
import br.com.soc.sistema.business.CompromissoBusiness;
import br.com.soc.sistema.business.FuncionarioBusiness;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.infra.Action;
import br.com.soc.sistema.vo.AgendaVo;
import br.com.soc.sistema.vo.CompromissoVo;
import br.com.soc.sistema.vo.FuncionarioVo;

public class CompromissoAction extends Action {
    private static final long serialVersionUID = 1L;

    private List<CompromissoVo> compromissos = new ArrayList<>();
    private List<FuncionarioVo> funcionarios = new ArrayList<>();
    private List<AgendaVo> agendas = new ArrayList<>();
    
    private CompromissoBusiness business = new CompromissoBusiness();
    private FuncionarioBusiness funcionarioBusiness = new FuncionarioBusiness();
    private AgendaBusiness agendaBusiness = new AgendaBusiness();
    
    private CompromissoVo compromissoVo = new CompromissoVo();

    public String todos() {
        compromissos.addAll(business.trazerTodosOsCompromissos());
        return SUCCESS;
    }

    public String novo() {
        carregarCombos();
        return INPUT;
    }
    
    public String salvar() {
        try {
            business.salvarCompromisso(compromissoVo);
            addActionMessage(getText("salvar.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            carregarCombos(); 
            return INPUT;
        }
        return REDIRECT;
    }
    
    public String editar() {
        if (compromissoVo.getRowid() == null || compromissoVo.getRowid().isEmpty()) {
            return REDIRECT;
        }

        try {
            compromissoVo = business.buscarCompromissoPor(compromissoVo.getRowid());

            carregarCombos(); 
        } catch (BusinessException e) {
            addActionError(e.getMessage());
        }

        return INPUT;
    }
    
    public String alterar() {
        System.out.println("--- DEBUG: Action.alterar() foi chamado. ---");
        try {
            System.out.println("--- DEBUG: Enviando para a Business: " + getCompromissoVo().toString());
            business.alterarCompromisso(getCompromissoVo());
            addActionMessage(getText("alterar.sucesso"));
        } catch (BusinessException e) {
            System.out.println("--- DEBUG: Action pegou uma BusinessException: " + e.getMessage());
            addActionError(e.getMessage());
            carregarCombos();
            return INPUT;
        }
        return REDIRECT;
    }

    public String excluir() {
        try {
            business.excluirCompromisso(compromissoVo.getRowid());
            addActionMessage(getText("excluir.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
        }
        return REDIRECT;
    }
    
    private void carregarCombos() {
        this.funcionarios = funcionarioBusiness.trazerTodosOsFuncionarios();
        this.agendas = agendaBusiness.trazerTodasAsAgendas();
    }
    
    public List<CompromissoVo> getCompromissos() { 
    	return compromissos; 
    }
    
    public void setCompromissos(List<CompromissoVo> compromissos) { 
    	this.compromissos = compromissos; 
    }
    
    public List<FuncionarioVo> getFuncionarios() { 
    	return funcionarios; 
    }
	
    public void setFuncionarios(List<FuncionarioVo> funcionarios) { 
    	this.funcionarios = funcionarios; 
    }
	
    public List<AgendaVo> getAgendas() { 
    	return agendas; 
    }
	
    public void setAgendas(List<AgendaVo> agendas) { 
    	this.agendas = agendas; 
    }
	
    public CompromissoVo getCompromissoVo() { 
    	return compromissoVo; 
    }
    
    public void setCompromissoVo(CompromissoVo compromissoVo) { 
    	this.compromissoVo = compromissoVo; 
    }
}