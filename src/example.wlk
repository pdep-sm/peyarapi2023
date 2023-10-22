import planes.*

class Pedido {
	
	const items
	const property local

	/** pto 1 */
	method precioBruto() = items.sum{ item => item.valor()}
	
	/** pto 3.a */
	method agregarProducto(producto, cantidad) {
		const item = self.itemPara(producto)
		// items.add(item) .. e items debe ser un Set
		item.agregarCantidad(cantidad)
	}
	
	method itemPara(producto) =  
		items.findOrElse({item => item.producto() == producto},
						{ const item = new Item(producto=producto)
						  items.add(item)
						  item})

	method productos() = items.map{ item => item.producto() }

	method validar() {
		local.validarProductos(self.productos())
	}

}


class Item {
	
	const property producto
	var cantidad = 0
	
	method valor() = producto.precio() * cantidad
	
	method agregarCantidad(otraCantidad) {
		cantidad = cantidad + otraCantidad
	}
	
	
}

class Producto {
	
	const property precio
	
	
}

class Cliente {
	
	var plan
	const compras = []
	
	/** pto 2.a */
	method costoRealEnvio(pedido) = calculadorCuadras.costoEnvio(self, pedido.local())
	
	/** pto 2.b */
	method costoEnvio(pedido) = plan.costoEnvio(self.costoRealEnvio(pedido))
	
	/** pto 3.b */
	method realizarComprar(pedido) {
		pedido.validar()
		const nuevaCompra = compra.nuevaCompra(pedido, self.costoEnvio(pedido))
		compras.add(nuevaCompra)
		plan.notificarNuevaCompra()
	}
	  
}

object compra {
	
	method nuevaCompra(pedido, valorEnvio) =
		return new Compra(pedido = pedido, valorEnvio = valorEnvio, fecha = new Date())
	
}

class Compra {
	const pedido
	const valorEnvio
	const fecha
	
	
}


class Local {
	
	const stockProductos
	
	method validarProductos(productos) {
		if (not productos.all{ prod => stockProductos.contains(prod) })
			throw new ProductoInexistenteException(message = "No están todos los productos disponibles en el Local")
		
	}
	
}


class ProductoInexistenteException inherits Exception {
	
}

object calculadorCuadras {
	
	var valorMaximo = 300
	var valorPorCuadra = 15
	
	method costoEnvio(cliente, local) = 
		valorMaximo.min(self.cuadras(cliente, local) * valorPorCuadra)

	method cuadras(cliente, local)  = 28 //Implementación externa	
}


