<?php

namespace My;

use Lmc\Steward\Test\AbstractTestCase;

include_once dirname(__DIR__) . '/utils/utils.php';

class TitlePageTest extends AbstractTestCase

{
    public function testShouldContainMetaTitle()
    {
        $url = 'http://localhost/';
        $value = 'title';

        $this->wd->get($url);

        $this->assertContains(expectedValueOf($value), actualValueOf($url, $value));

        $this->log('Current page "%s" has meta tag "%s" "%s"', $this->wd->getCurrentURL(), $value, actualValueOf($url, $value));

    }
}