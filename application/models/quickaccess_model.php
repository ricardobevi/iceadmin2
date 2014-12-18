<?php

class QuickAccess_model extends CI_Model {

    private $CI;

    public function __construct() {

        $this->load->database ();

    }


    public function getQuickAccesses() {

        $sql =
        "SELECT
                qa . * ,
                p.label
         FROM
                `quick_access` qa JOIN product p ON qa.product_id = p.id
         ORDER BY `qa`.`position`, `qa`.`group`";

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

