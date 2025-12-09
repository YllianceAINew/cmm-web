<?php

namespace Jestillore\PHPOpenfireUchatservice;

class Response {

	private $success;
	private $message;

	public function __construct($success = true, $message = array()) {
		$this->success = $success;
		$this->message = $message;
	}

	public function isSuccess() {
		return $this->success;
	}

	public function getMessage() {
		return $this->message;
	}

	public function __toString() {
		return 'Request ' . ($this->success ? '' : 'not ') . 'successful! ' . json_encode($this->message);
	}
}
