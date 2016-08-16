


//=========================================================================//
/*
/*                                Kinect-Leap-UDP
/*                              SINGLE MAC VERSION
/*                               Contraste Sonoro
/*                                Roberto Cuervo
/* 
/*                                Coded By: JuanS
 */
//=========================================================================//
/*
/*
/*          TODO LIST
/*  
/*  
/*
/*
/*
/*
/*
/*
 */
//=========================================================================//

/* Librerías necesarias para Correr el software
- Osc P5 y NetP5 para utilizar el protocolo OSC a través de puertos UDP en una
red Interna
- Open Kinect para el uso del Kinect
- LeapMotion para usar el LEAP
*/
import oscP5.*;
import netP5.*;

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

import de.voidplus.leapmotion.*;
import development.*;

import themidibus.*;

//=========================================================================//

// Declarar Nombres de clases correspondientes
/*
CS -> contraste Sonoro
CS1Pro Contraste Sonoro computador 1 Processing
CS2Pro Contraste Sonoro compudador 2 Processing
CS1Max Contraste Sonoro computador 1 MAX/MSP
CS2Max Contraste Sonoro compudador 2 MAX/MSP (acutalmente no se utiliza y
posteriormente podría funcionar como el puerto del software de VJ)
*/

OscP5 osc;
MidiBus midiBus;

//NetAddress CS1Pro;    NO NEED ON SINGLE MAC VERSION
//NetAddress CS2Pro;    NO NEED ON SINGLE MAC VERSION

NetAddress CS1Max;

//NetAddress CS2Max;    NO NEED ON SINGLE MAC VERSION
LeapMotion leap;
Kinect kinect;

//=========================================================================//
////////////////////////////////GLOBAL VARIABLES/////////////////////////////
//=========================================================================//

/*
¡¡¡El Siguiente vector indica las partes del software que estarán activas!!!
el vector corresponde con los booleanos siguientes en el orden correspondiente
*/
int[] setup = {1, 1, 1, 1, 1, 1};

boolean netEnabled; //Conexión de Red
boolean leapEnabled;//Leap
boolean kinectEnabled;//Kinect
boolean dummyDrawEnabled;//Visualización de la Info en Processing
boolean refTextEnabled;//Visualización del texto de la info en processing
boolean midiBusEnabled;//Bus MIDI
//UDP STUFF
/*Declaración de Puertos utilizados para transmisión de datos por red interna
Declaración de direcciones IP
En Ambos casos se utilizan vectores para alojar toda la información en un
único paquete*/

//int[] port = {12001, 12002, 12011, 12012};        //NO NEED ON SINGLE MAC VERSION
//String[] IP = {"192.168.0.101", "192.168.0.102"}; //NO NEED ON SINGLE MAC VERSION

static int maxPort = 12002;
static String myIP = "127.0.0.1";

//String myIP = NetInfo.lan(); //NO NEED ON SINGLE MAC VERSION
int myPort = 12001;

Boolean midiInit = false;

//=========================================================================//
////////////////////////////////MOUSE SIM STUFF//////////////////////////////
//=========================================================================//

PVector mousePos = new PVector(0,0,0);


//=========================================================================//
//////////////////////////////////KINECT STUFF///////////////////////////////
//=========================================================================//

int meanSize = 100;
int meanLength = 50;
int meanFactor = 5; // change later to 3 at least

/////////////(Cambiar a dependiendo de la instalación)//////////////
int deg = 0; //Ángulo Inicial de inclinación del Kinect  
float accuracy = 15;

int kinectSize = 307200; //Tamaño del frame en pixeles
int kinectWidth = 640; //Anchura del frame
int kinectHeight = 480; //Altura del frame

int[] depth = new int[kinectSize]; 
//Vector que alberca el mapa de profundidades 
int[] meanDepth = new int[kinectSize]; 
//Vector que alberga el mapa del promedio de las profundidades
float[] stndDepth = new float[kinectSize]; 
//Vector que alberga el mapa de la desviación típica de las profundidades

