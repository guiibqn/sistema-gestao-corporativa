package br.com.soc.sistema.action;

import java.util.ArrayList;
import java.util.List;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;


import br.com.soc.sistema.business.CompromissoBusiness;
import br.com.soc.sistema.exception.BusinessException;
import br.com.soc.sistema.infra.Action;
import br.com.soc.sistema.vo.CompromissoVo;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


public class RelatorioAction extends Action {
    private static final long serialVersionUID = 1L;

    private List<CompromissoVo> compromissos = new ArrayList<>();
    private CompromissoBusiness business = new CompromissoBusiness();
    
    private String dataInicial;
    private String dataFinal;
    private InputStream excelStream;

    public String index() {
        return INPUT;
    }

    public String gerar() {
        try {
            compromissos = business.buscarCompromissosPorPeriodo(dataInicial, dataFinal);
            return INPUT;
        } catch (BusinessException e) {
            addActionError(e.getMessage());
            return INPUT;
        } catch (Exception e) {
            return ERROR;
        }
    }
    
     
    public String exportar() {
        try {
            compromissos = business.buscarCompromissosPorPeriodo(dataInicial, dataFinal);

            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet("Compromissos");

            int rownum = 0;
            Row headerRow = sheet.createRow(rownum++);
            String[] headers = {"Cód. Funcionário", "Nome Funcionário", "Cód. Agenda", "Nome Agenda", "Data", "Hora"};
            for(int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
            }

            for (CompromissoVo compromisso : compromissos) {
                Row row = sheet.createRow(rownum++);
                row.createCell(0).setCellValue(compromisso.getIdFuncionario());
                row.createCell(1).setCellValue(compromisso.getNomeFuncionario());
                row.createCell(2).setCellValue(compromisso.getIdAgenda());
                row.createCell(3).setCellValue(compromisso.getNomeAgenda());
                row.createCell(4).setCellValue(compromisso.getData());
                row.createCell(5).setCellValue(compromisso.getHora());
            }

            ByteArrayOutputStream bos = new ByteArrayOutputStream();
            workbook.write(bos);
            workbook.close();

            excelStream = new ByteArrayInputStream(bos.toByteArray());
            return SUCCESS;

        } catch (BusinessException e) {
            addActionError("Preencha as datas inicial e final para exportar o relatório.");
            return INPUT;
        } catch (Exception e) {
            return ERROR;
        }
    }

    public InputStream getExcelStream() { return excelStream; }
    public List<CompromissoVo> getCompromissos() { return compromissos; }
    public void setCompromissos(List<CompromissoVo> compromissos) { this.compromissos = compromissos; }
    public String getDataInicial() { return dataInicial; }
    public void setDataInicial(String dataInicial) { this.dataInicial = dataInicial; }
    public String getDataFinal() { return dataFinal; }
    public void setDataFinal(String dataFinal) { this.dataFinal = dataFinal; }
}