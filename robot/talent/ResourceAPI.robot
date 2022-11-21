*** Settings **** 
Documentation   Documentação da api: https://fakerestapi.azurewebsites.net/index.html
Library     RequestsLibrary
Library     Collections

*** Variables ***
${base_url_api}     https://fakerestapi.azurewebsites.net/api/v1

&{book_15}   id=15
    ...      title=Book 15
    ...      pageCount=1500
 
***Keywords***
###Setup - Criando a sessão###
Dado esteja conectado na API
    Create Session      FakeAPI     ${base_url_api}

### Ações ###

### TESTE_1 ###
Dado que tenha todos os livros 
    ${RESPOSTA}     Get On Session      FakeAPI       Books
    Log             ${RESPOSTA.text}  
    Set Test Variable   ${RESPOSTA}

Quando retornar uma lista com "${QTD_LIVROS}" livros
   Length Should Be        ${RESPOSTA.json()}    ${QTD_LIVROS} 

### TESTE_2 ###
Dado que tenha o livro "${ID_LIVRO}"
    ${RESPOSTA}     Get On Session      FakeAPI       Books/${ID_LIVRO}
    Log             ${RESPOSTA.text}  
    Set Test Variable   ${RESPOSTA}  

Quando tiver as informacoes corretas 
    Dictionary Should Contain Item      ${Resposta.json()}     id             ${book_15.id}    
    Dictionary Should Contain Item      ${Resposta.json()}     title          ${book_15.title}  
    Dictionary Should Contain Item      ${Resposta.json()}     pageCount      ${book_15.pageCount}    
    Should Not Be Empty                 ${Resposta.json()["description"]} 
    Should Not Be Empty                 ${Resposta.json()["excerpt"]} 
    Should Not Be Empty                 ${Resposta.json()["publishDate"]}  

### TESTE_3 ####
Quando criar um livro 
    ${HEADERS}      Create Dictionary   content-type=application/json
    ${Resposta}     POST On Session     FakeAPI       Books
    ...                                 data={"id": 2323, "title": "teste", "description": "teste", "pageCount": 200, "excerpt": "teste", "publishDate": "2021-11-24T21:00:05.449Z"}
    ...                                 headers=${HEADERS}
    Log     ${Resposta.text}  
    Set Test Variable   ${Resposta}

###STATUS_CODE###   
Entao o status code "${STATUSCODE_DESEJADO}"
    Should Be Equal As strings      ${RESPOSTA.status_code}      ${STATUSCODE_DESEJADO} 

