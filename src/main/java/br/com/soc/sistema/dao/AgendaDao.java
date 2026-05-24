package br.com.soc.sistema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.com.soc.sistema.exception.TechnicalException;
import br.com.soc.sistema.vo.AgendaVo;

public class AgendaDao extends Dao {


    private static final String INSERT = "INSERT INTO agenda (nm_agenda, tp_periodo) VALUES (?, ?)";
    private static final String SELECT_ALL = "SELECT id, nm_agenda AS nome, tp_periodo AS periodo FROM agenda";
    private static final String UPDATE = "UPDATE agenda SET nm_agenda = ?, tp_periodo = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM agenda WHERE id = ?";
    private static final String SELECT_BY_ID = "SELECT id, nm_agenda AS nome, tp_periodo AS periodo FROM agenda WHERE id = ?";

    public void insertAgenda(AgendaVo agendaVo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(INSERT)) {

            ps.setString(1, agendaVo.getNome());
            ps.setString(2, agendaVo.getPeriodo());
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar inserir a agenda no banco de dados.", e);
        }
    }

    public List<AgendaVo> findAllAgendas() {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
             ResultSet rs = ps.executeQuery()) {

            List<AgendaVo> agendas = new ArrayList<>();
            while (rs.next()) {
                AgendaVo vo = new AgendaVo();
                vo.setRowid(rs.getString("id"));
                vo.setNome(rs.getString("nome"));
                vo.setPeriodo(rs.getString("periodo"));
                agendas.add(vo);
            }
            return agendas;

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar buscar a lista de agendas.", e);
        }
    }
    
    public void updateAgenda(AgendaVo agendaVo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(UPDATE)) {

            ps.setString(1, agendaVo.getNome());
            ps.setString(2, agendaVo.getPeriodo());
            ps.setInt(3, Integer.parseInt(agendaVo.getRowid()));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar atualizar a agenda no banco de dados.", e);
        }
    }

    public void deleteAgenda(String rowid) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(DELETE)) {

            ps.setInt(1, Integer.parseInt(rowid));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar excluir a agenda do banco de dados.", e);
        }
    }

    public AgendaVo findByCodigo(String codigo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {
            
            ps.setInt(1, Integer.parseInt(codigo));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { 
                    AgendaVo vo = new AgendaVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setNome(rs.getString("nome"));
                    vo.setPeriodo(rs.getString("periodo"));
                    return vo;
                }
            }
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar buscar a agenda pelo código.", e);
        }
        
        return null;
    }
}