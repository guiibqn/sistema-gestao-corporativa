-- ===============================================================
-- Criação e população da tabela de Funcionário
-- ===============================================================
CREATE TABLE funcionario (
  rowid BIGINT AUTO_INCREMENT PRIMARY KEY,
  nm_funcionario VARCHAR(255) NOT NULL
);

INSERT INTO funcionario (nm_funcionario) VALUES ('João'), ('Maria'), ('José'), ('Joana');

-- ===============================================================
-- Criação e população da tabela de Agenda
-- ===============================================================
CREATE TABLE agenda (
  rowid BIGINT AUTO_INCREMENT PRIMARY KEY,
  nm_agenda VARCHAR(255) NOT NULL,
  tp_periodo VARCHAR(1) NOT NULL -- 1=Manhã, 2=Tarde, 3=Ambos
);

INSERT INTO agenda (nm_agenda, tp_periodo) VALUES ('Agenda da Manhã', '1');
INSERT INTO agenda (nm_agenda, tp_periodo) VALUES ('Agenda da Tarde', '2');
INSERT INTO agenda (nm_agenda, tp_periodo) VALUES ('Agenda Integral', '3');

-- ===============================================================
-- Criação da tabela de Compromisso
-- ===============================================================
CREATE TABLE compromisso (
  rowid BIGINT AUTO_INCREMENT PRIMARY KEY,
  id_funcionario BIGINT NOT NULL,
  id_agenda BIGINT NOT NULL,
  dt_compromisso DATE NOT NULL,
  hr_compromisso TIME NOT NULL,
  FOREIGN KEY (id_funcionario) REFERENCES funcionario(rowid),
  FOREIGN KEY (id_agenda) REFERENCES agenda(rowid)
);

-- ===============================================================
-- Inserção de dados iniciais na tabela de Compromisso
-- ===============================================================
-- Compromisso para o João (ID 1) na Agenda da Manhã (ID 1)
INSERT INTO compromisso (id_funcionario, id_agenda, dt_compromisso, hr_compromisso) VALUES (1, 1, '2025-09-15', '10:00:00');
-- Compromisso para a Maria (ID 2) na Agenda da Tarde (ID 2)
INSERT INTO compromisso (id_funcionario, id_agenda, dt_compromisso, hr_compromisso) VALUES (2, 2, '2025-09-15', '15:30:00');
-- Compromisso para o José (ID 3) na Agenda Integral (ID 3)
INSERT INTO compromisso (id_funcionario, id_agenda, dt_compromisso, hr_compromisso) VALUES (3, 3, '2025-09-16', '11:00:00');