<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );

class Main extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        //$this->load->controller ( 'quick_access' );

    }

    public function index() {

        $this->load->view ( 'templates/header' );

        $data ['content'] = '';

        $data ['leftColumn'] = $this->load->view ( 'templates/left_column', $data, true );

        $data ['rightColumn'] = $this->load->view ( 'templates/right_column', $data, true );

        $this->load->view ( 'templates/row', $data );

        $this->load->view ( 'templates/footer' );

    }

}

/* End of file test.php */
/* Location: ./application/controllers/test.php */