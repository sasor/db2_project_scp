<?php

namespace App\Controllers;

use \Psr\Http\Message\ServerRequestInterface as Request;
use \Psr\Http\Message\ResponseInterface as Response;
use \App\Controllers\Controller;

class HomeController extends Controller
{
	public function home(Request $req, Response $res, $args)
	{
		$data = array('message' => 'Good Luck!!');
		return $res->withJson($data);
	}
}

# vim: syntax=php ts=3 sw=3 sts=3
