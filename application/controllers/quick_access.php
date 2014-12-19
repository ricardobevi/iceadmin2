<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Quick_Access extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'quick_access_model' );

    }

    public function index() {

        $data ['quickaccess'] = $this->quick_access_model->getQuickAccesses ();

        $this->load->view ( 'quick_access_view', $data );

    }

    public function group($group = 1) {

        $data ['quickaccess'] = $this->quick_access_model->getQuickAccesses ($group);

        $this->load->view ( 'quick_access_view', $data );

    }

}

/* End of file quick_access.php */
/* Location: ./application/controllers/quick_access.php */
