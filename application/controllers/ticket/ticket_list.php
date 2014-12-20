<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Ticket_List extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'ticket/ticket_list_model' );

    }

    public function index() {

        //$this->ticket_list_model->add_product ();

        $this->load->view ( 'ticket/ticket_list_view');

    }

    public function add_product( $product_id, $quantity ){
        $this->ticket_list_model->add_product ($product_id, $quantity);
        $this->load->view ( 'ticket/ticket_list_view');
    }

    public function del_product($product_id){
        $this->ticket_list_model->del_product ($product_id);
        $this->load->view ( 'ticket/ticket_list_view');
    }

}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket_list.php */
