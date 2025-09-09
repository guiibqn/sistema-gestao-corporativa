package br.com.soc.sistema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import br.com.soc.sistema.vo.AgendaVo;

public class AgendaDao extends Dao {

    public void insertAgenda(AgendaVo agendaVo) {
        StringBuilder query = new StringBuilder("INSERT INTO agenda (nm_agenda, tp_periodo) values (?, ?)");
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            int i = 1;
            ps.setString(i++, agendaVo.getNome());
            ps.setString(i++, agendaVo.getPeriodo());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<AgendaVo> findAllAgendas() {
        StringBuilder query = new StringBuilder("SELECT rowid id, nm_agenda nome, tp_periodo periodo FROM agenda");
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString());
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
            e.printStackTrace();
        }
        
        return Collections.emptyList();
    }
    
    public void updateAgenda(AgendaVo agendaVo) {
        StringBuilder query = new StringBuilder("UPDATE agenda SET nm_agenda = ?, tp_periodo = ? WHERE rowid = ?");
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setString(1, agendaVo.getNome());
            ps.setString(2, agendaVo.getPeriodo());
            ps.setString(3, agendaVo.getRowid());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteAgenda(String rowid) {
        StringBuilder query = new StringBuilder("DELETE FROM agenda WHERE rowid = ?");
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setString(1, rowid);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public AgendaVo findByCodigo(String codigo) {
        StringBuilder query = new StringBuilder("SELECT rowid id, nm_agenda nome, tp_periodo periodo FROM agenda ")
            .append("WHERE rowid = ?");

        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {
            
            ps.setString(1, codigo);

            try (ResultSet rs = ps.executeQuery()) {
                AgendaVo vo = null;
                if (rs.next()) {
                    vo = new AgendaVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setNome(rs.getString("nome"));
                    vo.setPeriodo(rs.getString("periodo"));
                }
                return vo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}