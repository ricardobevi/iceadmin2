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
                P.id AS product_id,
                P.label
            FROM
                `product` P
        ORDER BY P.name;";
        
        $query = $this->db->query($sql);
        
        $result = $query->result_array ();
        
        return $result;
        
    }

}

