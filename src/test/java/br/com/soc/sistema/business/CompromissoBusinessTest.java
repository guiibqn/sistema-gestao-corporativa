package br.com.soc.sistema.business;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.when;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import br.com.soc.sistema.dao.AgendaDao;
import br.com.soc.sistema.dao.CompromissoDao;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.vo.AgendaVo;
import br.com.soc.sistema.vo.CompromissoVo;

public class CompromissoBusinessTest {

    @Mock
    private CompromissoDao compromissoDaoMock;

    @Mock
    private AgendaDao agendaDaoMock;

    private CompromissoBusiness business;

    @BeforeEach
    public void setup() {
        // Inicializa os Mocks "falsos" antes de cada teste
        MockitoAnnotations.openMocks(this);
        
        // Injetando os DAOs simulados na nossa classe de negócio
        business = new CompromissoBusiness(compromissoDaoMock, agendaDaoMock);
    }

    @Test
    public void deveLancarErroQuandoAgendaNaoExistir() {
        CompromissoVo compromisso = new CompromissoVo();
        compromisso.setIdFuncionario("1");
        compromisso.setIdAgenda("99"); // Agenda inexistente
        compromisso.setData("2026-10-10");
        compromisso.setHora("10:00");

        // Simulando que o banco não encontrou a agenda
        when(agendaDaoMock.findByCodigo("99")).thenReturn(null);

        BusinessException erro = assertThrows(BusinessException.class, () -> {
            business.salvarCompromisso(compromisso);
        });

        assertEquals("A agenda selecionada não foi encontrada.", erro.getMessage());
    }

    @Test
    public void deveLancarErroQuandoHorarioForIncompativelComPeriodoManha() {
        // Preparando a agenda para ser APENAS MANHÃ (1)
        AgendaVo agendaManha = new AgendaVo();
        agendaManha.setRowid("1");
        agendaManha.setPeriodo("1"); 
        
        when(agendaDaoMock.findByCodigo("1")).thenReturn(agendaManha);

        // Criando um compromisso de TARDE (14:00) para forçar o choque
        CompromissoVo compromisso = new CompromissoVo();
        compromisso.setIdFuncionario("1");
        compromisso.setIdAgenda("1");
        compromisso.setData("2026-10-10");
        compromisso.setHora("14:00"); // Fora do horário permitido!

        BusinessException erro = assertThrows(BusinessException.class, () -> {
            business.salvarCompromisso(compromisso);
        });

        assertEquals("O horário do compromisso é incompatível com o período disponível da agenda.", erro.getMessage());
    }
}