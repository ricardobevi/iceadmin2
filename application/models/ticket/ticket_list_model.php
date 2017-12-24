<?php

class Ticket_List_Model extends CI_Model {

    public $_table = 'product';

    public function __construct() {

        $this->load->database ();
        $this->load->library('cart');

    }

    public function add_product($product_id, $quantity) {

        $this->mod_product($product_id, $quantity, true);

    }

    public function mod_product($product_id, $quantity, $add = FALSE ) {

        $product_info = $this->obtain_product_info($product_id);

        if ( $product_info !== 0 ){

            $total_qty = $quantity;

            if ( $add !== FALSE ) {

                $current_qty = $this->obtain_current_quantity($product_id);

                $total_qty = $current_qty + $quantity;

            }

            if ( $total_qty > 0 ){

                $rowid = $this->obtain_rowid($product_id);

                if($rowid == -1){

                    $product_info['qty'] = $total_qty;

                    $product_info['options'] = array( 'price_id' => $product_info['price_id']);

                    $this->cart->insert($product_info);

                } else {

                    $data = array(
                            'rowid' => $rowid,
                            'qty'   => $total_qty
                    );

                    $this->cart->update($data);

                }

            } else {
                $this->del_product($product_id);
            }

        }

    }

    public function del_product($product_id){


        $rowid = $this->obtain_rowid($product_id);

        $data = array(
                'rowid' => $rowid,
                'qty'   => 0
        );

        $this->cart->update($data);


    }


    public function get_ticket_data(){
    	
    	$data = array(
    			'list' => $this->cart->contents(),
    			'total'   => $this->cart->total()
    	);
    	 
        return $data;
    }

    public function close(){

        $ticket_items = $this->cart->contents();
        
        $subsidiary_id = $this->config->item('subsidiary_id');

        if( count( $this->cart->contents() ) > 0 ){

            $this->db->set('printed_number', 100);
            $this->db->set('date_time', 'NOW()', FALSE);

            $this->db->insert('ticket');

            $ticket_id = $this->db->insert_id();

            foreach ($ticket_items as $item) {
                $this->db->set('product_id', $item['id']);
                $this->db->set('ticket_id', $ticket_id);
                $this->db->set('price_id', $item['options']['price_id']);
                $this->db->set('quantity', $item['qty']);
                $this->db->set('subsidiary_id', $subsidiary_id);
                $this->db->insert('product_ticket');
            }

            $this->cart->destroy();

        }

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
        
        $subsidiary_id = $this->config->item('subsidiary_id');
        
        /*
          HAY QUE CORRER ESTE INSERT PARA LA ID DE SUCURSAL 2!
          
         insert into `product_price` (
   			select `product_id`, `price_id`, 2 as subsidiary_id, sysdate() as set_date from `product_price`
		 );
         
         */

        if ( $product_id !== null ){

            $sql =
            "SELECT
                P.id, P.label AS name, PR.price, PR.id as price_id
            FROM
                `product` P
                JOIN `product_price` PP ON P.id = PP.product_id
                JOIN `price` PR ON PP.price_id = PR.id
            WHERE 
            		P.id = " . $product_id . " 
			AND PP.subsidiary_id = " . $subsidiary_id . " 
            ORDER BY PP.set_date DESC;";

            $query = $this->db->query($sql);

            $result = $query->result_array ();

            if ( count($result) > 0 ){
                $result = $result[0];
            } else {
                $result = 0;
            }

        }

        return $result;
    }

}
