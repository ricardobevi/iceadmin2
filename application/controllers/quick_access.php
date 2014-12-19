<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Quick_Access extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'quickaccess_model' );

    }

    public function index() {

        $data ['quickaccess'] = $this->quickaccess_model->getQuickAccesses ();

        $this->load->view ( 'product_keypad_view', $data );

    }

    public function group($group = 1) {

        $data ['quickaccess'] = $this->quickaccess_model->getQuickAccesses ($group);

        $this->load->view ( 'product_keypad_view', $data );

    }

}

/* End of file quick_access.php */
/* Location: ./application/controllers/quick_access.php */
