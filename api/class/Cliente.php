<?php
require_once 'DataBase.php';
class Cliente {

    public $id; 
    public $cpf; 
    public $email; 
    public $senha; 
    public $nome; 
    public $telefone; 
    public $data_nasc; 
    public $status;


    public function cadastrar(){
        $db = new DataBase();
        $cx = $db->connection();
        $cmdSql = 'CALL cliente_Cadastrar(:cpf, :email, :senha, :nome, :telefone, :data_nasc, :status);';
        $dados=[            
            ':cpf'=>$this->cpf, 
            ':email'=>$this->email, 
            ':senha'=>$this->senha, 
            ':nome'=>$this->nome, 
            ':telefone'=>$this->telefone, 
            ':data_nasc'=>$this->data_nasc, 
            ':status'=>$this->status
        ];
        $cx = $cx->prepare($cmdSql);
        return $cx->execute($dados);
    }

    public function logar($email, $senha){
        if($this->consultarPorEmail($email)){
            return ($this->senha == $senha);
        }
        return false;
    }

    public function consultarPorEmail($email){
        $db = new DataBase();
        $cx = $db->connection();
        $cmdSql = 'CALL cliente_Consultar_Por_Email(:email);';
        $dados = [
            ':email'=>$email
        ];

        $cx = $cx->prepare($cmdSql); 
        if ($cx->execute($dados)) {
            if ($cx->rowCount()) {
                $cliente =  $cx->fetchObject('Cliente');

                $this->id = $cliente->id; 
                $this->cpf = $cliente->cpf; 
                $this->email = $cliente->email; 
                $this->senha = $cliente->senha; 
                $this->nome = $cliente->nome; 
                $this->telefone = $cliente->telefone; 
                $this->data_nasc = $cliente->data_nasc; 
                $this->status = $cliente->status;

                return true;
            }
        }
        return false;
    }

}