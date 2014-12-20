<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Ticket_List extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'ticket_list_model' );

    }

    public function index() {

        $this->ticket_list_model->add_product ();

        $this->load->view ( 'ticket_list_view');

    }


}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket_list.php */
