<?php

class Report_Model extends CI_Model {

	public function __construct() {

		$this->load->database ();

	}


	public function obtain_daily_sales( $date ){

		$result = 0;
		
		$subsidiary_id = $this->config->item('subsidiary_id');
		
		if ( $date !== null ) {

			$sql = 
			"	SELECT P.label as Producto, sum(PT.quantity) as Cantidad, sum(Pr.price) as Total
				FROM 
					`ticket` T 
				    	join `product_ticket` PT on T.id = PT.ticket_id
				        join `product` P on PT.product_id = P.id
				        join `price` Pr on PT.price_id = Pr.id
				        
				WHERE 
					T.subsidiary_id = ". $subsidiary_id ."
				    
				    AND T.date_time 
				    	between 
				        	date_add( '". $date ."', INTERVAL 6 HOUR) 
				        and 
				        	date_add( '". $date ."', INTERVAL 30 HOUR)
				GROUP BY PT.product_id;";
			
			$query = $this->db->query($sql);

			$result = $query->result_array ();

			if ( count($result) < 1 ){
				$result = 0;
			}

		}

		return $result;
	}

}