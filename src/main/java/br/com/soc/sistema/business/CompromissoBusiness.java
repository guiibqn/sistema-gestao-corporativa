package br.com.soc.sistema.business;

import java.time.LocalTime;
import java.util.List;

import br.com.soc.sistema.dao.AgendaDao;
import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.vo.AgendaVo;
import br.com.soc.sistema.vo.CompromissoVo;

public class CompromissoBusiness {

    private final CompromissoDao dao;
    private final AgendaDao agendaDao;

    public CompromissoBusiness() {
        this.dao = new CompromissoDao();
        this.agendaDao = new AgendaDao();
    }
    
    public CompromissoBusiness(CompromissoDao dao, AgendaDao agendaDao) {
        this.dao = dao;
        this.agendaDao = agendaDao;
    }

    public List<CompromissoVo> trazerTodosOsCompromissos() {
        return dao.findAllCompromissos();
    }
    
    public List<CompromissoVo> buscarCompromissosPorPeriodo(String dataInicial, String dataFinal) {
        if (dataInicial == null || dataInicial.trim().isEmpty() || dataFinal == null || dataFinal.trim().isEmpty()) {
            throw new BusinessException("As datas inicial e final são obrigatórias para gerar o relatório.");
        }
        return dao.findCompromissosByDateRange(dataInicial, dataFinal);
    }
    
    private void validarCamposObrigatorios(CompromissoVo compromissoVo) {
        if (compromissoVo.getIdFuncionario() == null || compromissoVo.getIdFuncionario().trim().isEmpty()) {
            throw new BusinessException("Funcionário é obrigatório.");
        }
        if (compromissoVo.getIdAgenda() == null || compromissoVo.getIdAgenda().trim().isEmpty()) {
            throw new BusinessException("Agenda é obrigatória.");
        }
        if (compromissoVo.getData() == null || compromissoVo.getData().trim().isEmpty()) {
            throw new BusinessException("Data é obrigatória.");
        }
        if (compromissoVo.getHora() == null || compromissoVo.getHora().trim().isEmpty()) {
            throw new BusinessException("Hora é obrigatória.");
        }
    }
    
    private void validarRegrasDeNegocio(CompromissoVo compromissoVo) {
        AgendaVo agendaSelecionada = agendaDao.findByCodigo(compromissoVo.getIdAgenda());
        if(agendaSelecionada == null){
            throw new BusinessException("A agenda selecionada não foi encontrada.");
        }

        LocalTime horaCompromisso = LocalTime.parse(compromissoVo.getHora());
        String periodoAgenda = agendaSelecionada.getPeriodo();

        boolean horarioValido = false;
        switch (periodoAgenda) {
            case "1": // Manhã (08:00 - 11:59)
                if (!horaCompromisso.isBefore(LocalTime.of(8, 0)) && horaCompromisso.isBefore(LocalTime.of(12, 0))) {
                    horarioValido = true;
                }
                break;
            case "2": // Tarde (13:00 - 17:59)
                if (!horaCompromisso.isBefore(LocalTime.of(13, 0)) && horaCompromisso.isBefore(LocalTime.of(18, 0))) {
                    horarioValido = true;
                }
                break;
            case "3": // Ambos
                horarioValido = true;
                break;
        }

        if (!horarioValido) {
            throw new BusinessException("O horário do compromisso é incompatível com o período disponível da agenda.");
        }
        
        boolean existeChoque = dao.existeChoqueHorario(
                compromissoVo.getIdFuncionario(), 
                compromissoVo.getData(), 
                compromissoVo.getHora(), 
                compromissoVo.getRowid()
            );
            
            if (existeChoque) {
                throw new BusinessException("Este funcionário já possui um compromisso agendado exatamente nesta data e horário.");
            }
    }

    public void salvarCompromisso(CompromissoVo compromissoVo) {
        validarCamposObrigatorios(compromissoVo);
        validarRegrasDeNegocio(compromissoVo);
        dao.insertCompromisso(compromissoVo);
    }
    
    public void alterarCompromisso(CompromissoVo compromissoVo) {
        validarCamposObrigatorios(compromissoVo);
        validarRegrasDeNegocio(compromissoVo);
        dao.updateCompromisso(compromissoVo);
    }
    
    public void excluirCompromisso(String rowid) {
        dao.deleteCompromisso(rowid);
    }
    
    public CompromissoVo buscarCompromissoPor(String codigo) {
        return dao.findByCodigo(codigo);
    }
}