*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/HomeResource.robot
Resource    ../resources/AutenticacaoResource.robot
Resource    ../resources/MeusDadosResource.robot

Test Setup     Abrir browser
Test Teardown  Fechar browser

*** Test Cases ***


Realizar Login com Sucesso
    [Tags]  id-001
    Acessar site da Automation Exercise
    Realizar Login
    Validar usuário logado

Excluir conta com sucesso
    [Tags]  id-002    
    Acessar site da Automation Exercise
    Realizar Login
    Clicar no botão "Delete Account"
    Validar que a conta foi excluída

Preencher formulário de Contato (Simulando alteração de dados)
    [Tags]  id-003
    Acessar site da Automation Exercise
    Clicar no botão "Contact Us"
    Preencher formulário de contato
    Enviar formulário
    Validar mensagem de sucesso do envio

Cadastrar Usuário com Sucesso
    [Tags]  id-004
    Acessar site da Automation Exercise
    Iniciar Cadastro de Usuário
    Preencher Formulário de Cadastro
    Finalizar Cadastro
    Validar Conta Criada com Sucesso
    Clicar no botão "Delete Account"
    Validar que a conta foi excluída