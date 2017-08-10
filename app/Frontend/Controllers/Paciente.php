<?php

namespace App\Frontend\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Frontend\Controllers\Controller;

class Paciente extends Controller
{
   public function index(Request $req, Response $res, $args = [])
   {
		return $this->view->render($res, 'paciente/index.twig');
   }

   public function create(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'create frontend');
      return $res->withJson($data);
   }

   public function read(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'read frontend');
      return $res->withJson($data);
   }

   public function update(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'update frontend');
      return $res->withJson($data);
   }

   public function destroy(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'destroy frontend');
      return $res->withJson($data);
   }

}

# vim: syntax=php ts=3 sw=3 sts=3
