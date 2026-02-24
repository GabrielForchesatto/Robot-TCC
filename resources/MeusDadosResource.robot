*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DebugLibrary

*** Keywords ***
Então o campo "${campo}" deve conter "${dado}"
    Debug

Quando ele clica no botão
    [Arguments]  ${botao}
    Debug