package br.com.soc.sistema.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import br.com.soc.sistema.exception.TechnicalException;

public abstract class Dao implements AutoCloseable {

    private static boolean primeiraInicializacao = true;
    private Connection con = null;
    

    private static final String DRIVER = "org.postgresql.Driver";
    private static final String URL = "jdbc:postgresql://localhost:5432/gestao_corporativa";
    private static final String USER = "postgres";
    private static final String PASS = "123";

    public Dao() {
        conectar();
    }

    private void conectar() {
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, USER, PASS);
            
            if (primeiraInicializacao) {
                criarTabelasIniciais();
                primeiraInicializacao = false;
            }

        } catch (SQLException ex) {
            throw new TechnicalException("Ocorreu um problema na tentativa de conexao com o banco de dados", ex);
        } catch (ClassNotFoundException e) {
            throw new TechnicalException("Driver do banco não encontrado. Verifique as dependências do Maven", e);
        }
    }
    
    private void criarTabelasIniciais() {
        String sqlFuncionario = "CREATE TABLE IF NOT EXISTS funcionario ("
                              + "id SERIAL PRIMARY KEY, "
                              + "nm_funcionario VARCHAR(255) NOT NULL)";
        
        
        String sqlAgenda = "CREATE TABLE IF NOT EXISTS agenda ("
                		 + "id SERIAL PRIMARY KEY, "
                		 + "nm_agenda VARCHAR(255) NOT NULL, "
                		 + "tp_periodo VARCHAR(255))";
        
        
        String sqlCompromisso = "CREATE TABLE IF NOT EXISTS compromisso ("
                + "id SERIAL PRIMARY KEY, "
                + "id_funcionario INT NOT NULL, "
                + "id_agenda INT NOT NULL, "
                + "dt_compromisso DATE NOT NULL, "
                + "hr_compromisso TIME NOT NULL, "
                + "CONSTRAINT fk_funcionario FOREIGN KEY (id_funcionario) REFERENCES funcionario(id), "
                + "CONSTRAINT fk_agenda FOREIGN KEY (id_agenda) REFERENCES agenda(id))";
        
        try (Statement st = con.createStatement()) {
            st.execute(sqlFuncionario);
            st.execute(sqlAgenda);
            st.execute(sqlCompromisso);
            System.out.println("[SOC-LOG] Tabela 'funcionario' verificada/criada no PostgreSQL com sucesso!");
        } catch (SQLException e) {
            System.err.println("[SOC-LOG] Erro ao tentar criar a tabela no banco: " + e.getMessage());
        }
    }

    private void fechar() throws SQLException {
        if (con == null)
            throw new TechnicalException("Conexao nao foi criada");

        if (con.isClosed())
            throw new TechnicalException("Conexao ja foi encerrada");

        con.close();
    }

    @Override
    public void close() throws Exception {
        try {
            fechar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * retorna uma conexao
     * @return
     * @throws SQLException 
     */
    protected Connection getConexao() throws SQLException {
        if (con == null || con.isClosed())
            conectar();
        return con;
    }
}