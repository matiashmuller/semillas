import plantas.*

class Parcela {
	var property ancho
	var property largo
	const property horasDeSol
	//No va property, tenemos metodo controlado para agregar plantas
	const plantasQueTiene = []
	
	method superficie() = ancho*largo
	method cantidadMaximaDePlantas() =
		if(ancho>largo) self.superficie()*0.2
		else self.superficie()/3 + largo
	method tieneComplicaciones() = plantasQueTiene.any{ p => p.horasToleraSol() < horasDeSol}
	//Se podría hacer especificando el error también
	method plantar(planta) {
		if(!self.sePuedePlantar(planta)) self.error("No se puede plantar")
		plantasQueTiene.add(planta)
	}
	method sePuedePlantar(planta) =
		plantasQueTiene.size()+1 <= self.cantidadMaximaDePlantas() &&
		horasDeSol - planta.horasToleraSol() < 2
	method cantPlantas() = plantasQueTiene.size()
	method porcentajeDeBienAsociadas() = self.cantidadQueSeAsocianBien() * 100 / self.cantPlantas()
	method cantidadQueSeAsocianBien() = plantasQueTiene.count{ p => self.seAsociaBien(p)}
	method hayAlgunaQueSupereAltura(altura) = plantasQueTiene.any{ p => p.altura() > altura }
	method seAsociaBien(planta)
}

class Ecologica inherits Parcela {
	override method seAsociaBien(planta) = !self.tieneComplicaciones() && planta.esIdeal(self)
}

class Industrial inherits Parcela {
	override method seAsociaBien(planta) = plantasQueTiene.size() <= 2 && planta.esFuerte()
}


object inta {
	const property parcelas = []
	
	method promedioPlantaParcela() = self.sumaDePlantas() / parcelas.size()
	method sumaDePlantas() = parcelas.sum{ p => p.cantPlantas() }
	method parcelaMasAutoSustentable() = self.parcelasConMasDe4().max{ p => p.porcentajeDeBienAsociadas() }
	method parcelasConMasDe4() = parcelas.filter{ p => p.cantPlantas() >4 }
}