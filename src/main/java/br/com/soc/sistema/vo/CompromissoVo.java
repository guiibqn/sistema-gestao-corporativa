package br.com.soc.sistema.vo;

public class CompromissoVo {

    private String rowid;
    private String idFuncionario;
    private String idAgenda;
    private String data;
    private String hora;
    private String nomeFuncionario;
    private String nomeAgenda;

    public CompromissoVo() {}

    public CompromissoVo(String rowid, String idFuncionario, String idAgenda, String data, String hora) {
        this.rowid = rowid;
        this.idFuncionario = idFuncionario;
        this.idAgenda = idAgenda;
        this.data = data;
        this.hora = hora;
    }

    public String getRowid() { 
    	return rowid; 
    }
    
    public void setRowid(String rowid) { 
    	this.rowid = rowid;
    }
    
    public String getIdFuncionario() { 
    	return idFuncionario; 
    }
    
    public void setIdFuncionario(String idFuncionario) { 
    	this.idFuncionario = idFuncionario; 
    }
    
    public String getIdAgenda() { 
    	return idAgenda; 
    }
    
    public void setIdAgenda(String idAgenda) { 
    	this.idAgenda = idAgenda; 
    }
    
    public String getData() { 
    	return data; 
    }
    
    public void setData(String data) { 
    	this.data = data; 
    }
    
    public String getHora() { 
    	return hora; 
    }
    
    public void setHora(String hora) { 
    	this.hora = hora; 
    }
    
    public String getNomeFuncionario() { 
    	return nomeFuncionario; 
    }
    
    public void setNomeFuncionario(String nomeFuncionario) { 
    	this.nomeFuncionario = nomeFuncionario; 
    }
    
    public String getNomeAgenda() { 
    	return nomeAgenda; 
    }
    
    public void setNomeAgenda(String nomeAgenda) { 
    	this.nomeAgenda = nomeAgenda; 
    }

    @Override
    public String toString() {
        return "CompromissoVo [rowid=" + rowid + ", idFuncionario=" + idFuncionario + ", idAgenda=" + idAgenda + ", data=" + data + ", hora=" + hora + "]";
    }
}