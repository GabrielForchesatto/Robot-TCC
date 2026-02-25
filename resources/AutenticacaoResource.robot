*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DebugLibrary

*** Variables ***
${EMAIL}          gabrielvalendorf@gmail.com
${SENHA}          123456Ab

# --- DADOS PARA NOVO CADASTRO ---
${NOME_NOVO}      Gabriel Teste TCC
${EMAIL_NOVO}     gabriel.tcc.novo@gmail.com
${SENHA_NOVA}     123456
${PRIMEIRO_NOME}  Gabriel
${ULTIMO_NOME}    Valendorf
${ENDERECO}       Rua Exemplo TCC, 123
${ESTADO}         Rio Grande do Sul
${CIDADE}         Passo Fundo
${CEP}            99070-000
${CELULAR}        54999999999

*** Keywords ***
Realizar Login
    Click Element    xpath://a[@href='/login']
    Wait Until Element Is Visible    xpath://div[@class='login-form']
    Input Text       xpath://input[@data-qa='login-email']       ${EMAIL}
    Input Text       xpath://input[@data-qa='login-password']    ${SENHA}
    Click Element    xpath://button[@data-qa='login-button']
    Capture Page Screenshot

Validar usuário logado
    Wait Until Element Is Visible    xpath://li/a[contains(text(), 'Logged in as')]
    Page Should Contain              Logged in as
    Capture Page Screenshot

# --- KEYWORDS DE CADASTRO ---
Iniciar Cadastro de Usuário
    Click Element    xpath://a[@href='/login']
    Wait Until Element Is Visible    xpath://div[@class='signup-form']
    Input Text       xpath://input[@data-qa='signup-name']     ${NOME_NOVO}
    Input Text       xpath://input[@data-qa='signup-email']    ${EMAIL_NOVO}
    Click Element    xpath://button[@data-qa='signup-button']

Preencher Formulário de Cadastro
    Wait Until Element Is Visible    xpath://b[contains(text(),'Enter Account Information')]
    
    # Informações da Conta
    Click Element                id:id_gender1  # Seleciona "Mr."
    Input Text                   id:password    ${SENHA_NOVA}
    Select From List By Value    id:days     15
    Select From List By Value    id:months   6
    Select From List By Value    id:years    1995
    
    # Checkboxes (Newsletter e Ofertas)
    Click Element    id:newsletter
    Click Element    id:optin
    
    # Informações de Endereço
    Input Text       id:first_name     ${PRIMEIRO_NOME}
    Input Text       id:last_name      ${ULTIMO_NOME}
    Input Text       id:address1       ${ENDERECO}
    Select From List By Value    id:country    India
    Input Text       id:state          ${ESTADO}
    Input Text       id:city           ${CIDADE}
    Input Text       id:zipcode        ${CEP}
    Input Text       id:mobile_number  ${CELULAR}
    Capture Page Screenshot

Finalizar Cadastro
    Click Element    xpath://button[@data-qa='create-account']

Validar Conta Criada com Sucesso
    Wait Until Element Is Visible    xpath://h2[@data-qa='account-created']
    Page Should Contain              ACCOUNT CREATED
    Click Element    xpath://a[@data-qa='continue-button']
    
    # Valida se logou automaticamente após criar
    Wait Until Element Is Visible    xpath://li/a[contains(text(), 'Logged in as')]
    Page Should Contain              Logged in as
    Capture Page Screenshot

# --- KEYWORDS DE EXCLUSÃO ---
Clicar no botão "Delete Account"
    Click Element    xpath://a[@href='/delete_account']

Validar que a conta foi excluída
    Wait Until Element Is Visible    xpath://h2[@data-qa='account-deleted']
    Page Should Contain              ACCOUNT DELETED
    Click Element    xpath://a[@data-qa='continue-button']
    Capture Page Screenshot