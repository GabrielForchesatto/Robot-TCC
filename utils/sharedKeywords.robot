*** Settings ***
Library  SeleniumLibrary  run_on_failure=Capture Page Screenshot
Library  DebugLibrary

*** Keywords ***

Abrir browser
    Set Screenshot Directory    ${OUTPUT DIR}/screenshots/${TEST_NAME}

    Set Selenium Implicit Wait  40 seconds
    Set Selenium Timeout        40 seconds
    Set Selenium Speed          0.3 seconds

    Create Webdriver  Chrome

Fechar Browser
    Close Window  