<div id="quick_access_group_<?php echo $group; ?>" class="panel panel-default">

	<div class="panel-body text-center">

		<?php 
			$buttons = array();
		?>

        <?php 
        
        
            foreach ($quickaccess as $quickaccess_item): 
            
            
            $possition = 1;
         ?>

    		<?php 
    		if( ( $possition % 3 ) == 0  ) {
    				echo '<div class="btn-group btn-group-lg" role="group">';
    			}
    		?>

				<?php ?>

    		    <?php
    		      $css_classes = "btn btn-default btn-block block quickaccess";
    		      

    		      $buttons[] = '<button type="button"
                                class="'.$css_classes.'"
                                style="white-space: normal;"
                                productid="'.$quickaccess_item['product_id'].'">';
    		      
    		      $currentPos = count($buttons) - 1;

    		    ?>

    			     <?php $buttons[$currentPos] = $buttons[$currentPos] . $quickaccess_item['label'];?>

    			</button>

    		<?php if( count($buttons) >= 3) {
    		           
    		        $button_count = count($buttons);    
    		        
    		        for( $j = $button_count - 1 ; $j >= 0 ; $j-- ) {
    		        	echo $buttons[$j];
    		        }
   
    		        $buttons = array();
    		                	
    		      	echo '</div>'; 
    		      } 
    		      
    		      
    		      $possition++;
    		?>
    		
    		

		<?php endforeach ?>


	</div>

	<!-- div class="panel-footer">Presiona <kbd>CTRL</kbd> para más opciones.</div -->

</div>

<?php 
// if ( isset($hidden_view) ) echo $hidden_view;
?>

