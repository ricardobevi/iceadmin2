<?php

class Report_Model extends CI_Model {


    public function __construct() {

        $this->load->database ();

    }


    public function query_report($date){
    
        $sql = "SELECT P.label AS product_name, SUM(PT.quantity) AS quantity, (SUM(PT.quantity) * PT.price) AS price
                FROM 
                	ticket AS T 
                    JOIN product_ticket AS PT ON T.id = PT.ticket_id
                    JOIN product AS P ON PT.product_id = P.id
                WHERE 
                	T.date_time BETWEEN '".$date." 06:00:00' AND '".$date." 06:00:00' + INTERVAL 23 HOUR + INTERVAL 59 MINUTE + INTERVAL 59 SECOND
                    
                GROUP BY P.label, PT.price
                ORDER BY P.label";
    
    	$query = $this->db->query($sql);
    	
    	$result = $query->result_array ();
    	
        return $result;
    
    }

}
