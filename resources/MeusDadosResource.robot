*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Variables  ../data.yaml

*** Keywords ***
Preencher formulário de contato
    Input Text       xpath://input[@data-qa='name']        ${NOME_CONTATO}
    Input Text       xpath://input[@data-qa='email']       ${EMAIL_CONTATO}
    Input Text       xpath://input[@data-qa='subject']     ${ASSUNTO}
    Input Text       xpath://textarea[@data-qa='message']  ${MENSAGEM}
    Capture Page Screenshot

Enviar formulário
    Click Element    xpath://input[@data-qa='submit-button']
    Handle Alert     ACCEPT

Validar mensagem de sucesso do envio
    Capture Page Screenshot
    Wait Until Element Is Visible    xpath://div[@class='status alert alert-success']
    Element Text Should Be           xpath://div[@class='status alert alert-success']    Success! Your details have been submitted successfully.
    Capture Page Screenshot
    Click Element                    xpath://a[@class='btn btn-success']


Acessar Detalhes da Conta
    Wait Until Element Is Visible    xpath://li/a[contains(text(), 'Logged in as')]

Alterar Cidade e Celular
    [Arguments]    ${cidade}    ${celular}
    Debug
    Input Text    id:city             ${cidade}
    Input Text    id:mobile_number    ${celular}

Salvar Alterações de Cadastro
    Scroll Element Into View    xpath://button[@data-qa='create-account']
    Click Element               xpath://button[@data-qa='create-account']

Validar Dados Atualizados
    [Arguments]    ${cidade_esperada}    ${celular_esperado}
    Page Should Contain    ${cidade_esperada}
    Page Should Contain    ${celular_esperado}
    Capture Page Screenshot