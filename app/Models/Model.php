<?php

namespace App\Models;

use \Interop\Container\ContainerInterface as ContainerInterface;

class Model
{
   protected $container;

   public function __construct(ContainerInterface $container)
   {
      $this->container = $container;
   }

   public function __get($property)
   {
      if ($this->container->{$property}) {
	 return $this->container->{$property};
      }
   }
}
