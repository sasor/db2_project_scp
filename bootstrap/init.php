<?php

require __DIR__ . '/../vendor/autoload.php';

$configuration = require __DIR__ . '/settings.php';

$app = new \Slim\App($configuration);

$container = $app->getContainer();

$container['view'] = function () use ($container) {
	$view = new \Slim\Views\Twig(
		__DIR__ . '/../app/Frontend/views',
		array('cache' => false, 'debug' => true)
	); 
	$view->addExtension(
		new \Slim\Views\TwigExtension(
			$container->router, $container->request->getUri()
		)
	);
	return $view;
};

$container['db'] = function () use ($container) {

	$credentials = $container->get('settings')['db'];
	$driver = $credentials['driver'];
	$host = $credentials['host'];
	$database = $credentials['database'];
	$user = $credentials['username'];
	$password = $credentials['password'];

	$db = new \PDO(
						"{$driver}:dbname={$database};host={$host}",
						"{$user}",
						"{$password}"
					);
	$db->setAttribute(\PDO::ATTR_ERRMODE, \PDO::ERRMODE_EXCEPTION);

	return $db;
};

require __DIR__ . '/routes.php';


# vim: syntax=php ts=3 sw=3 sts=3
