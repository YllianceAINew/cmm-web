<?php 
namespace Jestillore\PHPOpenfireUchatservice;
#require_once ('curl/cURL.php');
#require_once ('Response.php');
#use SimpleXMLElement;
use Illuminate\Support\ServiceProvider;

class PhpOpenfireUchatserviceServiceProvider extends ServiceProvider {
#class PHPOpenfireUserservice {

	/**
	 * Indicates if loading of the provider is deferred.
	 *
	 * @var bool
	 */
	protected $defer = false;

	/**
	 * Bootstrap the application events.
	 *
	 * @return void
	 */
	public function boot()
	{
		$this->package('jestillore/PHPOpenfireUchatservice');
	}

	/**
	 * Register the service provider.
	 *
	 * @return void
	 */
	public function register()
	{
		//
	}

	/**
	 * Get the services provided by the provider.
	 *
	 * @return array
	 */
	public function provides()
	{
		return array();
	}

}

