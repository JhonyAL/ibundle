<?php
require_once 'class/Cliente.php';
header('Content-type: application/json');
$dadosRecebidos = file_get_contents('php://input');

$dadosRecebidos = json_decode($dadosRecebidos);

$result = [
    'result' => false,
    'data' => '',
    'error' =>''     
];

if($dadosRecebidos->acao == 'cadastrar'){
    $cliente = new Cliente();
    $cliente->cpf = $dadosRecebidos->cpf;
    $cliente->email = $dadosRecebidos->email;
    $cliente->senha = $dadosRecebidos->senha;
    $cliente->nome = $dadosRecebidos->nome;
    $cliente->telefone = $dadosRecebidos->telefone;
    $cliente->data_nasc = $dadosRecebidos->data_nasc;
    $cliente->status = 1;

    if($cliente->cadastrar()){
        $result['result'] = true;
        $result['data'] = $cliente;
    }
    else{
        $result['error'] = 'Erro de cadastro';
    }
}
if($dadosRecebidos->acao == 'consultarPorEmail'){
    $cliente = new Cliente();
    if($cliente->consultarPorEmail($dadosRecebidos->email)){
        $result['result'] = true;
        $result['data'] = $cliente;
    }
    else{
        $result['error'] = 'E-mail não encontrado';
    }
}
if($dadosRecebidos->acao == 'logar'){
    $cliente = new Cliente();
    if($cliente->logar($dadosRecebidos->email, $dadosRecebidos->senha)){
        $result['result'] = true;
        $cliente->senha = '';
        $result['data'] = $cliente;
    }
    else{
        $result['error'] = 'Usuaário ou senha inválido';
    }
}

echo json_encode($result);
