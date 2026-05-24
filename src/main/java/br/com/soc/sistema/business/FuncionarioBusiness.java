package br.com.soc.sistema.business;

import java.util.ArrayList;
import java.util.List;

import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.dao.FuncionarioDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.filter.FuncionarioFilter;
import br.com.soc.sistema.vo.FuncionarioVo;

public class FuncionarioBusiness {

    private static final String FOI_INFORMADO_CARACTER_NO_LUGAR_DE_UM_NUMERO = "Foi informado um caracter no lugar de um numero";
    
    private final FuncionarioDao dao;
    
    public FuncionarioBusiness() {
        this.dao = new FuncionarioDao();
    }
    
    public List<FuncionarioVo> trazerTodosOsFuncionarios() {
        return dao.findAllFuncionarios();
    }
    

    private void validarFuncionario(FuncionarioVo funcionarioVo) {
        if (funcionarioVo.getNome() == null || funcionarioVo.getNome().trim().isEmpty()) {
            throw new BusinessException("Nome nao pode ser em branco");
        }
    }
    

    public void salvarFuncionario(FuncionarioVo funcionarioVo) {
        validarFuncionario(funcionarioVo);
        dao.insertFuncionario(funcionarioVo);
    }
    
    public void alterarFuncionario(FuncionarioVo funcionarioVo) {
        validarFuncionario(funcionarioVo);
        dao.updateFuncionario(funcionarioVo);
    }
    
    public void excluirFuncionario(FuncionarioVo vo) {
        CompromissoDao compromissoDao = new CompromissoDao();
        compromissoDao.deleteCompromissosByFuncionario(vo.getRowid());
        
        dao.deleteFuncionario(vo);
    }
    
    public List<FuncionarioVo> filtrarFuncionarios(FuncionarioFilter filter) {
        List<FuncionarioVo> funcionarios = new ArrayList<>();
        
        switch (filter.getOpcoesCombo()) {
            case ID:
                try {
                    Integer codigo = Integer.parseInt(filter.getValorBusca());
                    FuncionarioVo vo = dao.findByCodigo(codigo);
                    
                    if (vo != null) {
                        funcionarios.add(vo);
                    }
                } catch (NumberFormatException e) {
                    throw new BusinessException(FOI_INFORMADO_CARACTER_NO_LUGAR_DE_UM_NUMERO);
                }
                break;

            case NOME:
                funcionarios.addAll(dao.findAllByNome(filter.getValorBusca()));
                break;
        }
        
        return funcionarios;
    }
    
    public FuncionarioVo buscarFuncionarioPor(String codigo) {
        try {
            Integer cod = Integer.parseInt(codigo);
            return dao.findByCodigo(cod);
        } catch (NumberFormatException e) {
            throw new BusinessException(FOI_INFORMADO_CARACTER_NO_LUGAR_DE_UM_NUMERO);
        }
    }
}