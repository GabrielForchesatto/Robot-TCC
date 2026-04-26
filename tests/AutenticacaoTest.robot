*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/HomeResource.robot
Resource    ../resources/AutenticacaoResource.robot
Resource    ../resources/MeusDadosResource.robot

Test Setup     Abrir browser
Test Teardown  Fechar browser

*** Test Cases ***

Cadastrar Usuário com Sucesso
    [Tags]  id-001
    Acessar site da Automation Exercise
    Iniciar Cadastro de Usuário
    Preencher Formulário de Cadastro
    Finalizar Cadastro
    Validar Conta Criada com Sucesso

Realizar Login com Sucesso
    [Tags]  id-002
    Acessar site da Automation Exercise
    Realizar Login
    Validar usuário logado

Excluir conta com sucesso
    [Tags]  id-003    
    Acessar site da Automation Exercise
    Iniciar Cadastro de Usuário
    Preencher Formulário de Cadastro
    Finalizar Cadastro
    Validar Conta Criada com Sucesso
    Clicar no botão "Delete Account"
    Validar que a conta foi excluída

Preencher formulário de Contato (Simulando alteração de dados)
    [Tags]  id-004
    Acessar site da Automation Exercise
    Clicar no botão "Contact Us"
    Preencher formulário de contato
    Enviar formulário
    Validar mensagem de sucesso do envio

Login com Senha Incorreta
    [Tags]  id-005  negativo
    Acessar site da Automation Exercise
    Tentar Login com Credenciais    ${EMAIL}    ${SENHA_ERRADA}
    Validar Mensagem de Erro no Login

Realizar Logout
    [Tags]  id-006
    Acessar site da Automation Exercise
    Realizar Login
    Realizar Logout do Sistema
    Validar que voltou para a tela de Login

