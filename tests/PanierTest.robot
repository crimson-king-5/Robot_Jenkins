*** Settings ***
Resource    ../resources/LoginPage.resource
Resource    ../resources/ProductPage.resource
Test Setup  Open Login Page
Test Teardown    Close Browser

*** Test Cases ***
Ajout d’un produit au panier
    [Tags]    XRAY-AJOUT-PANIER
    Enter Credentials    standard_user    secret_sauce
    Click Login
    Click Add To Cart
    Open Cart
    Cart Should Have One Item