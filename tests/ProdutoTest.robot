*** Settings ***
Resource    ../utils/sharedKeywords.robot
Resource    ../resources/ProdutoResource.robot
Resource    ../resources/AutenticacaoResource.robot

Test Setup     Abrir browser
Test Teardown  Fechar browser

*** Test Cases ***

Pesquisar Produto Específico
    [Tags]  id-001  produtos
    Acessar site da Automation Exercise
    Pesquisar pelo produto    ${PRODUTO_BUSCA}
    Validar se o produto pesquisado é exibido

Adicionar Produto ao Carrinho
    [Tags]  id-002  carrinho
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Validar se o produto está no carrinho    ${NOME_PRODUTO_CARRINHO}

Validar Inscrição na Newsletter (Rodapé)
    [Tags]  id-003  home
    Acessar site da Automation Exercise
    Rolar até o rodapé
    Preencher e-mail para inscrição    ${EMAIL_SUBSCRIPTION}
    Validar mensagem de sucesso na inscrição

Visualizar Detalhes do Produto
    [Tags]  id-004  produtos
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Validar detalhes do produto (Preço e Categoria)

Fluxo de Checkout Completo (E2E)
    [Tags]  id-005  e2e
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Ir para a tela de Checkout
    Realizar Login 
    Prosseguir para o Pagamento
    Finalizar Pedido e Validar Sucesso

Remover Produto do Carrinho
    [Tags]  id-006  carrinho
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Acessar a página do carrinho
    Remover o produto do carrinho
    Validar que o carrinho está vazio

Adicionar Avaliação (Review) em um Produto
    [Tags]  id-007  produtos
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Preencher formulário de avaliação    ${NOME_CONTATO}    ${EMAIL}    Ótimo produto, atende aos requisitos do TCC!
    Enviar avaliação
    Validar mensagem de sucesso da avaliação

Filtrar Produtos por Categoria Feminina (Dress)
    [Tags]  id-008  produtos  filtros
    Acessar site da Automation Exercise
    Clicar na categoria "Women"
    Clicar na subcategoria "Dress"
    Validar que a página de produtos da categoria foi carregada

Adicionar produto ao carrinho com quantidade customizada
    [Tags]  id-009  carrinho
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Alterar quantidade do produto para    4
    Adicionar ao carrinho na tela de detalhes
    Validar produto no carrinho com quantidade    ${NOME_PRODUTO_CARRINHO}    4

Filtrar produtos por marca específica
    [Tags]  id-010  produtos  filtros
    Acessar site da Automation Exercise
    Acessar menu de Produtos
    Clicar na marca "Polo"
    Validar que os produtos da marca "Polo" são exibidos

Busca por produto inexistente
    [Tags]  id-011  produtos  busca
    Acessar site da Automation Exercise
    Pesquisar pelo produto    ProdutoFicticio123
    Validar que nenhum produto é retornado na busca

Download de fatura (Invoice) após finalizar compra
    [Tags]  id-012  e2e  fatura
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Ir para a tela de Checkout
    Realizar Login
    Prosseguir para o Pagamento
    Finalizar Pedido e Validar Sucesso
    Baixar fatura do pedido
    Avançar após download da fatura

Verificar equivalência de endereços no Checkout
    [Tags]  id-013  e2e  checkout
    Acessar site da Automation Exercise
    Realizar Login
    Adicionar o primeiro produto ao carrinho
    Ir para a tela de Checkout logado
    Validar que o endereço de entrega é igual ao de faturamento

Validação de obrigatoriedade no formulário de Contato
    [Tags]  id-014  negativo  contato
    Acessar site da Automation Exercise
    Acessar página de contato
    Clicar no botão de enviar contato
    Validar que o formulário não foi enviado

Adicionar múltiplos produtos diferentes ao carrinho
    [Tags]  id-015  carrinho
    Acessar site da Automation Exercise
    Acessar menu de Produtos
    Adicionar produto ao carrinho por ID    1
    Continuar comprando no modal
    Adicionar produto ao carrinho por ID    2
    Acessar a página do carrinho
    Validar que o carrinho contém múltiplos produtos

Interceptação de Checkout para usuário não logado (Visitante)
    [Tags]  id-016  checkout  negativo
    Acessar site da Automation Exercise
    Adicionar o primeiro produto ao carrinho
    Acessar a página do carrinho
    Tentar prosseguir para o Checkout como Visitante
    Validar modal de aviso para login no checkout

Filtrar produtos por categoria Masculina (Men)
    [Tags]  id-017  produtos  filtros
    Acessar site da Automation Exercise
    Clicar na categoria "Men"
    Clicar na subcategoria "Tshirts"
    Validar que a página de produtos da categoria masculina foi carregada

Alternância entre diferentes marcas de produtos
    [Tags]  id-018  produtos  filtros
    Acessar site da Automation Exercise
    Acessar menu de Produtos
    Clicar na marca "Polo"
    Validar que os produtos da marca "Polo" são exibidos
    Clicar na marca "Madame"
    Validar que os produtos da marca "Madame" são exibidos

Persistência do carrinho de compras após Logout e novo Login
    [Tags]  id-019  carrinho  e2e
    Acessar site da Automation Exercise
    Realizar Login
    Acessar menu de Produtos
    Adicionar o primeiro produto ao carrinho
    Realizar Logout do Sistema
    Realizar Login
    Acessar a página do carrinho
    Validar se o produto está no carrinho    ${NOME_PRODUTO_CARRINHO}

Inscrição na Newsletter via página do Carrinho
    [Tags]  id-020  carrinho  newsletter
    Acessar site da Automation Exercise
    Acessar a página do carrinho
    Rolar até o rodapé
    Preencher e-mail para inscrição    ${EMAIL_SUBSCRIPTION}
    Validar mensagem de sucesso na inscrição    
    
Filtrar produtos pela categoria Infantil (Kids)
    [Tags]  id-021  produtos  filtros
    Acessar site da Automation Exercise
    Clicar na categoria "Kids"
    Clicar na subcategoria infantil "Dress"
    Validar que a página de produtos da categoria infantil foi carregada

Tentativa de envio de avaliação em branco
    [Tags]  id-022  produtos  negativo
    Acessar site da Automation Exercise
    Clicar em "View Product" do primeiro item
    Deixar campos de avaliação em branco e tentar enviar
    Validar que o formulário de avaliação não foi enviado

Remover item específico de um carrinho com múltiplos produtos
    [Tags]  id-023  carrinho
    Acessar site da Automation Exercise
    Acessar menu de Produtos
    Adicionar produto ao carrinho por ID    1
    Continuar comprando no modal
    Adicionar produto ao carrinho por ID    2
    Continuar comprando no modal
    Adicionar produto ao carrinho por ID    3
    Acessar a página do carrinho
    Remover o segundo produto do carrinho
    Validar que o segundo produto foi removido e os demais permanecem