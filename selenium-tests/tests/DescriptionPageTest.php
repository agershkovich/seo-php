<?php

namespace My;

use Lmc\Steward\Test\AbstractTestCase;

include_once dirname(__DIR__) . '/utils/utils.php';

class DescriptionPageTest extends AbstractTestCase

{
    public function testShouldContainDescription()
    {
        $url = 'http://localhost/';
        $value = 'description';

        $this->wd->get($url);

        $this->assertContains(expectedValueOf($value), actualValueOf($url, $value));

        $this->log('Current page "%s" has meta tag "%s" "%s"', $this->wd->getCurrentURL(), $value, actualValueOf($url, $value));
    }


}