<table class="table table-striped">

	<thead>
		<tr>
			<th class="col-md-5">Descripción</th>
			<th class="col-md-2">Cantidad</th>
			<th class="col-md-2">Subtotal</th>
		</tr>
	</thead>
	<tbody>

	<?php foreach ($this->cart->contents() as $items): ?>

	    <tr>
			<td class="ticket-list-row"><?php echo $items['name'];?></td>
			<td class="ticket-list-row">

				<form class="form-inline" role="form">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control input-number text-center ticket_list_qty"
								id="cant" placeholder="Cantidad" value="<?php echo $items['qty'];?>" productid="<?php echo $items['id'];?>" />

						</div>
					</div>

			</td>
			<td class="text-right ticket-list-row">$ <?php echo $this->cart->format_number($items['subtotal']); ?></td>
		</tr>

	<?php endforeach ?>

	</tbody>



</table>

<!-- TODO: sacar de aca este estilo -->
<h1 style="text-align: right;">Total: $ <?php echo $this->cart->format_number($this->cart->total()); ?></h1>