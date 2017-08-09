<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class EnfermeroController extends Controller
{
   public function create(Request $req, Response $res, $args = [])
   {
      $data = array('message' => 'create');
      return $res->withJson($data);
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
