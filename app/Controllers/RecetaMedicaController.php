<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class RecetaMedicaController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
		$out = null;
		$data = $req->getParsedBody();
		$diag = filter_var($data['diagnostico_id'], FILTER_SANITIZE_NUMBER_INT);
		$medid = filter_var($data['medicamento_id'], FILTER_SANITIZE_NUMBER_INT);
		$dos = filter_var($data['dosificacion'], FILTER_SANITIZE_STRING);
		$hora = filter_var($data['hora']);
		$fecha = filter_var($data['fecha']);
		$sql = 'SELECT insertar_receta_medica(?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $diag, \PDO::PARAM_INT);
			$stmt->bindParam(2, $medid, \PDO::PARAM_BOOL);
			$stmt->bindParam(3, $dos, \PDO::PARAM_BOOL);
			$stmt->bindParam(4, $hora, \PDO::PARAM_BOOL);
			$stmt->bindParam(5, $fecha, \PDO::PARAM_BOOL);
			$stmt->execute();
			$out = array('status' => '1', 'receta_medica' => $stmt->fetchColumn());
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
		$sql = 'SELECT * FROM obtener_receta_medica(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$out = array('status' => '1', 'receta_medica' => $stmt->fetch());
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
		$medid = filter_var($data['medicamento_id'], FILTER_SANITIZE_NUMBER_INT);
		$dos = filter_var($data['dosificacion'], FILTER_SANITIZE_STRING);
		$hora = filter_var($data['hora']);
		$fecha = filter_var($data['fecha']);
		$sql = 'SELECT actualizar_receta_medica(?,?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->bindParam(2, $diag, \PDO::PARAM_INT);
			$stmt->bindParam(3, $medid, \PDO::PARAM_BOOL);
			$stmt->bindParam(4, $dos, \PDO::PARAM_BOOL);
			$stmt->bindParam(5, $hora, \PDO::PARAM_BOOL);
			$stmt->bindParam(6, $fecha, \PDO::PARAM_BOOL);
			$stmt->execute();
			$out = array('status' => '1', 'receta_medica' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);
		$sql = 'SELECT eliminar_receta_medica(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'receta_medica' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function all(Request $req, Response $res, $args = [])
   {
		$out = null;
		$sql = 'SELECT * FROM obtener_recetas_medicas()';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'recetas_medicas' => $stmt->fetchAll());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
