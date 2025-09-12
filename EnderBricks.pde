PImage menuImg;
PImage gameOverImg;
ControladorJuego juego;
float tiempoAnterior;

void setup() {
  size(900, 700);
  // Carga de imágenes
  menuImg      = loadImage("EnderBricks_Menu.png");
  gameOverImg  = loadImage("GameOver.png");

  juego = new ControladorJuego();
  // Asigna las imágenes
  juego.setMenuImage(menuImg);
  juego.setGameOverImage(gameOverImg);
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
