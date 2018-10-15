class Juego {

	var property nombre
	var property categoria
	var property precio
	var property demo 

	constructor(_nombre, _categoria,_precio,_demo) {
		nombre = _nombre
		categoria = _categoria
		precio = _precio
		demo =_demo
	}
	method esBarato() = self.precio() < 30

}

class Violento inherits Juego{
	method alteraciones(jugador){
		jugador.humor(jugador.humor()-10)		
	}
} 
class MOBA inherits Juego{
	method alteraciones(jugador){
		jugador.cobrar(30)		
	}
}
class Terrorifico inherits Juego{
	method alteraciones(jugador){
		jugador.suscripcion(infantil)		
	}
}
class Estrategico inherits Juego{
	method alteraciones(jugador){
		jugador.humor(jugador.humor()+5)	
	}
}

object catalogo {

	var property juegos = []

	method agregar(juego) {
		juegos.add(juego)
	}

	method quitar(juego) {
		juegos.remove(juego)
	}

	method filtrarXCategoria(categoria) {
		return juegos.filter({ juego => juego.categoria() == categoria })
	}

	method buscar(objetivo) {
		var encontrado = juegos.filter({ juego => juego.nombre() == objetivo})
		if (encontrado.isEmpty()) {
			throw new Exception("No se encontró el juego que buscaba le recomendamos el " + juegos.anyOne())
		} else {
			return encontrado.head()
		}
	}
}

class Usuario{
	var property dinero
	var property humor
	var property suscripcion
	constructor(_suscripcion,_dinero,_humor){
		suscripcion = _suscripcion
		dinero = _dinero
		humor = _humor
	}
	method puedeJugar(juego) = suscripcion.permite(juego)
	
	method cobrar(monto){
		if (dinero < monto){
			throw new Exception("Usted no tiene dinero para hacer dicha operación")
		}else{
			dinero -= monto
		}	
	}
	method cobrarSuscripcion(){
		//self.cobrar(suscripcion.costo())
		
		 if(dinero < suscripcion.costo()){
			suscripcion = prueba
		}else{
			dinero -= suscripcion.costo()
		}
		
	}
	
	method juega(juego){
		if (self.puedeJugar(juego)){
			juego.alteraciones(self)
			
		}else{
			throw new Exception("Usted no tiene permiso para jugar a este juego. Sea premium por $50 al mes")
		}
		
	}
}

object premium{
	method permite(juego) = true
	method costo() = 50
}
object base{
	method permite(juego) = juego.esBarato()
	method costo() = 25
}
object prueba{
	method permite(juego) = juego.demo()
	method costo() = 0
}
object infantil{
	method permite(juego) = (juego.categoria() == "Infantil")
	method costo() = 10
}