# Robot-TCC — Automação de Testes Regressivos com Robot Framework + Selenium

Projeto desenvolvido como parte do Trabalho de Conclusão de Curso (TCC) na Atitus Educação, com o objetivo de avaliar a viabilidade financeira da automação de testes regressivos em comparação com a execução manual, por meio do cálculo de ROI.

A plataforma utilizada como sistema sob teste é o [Automation Exercise](https://automationexercise.com/), um e-commerce de prática para automação.

---

## Estrutura do Projeto

```
Robot-TCC/
├── tests/
│   ├── AutenticacaoTest.robot   # Cenários de autenticação (7 casos)
│   └── ProdutoTest.robot        # Cenários de produtos e checkout (23 casos)
├── resources/
│   ├── AutenticacaoResource.robot
│   ├── HomeResource.robot
│   ├── MeusDadosResource.robot
│   └── ProdutoResource.robot
├── utils/
│   └── sharedKeywords.robot     # Keywords compartilhadas entre suítes
├── evidenciaManual/             # Evidências em PDF e MP4 da execução manual
├── screenshots/                 # Screenshots gerados automaticamente
├── overleaf/                    # Artigo LaTeX do TCC
├── data.yaml                    # Dados de teste (URLs, credenciais, fixtures)
└── requirements.txt             # Dependências Python
```

---

## Pré-requisitos

- Python 3.8 ou superior
- Google Chrome instalado
- Git

---

## Instalação

### 1. Clonar o repositório

```bash
git clone https://github.com/seu-usuario/Robot-TCC.git
cd Robot-TCC
```

### 2. Criar e ativar um ambiente virtual (recomendado)

```bash
python -m venv venv

# Windows
venv\Scripts\activate

# Linux / macOS
source venv/bin/activate
```

### 3. Instalar as dependências

```bash
pip install -r requirements.txt
```

O `requirements.txt` instala automaticamente:

- `robotframework` — framework de testes
- `robotframework-seleniumlibrary` — integração com Selenium
- `webdriver-manager` — gerenciamento automático do ChromeDriver
- `robotframework-debuglibrary` — utilitário de debug interativo
- `pyyaml` — leitura do arquivo `data.yaml`

### 4. Verificar a instalação

```bash
robot --version
```

---

## Configuração

Os dados de teste estão centralizados em `data.yaml`. Antes de executar, revise os campos abaixo caso queira usar suas próprias credenciais:

```yaml
EMAIL: "gabriel.tcc.novo@gmail.com"
SENHA: "123456"
```

> As credenciais são usadas apenas no site de prática Automation Exercise. Não use dados reais.

---

## Execução dos Testes

### Rodar todos os testes

```bash
python -m robot -d results tests/
```

### Rodar apenas autenticação

```bash
python -m robot -d results tests/AutenticacaoTest.robot
```

### Rodar apenas produtos

```bash
python -m robot -d results tests/ProdutoTest.robot
```

### Rodar por tag

```bash
# Apenas testes E2E
python -m robot -d results --include e2e tests/

# Apenas testes negativos
python -m robot -d results --include negativo tests/

# Apenas um cenário específico
python -m robot -d results --include id-005 tests/
```

### Gerar relatório em pasta específica

```bash
python -m robot -d results --outputdir results tests/
```

---

## Resultados

Após a execução, os seguintes arquivos são gerados:

| Arquivo | Descrição |
|---|---|
| `report.html` | Relatório visual completo dos testes |
| `output.xml` | Saída estruturada para integração CI |
| `Autenticacao.html` | Log detalhado da suíte de autenticação |
| `produtoTest.html` | Log detalhado da suíte de produtos |
| `screenshots/` | Capturas de tela automáticas por cenário |

Abra `report.html` no navegador para visualizar os resultados.

---

## Cenários Automatizados

### Autenticação (7 cenários)

| ID | Cenário |
|---|---|
| id-001 | Cadastrar Usuário com Sucesso |
| id-002 | Realizar Login com Sucesso |
| id-003 | Excluir conta com sucesso |
| id-004 | Preencher formulário de Contato |
| id-005 | Login com Senha Incorreta |
| id-006 | Realizar Logout |
| id-007 | Tentativa de cadastro com e-mail já existente |

### Produtos e Checkout (23 cenários)

| ID | Cenário |
|---|---|
| id-001 | Pesquisar Produto Específico |
| id-002 | Adicionar Produto ao Carrinho |
| id-003 | Validar Inscrição na Newsletter (Rodapé) |
| id-004 | Visualizar Detalhes do Produto |
| id-005 | Fluxo de Checkout Completo (E2E) |
| id-006 | Remover Produto do Carrinho |
| id-007 | Adicionar Avaliação (Review) em um Produto |
| id-008 | Filtrar Produtos por Categoria Feminina |
| id-009 | Adicionar produto com quantidade customizada |
| id-010 | Filtrar produtos por marca específica |
| id-011 | Busca por produto inexistente |
| id-012 | Download de fatura após finalizar compra |
| id-013 | Verificar equivalência de endereços no Checkout |
| id-014 | Validação de obrigatoriedade no formulário de Contato |
| id-015 | Adicionar múltiplos produtos diferentes ao carrinho |
| id-016 | Interceptação de Checkout para usuário não logado |
| id-017 | Filtrar produtos por categoria Masculina |
| id-018 | Alternância entre diferentes marcas de produtos |
| id-019 | Persistência do carrinho após Logout e novo Login |
| id-020 | Inscrição na Newsletter via página do Carrinho |
| id-021 | Filtrar produtos pela categoria Infantil |
| id-022 | Tentativa de envio de avaliação em branco |
| id-023 | Remover item específico de carrinho com múltiplos produtos |

---