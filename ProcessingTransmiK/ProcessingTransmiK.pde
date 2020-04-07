//--------------------------Librerias---------------------------
import processing.serial.*;
import processing.video.*;
Serial port;
int der =0;
int izk =0;

int x = 940;
//---------------------------Varibles--------------------------
//valores de los sensores de wiring como input

PImage inicio;
PImage instrucciones;
PImage instruccion1;
PImage instruccion3;
PImage nivel1;
PImage nivel2;
PImage enemigo;
PImage personaje;
PImage personajePI;
PImage personajePD;
PImage Estacion1;
PImage Estacion2;
Movie reflexion;
String sensores;

int sumar=0;

int maxPuntaje=0;
int Puntaje=0;
int vida=0;


int posDer =0;
int posIzq =0;

int izquierda;
int derecha;
int PieI;
int PieD;
int estado=0;
boolean unaVez=false;
boolean unaVez2=false;

int estadomal [];

float xpos;
float ypos;
float posx [];
float posy [];

int state = 0;
int begin; 
int duration;
int time;
int velocidad = sumar;
int vidas=0;
//font = createFont("BookAntiqua-BoldItalic-48.vlw");
float distancia =0;
//--------------------------- Setup ---------------------------
void setup()
{
  size(1980, 1080);
  
  begin = millis();
  time = duration = 100;
  reflexion = new Movie(this,"Transcultur.MP4");
  posx = new float[10]; 
  posy = new float[10]; 
  estadomal = new int [10];
  //Movie.start();


  noStroke();
  port = new Serial(this, Serial.list()[0], 9600);
  //port = new Serial(this, "COM3", 9600);
  //port = new Serial(this, "/dev/cu.usbmodemfa131", 9600); 
  inicio=loadImage("0.jpg"); 
  instrucciones=loadImage("1.jpg"); 
  instruccion1=loadImage("2.jpg");
  instruccion3=loadImage("3.jpg");
  nivel1= loadImage("Estacion1.jpg");
  nivel2= loadImage("Estacion2.png");
  enemigo= loadImage("Enemigo.png");
  personaje= loadImage("PersonajeP.png");
  personajePI= loadImage("FotoIzquierda.png");
  personajePD= loadImage("FotoDerecha.png");
  
  //llenar cada casilla de los arreglos
   for(int i=0; i<5; i++)
  {
  posx[i] = random(800, 1200);  
  posy[i] = random(800);  
  
  estadomal[i] = 1; //estado para definir si estan vivos o no
  }
  
  //llenar cada casilla de los arreglos
  
}


