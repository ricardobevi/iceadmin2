<?php

class Ticket_List_Model extends CI_Model {

    public $_table = 'product';

    public function __construct() {

        $this->load->database ();
        $this->load->library('cart');

    }

    public function add_product($product_id, $quantity) {

        $product_info = $this->obtain_product_info($product_id);

        if ( $product_info !== 0 ){

            $current_qty = $this->obtain_current_quantity($product_id);

            $product_info['qty'] = $current_qty + $quantity;

            $this->cart->insert($product_info);

        }


        //$this->cart->destroy();

    }

    public function del_product($product_id){


        $rowid = $this->obtain_rowid($product_id);

        $data = array(
                'rowid' => $rowid,
                'qty'   => 0
        );

        $this->cart->update($data);


    }

    private function obtain_rowid($product_id){
        $rowid = -1;

        $i = 0;
        $cart_contents = $this->cart->contents();

        $cart_row = array();

        while ( ( $cart_row = current($cart_contents) ) && $cart_row['id'] != $product_id )
            next($cart_contents);

        if ( $cart_row['id'] == $product_id ) {

            $rowid = $cart_row['rowid'];

        }

        return $rowid;
    }

    private function obtain_current_quantity($product_id){
        $quantity = 0;

        $rowid = $this->obtain_rowid($product_id);

        if ( $rowid != -1 ){
            $quantity = $this->cart->contents()[$rowid]['qty'];
        }

        return $quantity;
    }

    private function obtain_product_info( $product_id ){

        $result = 0;

        if ( $product_id !== null ){

            $sql =
            "SELECT
                P.id, P.label AS name, PR.price
            FROM
                `product` P
                JOIN `product_price` PP ON P.id = PP.product_id
                JOIN `price` PR ON PP.price_id = PR.id
            WHERE P.id = " . $product_id . " ;";

            $query = $this->db->query($sql);

            $result = $query->result_array ();

            if ( count($result) == 1 ){
                $result = $result[0];
            } else {
                $result = 0;
            }

        }

        return $result;
    }

}