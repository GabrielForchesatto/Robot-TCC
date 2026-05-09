*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library    DateTime
Variables  ../data.yaml

*** Keywords ***
*** Keywords ***
Abrir browser
    ${DATA_HORA}    Get Current Date    result_format=%Y%m%d_%H%M%S
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}_${DATA_HORA}
    
    Set Selenium Implicit Wait  10 seconds
    Set Selenium Timeout        30 seconds
    Set Selenium Speed          0.5 seconds
    
    ${options}=    Evaluate    selenium.webdriver.ChromeOptions()    modules=selenium.webdriver
    ${options.binary_location}=    Set Variable    C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe
    
    # Argumentos básicos
    Call Method    ${options}    add_argument    --incognito
    Call Method    ${options}    add_argument    --disable-extensions
    Call Method    ${options}    add_argument    --no-first-run
    Call Method    ${options}    add_argument    --no-default-browser-check
    Call Method    ${options}    add_argument    --headless
    
    # Uso de variáveis para evitar falha no parse do sinal de igual (=) pelo Robot
    ${arg_automation}=    Set Variable    --disable-blink-features=AutomationControlled
    Call Method    ${options}    add_argument    ${arg_automation}
    
    ${arg_brave_features}=    Set Variable    --disable-features=BraveP3A,BraveShields,BraveRewards
    Call Method    ${options}    add_argument    ${arg_brave_features}
    
    # Remoção da flag de controle automatizado
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
    
    # Aguarda o botão 'Home' do menu superior em vez da imagem do logo
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Home')]    timeout=30s
    
    Capture Page Screenshot