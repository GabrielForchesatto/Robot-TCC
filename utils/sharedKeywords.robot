*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DateTime
Variables  ../data.yaml

*** Keywords ***
Abrir browser
    ${DATA_HORA}    Get Current Date    result_format=%Y%m%d_%H%M%S
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}_${DATA_HORA}
    
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout        30 seconds
    Set Selenium Speed          0.5 seconds
    
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    ${options.binary_location}=    Set Variable    C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe
    
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-extensions
    # Barra invertida adicionada antes do sinal de igual:
    Call Method    ${options}    add_argument    --disable-blink-features\=AutomationControlled
    
    ${exclude}=    Create List    enable-automation
    Call Method    ${options}    add_experimental_option    excludeSwitches    ${exclude}
    Call Method    ${options}    add_experimental_option    useAutomationExtension    ${False}
    
    Create Webdriver    Chrome    options=${options}
    Go To    about:blank

Fechar Browser
    Close Browser

Acessar site da Automation Exercise
    Go To    ${URL_BASE}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath://img[@alt='Website for automation practice']
    Capture Page Screenshot