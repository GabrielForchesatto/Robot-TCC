*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/HomeResource.robot
Resource    ../resources/MeusDadosResource.robot
Resource    ../resources/LoginResource.robot


Test Setup     Abrir browser
Test Teardown  Fechar browser


*** Test Cases ***
Realizar Login
    [Tags]  id-001
    Acessar site da Kabum
    Realizar Login 
    Validar usuário logado
    
Exibir dados pessoais corretamente ao acessar a página
    [Tags]  id-002
    Logar no site da KaBuM
    Acessar a página  Meus Dados
    Então o campo "Nome completo" deve conter "Gabriel Forchesatto Valendorf"
    Então o campo "Telefone celular" deve conter "(54) 9 9906-4799"
    Então o campo "E-mail" deve conter "gabrielvalendorf@gmail.com"
    Então o campo "CPF" deve estar mascarado corretamente
    Então o campo "Data de nascimento" deve estar preenchido

Alterar telefone com sucesso
    [Tags]  id-003
    Dado que o usuário está logado no site KaBuM
    Quando ele acessa a página  Meus Dados
    Quando ele altera o campo "Telefone celular" para "(54) 9 9999-9999"
    E clica no botão "SALVAR ALTERAÇÕES"
    Então uma mensagem de sucesso deve ser exibida
    E o novo número deve ser salvo e exibido na próxima visita

Excluir conta com confirmação
    [Tags]  id-004
    Dado que o usuário está logado no site KaBuM
    Quando ele acessa a página  Meus Dados
    Quando ele clica no botão  EXCLUIR MINHA CONTA
    Então uma janela de confirmação deve ser exibida
    E ao confirmar, a conta deve ser excluída
    E o usuário deve ser redirecionado para a página inicial

Adicionar novo endereço
    [Tags]  id-005
    Dado que o usuário está na seção "Endereços"
    Quando ele clica em "CADASTRAR NOVO ENDEREÇO"
    E preenche o formulário com dados válidos
    E clica no botão "Salvar"
    Então o novo endereço deve aparecer na lista
    E deve ser possível defini-lo como endereço padrão

Redirecionamento para alteração de senha
    [Tags]  id-006
    Dado que o usuário está na página  "Meus Dados"
    Quando ele clica no botão "ALTERAR SENHA"
    Então ele deve ser redirecionado para a página de alteração de senha

Ativar recebimento de marketing
    [Tags]  id-007
    Dado que o checkbox "Quero receber ofertas..." está desmarcado
    Quando o usuário marca o checkbox
    E clica em "SALVAR ALTERAÇÕES"
    Então a preferência deve ser salva corretamente