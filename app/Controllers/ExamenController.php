<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class ExamenController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
		$out = null;
		$data = $req->getParsedBody();
		$diag = filter_var($data['diagnostico_id'], FILTER_SANITIZE_NUMBER_INT);
		$lab = filter_var($data['laboratorio_id'], FILTER_SANITIZE_NUMBER_INT);
		$tipo_ex = filter_var($data['tipo_examen_id'], FILTER_SANITIZE_NUMBER_INT);
		$hora = $data['hora'];
		$fecha = $data['fecha'];
		$rel = $data['resultado_disponible'];

		$sql = 'SELECT insertar_examen(?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $diag, \PDO::PARAM_INT);
			$stmt->bindParam(2, $lab, \PDO::PARAM_INT);
			$stmt->bindParam(3, $tipo_ex, \PDO::PARAM_STR);
			$stmt->bindParam(4, $hora);
			$stmt->bindParam(5, $fecha);
			$stmt->bindParam(6, $rel, \PDO::PARAM_BOOL);
			$stmt->execute();
			$out = array('status' => '1', 'examen' => $stmt->fetchColumn());
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
		$sql = 'SELECT * FROM obtener_examen(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$out = array('status' => '1', 'examen' => $stmt->fetch());
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
		$diag = filter_var($data['diagnostico_id'], FILTER_SANITIZE_NUMBER_INT);
		$lab = filter_var($data['laboratorio_id'], FILTER_SANITIZE_NUMBER_INT);
		$tipo_ex = filter_var($data['tipo_examen_id'], FILTER_SANITIZE_NUMBER_INT);
		$hora = $data['hora'];
		$fecha = $data['fecha'];
		$rel = $data['resultado_disponible'];

		$sql = 'SELECT actualizar_examen(?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->bindParam(2, $diag, \PDO::PARAM_INT);
			$stmt->bindParam(3, $lab, \PDO::PARAM_INT);
			$stmt->bindParam(4, $tipo_ex, \PDO::PARAM_STR);
			$stmt->bindParam(5, $hora);
			$stmt->bindParam(6, $fecha);
			$stmt->bindParam(7, $rel, \PDO::PARAM_BOOL);
			$stmt->execute();
			$out = array('status' => '1', 'examen' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);
		$sql = 'SELECT eliminar_examen(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'examen' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function all(Request $req, Response $res, $args = [])
   {
		$out = null;
		$sql = 'SELECT * FROM obtener_examenes()';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'examenes' => $stmt->fetchAll());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
