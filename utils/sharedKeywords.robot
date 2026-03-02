*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Variables  ../data.yaml

*** Keywords ***
Abrir browser
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout        30 seconds
    Set Selenium Speed          0.5 seconds
    Open Browser    about:blank    Chrome

Fechar Browser
    Close Browser

Acessar site da Automation Exercise
    Go To    ${URL_BASE}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath://img[@alt='Website for automation practice']
    Capture Page Screenshot