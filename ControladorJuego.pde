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

  void render(float dt) {
    switch (estado) {
      case INICIO:
        pantallaInicio();
        break;
      case JUGANDO:
        actualizarJuego(dt);
        dibujarJuego();
        break;
      case GAMEOVER:
        pantallaGameOver();
        break;
    }
  }

  void procesarKeyPressed(char tecla, int code) {
    if (estado == EstadoJuego.INICIO && tecla == ' ') {
      estado = EstadoJuego.JUGANDO;
      return;
    }
    if (estado == EstadoJuego.GAMEOVER && (tecla=='r'||tecla=='R')) {
      inicializar();
      return;
    }
    if (estado == EstadoJuego.JUGANDO && (tecla=='r'||tecla=='R')) {
      nivel.iniciarNivel();
      bola.reset();
      return;
    }
    // mover paleta solo en JUGANDO
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

  void pantallaInicio() {
    background(40);

    // Color y tamaño de texto
    fill(255);
    textSize(28);

    // Centrado horizontal y vertical
    textAlign(CENTER, CENTER);

    // Dibuja en el centro exacto de la ventana
    text("Press SPACE to Start", width/2, height/2);
  }

  void pantallaGameOver() {
    background(50);

    // Título GAME OVER
    fill(255, 100, 100);
    textSize(36);
    textAlign(CENTER, CENTER);
    text("GAME OVER", width/2, height/2 - 30);  // 30px arriba del centro

    // Indicaciones para reiniciar
    fill(255);
    textSize(18);
    textAlign(CENTER, CENTER);
    text("Press R to Restart Game", width/2, height/2 + 20);  // 20px abajo
  }
}
