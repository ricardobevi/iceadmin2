<?php

class Report_Model extends CI_Model {


    public function __construct() {

        $this->load->database ();

    }


    public function query_report(){

	$sql =
	    "SELECT
	        *
	    FROM
	        `product`;";
	
	$query = $this->db->query($sql);
	
	$result = $query->result_array ();

        return $result;
    }

}
