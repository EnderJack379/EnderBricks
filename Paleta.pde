class Paleta {
  int    tipo;          // 0: rectangular, 1: con hueco, 2: circular
  PVector pos;
  float  ancho, alto;
  float  holeWidth, radius;

  // flags para controlar el movimiento por teclas
  boolean izquierda = false;
  boolean derecha   = false;
  float   velocidad = 400;  // pix/s

  Paleta() {
    setTipo(0);
  }

  void setTipo(int t) {
    tipo = t;
    switch (tipo) {
      case 0:
        ancho     = width * 0.15;
        alto      = 10;
        holeWidth = 0;
        radius    = 0;
        break;
      case 1:
        ancho     = width * 0.15;
        alto      = 10;
        holeWidth = ancho * 0.6;
        radius    = 0;
        break;
      case 2:
        radius    = 8;
        ancho     = radius * 2;
        alto      = radius * 2;
        holeWidth = 0;
        break;
    }
    pos = new PVector((width - ancho) / 2, height - alto - 20);
  }

  // — estas dos firmas PERMITEN que paleta.keyPressed(...) compile —
  void keyPressed(int code, char tecla) {
    // flechas izquierda/derecha o A/D
    if (code == LEFT   || tecla=='a' || tecla=='A') izquierda = true;
    if (code == RIGHT  || tecla=='d' || tecla=='D') derecha   = true;
  }

  void keyReleased(int code, char tecla) {
    if (code == LEFT   || tecla=='a' || tecla=='A') izquierda = false;
    if (code == RIGHT  || tecla=='d' || tecla=='D') derecha   = false;
  }

  void actualizar(float dt) {
    float dx = 0;
    if (izquierda) dx -= velocidad * dt;
    if (derecha)   dx += velocidad * dt;
    pos.x += dx;
    // límite de pantalla
    pos.x = constrain(pos.x, 0, width - ancho);
  }

  void mostrar() {
    fill(255);
    noStroke();
    if (tipo == 0) {
      rect(pos.x, pos.y, ancho, alto);
    } 
    else if (tipo == 1) {
      float seg = (ancho - holeWidth) / 2;
      rect(pos.x,               pos.y, seg, alto);
      rect(pos.x + seg + holeWidth, pos.y, seg, alto);
    } 
    else {
      ellipse(pos.x + radius, pos.y + radius, radius*2, radius*2);
    }
  }
}
