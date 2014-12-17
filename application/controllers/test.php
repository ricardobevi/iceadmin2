<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );

class Test extends CI_Controller {

    public function index() {

        $this->load->view ( 'templates/header' );

        $data ['content'] = $this->load->view ( 'product_keypad', '', true );

        $data ['leftColumn'] = $this->load->view ( 'templates/left_column', $data, true );

        $data ['content'] = $this->load->view ( 'ticket_list', '', true );

        $data ['rightColumn'] = $this->load->view ( 'templates/right_column', $data, true );

        $this->load->view ( 'templates/row', $data );

        $this->load->view ( 'templates/footer' );

    }

}

/* End of file test.php */
/* Location: ./application/controllers/test.php */