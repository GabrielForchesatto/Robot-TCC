*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DebugLibrary

*** Keywords ***
Acessar site da Kabum
    Go To             https://www.kabum.com.br/
    Sleep   2
    Maximize Browser Window
    Capture Page Screenshot


Realizar Login 
    Click Element                  id:linkLoginHeader
    Capture Page Screenshot
    Wait Until Element Is Enabled  name:login
    Input Text                     name:login    gabrielvalendorf@gmail.com
    Input Text                     name:password  123456Ab
    Capture Page Screenshot
    Click Element                  xpath://button[@data-testid="login-submit-button"]
    
Validar usuário logado
    Wait Until Page Contains  Olá, Gabriel
    Capture Page Screenshot
    Page Should Contain    Olá, Gabriel

Logar no site da KaBuM
    Realizar Login 
    Validar usuário logado
