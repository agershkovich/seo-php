<?php


namespace My;

use Lmc\Steward\Test\AbstractTestCase;

class TitlePageTest extends AbstractTestCase
{
    public function testShouldContainSearchInput()
    {
        // Load the URL (will wait until page is loaded)
        $this->wd->get('http://localhost/'); // $this->wd holds instance of \RemoteWebDriver
//
//        // Do some assertion
        $this->assertContains('youtube - Поиск в Google', $this->wd->getTitle());

        // You can use $this->log(), $this->warn() or $this->debug() with sprintf-like syntax
        $this->log('Current page "%s" has title "%s"', $this->wd->getCurrentURL(), $this->wd->getTitle());

        // Make sure search input is present
//        $searchInput = $this->wd->findElement(WebDriverBy::cssSelector('#search-form input'));
        // Or you can use syntax sugar provided by Steward (this is equivalent of previous line)
        $searchInput = $this->findByCss('#search-form input');

        // Assert title of the search input
        $this->assertEquals('Search', $searchInput->getAttribute('title'));
    }
}