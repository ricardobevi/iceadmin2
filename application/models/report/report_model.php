<?php

class Report_Model extends CI_Model {


    public function __construct() {

        $this->load->database ();

    }


    public function query_report($date){

    $sql  = "SELECT P.label AS product_name, SUM(PT.quantity) AS quantity, SUM(PT.quantity) * Pr.price AS price\n"
    . "FROM \n"
    . "	ticket AS T \n"
    . "    JOIN product_ticket AS PT ON T.id = PT.ticket_id\n"
    . "    JOIN product AS P ON PT.product_id = P.id\n"
    . "    JOIN product_price AS PP ON P.id = PP.product_id AND PP.subsidiary_id = 1\n"
    . "    JOIN price AS Pr ON PP.price_id = Pr.id\n"
    . "WHERE \n"
    . "	T.date_time BETWEEN '".$date." 06:00:00' AND '".$date." 06:00:00' + INTERVAL 23 HOUR + INTERVAL 59 MINUTE + INTERVAL 59 SECOND\n"
    . "    \n"
    . "GROUP BY P.label \n"
    . "ORDER BY P.label; ";

	$query = $this->db->query($sql);
	
	$result = $query->result_array ();
	
        return $result;
    }

}
