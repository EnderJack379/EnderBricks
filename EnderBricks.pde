import ddf.minim.*;

Minim        minim;
AudioPlayer  menuMusic, goMusic, lvl1Music, lvl2Music, lvl3Music;
AudioPlayer  preMusic, pauseMusic, vicMusic;
AudioPlayer  bounceSound, brickSound;

ControladorJuego juego;
float           tiempoAnterior;

void setup() {
  size(900, 700);
  minim = new Minim(this);

  // Música de escenas
  menuMusic   = minim.loadFile("menu.mp3");
  goMusic     = minim.loadFile("gameover.mp3");
  lvl1Music   = minim.loadFile("nivel1.mp3");
  lvl2Music   = minim.loadFile("nivel2.mp3");
  lvl3Music   = minim.loadFile("nivel3.mp3");
  preMusic    = minim.loadFile("prejuego.mp3");
  pauseMusic  = minim.loadFile("pausa.mp3");
  vicMusic    = minim.loadFile("victoria.mp3");

  // Efectos de sonido
  bounceSound = minim.loadFile("bounce.wav");
  brickSound  = minim.loadFile("brick.mp3");

  // Inicializamos el controlador y le pasamos los assets
  juego = new ControladorJuego();
  juego.setMenuImage     (loadImage("EnderBricks_Menu.png"));
  juego.setGameOverImage (loadImage("GameOver.png"));
  juego.setVictoryImage  (loadImage("victoria.png"));

  juego.setMenuMusic   (menuMusic);
  juego.setGoMusic     (goMusic);
  juego.setLevel1Music (lvl1Music);
  juego.setLevel2Music (lvl2Music);
  juego.setLevel3Music (lvl3Music);
  juego.setPreMusic    (preMusic);
  juego.setPauseMusic  (pauseMusic);
  juego.setVicMusic    (vicMusic);

  juego.setBounceSound (bounceSound);
  juego.setBrickSound  (brickSound);

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
  // Invocamos la función que SÍ está definida
  juego.procesarKeyPressed(key, keyCode);
}

void keyReleased() {
  juego.procesarKeyReleased(key, keyCode);
}
