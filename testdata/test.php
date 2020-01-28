<?php

class Foo {
    public function __construct() {
        \Drupal::messenger()->error($_REQUEST);
    }
}
