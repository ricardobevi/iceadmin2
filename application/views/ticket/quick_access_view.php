<div id="quick_access_group_<?php echo $group; ?>" class="panel panel-default">

	<div class="panel-body text-center">

		<?php 
			$buttons = array();
		?>

        <?php foreach ($quickaccess as $quickaccess_item): ?>

    		<?php 
    			if( ( $quickaccess_item['position'] % 3 ) == 0  ) {
    				echo '<div class="btn-group btn-group-lg" role="group">';
    			}
    		?>

				<?php ?>

    		    <?php
    		      $css_classes = "btn btn-default btn-block block quickaccess";

    		      /*
    		      if( $quickaccess_item['position'] == 0 )
    		          $css_classes = $css_classes . " blockh2";
    		      */
    		      

    		      $buttons[] = '<button type="button"
                                class="'.$css_classes.'"
                                style="white-space: normal;"
                                productid="'.$quickaccess_item['product_id'].'"
    							position="' . $quickaccess_item['group'] . ',' . $quickaccess_item['position'] .'">';
    		      
    		      $currentPos = count($buttons) - 1;

    		    ?>

    			     <?php $buttons[$currentPos] = $buttons[$currentPos] . $quickaccess_item['label'];?>

    			</button>

    		<?php if( count($buttons) >= 3) {
    		           
    		        $i = count($buttons);    		                	
    		        
    		        for( $j = $i - 1 ; $j >= 0 ; $j-- ) {
    		        	echo $buttons[$j];
    		        }
   
    		        $buttons = array();
    		                	
    		      	echo '</div>'; 
    		      } 
    		?>
    		
    		

		<?php endforeach ?>


	</div>

	<!-- div class="panel-footer">Presiona <kbd>CTRL</kbd> para más opciones.</div -->

</div>

<?php 
// if ( isset($hidden_view) ) echo $hidden_view;
?>

