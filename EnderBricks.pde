ControladorJuego juego;
float tiempoAnterior;

void setup() {
  size(800, 600);
  juego = new ControladorJuego();
  juego.inicializar();
  tiempoAnterior = millis() / 1000.0;
  textAlign(CENTER, CENTER);
}

void draw() {
  float ahora = millis() / 1000.0;
  float dt    = ahora - tiempoAnterior;
  tiempoAnterior = ahora;

  // Pantallas según estado
  if (juego.estado == EstadoJuego.INICIO) {
    background(40);
    fill(255);
    textSize(28);
    text("Press SPACE to Start", width/2, height/2);
  }
  else if (juego.estado == EstadoJuego.GAMEOVER) {
    background(50);
    fill(255, 100, 100);
    textSize(36);
    text("GAME OVER", width/2, height/2 - 20);
    fill(255);
    textSize(18);
    text("Press R to Restart Game", width/2, height/2 + 20);
  }
  else {  // Estado JUGANDO
    juego.actualizar(dt);
    juego.dibujar();
  }
}

void keyPressed() {
  // Manejo de arranques y reinicios
  if (juego.estado == EstadoJuego.INICIO && key == ' ') {
    juego.estado = EstadoJuego.JUGANDO;
  }
  else if (juego.estado == EstadoJuego.GAMEOVER && (key == 'r' || key == 'R')) {
    juego.inicializar();
    juego.estado = EstadoJuego.INICIO;
  }
  else if (juego.estado == EstadoJuego.JUGANDO && (key == 'r' || key == 'R')) {
    // Reiniciar solo el nivel actual
    juego.nivel.iniciarNivel();
    juego.bola.reset();
  }
  else {
    // Para movimientos de paleta u otras teclas en JUGANDO
    juego.verificarEntrada();
  }
}
