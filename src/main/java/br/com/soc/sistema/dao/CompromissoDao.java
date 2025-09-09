package br.com.soc.sistema.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import br.com.soc.sistema.vo.CompromissoVo;

public class CompromissoDao extends Dao {

    public void insertCompromisso(CompromissoVo compromissoVo) {
        StringBuilder query = new StringBuilder("INSERT INTO compromisso (id_funcionario, id_agenda, dt_compromisso, hr_compromisso) VALUES (?, ?, ?, ?)");
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            int i = 1;
            ps.setString(i++, compromissoVo.getIdFuncionario());
            ps.setString(i++, compromissoVo.getIdAgenda());
            ps.setDate(i++, Date.valueOf(LocalDate.parse(compromissoVo.getData())));
            ps.setTime(i++, Time.valueOf(LocalTime.parse(compromissoVo.getHora())));
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CompromissoVo> findAllCompromissos() {
        StringBuilder query = new StringBuilder(
            "SELECT c.rowid id, c.id_funcionario, f.nm_funcionario, c.id_agenda, a.nm_agenda, c.dt_compromisso, c.hr_compromisso "
          + "FROM compromisso c "
          + "INNER JOIN funcionario f ON c.id_funcionario = f.rowid "
          + "INNER JOIN agenda a ON c.id_agenda = a.rowid"
        );
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString());
             ResultSet rs = ps.executeQuery()) {

            List<CompromissoVo> compromissos = new ArrayList<>();
            DateTimeFormatter dtfData = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter dtfHora = DateTimeFormatter.ofPattern("HH:mm");

            while (rs.next()) {
                CompromissoVo vo = new CompromissoVo();
                vo.setRowid(rs.getString("id"));
                vo.setIdFuncionario(rs.getString("id_funcionario"));
                vo.setNomeFuncionario(rs.getString("nm_funcionario"));
                vo.setIdAgenda(rs.getString("id_agenda"));
                vo.setNomeAgenda(rs.getString("nm_agenda"));
                vo.setData(rs.getDate("dt_compromisso").toLocalDate().format(dtfData));
                vo.setHora(rs.getTime("hr_compromisso").toLocalTime().format(dtfHora));
                compromissos.add(vo);
            }
            return compromissos;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return Collections.emptyList();
    }
    
    public List<CompromissoVo> findCompromissosByDateRange(String dataInicial, String dataFinal) {
        StringBuilder query = new StringBuilder(
            "SELECT c.rowid id, f.rowid id_funcionario, f.nm_funcionario, a.rowid id_agenda, a.nm_agenda, c.dt_compromisso, c.hr_compromisso "
          + "FROM compromisso c "
          + "INNER JOIN funcionario f ON c.id_funcionario = f.rowid "
          + "INNER JOIN agenda a ON c.id_agenda = a.rowid "
          + "WHERE c.dt_compromisso BETWEEN ? AND ?"
        );

        List<CompromissoVo> compromissos = new ArrayList<>();
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setDate(1, java.sql.Date.valueOf(dataInicial));
            ps.setDate(2, java.sql.Date.valueOf(dataFinal));

            try (ResultSet rs = ps.executeQuery()) {
                DateTimeFormatter dtfData = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                DateTimeFormatter dtfHora = DateTimeFormatter.ofPattern("HH:mm");
                while (rs.next()) {
                    CompromissoVo vo = new CompromissoVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setIdFuncionario(rs.getString("id_funcionario"));
                    vo.setNomeFuncionario(rs.getString("nm_funcionario"));
                    vo.setIdAgenda(rs.getString("id_agenda"));
                    vo.setNomeAgenda(rs.getString("nm_agenda"));
					vo.setData(rs.getDate("dt_compromisso").toLocalDate().format(dtfData));
					vo.setHora(rs.getTime("hr_compromisso").toLocalTime().format(dtfHora));
                    compromissos.add(vo);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return compromissos;
    }
    
    public CompromissoVo findByCodigo(String codigo) {
        StringBuilder query = new StringBuilder("SELECT rowid id, id_funcionario, id_agenda, dt_compromisso, hr_compromisso FROM compromisso ")
            .append("WHERE rowid = ?");

        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setString(1, codigo);

            try (ResultSet rs = ps.executeQuery()) {
                CompromissoVo vo = null;
                if (rs.next()) {
                    vo = new CompromissoVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setIdFuncionario(rs.getString("id_funcionario"));
                    vo.setIdAgenda(rs.getString("id_agenda"));
                    vo.setData(rs.getDate("dt_compromisso").toLocalDate().toString());
                    vo.setHora(rs.getTime("hr_compromisso").toLocalTime().toString());
                }
                return vo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public int countCompromissosByAgenda(String idAgenda) {
        StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM compromisso WHERE id_agenda = ?");

        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setString(1, idAgenda);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void updateCompromisso(CompromissoVo compromissoVo) {
        StringBuilder query = new StringBuilder("UPDATE compromisso SET id_funcionario = ?, id_agenda = ?, dt_compromisso = ?, hr_compromisso = ? WHERE rowid = ?");
        
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            int i = 1;
            ps.setString(i++, compromissoVo.getIdFuncionario());
            ps.setString(i++, compromissoVo.getIdAgenda());
            
            ps.setDate(i++, Date.valueOf(LocalDate.parse(compromissoVo.getData())));
            ps.setTime(i++, Time.valueOf(LocalTime.parse(compromissoVo.getHora())));
            
            ps.setString(i++, compromissoVo.getRowid());
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteCompromisso(String rowid) {
        StringBuilder query = new StringBuilder("DELETE FROM compromisso WHERE rowid = ?");
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {
            ps.setString(1, rowid);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void deleteCompromissosByFuncionario(String idFuncionario) {
        StringBuilder query = new StringBuilder("DELETE FROM compromisso WHERE id_funcionario = ?");

        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(query.toString())) {

            ps.setString(1, idFuncionario);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}