<?php

$app->get('/', '\App\Frontend\Controllers\Home:home')->setName('home');
$app->group('/paciente', function () use ($app) {
	$app->get('', '\App\Frontend\Controllers\Paciente:index');
	$app->get('/{id:\d+}', '\App\Frontend\Controllers\Paciente:read');
	$app->get('/create', '\App\Frontend\Controllers\Paciente:create');
	$app->get('/update', '\App\Frontend\Controllers\Paciente:update');
	$app->get('/delete', '\App\Frontend\Controllers\Paciente:destroy');
});
$app->group('/medico', function () use ($app) {

});
$app->group('/enfermero', function () use ($app) {

});
$app->group('/laboratorista', function () use ($app) {

});

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
		$app->get('', '\App\Controllers\LaboratoristaController:all');
		$app->post('', '\App\Controllers\LaboratoristaController:create');
		$app->get('/{id:\d+}', '\App\Controllers\LaboratoristaController:read');
		$app->put('/{id:\d+}', '\App\Controllers\LaboratoristaController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\LaboratoristaController:destroy');
	});
	$app->group('/cita', function () use ($app) {
		$app->get('', '\App\Controllers\CitaController:all');
		$app->post('', '\App\Controllers\CitaController:create');
		$app->get('/{id:\d+}', '\App\Controllers\CitaController:read');
		$app->put('/{id:\d+}', '\App\Controllers\CitaController:update');
		$app->delete('/{id:\d+}', '\App\Controllers\CitaController:destroy');
	});
});

# vim: syntax=php ts=3 sw=3 sts=3
