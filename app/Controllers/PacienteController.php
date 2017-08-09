<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class PacienteController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
		$out = null;
		$data = $req->getParsedBody();
		$ci = filter_var($data['ci'], FILTER_SANITIZE_NUMBER_INT);
		$sexo = filter_var($data['sexo'], FILTER_SANITIZE_STRING);
		$nombre = filter_var($data['nombre'], FILTER_SANITIZE_STRING);
		$ap = filter_var($data['ap'], FILTER_SANITIZE_STRING);
		$am = filter_var($data['am'], FILTER_SANITIZE_STRING);
		$tel = filter_var($data['telefono'], FILTER_SANITIZE_NUMBER_INT);
		$fn = $data['fecha_nacimiento'];
		$ts = $data['tipo_sangre'];
		$dir = filter_var($data['direccion'], FILTER_SANITIZE_STRING);
		$sql = 'SELECT insertar_paciente(?,?,?,?,?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $ci, \PDO::PARAM_INT);
			$stmt->bindParam(2, $sexo, \PDO::PARAM_BOOL);
			$stmt->bindParam(3, $nombre, \PDO::PARAM_STR);
			$stmt->bindParam(4, $ap, \PDO::PARAM_STR);
			$stmt->bindParam(5, $am, \PDO::PARAM_STR);
			$stmt->bindParam(6, $tel, \PDO::PARAM_INT);
			$stmt->bindParam(7, $fn);
			$stmt->bindParam(8, $ts);
			$stmt->bindParam(9, $dir, \PDO::PARAM_STR);
			$stmt->execute();
			//$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'paciente' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function read(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'read');
      return $res->withJson($data);
   }

   public function update(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'update');
      return $res->withJson($data);
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'destroy');
      return $res->withJson($data);
   }

   public function all(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'all');
      return $res->withJson($data);
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
