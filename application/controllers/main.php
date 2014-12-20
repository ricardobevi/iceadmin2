<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );

class Main extends CI_Controller {

    public function __construct() {

        parent::__construct ();

    }

    public function index() {

        $this->load->view ( 'templates/header' );

        $this->load->view ( 'ticket/ticket_view' );

        $this->load->view ( 'templates/footer' );

    }

}

/* End of file test.php */
/* Location: ./application/controllers/test.php */