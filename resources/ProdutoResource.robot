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