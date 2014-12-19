<?php

class QuickAccess_model extends CI_Model {

    public $_table = 'product';

    public function __construct() {

        $this->load->database ();

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