//------------------------Gráfica-----------------------------
void draw()
{
  //font = createFont("BookAntiqua-BoldItalic-48.vlw");
  //ubicacion del jugador con el sensor de wiring
  if (0 < port.available()) 
  {     
    //otra forma de enviar los datos a processing es no usando serial.write, sino serial.println, sin embargo en processing no se utiliza port.read(), sino port.readStringUntil('\n');
    sensores =  port.readStringUntil('\n');    

    if (sensores != null)
    {
      println(sensores);
      //se crea un arreglo que divide los datos y los guarda dentro del arreglo, para dividir los datos se hace con split cuando le llegue el caracter 'T',
      String[] datosSensor = split(sensores, 'T');

      if (datosSensor.length == 4)
      {
        println(datosSensor[0]);
        println(datosSensor[1]);
        println(datosSensor[2]);
        println(datosSensor[3]);
        PieI = int(trim(datosSensor[1]));      
        PieD = int(trim(datosSensor[2]));
        izquierda = int(trim(datosSensor[0]));      
        derecha = int(trim(datosSensor[3]));
      }
    }
  }

  background(255);


  if (estado==0 )
  {
    image(inicio, 0, 0);
    image(reflexion, 200, 300);
    if (izquierda == 0)
    {
      unaVez2 = false;
    }

    if (unaVez == false)
    {
      if (derecha==1)
      {
        estado = 1; 
        unaVez = true;
      }
    }
    if (unaVez2 == false)
    {
      if (izquierda==1)
      {
        estado = 1; 
        unaVez2 = true;
      }
    }
  }



  // println(sumar);
  if (estado==1) 
  {
    image(instrucciones, 0, 0);

    if (izquierda == 0)
    {
      unaVez2 = false;
    }

    if (unaVez==true) 
    {
      if (derecha == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez==false)
    {
      if (derecha == 1)
      {
        estado = 2;
        unaVez = true;
      }
    }    

    if (unaVez2==false)
    {
      if (izquierda == 1)
      {
        estado=0;
        unaVez2 =true;
      }
    }
  }

  if (estado==2) {
    image(instruccion1, 0, 0);

    if (izquierda == 0)
    {
      unaVez2 = false;
    }

    if (unaVez==true) 
    {
      if (derecha == 0)
      {
        unaVez = false;
      }
    }

    if (unaVez==false)
    {
      if (derecha == 1)
      {
        estado = 4;
        unaVez = true;
      }
    }

    if (unaVez2==false)
    {
      if (izquierda == 1)
      {
        estado=1;
        unaVez2 =true;
      }
    }
  }

  if (estado==3) {

    image( instruccion3, 0, 0);

    if (izquierda == 0)
    {
      unaVez2 = false;
    }

    if (unaVez==true) 
    {
      if (derecha == 0)
      {
        unaVez = false;
      }
    }
    if (unaVez==false)
    {
      if (derecha == 1)
      {
        estado = 4;
        unaVez=true;
      }
    }


    if (unaVez2==false)
    {
      if (izquierda == 1)
      {
        estado=2;
        unaVez2 =true;
      }
    }
  }
  
  if (estado ==4) {
    juego();
  }
}

void juego()
{
  direccion();
  background(166,182,191);
  image(nivel1, 200, 0,1700,1080);   
  //image(enemigo, 640, 340, sumar, sumar);
  image(personaje,750 + posDer + posIzq, 740, 100,100);
     
  //for para hacer caer los enemigos y velocidad de caida 
  for(int i=0; i<5; i++)
  {
    posy[i] = posy[i] + random(0.5,sumar);//random para la velocidad en posy
   
     if(posy[i] >= 720 || posy[i] <= 0)
  {
    posy[i] = 0;
    sumar = 1;
    //velocidad = 1; 
    
    println ("llego hasta abajo");
}
  }

    //aca inicia el codigo para el for de dibujar los enemigos y se define su tamaño y posición
  for(int i=0; i<5; i++)
  {
    if(estadomal[i] == 1)//visibilidad del Enemigo dependiendo del estado
    {
    image(enemigo, posx[i], posy[i], 100,100);
    }
  }
  

  for(int i=0; i<5; i++)
{
    distancia = dist(x + posDer + posIzq ,640,posx[i], posy[i]);
    
    if(distancia <70)
    {
    estadomal[i] = 0;
    
    
    }
}

  
  
   //aca inicia el codigo para sumar el puntaje cuando mato una bola
fill(#000000);

text("vida: " + vida,450,40);

vida= 10;
for(int i =0; i<5; i++)
{
  if(estadomal[i] == 0)
  {
    vida --;
    //time = duration = +10;
  }
  if(vida == 0)
  {
    textSize(40);
    background(nivel2);
    //textFont(font, 32);
    text("perdiste", 200,200 );
    reflexion.play();
    image(reflexion, 0, 0);
    reflexion.speed(50.0);
     noFill();
    //fill(150,206,420);
 
  }
  
  
   if (time > 0)  time = duration - (millis() - begin)/1000;
    textSize(16);
    text("Tiempo Restante : " + time, 400,80);
   
    if(time <= 0 )
{
  textSize(40);
  //font = loadFont("BookAntiqua-BoldItalic-48.vlw");
    image(inicio, 0, 0);
    //textFont(font);
    text("perdiste", 200,300 );
    reflexion.play();
    image(reflexion, 0, 0);
    reflexion.speed(50.0);

}
}
  
  
  
  if (unaVez==true) 
  {
    if (PieD == 0)
    {
      unaVez = false;
      
    }
  }
  if (unaVez==false)
  {
    if (PieD == 1)
    {
      //image(personajePI, 540 + PieD,340 ,400,400);
      sumar+=1;
      der=1;        
      izk=0;
      unaVez=true;
      if (der==1 && izk==0 || der==0 && izk==1)
      {
        sumar+=1;
        
      }
    }
  }

  if (unaVez2==true) 
  {
    if (PieI == 0)
    {
      unaVez2 = false;
    }
  }
  if (unaVez2==false)
  {
    if (PieI == 1)
    {
      sumar+=1;
      izk=1;        
      der=0;
      unaVez2=true;

      if (der==1 && izk==0 || der==0 && izk==1)
      {
        sumar+=1;
      }
    }
  }
}

void direccion(){
 
  if(derecha == 1){
    x = posDer += 15;
  }
  if(izquierda == 1){
   x= posIzq -=15;
  }
  sumar+=1;
  
}

void movieEvent(Movie m) {
  m.read();
}

/*void  keyReleased (){
 if(key == 'a'){
 sumar ++;
 
 }
 
 }*/
