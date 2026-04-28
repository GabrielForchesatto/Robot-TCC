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
    Click Element                    xpath://button[text()='Continue Shopping']
    Capture Page Screenshot

Validar se o produto está no carrinho
    [Arguments]    ${nome_produto}
    Click Element    xpath://li/a[@href='/view_cart']
    Page Should Contain    ${nome_produto}
    Capture Page Screenshot

Rolar até o rodapé
    Execute Javascript    window.scrollTo(0, document.body.scrollHeight)
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
    Click Element                    xpath://a[contains(text(), 'Proceed To Checkout')]
    
    # Como não estamos logados, o site abre um modal. Clicamos no link para ir para a tela de login.
    Wait Until Element Is Visible    xpath://u[contains(text(), 'Register / Login')]    timeout=10s
    Click Element                    xpath://u[contains(text(), 'Register / Login')]

Prosseguir para o Pagamento
    # Após o login ter sido feito, precisamos voltar ao carrinho e prosseguir novamente
    Wait Until Element Is Visible    xpath://li/a[@href='/view_cart']    timeout=10s
    Click Element                    xpath://li/a[@href='/view_cart']
    
    Wait Until Element Is Visible    xpath://a[contains(text(), 'Proceed To Checkout')]    timeout=10s
    Click Element                    xpath://a[contains(text(), 'Proceed To Checkout')]
    
    # Na tela de revisão do pedido, rola até o botão e clica em Place Order
    Wait Until Element Is Visible    xpath://a[@href='/payment']    timeout=10s
    Scroll Element Into View         xpath://a[@href='/payment']
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
    Click Element    id:submit
    
    # Valida a mensagem final de sucesso
    Wait Until Element Is Visible    xpath://p[contains(text(), 'Congratulations! Your order has been confirmed!')]    timeout=15s
    Page Should Contain              Congratulations! Your order has been confirmed!
    Capture Page Screenshot