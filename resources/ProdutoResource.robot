*** Settings ***
Library    SeleniumLibrary  run_on_failure=Capture Page Screenshot
Variables  ../data.yaml
Library    DebugLibrary


*** Keywords ***
Pesquisar pelo produto
    [Arguments]    ${produto}
    Click Element    xpath://a[@href='/products']

    Wait Until Element Is Visible    id:search_product    timeout=15s
    
    Input Text       id:search_product    ${produto}
    Capture Page Screenshot
    Click Element    id:submit_search

Validar se o produto pesquisado é exibido
    Page Should Contain    Searched Products
    Capture Page Screenshot

Adicionar o primeiro produto ao carrinho
    # Rola a tela para garantir que o elemento está na área visível
    Scroll Element Into View    xpath:(//a[@data-product-id='1'])[1]
    
    # Executa o clique direto via JavaScript para driblar o overlay laranja
    Execute Javascript          document.querySelector("a[data-product-id='1']").click()
    Capture Page Screenshot

    Wait Until Element Is Visible    xpath://button[text()='Continue Shopping']    timeout=10s
    Capture Page Screenshot
    Click Element                    xpath://button[text()='Continue Shopping']

Validar se o produto está no carrinho
    [Arguments]    ${nome_produto}
    Click Element    xpath://li/a[@href='/view_cart']
    Page Should Contain    ${nome_produto}
    Capture Page Screenshot

Preencher e-mail para inscrição
    [Arguments]    ${email}
    Input Text    id:susbscribe_email    ${email}
    Capture Page Screenshot
    Click Element    id:subscribe
    Capture Page Screenshot

Validar mensagem de sucesso na inscrição
    Wait Until Element Is Visible    id:success-subscribe
    Page Should Contain    You have been successfully subscribed!
    Capture Page Screenshot

Clicar em "View Product" do primeiro item
    # Rola a tela até o elemento para garantir que ele esteja visível
    Scroll Element Into View    xpath://a[contains(@href, '/product_details/1')]
    
    Wait Until Element Is Visible    xpath://a[contains(@href, '/product_details/1')]    timeout=10s

    # Clica usando JavaScript para evitar o mesmo problema do overlay laranja que tivemos no carrinho
    Execute Javascript    document.querySelector("a[href='/product_details/1']").click()

Validar detalhes do produto (Preço e Categoria)
    # Aguarda o painel de informações do produto carregar
    Wait Until Element Is Visible    xpath://div[@class='product-information']    timeout=10s
    
    # Validações dos dados do "Blue Top" (produto 1)
    Page Should Contain    Blue Top
    Page Should Contain    Category: Women > Tops
    Page Should Contain    Rs. 500
    Page Should Contain    Availability: In Stock
    
    Capture Page Screenshot

Ir para a tela de Checkout
    # Acessa o carrinho
    Wait Until Element Is Visible    xpath://li/a[@href='/view_cart']    timeout=10s
    Click Element                    xpath://li/a[@href='/view_cart']
    
    # Clica no botão para prosseguir
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Proceed To Checkout')]    timeout=10s
    Capture Page Screenshot
    Click Element                    xpath://a[contains(text(), 'Proceed To Checkout')]
    
    # Como não estamos logados, o site abre um modal. Clicamos no link para ir para a tela de login.
    Wait Until Element Is Visible    xpath://u[contains(text(), 'Register / Login')]    timeout=10s
    Capture Page Screenshot
    Click Element                    xpath://u[contains(text(), 'Register / Login')]

Prosseguir para o Pagamento
    # Após o login ter sido feito, precisamos voltar ao carrinho e prosseguir novamente
    Wait Until Element Is Visible    xpath://li/a[@href='/view_cart']    timeout=10s
     Click Element                    xpath://li/a[@href='/view_cart']
    
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Proceed To Checkout')]    timeout=10s
    Capture Page Screenshot
    Click Element                    xpath://a[contains(text(), 'Proceed To Checkout')]
    
    # Na tela de revisão do pedido, rola até o botão e clica em Place Order
    Wait Until Element Is Visible    xpath://a[@href='/payment']    timeout=10s
    Scroll Element Into View         xpath://a[@href='/payment']
    Capture Page Screenshot
    Click Element                    xpath://a[@href='/payment']

Finalizar Pedido e Validar Sucesso
    # Aguarda o formulário de pagamento carregar
    Wait Until Element Is Visible    name:name_on_card    timeout=10s
    
    # Preenche dados fictícios de cartão
    Input Text    name:name_on_card    Gabriel Teste
    Input Text    name:card_number     4111111111111111
    Input Text    name:cvc             123
    Input Text    name:expiry_month    12
    Input Text    name:expiry_year     2030
    
    # Confirma o pagamento clicando no botão 'Pay and Confirm Order'
    Capture Page Screenshot
    Click Element    id:submit
    
    # Valida a mensagem final de sucesso
    Wait Until Element Is Visible    xpath://p[contains(text(), 'Congratulations! Your order has been confirmed!')]    timeout=15s
    Page Should Contain              Congratulations! Your order has been confirmed!
    Capture Page Screenshot

Acessar a página do carrinho
    Wait Until Element Is Visible    xpath://li/a[@href='/view_cart']    timeout=10s
    Click Element                    xpath://li/a[@href='/view_cart']
    Wait Until Page Contains         Shopping Cart    timeout=10s
    Capture Page Screenshot

Remover o produto do carrinho
    Wait Until Element Is Visible    xpath://a[@class='cart_quantity_delete']    timeout=10s
    Click Element                    xpath://a[@class='cart_quantity_delete']

Validar que o carrinho está vazio
    Wait Until Element Is Visible    xpath://b[contains(text(), 'Cart is empty!')]    timeout=10s
    Page Should Contain              Cart is empty!
    Capture Page Screenshot

# --- KEYWORDS DE AVALIAÇÃO (REVIEW) ---
Preencher formulário de avaliação
    [Arguments]    ${nome}    ${email}    ${mensagem}
    Wait Until Element Is Visible    id:name    timeout=10s
    Input Text    id:name     ${nome}
    Input Text    id:email    ${email}
    Input Text    id:review   ${mensagem}
    Capture Page Screenshot

Enviar avaliação
    Click Element    id:button-review

Validar mensagem de sucesso da avaliação
    Wait Until Element Is Visible    xpath://span[text()='Thank you for your review.']    timeout=10s
    Page Should Contain              Thank you for your review.
    Capture Page Screenshot

Clicar na categoria "Women"
    # Clica no menu sanfona para expandir as opções
    Wait Until Element Is Visible    xpath://a[@href='#Women']    timeout=10s
    Scroll Element Into View         xpath://a[@href='#Women']
    Capture Page Screenshot
    Click Element                    xpath://a[@href='#Women']

Clicar na subcategoria "Dress"
    Wait Until Element Is Visible    xpath://a[@href='/category_products/1']    timeout=10s
    Click Element                    xpath://a[@href='/category_products/1']

Validar que a página de produtos da categoria foi carregada
    Wait Until Element Is Visible    xpath://h2[contains(text(), 'Women - Dress Products')]    timeout=10s
    Page Should Contain              Women - Dress Products
    Capture Page Screenshot


Alterar quantidade do produto para
    [Arguments]    ${quantidade}
    Wait Until Element Is Visible    id:quantity    timeout=10s
    Clear Element Text               id:quantity
    Input Text                       id:quantity    ${quantidade}
    Capture Page Screenshot

Adicionar ao carrinho na tela de detalhes
    Click Button                     css:button.cart
    # No detalhe do produto, o modal de sucesso exibe o link 'View Cart'
    Wait Until Element Is Visible    xpath://u[contains(text(), 'View Cart')]    timeout=10s
    Click Element                    xpath://u[contains(text(), 'View Cart')]

Validar produto no carrinho com quantidade
    [Arguments]    ${nome_produto}    ${quantidade}
    Wait Until Element Is Visible    xpath://a[text()='${nome_produto}']    timeout=10s
    # O site armazena a quantidade dentro de um botão desabilitado na coluna cart_quantity
    Page Should Contain Element      xpath://td[@class='cart_quantity']/button[text()='${quantidade}']
    Capture Page Screenshot


Acessar menu de Produtos
    Click Element                    xpath://a[@href='/products']
    Wait Until Element Is Visible    id:search_product    timeout=10s
    Capture Page Screenshot

Clicar na marca "Polo"
    Wait Until Element Is Visible    xpath://a[@href='/brand_products/Polo']    timeout=10s
    Scroll Element Into View         xpath://a[@href='/brand_products/Polo']
    Click Element                    xpath://a[@href='/brand_products/Polo']

Validar que os produtos da marca "Polo" são exibidos
    Wait Until Element Is Visible    xpath://h2[contains(text(), 'Brand - Polo Products')]    timeout=10s
    Page Should Contain              Brand - Polo Products
    Capture Page Screenshot

# --- KEYWORDS DE BUSCA NEGATIVA ---
Validar que nenhum produto é retornado na busca
    Wait Until Element Is Visible    xpath://h2[contains(text(), 'Searched Products')]    timeout=10s
    # Garante que nenhum elemento com a classe de card de produto foi carregado na tela
    Page Should Not Contain Element  xpath://div[@class='productinfo text-center']
    Capture Page Screenshot

# --- KEYWORDS DE FATURA (INVOICE) ---
Baixar fatura do pedido
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Download Invoice')]    timeout=10s
    Click Element                    xpath://a[contains(text(), 'Download Invoice')]
    # Um pequeno Sleep é útil aqui para dar tempo ao navegador de iniciar o download localmente
    Sleep    2s
    Capture Page Screenshot

Avançar após download da fatura
    Wait Until Element Is Visible    xpath://a[@data-qa='continue-button']    timeout=10s
    Capture Page Screenshot
    Click Element                    xpath://a[@data-qa='continue-button']

    # --- KEYWORDS DE VALIDAÇÃO DE ENDEREÇO (CHECKOUT) ---
Validar que o endereço de entrega é igual ao de faturamento
    Wait Until Element Is Visible    id:address_delivery    timeout=10s
    Wait Until Element Is Visible    id:address_invoice     timeout=10s
    
    # Captura o nome e sobrenome das duas colunas
    ${nome_entrega}=        Get Text    xpath://ul[@id='address_delivery']/li[@class='address_firstname address_lastname']
    ${nome_faturamento}=    Get Text    xpath://ul[@id='address_invoice']/li[@class='address_firstname address_lastname']
    
    # Captura a linha principal do endereço (A estrutura do site coloca o endereço na 4ª linha da lista)
    ${end_entrega}=         Get Text    xpath://ul[@id='address_delivery']/li[4]
    ${end_faturamento}=     Get Text    xpath://ul[@id='address_invoice']/li[4]
    
    # Realiza a comparação exata dos dados
    Should Be Equal    ${nome_entrega}    ${nome_faturamento}
    Should Be Equal    ${end_entrega}     ${end_faturamento}
    
    Capture Page Screenshot

Ir para a tela de Checkout logado
    # Acessa o carrinho
    Wait Until Element Is Visible    xpath://li/a[@href='/view_cart']    timeout=10s
    Click Element                    xpath://li/a[@href='/view_cart']
    
    # Clica no botão para prosseguir
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Proceed To Checkout')]    timeout=10s
    Click Element                    xpath://a[contains(text(), 'Proceed To Checkout')]

    Wait Until Element Is Visible    id:address_delivery    timeout=10s

Acessar página de contato
    Wait Until Element Is Visible    xpath://a[@href='/contact_us']    timeout=10s
    Click Element                    xpath://a[@href='/contact_us']
    Wait Until Page Contains         Get In Touch    timeout=10s

Clicar no botão de enviar contato
    # Rola para garantir que o botão Submit está na tela
    Scroll Element Into View    xpath://input[@data-qa='submit-button']
    Click Element               xpath://input[@data-qa='submit-button']

Validar que o formulário não foi enviado
    # Como o navegador impede o envio via HTML5, a página não muda.
    # Validamos que o título "Get In Touch" ainda está visível e capturamos o print.
    Page Should Contain    Get In Touch
    Capture Page Screenshot

Rolar até o rodapé
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
    Capture Page Screenshot
