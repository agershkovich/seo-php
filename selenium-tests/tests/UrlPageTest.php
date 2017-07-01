<?php

namespace My;

use \Lmc\Steward\Test\AbstractTestCase;

class UrlPageTest extends AbstractTestCase
{
    public function testUrl()
    {
        // Load the URL (will wait until page is loaded)
        $this->wd->get('http://app/'); // $this->wd holds instance of \RemoteWebDriver

        // Do some assertion
        $this->assertContains('app', $this->wd->getCurrentURL());

    }

}