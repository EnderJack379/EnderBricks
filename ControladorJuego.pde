class ControladorJuego {
  Paleta paleta;
  Bola   bola;
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
    bola.actualizar(dt, paleta);                  // colisiones y caída
    nivel.actualizar(dt, bola, puntuacion);       // golpear ladrillos
    // Verificar vida y Game Over
    if (puntuacion.vidas <= 0) {
      estado = EstadoJuego.GAMEOVER;
    }
  }

  void dibujar() {
    background(0);
    paleta.mostrar();
    bola.mostrar();
    nivel.dibujarLadrillos();
    puntuacion.mostrar();
  }

  void verificarEntrada() {
    // Aquí puedes capturar W/A/S/D u otras teclas si las necesitas
  }
}
