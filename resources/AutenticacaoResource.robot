*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DebugLibrary
Library    String  
Variables  ../data.yaml

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

Iniciar Cadastro de Usuário
    Click Element    xpath://a[@href='/login']
    Wait Until Element Is Visible    xpath://div[@class='signup-form']
    
    ${SUFIXO_ALEATORIO}    Generate Random String    6    [LOWER][NUMBERS]
    ${EMAIL_DINAMICO}      Set Variable    gabriel.tcc.${SUFIXO_ALEATORIO}@gmail.com
    
    Input Text       xpath://input[@data-qa='signup-name']     ${NOME_NOVO}
    Input Text       xpath://input[@data-qa='signup-email']    ${EMAIL_DINAMICO}
    
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
    Select From List By Value    id:country    Israel
    Input Text       id:state          ${ESTADO}
    Input Text       id:city           ${CIDADE}
    Input Text       id:zipcode        ${CEP}
    Input Text       id:mobile_number  ${CELULAR}
    Capture Page Screenshot

Finalizar Cadastro
    Click Element    xpath://button[@data-qa='create-account']

Validar Conta Criada com Sucesso
    Wait Until Element Is Visible    xpath://h2[@data-qa='account-created']
    Click Element    xpath://a[@data-qa='continue-button']
    
    # Valida se logou automaticamente após criar    
    Wait Until Element Is Visible    xpath://li/a[contains(text(), 'Logged in as')]
    Capture Page Screenshot

# --- KEYWORDS DE EXCLUSÃO ---
Clicar no botão "Delete Account"
    Click Element    xpath://a[@href='/delete_account']

Validar que a conta foi excluída
    Wait Until Element Is Visible    xpath://h2[@data-qa='account-deleted']
    Page Should Contain              ACCOUNT DELETED
    Click Element    xpath://a[@data-qa='continue-button']
    Capture Page Screenshot