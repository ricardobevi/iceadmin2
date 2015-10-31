<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Quick_Access extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'ticket/quick_access_model' );

    }

    public function index() {

        $data ['quickaccess'] = $this->quick_access_model->get_quick_accesses (2);

        $data ['group'] = 2;

        $data ['hidden'] = true;

        $hidden_view = $this->load->view ( 'ticket/quick_access_view', $data, true );



        $data ['quickaccess'] = $this->quick_access_model->get_quick_accesses (1);

        $data ['group'] = 1;

        $data ['hidden'] = false;

        $data ['hidden_view'] = $hidden_view;

        $this->load->view ( 'ticket/quick_access_view', $data);

    }

    public function group($group = 1) {

        $data ['quickaccess'] = $this->quick_access_model->get_quick_accesses ($group);

        $this->load->view ( 'ticket/quick_access_view', $data );

    }

}

/* End of file quick_access.php */
/* Location: ./application/controllers/quick_access.php */
