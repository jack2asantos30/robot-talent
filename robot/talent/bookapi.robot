*** Settings **** 
Documentation   Documentação da api: https://fakerestapi.azurewebsites.net/index.html
Resource        resourceapi.robot
Suite Setup     Dado esteja conectado na API

*** Test Cases ***
Buscar Listagem de todos os livros(comando get)
    Dado que tenha todos os livros 
    Quando retornar uma lista com "200" livros
    Entao o status code "200"

Buscar um livro especifico(comando get)
    Dado que tenha o livro "15"
    Quando tiver as informacoes corretas 
    Entao o status code "200"

Cadastrar um novo livro(comando POST)
    Quando criar um livro 
    Entao o status code "200"



