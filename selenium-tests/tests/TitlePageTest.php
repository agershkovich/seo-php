<?php

namespace My; // Note the "My" namespace maps to the "tests" folder, as defined in the autoload part of `composer.json`.

use \Lmc\Steward\Test\AbstractTestCase;

class TitlePageTest extends AbstractTestCase
{
    public function testShouldContainTitle()
    {
        // Load the URL (will wait until page is loaded)
        $this->wd->get('http://app/'); // $this->wd holds instance of \RemoteWebDriver

        // Do some assertion
        $this->assertContains('Original Title', $this->wd->getTitle());

        // You can use $this->log(), $this->warn() or $this->debug() with sprintf-like syntax
        $this->log('Current page "%s" has title "%s"', $this->wd->getCurrentURL(), $this->wd->getTitle());

    }
}