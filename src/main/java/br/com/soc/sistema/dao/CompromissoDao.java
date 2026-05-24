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
import java.util.List;

import br.com.soc.sistema.exception.TechnicalException;
import br.com.soc.sistema.vo.CompromissoVo;

public class CompromissoDao extends Dao {


    private static final String INSERT = "INSERT INTO compromisso (id_funcionario, id_agenda, dt_compromisso, hr_compromisso) VALUES (?, ?, ?, ?)";
    private static final String SELECT_ALL = "SELECT c.id, c.id_funcionario, f.nm_funcionario, c.id_agenda, a.nm_agenda, c.dt_compromisso, c.hr_compromisso "
                                           + "FROM compromisso c "
                                           + "INNER JOIN funcionario f ON c.id_funcionario = f.id "
                                           + "INNER JOIN agenda a ON c.id_agenda = a.id";
    private static final String SELECT_BY_DATE = "SELECT c.id, f.id AS id_funcionario, f.nm_funcionario, a.id AS id_agenda, a.nm_agenda, c.dt_compromisso, c.hr_compromisso "
                                               + "FROM compromisso c "
                                               + "INNER JOIN funcionario f ON c.id_funcionario = f.id "
                                               + "INNER JOIN agenda a ON c.id_agenda = a.id "
                                               + "WHERE c.dt_compromisso BETWEEN ? AND ?";
    private static final String SELECT_BY_ID = "SELECT id, id_funcionario, id_agenda, dt_compromisso, hr_compromisso FROM compromisso WHERE id = ?";
    private static final String COUNT_BY_AGENDA = "SELECT COUNT(*) FROM compromisso WHERE id_agenda = ?";
    private static final String UPDATE = "UPDATE compromisso SET id_funcionario = ?, id_agenda = ?, dt_compromisso = ?, hr_compromisso = ? WHERE id = ?";
    private static final String DELETE = "DELETE FROM compromisso WHERE id = ?";
    private static final String DELETE_BY_FUNC = "DELETE FROM compromisso WHERE id_funcionario = ?";

    public void insertCompromisso(CompromissoVo compromissoVo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(INSERT)) {

            ps.setInt(1, Integer.parseInt(compromissoVo.getIdFuncionario()));
            ps.setInt(2, Integer.parseInt(compromissoVo.getIdAgenda()));
            ps.setDate(3, Date.valueOf(LocalDate.parse(compromissoVo.getData())));
            ps.setTime(4, Time.valueOf(LocalTime.parse(compromissoVo.getHora())));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao tentar inserir o compromisso no banco de dados.", e);
        }
    }

    public List<CompromissoVo> findAllCompromissos() {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_ALL);
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
            throw new TechnicalException("Erro ao buscar a lista de compromissos.", e);
        }
    }
    
    public List<CompromissoVo> findCompromissosByDateRange(String dataInicial, String dataFinal) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_DATE)) {

            ps.setDate(1, Date.valueOf(dataInicial));
            ps.setDate(2, Date.valueOf(dataFinal));

            try (ResultSet rs = ps.executeQuery()) {
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
            }
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao buscar compromissos por período.", e);
        }
    }
    
    public CompromissoVo findByCodigo(String codigo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(SELECT_BY_ID)) {

            ps.setInt(1, Integer.parseInt(codigo));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { 
                    CompromissoVo vo = new CompromissoVo();
                    vo.setRowid(rs.getString("id"));
                    vo.setIdFuncionario(rs.getString("id_funcionario"));
                    vo.setIdAgenda(rs.getString("id_agenda"));
                    vo.setData(rs.getDate("dt_compromisso").toLocalDate().toString());
                    vo.setHora(rs.getTime("hr_compromisso").toLocalTime().toString());
                    return vo;
                }
            }
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao buscar o compromisso pelo código.", e);
        }
        return null;
    }
    
    public int countCompromissosByAgenda(String idAgenda) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(COUNT_BY_AGENDA)) {

            ps.setInt(1, Integer.parseInt(idAgenda));

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao contar compromissos da agenda.", e);
        }
        return 0;
    }

    public void updateCompromisso(CompromissoVo compromissoVo) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(UPDATE)) {

            ps.setInt(1, Integer.parseInt(compromissoVo.getIdFuncionario()));
            ps.setInt(2, Integer.parseInt(compromissoVo.getIdAgenda()));
            ps.setDate(3, Date.valueOf(LocalDate.parse(compromissoVo.getData())));
            ps.setTime(4, Time.valueOf(LocalTime.parse(compromissoVo.getHora())));
            ps.setInt(5, Integer.parseInt(compromissoVo.getRowid()));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao atualizar o compromisso no banco de dados.", e);
        }
    }
    
    public void deleteCompromisso(String rowid) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(DELETE)) {
             
            ps.setInt(1, Integer.parseInt(rowid));
            ps.executeUpdate();
            
        } catch (SQLException e) {
            throw new TechnicalException("Erro ao excluir o compromisso.", e);
        }
    }
    
    public void deleteCompromissosByFuncionario(String idFuncionario) {
        try (Connection con = getConexao();
             PreparedStatement ps = con.prepareStatement(DELETE_BY_FUNC)) {

            ps.setInt(1, Integer.parseInt(idFuncionario));
            ps.executeUpdate();

        } catch (SQLException e) {
            throw new TechnicalException("Erro ao excluir compromissos do funcionário.", e);
        }
    }
}