<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Ticket_List extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        //$this->load->model ( 'quickaccess_model' );

    }

    public function index() {

        //$data ['quickaccess'] = $this->quickaccess_model->getQuickAccesses ();

        $this->load->view ( 'ticket_list_view' );

    }


}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket_list.php */
