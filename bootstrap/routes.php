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
   $app->get('', '\App\Frontend\Controllers\Medico:index');
   $app->get('/{id:\d+}', '\App\Frontend\Controllers\Medico:read');
   $app->get('/create', '\App\Frontend\Controllers\Medico:create');
   $app->get('/update', '\App\Frontend\Controllers\Medico:update');
   $app->get('/delete', '\App\Frontend\Controllers\Medico:destroy');
});
$app->group('/enfermero', function () use ($app) {
});
$app->group('/laboratorista', function () use ($app) {
});

$app->group('/api', function () use ($app) {
   $app->group('/paciente', function () use ($app) {
      $app->get('', '\App\Controllers\PacienteController:all');
      $app->post('', '\App\Controllers\PacienteController:create');
      $app->get('/{ci:\d+}', '\App\Controllers\PacienteController:read');
      $app->put('/{ci:\d+}', '\App\Controllers\PacienteController:update');
      $app->delete('/{ci:\d+}', '\App\Controllers\PacienteController:destroy');
   });
   $app->group('/medico', function () use ($app) {
      $app->get('', '\App\Controllers\MedicoController:all');
      $app->post('', '\App\Controllers\MedicoController:create');
      $app->get('/{ci:\d+}', '\App\Controllers\MedicoController:read');
      $app->put('/{ci:\d+}', '\App\Controllers\MedicoController:update');
      $app->delete('/{ci:\d+}', '\App\Controllers\MedicoController:destroy');
   });
   $app->group('/enfermero', function () use ($app) {
      $app->get('', '\App\Controllers\EnfermeroController:all');
      $app->post('', '\App\Controllers\EnfermeroController:create');
      $app->get('/{ci:\d+}', '\App\Controllers\EnfermeroController:read');
      $app->put('/{ci:\d+}', '\App\Controllers\EnfermeroController:update');
      $app->delete('/{ci:\d+}', '\App\Controllers\EnfermeroController:destroy');
   });
   $app->group('/laboratorista', function () use ($app) {
      $app->get('', '\App\Controllers\LaboratoristaController:all');
      $app->post('', '\App\Controllers\LaboratoristaController:create');
      $app->get('/{ci:\d+}', '\App\Controllers\LaboratoristaController:read');
      $app->put('/{ci:\d+}', '\App\Controllers\LaboratoristaController:update');
      $app->delete('/{ci:\d+}', '\App\Controllers\LaboratoristaController:destroy');
   });
   $app->group('/cita', function () use ($app) {
      $app->get('', '\App\Controllers\CitaController:all');
      $app->post('', '\App\Controllers\CitaController:create');
      $app->get('/{id:\d+}', '\App\Controllers\CitaController:read');
      $app->put('/{id:\d+}', '\App\Controllers\CitaController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\CitaController:destroy');
   });
   $app->group('/alta-medica', function () use ($app) {
      $app->get('', '\App\Controllers\AltaMedicaController:all');
      $app->post('', '\App\Controllers\AltaMedicaController:create');
      $app->get('/{id:\d+}', '\App\Controllers\AltaMedicaController:read');
      $app->put('/{id:\d+}', '\App\Controllers\AltaMedicaController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\AltaMedicaController:destroy');
   });
   $app->group('/laboratorio', function () use ($app) {
      $app->get('', '\App\Controllers\LaboratorioController:all');
      $app->post('', '\App\Controllers\LaboratorioController:create');
      $app->get('/{id:\d+}', '\App\Controllers\LaboratorioController:read');
      $app->put('/{id:\d+}', '\App\Controllers\LaboratorioController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\LaboratorioController:destroy');
   });
   $app->group('/examen', function () use ($app) {
      $app->get('', '\App\Controllers\ExamenController:all');
      $app->post('', '\App\Controllers\ExamenController:create');
      $app->get('/{id:\d+}', '\App\Controllers\ExamenController:read');
      $app->put('/{id:\d+}', '\App\Controllers\ExamenController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\ExamenController:destroy');
   });
   $app->group('/internacion', function () use ($app) {
      $app->get('', '\App\Controllers\InternacionController:all');
      $app->post('', '\App\Controllers\InternacionController:create');
      $app->get('/{id:\d+}', '\App\Controllers\InternacionController:read');
      $app->put('/{id:\d+}', '\App\Controllers\InternacionController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\InternacionController:destroy');
   });
   $app->group('/receta-medica', function () use ($app) {
      $app->get('', '\App\Controllers\RecetaMedicaController:all');
      $app->post('', '\App\Controllers\RecetaMedicaController:create');
      $app->get('/{id:\d+}', '\App\Controllers\RecetaMedicaController:read');
      $app->put('/{id:\d+}', '\App\Controllers\RecetaMedicaController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\RecetaMedicaController:destroy');
   });
   $app->group('/diagnostico', function () use ($app) {
      $app->get('', '\App\Controllers\DiagnosticoController:all');
      $app->post('', '\App\Controllers\DiagnosticoController:create');
      $app->get('/{id:\d+}', '\App\Controllers\DiagnosticoController:read');
      $app->put('/{id:\d+}', '\App\Controllers\DiagnosticoController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\DiagnosticoController:destroy');
   });
   $app->group('/medicamento', function () use ($app) {
      $app->get('', '\App\Controllers\MedicamentoController:all');
      $app->post('', '\App\Controllers\MedicamentoController:create');
      $app->get('/{id:\d+}', '\App\Controllers\MedicamentoController:read');
      $app->put('/{id:\d+}', '\App\Controllers\MedicamentoController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\MedicamentoController:destroy');
   });
   $app->group('/cama', function () use ($app) {
      $app->get('', '\App\Controllers\CamaController:all');
      $app->post('', '\App\Controllers\CamaController:create');
      $app->get('/{id:\d+}', '\App\Controllers\CamaController:read');
      $app->put('/{id:\d+}', '\App\Controllers\CamaController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\CamaController:destroy');
   });
   $app->group('/resultado-medico', function () use ($app) {
      $app->get('', '\App\Controllers\ResultadoMedicoController:all');
      $app->post('', '\App\Controllers\ResultadoMedicoController:create');
      $app->get('/{id:\d+}', '\App\Controllers\ResultadoMedicoController:read');
      $app->put('/{id:\d+}', '\App\Controllers\ResultadoMedicoController:update');
      $app->delete('/{id:\d+}', '\App\Controllers\ResultadoMedicoController:destroy');
   });
   /*$app->group('/', function () use ($app) {
      $app->get('', '\App\Controllers\Controller:all');
      $app->post('', '\App\Controllers\Controller:create');
      $app->get('/{id:\d+}', '\App\Controllers\Controller:read');
      $app->put('/{id:\d+}', '\App\Controllers\Controller:update');
      $app->delete('/{id:\d+}', '\App\Controllers\Controller:destroy');
   });*/
});

# vim: syntax=php ts=3 sw=3 sts=3
