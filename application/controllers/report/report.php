<?php

if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Report extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        
        $this->load->model ( 'report/report_model' );

    }

    public function index() {
    	
    	$date = "0";

		$data ['report_data'] = $this->report_model->obtain_daily_sales($date);
		
		$this->load->view ( 'templates/header' );
        $this->load->view ( 'report/report_view', $data );
        $this->load->view ( 'templates/footer' );
    }
    
    public  function date($date){
    
    	$data ['report_data'] = $this->report_model->obtain_daily_sales($date);
    	
    	$header['load_printer'] = false;
    	
    	$this->load->view ( 'templates/header', $header );
    	$this->load->view ( 'report/report_view', $data );
    	$this->load->view ( 'templates/footer' );
    }


}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket.php */
