class ControladorJuego {
  Paleta paleta;
  Bola bola;
  GestorNivel nivel;
  GestorPuntuacion puntuacion;
  EstadoJuego estado;

  PImage menuImg;
  PImage gameOverImg;

  void setMenuImage(PImage img)      { this.menuImg = img; }
  void setGameOverImage(PImage img)  { this.gameOverImg = img; }

  void inicializar() {
    paleta     = new Paleta();
    bola       = new Bola();
    nivel      = new GestorNivel(5, 10);
    puntuacion = new GestorPuntuacion();
    estado     = EstadoJuego.INICIO;
  }

  void render(float dt) {
    switch (estado) {
      case INICIO:
        image(menuImg, 0, 0, width, height);
        break;

      case PRE_JUEGO:
        dibujarJuego();
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(18);
        text("Presiona barra espaciadora para iniciar", width/2, height - 40);
        break;

      case JUGANDO:
        actualizarJuego(dt);
        dibujarJuego();
        break;

      case GAMEOVER:
        image(gameOverImg, 0, 0, width, height);
        break;
    }
  }

  void procesarKeyPressed(char tecla, int code) {
    // 1) INICIO + SPACE → PRE_JUEGO
    if (estado == EstadoJuego.INICIO && tecla == ' ') {
      estado = EstadoJuego.PRE_JUEGO;
      return;
    }

    // 2) Cualquier estado + R → reiniciar nivel/bola y PRE_JUEGO
    if (tecla == 'r' || tecla == 'R') {
      nivel.iniciarNivel();
      bola.reset();
      // Si quieres resetear puntuación y vidas descomenta:
      // puntuacion.reset();
      estado = EstadoJuego.PRE_JUEGO;
      return;
    }

    // 3) PRE_JUEGO + SPACE → arranca la pelota y pasa a JUGANDO
    if (estado == EstadoJuego.PRE_JUEGO && tecla == ' ') {
      estado = EstadoJuego.JUGANDO;
      return;
    }

    // 4) Movimiento de paleta solo en JUGANDO
    if (estado == EstadoJuego.JUGANDO) {
      paleta.keyPressed(code);
    }
  }

  void procesarKeyReleased(int code) {
    if (estado == EstadoJuego.JUGANDO) {
      paleta.keyReleased(code);
    }
  }

  void actualizarJuego(float dt) {
    paleta.actualizar(dt);
    bola.actualizar(dt, paleta);
    nivel.actualizar(dt, bola, puntuacion);
    if (puntuacion.vidas <= 0) {
      estado = EstadoJuego.GAMEOVER;
    }
  }

  void dibujarJuego() {
    background(0);
    paleta.mostrar();
    bola.mostrar();
    nivel.dibujarLadrillos();
    puntuacion.mostrar();
  }
}
