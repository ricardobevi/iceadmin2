<table class="table table-striped">

	<thead>
		<tr>
			<th class="col-md-5">Producto</th>
			<th class="col-md-2">Cantidad</th>
			<th class="col-md-2">Total</th>
		</tr>
	</thead>
	<tbody>

	<?php foreach ($report_data as $row): ?>

	    <tr>
			<td><?php echo $row['Producto'];?></td>
			<td><?php echo $row['Cantidad'];?></td>
			<td><?php echo $row['Total'];?></td>
		</tr>

	<?php endforeach ?>

	</tbody>



</table>
