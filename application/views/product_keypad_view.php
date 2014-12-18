
<div class="panel panel-default">

	<div class="panel-body text-center">

        <?php foreach ($quickaccess as $quickaccess_item): ?>

    		<?php if( ( $quickaccess_item['position'] % 3 ) == 0  ) echo '<div class="btn-group btn-group-lg" role="group">'; ?>

    			<button type="button" class="btn btn-default btn-block block"><?php echo $quickaccess_item['label'];?></button>

    		<?php if( ( $quickaccess_item['position'] % 3 ) == 0  ) echo '</div>'; ?>

		<?php endforeach ?>


		<div class="btn-group btn-group-lg" role="group">

			<button type="button" class="btn btn-default btn-block block blockh2">1
				Kg</button>
			<button type="button" class="btn btn-default btn-block block">Vaso
				$10</button>

		</div>

	</div>

	<div class="panel-footer">Presiona <kbd>CTRL</kbd> para más opciones.</div>

</div>


