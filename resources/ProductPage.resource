*** Settings ***
Library    SeleniumLibrary
*** Variables ***
${PRODUCT_ADD_BTN}     xpath=//button[text()='Add to cart']
${CART_ICON}           id=shopping_cart_container
${CART_BADGE}          class=shopping_cart_badge

*** Keywords ***
Click Add To Cart
    Click Button    ${PRODUCT_ADD_BTN}

Open Cart
    Click Element   ${CART_ICON}

Cart Should Have One Item
    Element Should Contain    ${CART_BADGE}    1