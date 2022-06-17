import parcelas.*

class Planta {
	const property anioCosecha
	var property altura
	
	method horasToleraSol()
	method esFuerte() = self.horasToleraSol() > 10
	method daSemillasNuevas() = self.esFuerte() || self.alternativa()
	method alternativa()
	method espacioQueOcupa()
	method esIdeal(parcela)
}

class Menta inherits Planta {
	override method horasToleraSol() = 6
	override method alternativa() = altura > 0.4
	override method espacioQueOcupa() = altura*3
	override method esIdeal(parcela) = parcela.superficie() > 6
}

class Soja inherits Planta {
	override method horasToleraSol() =
		if(altura < 0.5) 6
		else if (altura.between(0.5,1)) 7
		else 9
		
	override method alternativa() = anioCosecha > 2007 && altura > 1
	override method espacioQueOcupa() = altura*0.5
	override method esIdeal(parcela) = parcela.horasDeSol() == self.horasToleraSol()
}

class Quinoa inherits Planta {
	const property horasToleraSol
	
	override method alternativa() = anioCosecha < 2005
	override method espacioQueOcupa() = 0.5
	override method esIdeal(parcela) = !parcela.hayAlgunaQueSupereAltura(1.5)
}


class SojaTransgenica inherits Soja {
	override method daSemillasNuevas() = false
	override method esIdeal(parcela) = parcela.cantidadMaximaDePlantas() == 1
}

class Hierbabuena inherits Menta {
	override method espacioQueOcupa() = super()*2
}