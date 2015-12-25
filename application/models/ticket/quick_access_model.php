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

    /*

    public function set_news() {

        $this->load->helper ( 'url' );

        $slug = url_title ( $this->input->post ( 'title' ), 'dash', TRUE );

        $data = array (
                'title' => $this->input->post ( 'title' ),
                'slug' => $slug,
                'text' => $this->input->post ( 'text' )
        );

        return $this->db->insert ( 'news', $data );

    }
    */

}

