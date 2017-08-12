<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class CitaController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
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
		$out = null;
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);

		$sql = 'SELECT * FROM obtener_cita(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$out = array('status' => '1', 'cita_medica' => $stmt->fetch());
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
		$pid = filter_var($data['pid'], FILTER_SANITIZE_NUMBER_INT);
		$mid = filter_var($data['mid'], FILTER_SANITIZE_NUMBER_INT);
		$hora = $data['hora'];
		$fecha = $data['fecha'];
		$sql = 'SELECT actualizar_cita(?,?,?,?,?,?,?,?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->bindParam(2, $pid, \PDO::PARAM_INT);
			$stmt->bindParam(3, $mid, \PDO::PARAM_INT);
			$stmt->bindParam(4, $hora);
			$stmt->bindParam(5, $fecha);
			$stmt->execute();
			$out = array('status' => '1', 'cita' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);
		$sql = 'SELECT eliminar_cita(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'cita' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function all(Request $req, Response $res, $args = [])
   {
		$out = null;
		$sql = 'SELECT * FROM obtener_citas()';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'citas_medicas' => $stmt->fetchAll());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
