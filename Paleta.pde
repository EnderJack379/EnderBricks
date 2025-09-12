class Paleta {
  PVector pos;
  float ancho     = 100;
  float alto      = 20;
  float velocidad = 400;
  boolean moverIzq = false, moverDer = false;

  Paleta() {
    pos = new PVector(width/2 - ancho/2, height - alto - 20);
  }

  void keyPressed(int code) {
    if (code == LEFT)  moverIzq = true;
    if (code == RIGHT) moverDer = true;
  }

  void keyReleased(int code) {
    if (code == LEFT)  moverIzq = false;
    if (code == RIGHT) moverDer = false;
  }

  void actualizar(float dt) {
    if (moverIzq)  pos.x -= velocidad * dt;
    if (moverDer)  pos.x += velocidad * dt;
    pos.x = constrain(pos.x, 0, width - ancho);
  }

  void mostrar() {
    fill(200);
    rect(pos.x, pos.y, ancho, alto);
  }
}
