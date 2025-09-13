import ddf.minim.AudioPlayer;

class ControladorJuego {
  // —— Componentes de juego ——  
  Paleta           paleta;
  Bola             bola;
  GestorNivel      nivel;
  GestorPuntuacion puntuacion;
  EstadoJuego      estado;
  int              nivelActual;

  // —— Recursos gráficos ——  
  PImage           menuImg, gameOverImg, victoryImg;

  // —— Música de escena ——  
  AudioPlayer      menuMusic, goMusic, lvl1Music, lvl2Music, lvl3Music;
  AudioPlayer      preMusic, pauseMusic, vicMusic;

  // —— Efectos de sonido ——  
  AudioPlayer      bounceSound, brickSound;

  // —— Setters de imágenes ——  
  void setMenuImage(PImage img)      { menuImg     = img; }
  void setGameOverImage(PImage img)  { gameOverImg = img; }
  void setVictoryImage(PImage img)   { victoryImg  = img; }

  // —— Setters de música ——  
  void setMenuMusic(AudioPlayer ap)    { menuMusic   = ap; }
  void setGoMusic(AudioPlayer ap)      { goMusic     = ap; }
  void setLevel1Music(AudioPlayer ap)  { lvl1Music   = ap; }
  void setLevel2Music(AudioPlayer ap)  { lvl2Music   = ap; }
  void setLevel3Music(AudioPlayer ap)  { lvl3Music   = ap; }
  void setPreMusic(AudioPlayer ap)     { preMusic    = ap; }
  void setPauseMusic(AudioPlayer ap)   { pauseMusic  = ap; }
  void setVicMusic(AudioPlayer ap)     { vicMusic    = ap; }

  // —— Setters de efectos ——  
  void setBounceSound(AudioPlayer ap)  { bounceSound = ap; }
  void setBrickSound(AudioPlayer ap)   { brickSound  = ap; }

  // —— Inicialización de componentes y estado ——  
  void inicializar() {
    nivelActual = 1;
    paleta      = new Paleta();
    bola        = new Bola();
    nivel       = new GestorNivel(5, 10);
    puntuacion  = new GestorPuntuacion();
    paleta.setTipo(0);

    // pasa efectos a instancias
    bola.setBounceSound(bounceSound);
    nivel.setBrickSound(brickSound);

    estado = EstadoJuego.INICIO;
    reproducirMusica(estado);
  }

  // —— Renderizado según estado ——  
  void render(float dt) {
    switch (estado) {
      case INICIO:
        image(menuImg, 0, 0, width, height);
        break;
      case PRE_JUEGO:
        dibujarJuego();
        mostrarTexto("Presiona SPACE para iniciar");
        break;
      case JUGANDO:
        actualizarJuego(dt);
        dibujarJuego();
        break;
      case PAUSA:
        dibujarJuego();
        mostrarTexto("PAUSA – presiona P para continuar");
        break;
      case GAMEOVER:
        image(gameOverImg, 0, 0, width, height);
        break;
      case VICTORIA:
        image(victoryImg, 0, 0, width, height);
        break;
    }
  }

  // —— Firmas que deben existir para coincidir con Main.pde ——  
  // En Main.pde llamamos: juego.keyPressed(keyCode, key);
  void keyPressed(int code, char tecla) {
    procesarKeyPressed(tecla, code);
  }

  // En Main.pde llamamos: juego.keyReleased(keyCode, key);
  void keyReleased(int code, char tecla) {
    procesarKeyReleased(tecla, code);
  }

