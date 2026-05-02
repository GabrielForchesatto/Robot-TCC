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

Remover Produto do Carrinho
    [Tags]  id-012  carrinho
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Acessar a página do carrinho
    Remover o produto do carrinho
    Validar que o carrinho está vazio

Adicionar Avaliação (Review) em um Produto
    [Tags]  id-013  produtos
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Preencher formulário de avaliação    ${NOME_CONTATO}    ${EMAIL}    Ótimo produto, atende aos requisitos do TCC!
    Enviar avaliação
    Validar mensagem de sucesso da avaliação

Filtrar Produtos por Categoria Feminina (Dress)
    [Tags]  id-014  produtos  filtros
    Acessar site da Automation Exercise
    Clicar na categoria "Women"
    Clicar na subcategoria "Dress"
    Validar que a página de produtos da categoria foi carregada


