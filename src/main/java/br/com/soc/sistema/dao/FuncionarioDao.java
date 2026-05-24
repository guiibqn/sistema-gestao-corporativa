package br.com.soc.sistema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.soc.sistema.exception.TechnicalException;
import br.com.soc.sistema.vo.FuncionarioVo;

public class FuncionarioDao extends Dao {
    
    private static final String INSERT = "INSERT INTO funcionario (nm_funcionario) VALUES (?)";
    private static final String UPDATE = "UPDATE funcionario SET nm_funcionario = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM funcionario WHERE id = ?";
    private static final String SELECT_ALL = "SELECT id, nm_funcionario AS nome FROM funcionario";
    private static final String SELECT_BY_NOME = "SELECT id, nm_funcionario AS nome FROM funcionario WHERE lower(nm_funcionario) LIKE lower(?)";
    private static final String SELECT_BY_ID = "SELECT id, nm_funcionario AS nome FROM funcionario WHERE id = ?";

    public void insertFuncionario(FuncionarioVo funcionarioVo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(INSERT)) {
            
            ps.setString(1, funcionarioVo.getNome());
            ps.executeUpdate();
            
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar inserir o funcionário no banco de dados.", e);
        }
    }
    
    public void updateFuncionario(FuncionarioVo vo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(UPDATE)) {

            ps.setString(1, vo.getNome());
            ps.setInt(2, Integer.parseInt(vo.getRowid()));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar atualizar o funcionário no banco de dados.", e);
        }
    }
    
    public void deleteFuncionario(FuncionarioVo vo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(DELETE)) {

        	ps.setInt(1, Integer.parseInt(vo.getRowid()));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar excluir o funcionário do banco de dados.", e);
        }
    }
    
    public List<FuncionarioVo> findAllFuncionarios() {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {
            
            List<FuncionarioVo> funcionarios = new ArrayList<>();
            while (rs.next()) {
                FuncionarioVo vo = new FuncionarioVo();
                vo.setRowid(rs.getString("id"));
                vo.setNome(rs.getString("nome"));    
                funcionarios.add(vo);
            }
            return funcionarios;
            
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar buscar a lista de funcionários.", e);
        }
    }
    
    public List<FuncionarioVo> findAllByNome(String nome) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_NOME)) {
            
            ps.setString(1, "%" + nome + "%");
            
            try (ResultSet rs = ps.executeQuery()) {
                List<FuncionarioVo> funcionarios = new ArrayList<>();
                while (rs.next()) {
                    FuncionarioVo vo = new FuncionarioVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setNome(rs.getString("nome"));    
                    funcionarios.add(vo);
                }
                return funcionarios;
            }
            
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar buscar funcionários pelo nome.", e);
        }        
    }
    
    public FuncionarioVo findByCodigo(Integer codigo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {
            
            ps.setInt(1, codigo);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { 
                    FuncionarioVo vo = new FuncionarioVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setNome(rs.getString("nome"));    
                    return vo;
                }
            }
            
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar buscar o funcionário pelo código.", e);
        }        
        return null;
    }
}