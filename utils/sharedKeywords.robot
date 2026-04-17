*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DateTime
Variables  ../data.yaml

*** Keywords ***
Abrir browser
    ${DATA_HORA}    Get Current Date    result_format=%Y%m%d_%H%M%S
    
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}_${DATA_HORA}
    
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout        20 seconds
    Set Selenium Speed          0.5 seconds
    Open Browser    about:blank    Chrome    options=add_argument("--incognito")
    
Fechar Browser
    Close Browser

Acessar site da Automation Exercise
    Go To    ${URL_BASE}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath://img[@alt='Website for automation practice']
    Capture Page Screenshot