
<div class="panel panel-default">

	<div class="panel-body text-center">

        <?php foreach ($quickaccess as $quickaccess_item): ?>

    		<?php if( ( $quickaccess_item['position'] % 3 ) == 0  ) echo '<div class="btn-group btn-group-lg" role="group">'; ?>

    		    <?php
    		      $css_classes = "btn btn-default btn-block block quickaccess";

    		      if( $quickaccess_item['position'] == 9 )
    		          $css_classes = $css_classes . " blockh2";

		          echo '<button type="button"
                                class="'.$css_classes.'"
                                style="white-space: normal;"
                                productid="'.$quickaccess_item['product_id'].'">';

    		    ?>

    			     <?php echo $quickaccess_item['label'];?>

    			</button>

    		<?php if( ( ( $quickaccess_item['position'] + 1) % 3 == 0 ) || ( $quickaccess_item['position'] == 10 ) ) echo '</div>'; ?>

		<?php endforeach ?>


	</div>

	<div class="panel-footer">Presiona <kbd>CTRL</kbd> para más opciones.</div>

</div>


