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

        $this->load->view ( 'templates/header' );

        $this->load->view ( 'product_keypad_view', $data );

        $this->load->view ( 'templates/footer' );

    }

    public function build_view(){

        $data ['quickaccess'] = $this->quickaccess_model->getQuickAccesses ();

        $view = $this->load->view ( 'product_keypad_view', $data, true );

        return view;
    }


}

/* End of file quick_access.php */
/* Location: ./application/controllers/quick_access.php */
