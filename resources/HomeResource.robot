*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot

*** Keywords ***
Clicar no botão "Contact Us"
    Click Element    xpath://a[@href='/contact_us']
    Wait Until Element Is Visible    xpath://div[@class='contact-form']

Validar que a lista de produtos está visível
    Wait Until Element Is Visible    xpath://div[@class='features_items']
    Page Should Contain    FEATURES ITEMS
    Capture Page Screenshot    