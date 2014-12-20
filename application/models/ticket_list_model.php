<?php

class Ticket_List_Model extends CI_Model {

    public $_table = 'product';

    public function __construct() {

        $this->load->database ();
        $this->load->library('cart');

    }

    public function add_product($product_id = 0) {




        $data = array(
                'id'      => '42',
                'qty'     => 3,
                'price'   => 12.00,
                'name'    => '1/4 Kg'
        );

        $this->cart->insert($data);


        //$this->cart->destroy();

    }

    /*
     * public function get_product_by_id($productId) {
     *
     * $query = $this->db->get_where ( 'product', array (
     * 'product_id' => $productId
     * ) );
     * $result = $query->row_array ();
     *
     * return $result;
     *
     * }
     */
}