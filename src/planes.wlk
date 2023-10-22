class Plan {
	
	method costoEnvio(costoRealEnvio)
	
	method notificarNuevaCompra() {
		//No hace nada
	}
}


object comun inherits Plan {
	
	override method costoEnvio(costoRealEnvio) = costoRealEnvio
}

object silver inherits Plan {
	
	override method costoEnvio(costoRealEnvio) = costoRealEnvio * 0.5
	
}


class Gold inherits Plan {
	
	var cantidad = 0
	
	override method costoEnvio(costoRealEnvio) = if (self.siguienteEnvioGratis()) 0 else costoRealEnvio * 0.1
	
	method siguienteEnvioGratis() = cantidad > 0 and cantidad % 5 == 0
	
	override method notificarNuevaCompra() {
		cantidad = cantidad + 1
	}
	
}