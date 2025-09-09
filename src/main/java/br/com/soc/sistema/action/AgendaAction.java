package br.com.soc.sistema.action;

import java.util.ArrayList;
import java.util.List;

import br.com.soc.sistema.business.AgendaBusiness;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.infra.Action;
import br.com.soc.sistema.vo.AgendaVo;

public class AgendaAction extends Action {
    private static final long serialVersionUID = 1L;

    private List<AgendaVo> agendas = new ArrayList<>();
    private AgendaBusiness business = new AgendaBusiness();
    private AgendaVo agendaVo = new AgendaVo();

    public String todos() {
        agendas.addAll(business.trazerTodasAsAgendas());
        return SUCCESS;
    }

    public String novo() {
        return INPUT;
    }

    public String salvar() {
        try {
            business.salvarAgenda(agendaVo);
            addActionMessage(getText("salvar.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT;
        }
        return REDIRECT;
    }

    public String editar() {
        if (agendaVo.getRowid() == null || agendaVo.getRowid().isEmpty()) {
            return REDIRECT;
        }
        
        try {
        	agendaVo = business.buscarAgendaPor(agendaVo.getRowid());
        }catch(BusinessException e) {
        	addActionError(e.getMessage());
        }
        return INPUT;
    }

    public String alterar() {
        try {
            business.alterarAgenda(agendaVo);
            addActionMessage(getText("alterar.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT;
        }
        return REDIRECT;
    }
    
    public String excluir() {
        try {
            business.excluirAgenda(agendaVo.getRowid());
            addActionMessage(getText("excluir.sucesso"));
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return todos();
        }
        return REDIRECT;
    }

    public List<AgendaVo> getAgendas() {
        return agendas;
    }

    public void setAgendas(List<AgendaVo> agendas) {
        this.agendas = agendas;
    }

    public AgendaVo getAgendaVo() {
        return agendaVo;
    }

    public void setAgendaVo(AgendaVo agendaVo) {
        this.agendaVo = agendaVo;
    }
}