class Ladrillo {
  PVector pos;
  float   ancho, alto;
  boolean activo = true;
  int     col;

  Ladrillo(PVector pos, float ancho, float alto) {
    this.pos   = pos.copy();
    this.ancho = ancho;
    this.alto  = alto;
    col = color(
      random(50, 255),
      random(50, 200),
      random(50, 200)
    );
  }

  boolean golpear(Bola b) {
    if (b.pos.x > pos.x && b.pos.x < pos.x + ancho &&
        b.pos.y - b.radio < pos.y + alto &&
        b.pos.y + b.radio > pos.y) {
      activo = false;
      return true;
    }
    return false;
  }

  void mostrar() {
    if (activo) {
      fill(col);
      rect(pos.x, pos.y, ancho, alto);
    }
  }
}
