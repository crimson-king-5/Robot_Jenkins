*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${URL}           https://www.saucedemo.com
${USERNAME_LOC}  id=user-name
${PASSWORD_LOC}  id=password
${LOGIN_BTN}     id=login-button

*** Keywords ***
Open Login Page
    Open Browser    ${URL}    chrome
    Maximize Browser Window
    Wait Until Element Is Visible    ${USERNAME_LOC}

Enter Credentials
    [Arguments]    ${user}    ${pass}
    Input Text     ${USERNAME_LOC}    ${user}
    Input Text     ${PASSWORD_LOC}    ${pass}

Click Login
    Click Button   ${LOGIN_BTN}