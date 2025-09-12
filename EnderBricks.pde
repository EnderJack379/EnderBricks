ControladorJuego juego;
float tiempoAnterior;

void setup() {
  size(800, 600);
  juego = new ControladorJuego();
  juego.inicializar();
  tiempoAnterior = millis() / 1000.0;
}

void draw() {
  float ahora = millis() / 1000.0;
  float dt = ahora - tiempoAnterior;
  tiempoAnterior = ahora;
  juego.actualizar(dt);
  juego.dibujar();
}

void keyPressed() {
  juego.verificarEntrada();
}