  // —— Lógica de pulsación de tecla ——  
  void procesarKeyPressed(char tecla, int code) {
    // P ↔ PAUSA
    if (estado == EstadoJuego.JUGANDO && (tecla=='p' || tecla=='P')) {
      estado = EstadoJuego.PAUSA;
      reproducirMusica(estado);
      return;
    }
    if (estado == EstadoJuego.PAUSA && (tecla=='p' || tecla=='P')) {
      estado = EstadoJuego.JUGANDO;
      reproducirMusica(estado);
      return;
    }
    // Cheat V: siguiente nivel
    if (estado == EstadoJuego.JUGANDO && (tecla=='v' || tecla=='V')) {
      siguienteNivel();
      return;
    }
    // INICIO + SPACE → PRE_JUEGO
    if (estado == EstadoJuego.INICIO && tecla==' ') {
      nivel.iniciarNivel();
      bola.reset();
      puntuacion.reset();
      paleta.setTipo(0);
      estado = EstadoJuego.PRE_JUEGO;
      reproducirMusica(estado);
      return;
    }
    // R → reiniciar nivel actual
    if (tecla=='r' || tecla=='R') {
      nivel.iniciarNivel();
      bola.reset();
      puntuacion.reset();
      paleta.setTipo(nivelActual==2 ? 1 : nivelActual==3 ? 2 : 0);
      estado = EstadoJuego.PRE_JUEGO;
      reproducirMusica(estado);
      return;
    }
    // PRE_JUEGO + SPACE → JUGANDO
    if (estado == EstadoJuego.PRE_JUEGO && tecla==' ') {
      bola.reset();
      estado = EstadoJuego.JUGANDO;
      reproducirMusica(estado);
      return;
    }
    // W / ↑ → acelera bola
    if (estado == EstadoJuego.JUGANDO &&
       (tecla=='w' || tecla=='W' || code==UP)) {
      bola.vel.mult(1.1);
      return;
    }
    // Movimiento de paleta
    if (estado == EstadoJuego.JUGANDO) {
      paleta.keyPressed(code, tecla);
    }
  }

  // —— Lógica de liberación de tecla ——  
  void procesarKeyReleased(char tecla, int code) {
    if (estado == EstadoJuego.JUGANDO) {
      paleta.keyReleased(code, tecla);
    }
  }

  // —— Actualización de lógica de juego ——  
  void actualizarJuego(float dt) {
    paleta.actualizar(dt);
    bola.actualizar(dt, paleta);

    // pierde vida si la bola cae
    if (bola.pos.y - bola.radio > height) {
      puntuacion.decrementar();
      bola.reset();
    }

    nivel.actualizar(dt, bola, puntuacion);
    if (nivel.todosDestruidos()) {
      siguienteNivel();
      return;
    }
    // game over
    if (puntuacion.vidas <= 0) {
      estado = EstadoJuego.GAMEOVER;
      reproducirMusica(estado);
    }
  }

  // —— Dibuja elementos de juego ——  
  void dibujarJuego() {
    background(0);
    paleta.mostrar();
    bola.mostrar();
    nivel.dibujarLadrillos();
    puntuacion.mostrar();
  }

  // —— Transición de niveles ——  
  void siguienteNivel() {
    nivelActual++;
    if (nivelActual == 2) paleta.setTipo(1);
    if (nivelActual == 3) paleta.setTipo(2);
    if (nivelActual > 3) {
      estado = EstadoJuego.VICTORIA;
      reproducirMusica(estado);
      return;
    }
    nivel.iniciarNivel();
    bola.reset();
    estado = EstadoJuego.PRE_JUEGO;
    reproducirMusica(estado);
  }

  // —— Texto simple en pantalla ——  
  void mostrarTexto(String msg) {
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    text(msg, width/2, height - 40);
  }

  // —— Control de música de fondo ——  
  void reproducirMusica(EstadoJuego s) {
    AudioPlayer[] tracks = {
      menuMusic, goMusic,
      lvl1Music, lvl2Music, lvl3Music,
      preMusic, pauseMusic, vicMusic
    };
    for (AudioPlayer ap : tracks) {
      if (ap != null && ap.isPlaying()) {
        ap.pause();
        ap.rewind();
      }
    }
    switch (s) {
      case INICIO:
        if (menuMusic != null) menuMusic.loop();
        break;
      case PRE_JUEGO:
        if (preMusic != null) preMusic.loop();
        break;
      case JUGANDO:
        if      (nivelActual == 1 && lvl1Music != null) lvl1Music.loop();
        else if (nivelActual == 2 && lvl2Music != null) lvl2Music.loop();
        else if (nivelActual == 3 && lvl3Music != null) lvl3Music.loop();
        break;
      case PAUSA:
        if (pauseMusic != null) pauseMusic.loop();
        break;
      case GAMEOVER:
        if (goMusic != null) goMusic.loop();
        break;
      case VICTORIA:
        if (vicMusic != null) vicMusic.loop();
        break;
    }
  }
}
