<?php

namespace App\Frontend\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Frontend\Controllers\Controller;

class Home extends Controller
{
   public function home(Request $req, Response $res, $args)
   {
      return $this->view->render($res, 'index.twig');
   }
}

# vim: syntax=php ts=3 sw=3 sts=3
