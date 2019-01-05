<?php

class Quick_Access_Model extends CI_Model {

    private $CI;

    public function __construct() {

        $this->load->database ();

    }


    public function get_quick_accesses($group = 1) {

        $sql =
        "SELECT
                qa . * ,
                p.label
         FROM
                `quick_access` qa JOIN product p ON qa.product_id = p.id
         WHERE `qa`.`group` = " . $group . "
         ORDER BY  `qa`.`group`, `qa`.`position` desc";

        $query = $this->db->query($sql);

        $result = $query->result_array ();

        return $result;

    }


    
    public function get_products() {
        
        $sql =
        "SELECT
                P.id, P.label AS name, PR.price, PR.id as price_id
            FROM
                `product` P
                JOIN `product_price` PP ON P.id = PP.product_id
                JOIN `price` PR ON PP.price_id = PR.id
            WHERE
            	PP.set_date = (SELECT MAX(PP2.set_date) FROM `product_price` PP2 WHERE PP.price_id = PP2.price_id)
            ORDER BY PP.set_date DESC;";
        
        $query = $this->db->query($sql);
        
        $result = $query->result_array ();
        
        if ( count($result) > 0 ){
            $result = $result[0];
        } else {
            $result = 0;
        }
        
        
        return $result;
        
    }

}

