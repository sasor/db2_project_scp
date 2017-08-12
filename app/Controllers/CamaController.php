<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class CamaController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
		$out = null;
		$data = $req->getParsedBody();
		$dis = filter_var($data['disponible'], FILTER_SANITIZE_STRING);
		$sql = 'SELECT insertar_cama(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $dis, \PDO::PARAM_STR);
			$stmt->execute();
			$out = array('status' => '1', 'cama' => $stmt->fetchColumn());
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
		$sql = 'SELECT * FROM obtener_cama(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$out = array('status' => '1', 'cama' => $stmt->fetch());
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
		$dis = filter_var($data['disponible'], FILTER_SANITIZE_STRING);
		$sql = 'SELECT actualizar_cama(?,?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->bindParam(2, $dis, \PDO::PARAM_BOOL);
			$stmt->execute();
			$out = array('status' => '1', 'cama' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
		$id = filter_var($args['id'], FILTER_SANITIZE_NUMBER_INT);
		$sql = 'SELECT eliminar_cama(?)';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->bindParam(1, $id, \PDO::PARAM_INT);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'cama' => $stmt->fetchColumn());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }

   public function all(Request $req, Response $res, $args = [])
   {
		$out = null;
		$sql = 'SELECT * FROM obtener_camas()';
		try {
			$stmt = $this->db->prepare($sql);
			$stmt->execute();
			$stmt->setFetchMode(\PDO::FETCH_ASSOC);
			$out = array('status' => '1', 'camas' => $stmt->fetchAll());
			return $res->withJson($out);
		} catch (\PDOException $e) {
			$out = array('status' => '0', 'error' => $stmt->errorInfo());
			return $res->withJson($out); 
		}
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
