package br.com.soc.sistema.business;

import java.util.List;

import br.com.soc.sistema.dao.AgendaDao;
import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.vo.AgendaVo;

public class AgendaBusiness {

    private final AgendaDao dao;

    public AgendaBusiness() {
        this.dao = new AgendaDao();
    }

    public List<AgendaVo> trazerTodasAsAgendas() {
        return dao.findAllAgendas();
    }
    
    private void validarAgenda(AgendaVo agendaVo) {
        if (agendaVo.getNome() == null || agendaVo.getNome().trim().isEmpty()) {
            throw new BusinessException("Nome da agenda não pode ser em branco.");
        }
        if (agendaVo.getPeriodo() == null || agendaVo.getPeriodo().trim().isEmpty()) {
            throw new BusinessException("O período da agenda é obrigatório.");
        }
    }

    public void salvarAgenda(AgendaVo agendaVo) {
        validarAgenda(agendaVo);
        dao.insertAgenda(agendaVo);
    }

    public void alterarAgenda(AgendaVo agendaVo) {
        validarAgenda(agendaVo);  
        dao.updateAgenda(agendaVo);
    }

    public void excluirAgenda(String rowid) {
        CompromissoDao compromissoDao = new CompromissoDao();
        if (compromissoDao.countCompromissosByAgenda(rowid) > 0) {
            throw new BusinessException("Não é possível excluir uma agenda que possui compromissos cadastrados.");
        }
        
        dao.deleteAgenda(rowid);
    }

    public AgendaVo buscarAgendaPor(String codigo) {
        return dao.findByCodigo(codigo);
    }
}