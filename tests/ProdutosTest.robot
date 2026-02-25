*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/HomeResource.robot
Resource    ../resources/LoginResource.robot
Resource    ../resources/MeusDadosResource.robot

Test Setup     Abrir browser
Test Teardown  Fechar browser

*** Test Cases ***
Validar Produtos na Home Page
    [Tags]  id-001
    Acessar site da Automation Exercise
    Validar que a lista de produtos está visível