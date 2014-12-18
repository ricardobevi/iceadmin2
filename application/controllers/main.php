<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );

class Test extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        //$this->load->controller ( 'quick_access' );

    }

    public function index() {

        $this->load->view ( 'templates/header' );

        $data ['content'] = $this->quick_access->build_view();

        $data ['leftColumn'] = $this->load->view ( 'templates/left_column', $data, true );

        $data ['content'] = $this->load->view ( 'ticket_list_view', '', true );

        $data ['rightColumn'] = $this->load->view ( 'templates/right_column', $data, true );

        $this->load->view ( 'templates/row', $data );

        $this->load->view ( 'templates/footer' );

    }

}

/* End of file test.php */
/* Location: ./application/controllers/test.php */