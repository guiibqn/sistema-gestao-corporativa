package br.com.soc.sistema.business;

import java.time.LocalTime;
import java.util.List;

import br.com.soc.sistema.dao.AgendaDao;
import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.vo.AgendaVo;
import br.com.soc.sistema.vo.CompromissoVo;

public class CompromissoBusiness {

    private CompromissoDao dao;
    private AgendaDao agendaDao;

    public CompromissoBusiness() {
        this.dao = new CompromissoDao();
        this.agendaDao = new AgendaDao();
    }

    public List<CompromissoVo> trazerTodosOsCompromissos() {
        return dao.findAllCompromissos();
    }
    
    public List<CompromissoVo> buscarCompromissosPorPeriodo(String dataInicial, String dataFinal) throws BusinessException {
        if (dataInicial == null || dataInicial.trim().isEmpty() || dataFinal == null || dataFinal.trim().isEmpty()) {
            throw new BusinessException("As datas inicial e final são obrigatórias para gerar o relatório.");
        }

        try {
            return dao.findCompromissosByDateRange(dataInicial, dataFinal);
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a consulta de compromissos");
        }
    }
    
    private void validarCamposObrigatorios(CompromissoVo compromissoVo) throws IllegalArgumentException {
        if (compromissoVo.getIdFuncionario() == null || compromissoVo.getIdFuncionario().trim().isEmpty()) {
            throw new IllegalArgumentException("Funcionário é obrigatório");
        }
        if (compromissoVo.getIdAgenda() == null || compromissoVo.getIdAgenda().trim().isEmpty()) {
            throw new IllegalArgumentException("Agenda é obrigatória");
        }
        if (compromissoVo.getData() == null || compromissoVo.getData().isEmpty()) {
            throw new IllegalArgumentException("Data é obrigatória");
        }
        if (compromissoVo.getHora() == null || compromissoVo.getHora().isEmpty()) {
            throw new IllegalArgumentException("Hora é obrigatória");
        }
    }
    
    private void validarRegrasDeNegocio(CompromissoVo compromissoVo) throws BusinessException {
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
    	
    }
    

    public void salvarCompromisso(CompromissoVo compromissoVo) {
        try {
        	validarCamposObrigatorios(compromissoVo);
        	validarRegrasDeNegocio(compromissoVo);
            
            dao.insertCompromisso(compromissoVo);

        } catch (BusinessException e) {
            throw e;
        } catch (IllegalArgumentException e) {
            throw new BusinessException(e.getMessage());
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a inclusao do registro");
        }
    }
    
    public void alterarCompromisso(CompromissoVo compromissoVo) {
        try {
        	validarCamposObrigatorios(compromissoVo);
        	validarRegrasDeNegocio(compromissoVo);

            dao.updateCompromisso(compromissoVo);
            
        } catch (BusinessException e) {
            throw e;
        } catch (IllegalArgumentException e) {
            throw new BusinessException(e.getMessage());
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a alteracao do registro");
        }
    }
    
    public void excluirCompromisso(String rowid) throws BusinessException {
        try {
            dao.deleteCompromisso(rowid);
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel realizar a exclusao do registro");
        }
    }
    
    public CompromissoVo buscarCompromissoPor(String codigo) throws BusinessException {
        try {
            return dao.findByCodigo(codigo);
        } catch (Exception e) {
            throw new BusinessException("Nao foi possivel buscar o registro");
        }
    }
    
}