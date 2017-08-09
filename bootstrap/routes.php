<?php

$app->get('/', '\App\Controllers\HomeController:home')->setName('home');
$app->group('/api', function () use ($app) {
	$app->group('/paciente', function () use ($app) {
		$app->get('', '\App\Controllers\PacienteController:all');
		$app->post('', '\App\Controllers\PacienteController:create');
		$app->get('/{id:\d+}', '\App\Controllers\PacienteController:read');
		$app->put('/{id:\d+}', '\App\Controllers\PacienteController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\PacienteController:destroy');
	});
	$app->group('/medico', function () use ($app) {
		$app->get('', '\App\Controllers\MedicoController:all');
		$app->post('', '\App\Controllers\MedicoController:create');
		$app->get('/{id:\d+}', '\App\Controllers\MedicoController:read');
		$app->put('/{id:\d+}', '\App\Controllers\MedicoController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\MedicoController:destroy');
	});
	$app->group('/enfermero', function () use ($app) {
		$app->get('', '\App\Controllers\EnfermeroController:all');
		$app->post('', '\App\Controllers\EnfermeroController:create');
		$app->get('/{id:\d+}', '\App\Controllers\EnfermeroController:read');
		$app->put('/{id:\d+}', '\App\Controllers\EnfermeroController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\EnfermeroController:destroy');
	});
	$app->group('/laboratorista', function () use ($app) {
		$app->get('', '\App\Controllers\EnfermeroController:all');
		$app->post('', '\App\Controllers\EnfermeroController:create');
		$app->get('/{id:\d+}', '\App\Controllers\EnfermeroController:read');
		$app->put('/{id:\d+}', '\App\Controllers\EnfermeroController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\EnfermeroController:destroy');
	});
});

# vim: syntax=php ts=3 sw=3 sts=3
