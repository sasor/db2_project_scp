<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class CitaController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
      //$data = array('message' => 'create');
      //return $res->withJson($data);
		$out = null;
		$data = $req->getParsedBody();
		$pid = filter_var($data['pid'], FILTER_SANITIZE_NUMBER_INT);
		$mid = filter_var($data['mid'], FILTER_SANITIZE_NUMBER_INT);
		$hora = $data['hora'];
		$fecha = $data['fecha'];
		$sql = 'SELECT insertar_cita(?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $pid, \PDO::PARAM_INT);
			$stmt->bindParam(2, $mid, \PDO::PARAM_INT);
			$stmt->bindParam(3, $hora);
			$stmt->bindParam(4, $fecha);
			$stmt->execute();
			//$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'cita' => $stmt->fetchColumn());
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
