class Ladrillo {
  PVector pos;
  float ancho, alto;
  boolean activo = true;

  Ladrillo(PVector pos, float ancho, float alto) {
    this.pos = pos.copy();
    this.ancho = ancho;
    this.alto  = alto;
  }

  boolean golpear(Bola b) {
    if (b.pos.x > pos.x && b.pos.x < pos.x+ancho &&
        b.pos.y - b.radio < pos.y+alto && b.pos.y + b.radio > pos.y) {
      activo = false;
      return true;
    }
    return false;
  }

  void mostrar() {
    if (activo) {
      fill(100, 200, 255);
      rect(pos.x, pos.y, ancho, alto);
    }
  }
}
