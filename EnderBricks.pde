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
  juego.render(dt);
}

void keyPressed() {
  juego.procesarKeyPressed(key, keyCode);
}

void keyReleased() {
  juego.procesarKeyReleased(keyCode);
}
