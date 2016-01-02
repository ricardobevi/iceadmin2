<?php
if (! defined ( 'BASEPATH' ))
    exit ( 'No direct script access allowed' );


class Report extends CI_Controller {

    public function __construct() {

        parent::__construct ();
        
        $this->load->model ( 'report/report_model' );

    }

    public function index() {

		$data ['report_data'] = $this->report_model->obtain_daily_sales("2015-12-07");
		
        $this->load->view ( 'report/report_view', $data );

    }


}

/* End of file quick_access.php */
/* Location: ./application/controllers/ticket.php */
