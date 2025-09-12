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
  float dt = ahora - tiempoAnterior;
  tiempoAnterior = ahora;

  if (juego.estado == EstadoJuego.INICIO) {
    background(40);
    fill(255);
    textSize(28);
    text("Presiona [SPACE] para iniciar", width/2, height/2);
  } 
  else {
    juego.actualizar(dt);
  }

  juego.dibujar();
}

void keyPressed() {
  juego.verificarEntrada();
}
