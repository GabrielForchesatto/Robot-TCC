*** Settings ***
Library  SeleniumLibrary  run_on_failure=Capture Page Screenshot

*** Keywords ***
Abrir browser
    # Cria o diretório de screenshots se não existir
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}
    
    # Configurações de timeout para evitar falhas por lentidão da rede
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout        30 seconds
    
    # Um pequeno delay ajuda a visualizar a execução durante o desenvolvimento
    Set Selenium Speed          0.5 seconds

    Open Browser    about:blank    Chrome

Fechar Browser
    Close Browser

Acessar site da Automation Exercise
    Go To    https://automationexercise.com/
    Maximize Browser Window
    Wait Until Page Contains Element    xpath://img[@alt='Website for automation practice']
    Capture Page Screenshot