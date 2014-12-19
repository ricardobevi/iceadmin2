<?php

class Ticket_List_Model extends CI_Model {

    public $_table = 'product';

    public function __construct() {

        $this->load->database ();
        $this->load->library('session');

    }

    public function add_product(){
        $newdata = array(
                'username'  => 'johndoe',
                'email'     => 'johndoe@some-site.com',
                'logged_in' => TRUE
        );

        $this->session->set_userdata($newdata);
    }

    public function get_products() {

        $query = $this->db->get ( 'product' );
        $result = $query->result_array ();

        return $result;

    }

    public function get_product_by_id($productId) {

        $query = $this->db->get_where ( 'product', array (
                'product_id' => $productId
        ) );
        $result = $query->row_array ();

        return $result;

    }

}