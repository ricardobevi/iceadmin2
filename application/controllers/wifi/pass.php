<?php
if (! defined ( 'BASEPATH' ))
	exit ( 'No direct script access allowed' );


	class Pass extends CI_Controller {

		public function __construct() {

			parent::__construct ();

		}

		public function index() {
		}
		
		public function get_pass($token){
			
			if( $token == 'lala' ){
				
				$date = '';
				
				if ( date("G") > 0 && date("G") <= 6 ){
					$date = date("z") - 1;
				} else {
					$date = date("z");
				}
				
				$date = sprintf("%03d", $date + 1); //para compensar que empieza desde 0
				
				$wifi_pass['wifi_pass'] = 'amores_' . substr(md5($date), -4);
				
			}
			
			$this->load->view ( 'wifi/wifi_view', $wifi_pass);
		}


	}

	/* End of file wifi.php */
	/* Location: ./application/controllers/wifi/wifi.php */
