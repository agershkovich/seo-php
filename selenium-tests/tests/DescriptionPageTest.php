<?php

namespace My;

use Lmc\Steward\Test\AbstractTestCase;


class DescriptionPageTest extends AbstractTestCase

{
    public function testShouldContainDescription()
    {
        // Load the URL (will wait until page is loaded)
        $this->wd->get('http://app/'); // $this->wd holds instance of \RemoteWebDriver
    }




}