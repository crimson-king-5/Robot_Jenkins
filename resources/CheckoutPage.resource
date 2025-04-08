*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${CHECKOUT_BTN}       id=checkout
${FIRSTNAME_INPUT}    id=first-name
${LASTNAME_INPUT}     id=last-name
${ZIP_INPUT}          id=postal-code
${CONTINUE_BTN}       id=continue
${FINISH_BTN}         id=finish
${CONFIRM_MSG}        xpath=//h2[text()='Thank you for your order!']

*** Keywords ***
Start Checkout
    Click Button    ${CHECKOUT_BTN}

Fill Checkout Information
    [Arguments]     ${firstname}    ${lastname}    ${zip}
    Input Text      ${FIRSTNAME_INPUT}    ${firstname}
    Input Text      ${LASTNAME_INPUT}     ${lastname}
    Input Text      ${ZIP_INPUT}          ${zip}
    Click Button    ${CONTINUE_BTN}

Finish Checkout
    Click Button    ${FINISH_BTN}

Confirmation Message Should Be Visible
    Element Should Be Visible    ${CONFIRM_MSG}