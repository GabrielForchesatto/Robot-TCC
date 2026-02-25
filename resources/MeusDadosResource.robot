*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot

*** Variables ***
${NOME_CONTATO}    Gabriel Valendorf
${EMAIL_CONTATO}   gabrielvalendorf@gmail.com
${ASSUNTO}         Dúvida TCC
${MENSAGEM}        Este é um teste automatizado para o TCC.

*** Keywords ***
Preencher formulário de contato
    Input Text       xpath://input[@data-qa='name']        ${NOME_CONTATO}
    Input Text       xpath://input[@data-qa='email']       ${EMAIL_CONTATO}
    Input Text       xpath://input[@data-qa='subject']     ${ASSUNTO}
    Input Text       xpath://textarea[@data-qa='message']  ${MENSAGEM}
    # O upload de arquivo é opcional, mas se quiser testar:
    # Choose File      xpath://input[@name='upload_file']   ${EXECDIR}/tcc.pdf

Enviar formulário
    Click Element    xpath://input[@data-qa='submit-button']
    # Lidar com o alerta do navegador (popup de confirmação)
    Handle Alert     ACCEPT

Validar mensagem de sucesso do envio
    Wait Until Element Is Visible    xpath://div[@class='status alert alert-success']
    Element Text Should Be           xpath://div[@class='status alert alert-success']    Success! Your details have been submitted successfully.
    Click Element                    xpath://a[@class='btn btn-success']