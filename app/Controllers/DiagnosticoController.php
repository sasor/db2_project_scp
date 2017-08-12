<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class DiagnosticoController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
		$out = null;
		$data = $req->getParsedBody();
		$cid = filter_var($data['cita_id'], FILTER_SANITIZE_NUMBER_INT);
		$sintoma = filter_var($data['sintoma'], FILTER_SANITIZE_STRING);
		$desc = filter_var($data['descripcion'], FILTER_SANITIZE_STRING);
		$sql = 'SELECT insertar_diagnostico(?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $cid, \PDO::PARAM_INT);
			$stmt->bindParam(2, $sintoma, \PDO::PARAM_STR);
			$stmt->bindParam(3, $desc, \PDO::PARAM_STR);
			$stmt->execute();
			$out = array('status' => '1', 'diagnostico' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function read(Request $req, Response $res, $args = [])
   {
		$out = null;
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);

		$sql = 'SELECT * FROM obtener_diagnostico(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$out = array('status' => '1', 'diagnostico' => $stmt->fetch());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function update(Request $req, Response $res, $args = [])
   {
		$out = null;
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);

		$data = $req->getParsedBody();
		$cid = filter_var($data['cita_id'], FILTER_SANITIZE_NUMBER_INT);
		$sintoma = filter_var($data['sintoma'], FILTER_SANITIZE_STRING);
		$desc = filter_var($data['descripcion'], FILTER_SANITIZE_STRING);
		$sql = 'SELECT actualizar_diagnostico(?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->bindParam(2, $cid, \PDO::PARAM_INT);
			$stmt->bindParam(3, $sintoma, \PDO::PARAM_STR);
			$stmt->bindParam(4, $desc, \PDO::PARAM_STR);
			$stmt->execute();
			$out = array('status' => '1', 'diagnostico' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);
		$sql = 'SELECT eliminar_diagnostico(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'diagnostico' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function all(Request $req, Response $res, $args = [])
   {
		$out = null;
		$sql = 'SELECT * FROM obtener_diagnosticos()';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'diagnosticos' => $stmt->fetchAll());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
