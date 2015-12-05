<?php
if (! defined ( 'BASEPATH' ))
	exit ( 'No direct script access allowed' );


class Ticket_Number extends CI_Controller {

	public function __construct() {

		parent::__construct ();
		$this->load->helper('url');
		$this->load->model ( 'ticket/ticket_list_model' );

	}

	public function index() {

		$my_img = imagecreate( 160, 90 );
		$background = imagecolorallocate( $my_img, 255, 255, 255 );
		$text_colour = imagecolorallocate( $my_img, 0, 0, 0 );
		
		//imagestring( $my_img, 1, 0, 0, "lala", $text_colour );
		
		$font = "public/fonts/targa.ttf";
		
		imagettftext($my_img, 
					 84, // size 
				     0, 
				     15, // X
				     90, // Y
				     $text_colour, 
				     $font, 
				     "987");
		
		
		header( "Content-type: image/png" );
		imagepng( $my_img );
		imagecolordeallocate( $text_color );
		imagecolordeallocate( $background );
		imagedestroy( $my_img );
		
	}



}

/* End of file ticket_number.php */
/* Location: ./application/controllers/ticket/ticket_number.php */


