*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/ProdutoResource.robot
Resource    ../resources/AutenticacaoResource.robot

Test Setup     Abrir browser
Test Teardown  Fechar browser

*** Test Cases ***

Pesquisar Produto Específico
    [Tags]  id-007  produtos
    Acessar site da Automation Exercise
    Pesquisar pelo produto    ${PRODUTO_BUSCA}
    Validar se o produto pesquisado é exibido

Adicionar Produto ao Carrinho
    [Tags]  id-008  carrinho
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Validar se o produto está no carrinho    ${NOME_PRODUTO_CARRINHO}

Validar Inscrição na Newsletter (Rodapé)
    [Tags]  id-009  home
    Acessar site da Automation Exercise
    Rolar até o rodapé
    Preencher e-mail para inscrição    ${EMAIL_SUBSCRIPTION}
    Validar mensagem de sucesso na inscrição

Visualizar Detalhes do Produto
    [Tags]  id-010  produtos
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Validar detalhes do produto (Preço e Categoria)

Fluxo de Checkout Completo (E2E)
    [Tags]  id-011  e2e
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Ir para a tela de Checkout
    Realizar Login 
    Prosseguir para o Pagamento
    Finalizar Pedido e Validar Sucesso