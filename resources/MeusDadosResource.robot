*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Variables  ../data.yaml

*** Keywords ***
Preencher formulário de contato
    Input Text       xpath://input[@data-qa='name']        ${NOME_CONTATO}
    Input Text       xpath://input[@data-qa='email']       ${EMAIL_CONTATO}
    Input Text       xpath://input[@data-qa='subject']     ${ASSUNTO}
    Input Text       xpath://textarea[@data-qa='message']  ${MENSAGEM}

Enviar formulário
    Click Element    xpath://input[@data-qa='submit-button']
    Handle Alert     ACCEPT

Validar mensagem de sucesso do envio
    Wait Until Element Is Visible    xpath://div[@class='status alert alert-success']
    Element Text Should Be           xpath://div[@class='status alert alert-success']    Success! Your details have been submitted successfully.
    Click Element                    xpath://a[@class='btn btn-success']