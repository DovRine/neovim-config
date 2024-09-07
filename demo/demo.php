<?php

// Sample PHP file with issues for Phpactor testing

// Undefined class usage
$car = new Car();

// Function with missing return type
function add($a, $b) {
    return $a + $b;
}

// Incorrect variable usage
$sum = add(10, 20);
echo $total; // $total is undefined

// Incorrect method usage
class Person {
    public $name;
    private $age;

    public function __construct($name, $age) {
        $this->name = $name;
        $this->age = $age;
    }

    public function greet() {
        echo "Hello, my name is " . $this->name;
    }
}

$person = new Person("John", 25);
$person->greet();
$person->nonExistentMethod(); // Method doesn't exist

// Missing function documentation and type hinting
function multiply($x, $y) {
    return $x * $y;
}

$multipliedValue = multiply(5, 3);
echo $multipliedValue;
