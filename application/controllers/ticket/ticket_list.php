<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Ticket_List extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        $this->load->model ( 'ticket/ticket_list_model' );

    }

    public function index() {

        $this->load->view ( 'ticket/ticket_list_view');

    }

    public function add_product( $product_id, $quantity ){
        $this->ticket_list_model->add_product ($product_id, $quantity);
        $this->load->view ( 'ticket/ticket_list_view');
    }

    public function mod_product($product_id, $quantity, $add = FALSE){
        $this->ticket_list_model->mod_product ($product_id, $quantity, $add );
        $this->load->view ( 'ticket/ticket_list_view');
    }

    public function del_product($product_id){
        $this->ticket_list_model->del_product ($product_id);
        $this->load->view ( 'ticket/ticket_list_view');
    }

    public function json_print(){
        $ticket_data['ticket_data'] = $this->ticket_list_model->get_ticket_data ();
        $this->load->view ( 'ticket/ticket_json_view', $ticket_data);
    }


    public function close(){
        $this->ticket_list_model->close ();
        $this->load->view ( 'ticket/ticket_list_view');
    }

}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket_list.php */
