<?php

class Report_Model extends CI_Model {


    public function __construct() {

        $this->load->database ();

    }


    public function query_report(){

    $sql  = "SELECT P.label, SUM(PT.quantity), SUM(Pr.price)\n"
    . "FROM \n"
    . "	ticket AS T \n"
    . "    JOIN product_ticket AS PT ON T.id = PT.ticket_id\n"
    . "    JOIN product AS P ON PT.product_id = P.id\n"
    . "    JOIN product_price AS PP ON P.id = PP.product_id\n"
    . "    JOIN price AS Pr ON PP.price_id = Pr.id\n"
    . "WHERE \n"
    . "	T.date_time BETWEEN '2017-12-10 06:00:00' AND '2017-12-10 06:00:00' + INTERVAL 23 HOUR + INTERVAL 59 MINUTE + INTERVAL 59 SECOND\n"
    . "    \n"
    . "GROUP BY P.label";

	$query = $this->db->query($sql);
	
	$result = $query->result_array ();

        return $result;
    }

}
