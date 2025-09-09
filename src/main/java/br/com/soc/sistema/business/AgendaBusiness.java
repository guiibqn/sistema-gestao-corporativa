package br.com.soc.sistema.business;

import java.util.List;
import br.com.soc.sistema.dao.AgendaDao;
import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.vo.AgendaVo;

public class AgendaBusiness {

    private AgendaDao dao;

    public AgendaBusiness() {
        this.dao = new AgendaDao();
    }

    public List<AgendaVo> trazerTodasAsAgendas() {
        return dao.findAllAgendas();
    }
    
    private void validarAgenda(AgendaVo agendaVo) throws IllegalArgumentException {
        if (agendaVo.getNome() == null || agendaVo.getNome().trim().isEmpty()) {
            throw new IllegalArgumentException("Nome da agenda nao pode ser em branco");
        }
        if (agendaVo.getPeriodo() == null || agendaVo.getPeriodo().isEmpty()) {
            throw new IllegalArgumentException("O período da agenda é obrigatório");
        }
    }

    public void salvarAgenda(AgendaVo agendaVo) throws BusinessException {
        try {
            validarAgenda(agendaVo);
            dao.insertAgenda(agendaVo);
            
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a inclusao do registro");
        }
    }

    public void alterarAgenda(AgendaVo agendaVo) throws BusinessException {
        try {
        	validarAgenda(agendaVo);  
            dao.updateAgenda(agendaVo);
            
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a alteracao do registro");
        }
    }

    public void excluirAgenda(String rowid) throws BusinessException {
        try {
        	CompromissoDao compromissoDao = new CompromissoDao();
            if (compromissoDao.countCompromissosByAgenda(rowid) > 0) {
                throw new BusinessException("Não é possível excluir uma agenda que possui compromissos cadastrados.");
            }
            dao.deleteAgenda(rowid);
            
        } catch (BusinessException e) {
            throw e;
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a exclusao do registro");
        }
    }

    public AgendaVo buscarAgendaPor(String codigo) throws BusinessException {
        try {
            return dao.findByCodigo(codigo);
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel buscar o registro");
        }
    }
}