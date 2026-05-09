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
    
    Capture Page Screenshot

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

    Capture Page Screenshot
    Wait Until Element Is Visible  xpath://a[@data-qa='continue-button']
    Click Element  xpath://a[@data-qa='continue-button']

    Reload Page

    ${status} =    Run Keyword And Return Status    Wait Until Element Is Visible    xpath://a[@data-qa='continue-button']    timeout=10s
    IF    ${status}
        Click Element    xpath://a[@data-qa='continue-button']
    END

# --- KEYWORDS DE EXCLUSÃO ---
Clicar no botão "Delete Account"
    Capture Page Screenshot
    Click Element    xpath://a[@href='/delete_account']

Validar que a conta foi excluída
    Wait Until Element Is Visible    xpath://h2[@data-qa='account-deleted']

    Capture Page Screenshot
    Click Element    xpath://a[@data-qa='continue-button']
    Capture Page Screenshot

Tentar Login com Credenciais
    [Arguments]    ${email_teste}    ${senha_teste}
    Click Element    xpath://a[@href='/login']
    Wait Until Element Is Visible    xpath://div[@class='login-form']
    Input Text       xpath://input[@data-qa='login-email']       ${email_teste}
    Input Text       xpath://input[@data-qa='login-password']    ${senha_teste}
    Click Element    xpath://button[@data-qa='login-button']

Validar Mensagem de Erro no Login
    Wait Until Page Contains    Your email or password is incorrect!
    Capture Page Screenshot

Realizar Logout do Sistema
    Click Element    xpath://a[@href='/logout']
    Capture Page Screenshot

Validar que voltou para a tela de Login
    Wait Until Element Is Visible    xpath://div[@class='login-form']
    Page Should Contain    Login to your account
    Capture Page Screenshot

Preencher nome e e-mail já cadastrado
    [Arguments]    ${nome}    ${email}
    Wait Until Element Is Visible    xpath://input[@data-qa='signup-name']    timeout=10s
    Input Text    xpath://input[@data-qa='signup-name']     ${nome}
    Input Text    xpath://input[@data-qa='signup-email']    ${email}

Clicar em Signup
    Click Button    xpath://button[@data-qa='signup-button']

Validar mensagem de erro de e-mail duplicado
    Wait Until Element Is Visible    xpath://p[text()='Email Address already exist!']    timeout=10s
    Page Should Contain              Email Address already exist!
    Capture Page Screenshot

Acessar página de Login ou Signup
    Wait Until Element Is Visible    xpath://a[@href='/login']    timeout=10s
    Click Element                    xpath://a[@href='/login']
    Wait Until Element Is Visible    xpath://div[@class='signup-form']    timeout=10s