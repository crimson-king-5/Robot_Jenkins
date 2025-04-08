*** Settings ***
Resource    ../resources/LoginPage.resource
Library     SeleniumLibrary
Suite Setup    Open Login Page
Suite Teardown    Close Browser

*** Test Cases ***
Connexion Valide
    [Tags]    XRAY-CONNEXION-VALIDE
    Enter Credentials    standard_user    secret_sauce
    Click Login
    Page Should Contain Element    css=.inventory_list

Connexion Invalide
    [Tags]    XRAY-CONNEXION-INVALIDE
    Open Login Page
    Enter Credentials    standard_user    mauvais_mdp
    Click Login
    Page Should Contain    Epic sadface: Username and password do not match any user in this service