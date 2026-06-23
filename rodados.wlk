class Corsa {
    var color

    method pintarDe(unColor){color = unColor}
    method capacidad() = 4
    method velocidad() = 150
    method peso() = 1300
    method color() = color
    
}
class Kwid {
    var tieneTanqueAdicional

    method agregarTanque(){tieneTanqueAdicional = true}
    method quitarTanque(){tieneTanqueAdicional = false}
    method capacidad() = if(tieneTanqueAdicional) 3 else 4
    method velocidad() = if (tieneTanqueAdicional) 110 else 120
    method peso() = 1200 + if (tieneTanqueAdicional) 150 else 0
    method color() = "azul"
}
object trafic {
    var interior = comodo
    var motor = bataton
    method cambiarInterior(unInterior){interior =unInterior}
    method cambiarMotor(unMotor){motor = unMotor}
    method capacidad() = interior.capacidad()
    method velocidad() = motor.velocidad()
    method peso() = 4000 + interior.peso() + motor.peso()
    method color() = "blanco"
}
object comodo {
  method capacidad()= 5
  method peso() = 700
}
object popular {
  method capacidad()= 12
  method peso() = 1000
}
object bataton {
    method velocidad()= 80
    method peso() = 500
}
object pulenta {
    method velocidad()= 130
    method peso() = 800
}
class AutoEspecial {
    const capacidad
    const velocidad
    const peso
    var color

    method capacidad() = capacidad
    method velocidad() = velocidad
    method peso() = peso
    method color() = color
    method pintarDe(unColor){color = unColor}

}

class Dependencia {
    const flota = #{}
    const empleados
    const pedidos = #{}


    method flota() = flota
    method empleados() = empleados

    method agregarRodado(unRodado) {
      flota.add(unRodado)
    }
    method quitarRodado(unRodado) {
      flota.remove(unRodado)
    }
    method agregarUnPedido(unPedido) {
      pedidos.add(unPedido)
    }
    method quitarUnPedido(unPedido) {
      pedidos.remove(unPedido)
    }
    method relajarTodosLosPedidos() {
        pedidos.forEach({ p => p.relajar() })
    }

    method totalPasajerosEnPedidos() = pedidos.sum({ p => p.cantidadPasajeros() })
    method todosLosPedidosRechazanColor(unColor) = pedidos.all({ p => p.coloresIncompatibles().contains(unColor) })
    method pesoTotalFlota() = flota.sum({p => p.peso()})
    method estaBienEquipada() = flota.size() > 2 && self.todosVanA(100)
    method quePedidosNoPuedenSerSatisfechoPorNingunAuto() = pedidos.filter({p => not self.algunAutoSatisface(p)})
    method algunAutoSatisface(unPedido) = flota.any({p=> unPedido.puedeSatisfacer(p) })
    method todosVanA(unaVelocidad) =flota.all({p => p.velocidad() >= unaVelocidad})
    method capacidadTotalEnColor(unColor) = self.filtrarDeColor(unColor).sum({p => p.capacidad()})
    method filtrarDeColor(unColor) = flota.filter({p => p.color() == unColor})
    method colorDelRodadoMasRapido() =self.rodadoMasRapido().color()
    method rodadoMasRapido() = flota.max({p => p.velocidad()})  
    method capacidadFaltante() = (empleados - self.capacidadDeFlota()).max(0)
    method capacidadDeFlota() = flota.sum({p => p.capacidad()})
    method esGrande() = empleados >= 40 && flota.size() >= 5 
}
class Pedido {
    const distancia
    var tiempoMaximo
    var cantidadPasajeros
    const coloresIncompatibles = #{}

    method agregarColoresIncompatibles(unColor) {
        coloresIncompatibles.add(unColor)
    }
    method quitarColoresIncompatibles(unColor) {
        coloresIncompatibles.remove(unColor)
    }
    method cambiarCantidadPasajeros(nuevaCantidad) {
        cantidadPasajeros = nuevaCantidad
    }
    method acelerar() { 
        tiempoMaximo = tiempoMaximo - 1
    }
    method relajar() {
        tiempoMaximo = tiempoMaximo + 1 
    }

    method velocidadRequerida() = distancia.div(tiempoMaximo)
    method puedeSatisfacerPedido(unAuto) = 
            unAuto.velocidad() >= self.velocidadRequerida() + 10 && 
            unAuto.capacidad() >= cantidadPasajeros 
            && not coloresIncompatibles.contains(unAuto)
}
