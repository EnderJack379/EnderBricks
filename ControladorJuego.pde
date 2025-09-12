class ControladorJuego {
  Paleta paleta;
  Bola bola;
  GestorNivel nivel;
  GestorPuntuacion puntuacion;
  EstadoJuego estado;

  void inicializar() {
    paleta     = new Paleta();
    bola       = new Bola();
    nivel      = new GestorNivel(5, 10);
    puntuacion = new GestorPuntuacion();
    estado     = EstadoJuego.INICIO;
  }

  void actualizar(float dt) {
    paleta.actualizar(dt);
    bola.actualizar(dt, paleta);
    nivel.actualizar(dt, bola);
  }

  void dibujar() {
    background(0);
    paleta.mostrar();
    bola.mostrar();
    nivel.dibujarLadrillos();
    puntuacion.mostrar();
  }

  void verificarEntrada() {
    if (estado == EstadoJuego.INICIO && key == ' ') {
      estado = EstadoJuego.JUGANDO;
    }
  }
}
