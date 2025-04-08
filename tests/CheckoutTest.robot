*** Settings ***
Resource    ../resources/LoginPage.resource
Resource    ../resources/ProductPage.resource
Resource    ../resources/CheckoutPage.resource
Test Setup  Open Login Page
Test Teardown    Close Browser

*** Test Cases ***
Finalisation de commande
    [Tags]    XRAY-CHECKOUT
    Enter Credentials    standard_user    secret_sauce
    Click Login
    Click Add To Cart
    Open Cart
    Start Checkout
    Fill Checkout Information    John    Doe    75001
    Finish Checkout
    Confirmation Message Should Be Visible