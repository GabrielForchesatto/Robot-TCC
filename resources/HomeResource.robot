*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DebugLibrary

*** Keywords ***
Acessar a página
    [Arguments]  ${pagina}
    Debug