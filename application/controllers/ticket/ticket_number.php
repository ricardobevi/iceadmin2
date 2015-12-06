<?php
if (! defined ( 'BASEPATH' ))
	exit ( 'No direct script access allowed' );


class Ticket_Number extends CI_Controller {

	public function __construct() {

		parent::__construct ();
		$this->load->helper('url');
		$this->load->model ( 'ticket/ticket_list_model' );

	}

	public function index($number) {

		
	}
	
	public function print_number($number){

		$number_img = imagecreate( 160, 65 );
		$background = imagecolorallocate( $number_img, 255, 255, 255 );
		$text_colour = imagecolorallocate( $number_img, 0, 0, 0 );
		
		$font = "public/fonts/DejaVuSansMono-Bold.ttf";
		
		
		imagettftext($number_img,
				65, // size
				0,
				10, // X
				64, // Y
				$text_colour,
				$font,
				$number);
		
		$number_img = imagescale($number_img, 160, 90,  IMG_BICUBIC_FIXED);
		
		header( "Content-type: image/png" );
		
		imagepng( $number_img );
		imagecolordeallocate( $text_color );
		imagecolordeallocate( $background );
		imagedestroy( $number_img );
				
	}
	
	



}

/* End of file ticket_number.php */
/* Location: ./application/controllers/ticket/ticket_number.php */