int threshold = 5;
int stiffness = 2;

boolean initState = true;
int kinectFrame = 0;

PVector pos = new PVector();

PVector kinectPos1 = new PVector (); //Posición del Kinect 1
PVector kinectPos2 = new PVector (); //Posición del Kinect 2

//=========================================================================//
////////////////////////////////// LEAP STUFF////////////////////////////////
//=========================================================================//


boolean stabilization = false; //Indicador de activación de la estabilización

boolean isLeft1, isRight1; //Indicador de si la mano es izquierda o derecha
float leapGrabL1; //Medición de qué tan cerrada está la mano izq 1
PVector leapPosL1 = new PVector (); //Posición cartesiana de la mano izq 1
PVector leapDynL1 = new PVector (); //Posición rotacional de la mano izq 1
float leapGrabR1; //Medición de qué tan cerrada está la mano der 1 
PVector leapPosR1 = new PVector (); //Posición cartesiana de la mano Der 1
PVector leapDynR1 = new PVector (); //Posición rotacional de la mano Der 1
//=========================================================================//

boolean isLeft2, isRight2; //Indicador de si la mano es izquierda o derecha
float leapGrabL2; //Medición de qué tan cerrada está la mano izq 2
PVector leapPosL2 = new PVector (); //Posición cartesiana de la mano izq 2
PVector leapDynL2 = new PVector (); //Posición rotacional de la mano izq 2
float leapGrabR2; //Medición de qué tan cerrada está la mano der 2
PVector leapPosR2 = new PVector (); //Posición cartesiana de la mano Der 2
PVector leapDynR2 = new PVector (); //Posición rotacional de la mano Der 2 

//=========================================================================//
////////////////////////////////GRAPHIC STUFF////////////////////////////////
//=========================================================================//

PVector textPos; //Posición inicial del Texto
int info = 0;

//=========================================================================//
//=========================================================================//
//=========================================================================//
//=========================================================================//

void setup() {
  size (640, 720, P3D); //Tamaño de la pantalla
  background(255); //Color del fondo

  //////Rutina de inicialización/////
  initRoutine();

  if (netEnabled)
  {
    oscSetup();
  }
  
  if (midiBusEnabled)
  {
    if (!midiInit)
    {
      midiBusSetup();
    }
  }

  if (leapEnabled)
  {
    leapSetup();
  }

  if (kinectEnabled)
  {
    kinectSetup();
  }

  ////////////Imprimir a consola el estado de la inicialización//////////////
  
  println("Net: " + netEnabled);
  println("Leap: " + leapEnabled);
  println("Kinect: " + kinectEnabled);
  println("Dummy Draw: " + dummyDrawEnabled);
  println("Ref Text: " + refTextEnabled);
}


//=========================================================================//

void draw() {
  /*
  En Cada uno de los fotogramas, se corre una rutina para cada uno de los
  sistema implementados.
  Para ver el desarrollo de cada uno de los sistemas saltar a la 
  correspondiente pestaña
  Leap -> leap
  Kinect -> kinect
  UDP y OSC -> OSC
  Representación Gráfica -> dummyDraw
  Texto de Referencia -> refText
  */
  
  
  background(255);

  if (leapEnabled)
  {
    leapAnalisis();
  }

  if (kinectEnabled)
  {
    if (!initState)
    {
      kinectInit();
    }
    kinectAnalisis();
  } else {
    mousePos = new PVector (mouseX, mouseY, mousePos.z);
  }

  if (netEnabled)
  {
    oscRoutine();
  }
  
  if (midiBusEnabled)
  {
    midiRoutine();
  }

  if (dummyDrawEnabled)
  {
    dummyDraw();
  }

  if (refTextEnabled)
  {
    refTextRoutine();
  }
}

//=========================================================================//

void stop() {
  if (kinectEnabled)
  {
    //kinect.quit();
  }
  super.stop();
}



//=========================================================================//