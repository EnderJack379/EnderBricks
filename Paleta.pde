class Paleta {
  PVector pos;
  float ancho   = 100;
  float alto    = 20;
  float velocidad = 400; // px/seg

  Paleta() {
    pos = new PVector(width/2 - ancho/2, height - alto - 20);
  }

  void actualizar(float dt) {
    if (keyPressed) {
      if (keyCode == LEFT)  pos.x -= velocidad * dt;
      if (keyCode == RIGHT) pos.x += velocidad * dt;
    }
    pos.x = constrain(pos.x, 0, width - ancho);
  }

  void mostrar() {
    fill(200);
    rect(pos.x, pos.y, ancho, alto);
  }
}
