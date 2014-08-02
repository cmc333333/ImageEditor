PImage editing, segment;

Button loadImage;
Button blackWhite, grayScale, invert, blur, erode, dilate;
Button[] allButtons;

Button b;
Toggle t;
Toggle t2;
Slider s, sup, sdown;
MultiSlider ms, msvert;
RadioButtons r;
RadioButtons r2;

void setup()
{
  size(650, 700);
   
  loadImage = new Button("Load Image", (width - 100)/2, height - 35, 100, 25);
  blackWhite = new Button("B&W", 10, height - 35, 50, 25);
  grayScale = new Button("Gray Scale", 10 + 50 + 10, height - 35, 80, 25);
  invert = new Button("Invert", 20 + 50 + 80 + 10, height - 35, 60, 25);
  blur = new Button("Blur", width - 10 - 60, height - 35, 60, 25);
  erode = new Button("Erode", width - 20 - 60 - 60, height - 35, 60, 25);
  dilate = new Button("Dilate", width - 30 - 120 - 60, height - 35, 60, 25);

  allButtons = new Button[] {loadImage, blackWhite, grayScale, invert, blur,
                             erode, dilate};
    


   PImage ButtonInactive = loadImage("ButtonInactive.png");
   PImage ButtonActive = loadImage("ButtonActive.png");
   
   // name, pos.x, pos.y, width, height
   b = new Button("button", 100, 10, 50, 30);
   b.setInactiveImage(ButtonInactive);
   b.setActiveImage(ButtonActive);
   
   t = new Toggle("toggle", 100, 100, 50, 30);
   t2 = new Toggle("toggle2", 200, 100, 50, 30);
   t2.setInactiveImage(ButtonInactive);
   t2.setActiveImage(ButtonActive);
   
   // name, value, min, max, pos.x, pos.y, width, height
   s = new Slider("slider", 20, 0, 100, 100, 150, 200, 20, HORIZONTAL);
   
   sup = new Slider("up", 20, 0, 100, 450, 150, 20, 100, UPWARDS);
   sdown = new Slider("down", 100, 0, 100, 500, 150, 20, 100, DOWNWARDS);
   
   s.setInactiveColor(color(120, 80, 80));
   String [] sliderNames = {"red", "green", "blue", "conker"};
   // name,s min, max, pos.x, pos.y, width, height
   ms = new MultiSlider(sliderNames.length, 0, 255, 100, 300, 200, 10, HORIZONTAL);
   ms.setNames(sliderNames);
   //String [] sliderNamesVert = new String[20];
   //for (int i = 0; i < sliderNamesVert.length; i++)
   //  sliderNamesVert[i] = "";
   msvert = new MultiSlider(20, 0, 255, 400, 300, 10, 100, UPWARDS);
   String [] radioNames = {"one", "two", "three"};
   r = new RadioButtons(radioNames, 3,100, 400, 50, 30, HORIZONTAL);
   
   PImage [] inactiveButtons = {ButtonInactive, ButtonInactive, ButtonInactive};
   PImage [] activeButtons = {ButtonActive, ButtonActive, ButtonActive};
   r.setAllInactiveImages(inactiveButtons);
   r.setAllActiveImages(activeButtons);
   
   r2 = new RadioButtons(radioNames, 3,10, 350, 50, 30, VERTICAL);
}

void draw()
{
  background(100);

  for (Button button : allButtons) {
    button.display();
  }


   b.display();
   t.display();
   t2.display();
   s.display();
   sup.display();
   sdown.display();
   ms.display();
   msvert.display();
   r.display();
   r2.display();

  if (editing != null) {
    image(editing, (width - editing.width) / 2, 0);
  }
}

void fileSelected(File selection) {
  if (selection != null) {
    editing = loadImage(selection.getAbsolutePath());
    if (editing.width > width) {
      editing.resize(width, 0);
    }
    if (editing.height > height - 50) {
      editing.resize(0, height - 50);
    }
  }
}

void mousePressed()
{
  if (loadImage.mousePressed()) {
    selectInput("Select Image", "fileSelected");
  }  
  if (editing != null) {
    if (blackWhite.mousePressed()) {
      editing.filter(THRESHOLD);
    } else if (grayScale.mousePressed()) {
      editing.filter(GRAY);
    } else if (invert.mousePressed()) {
      editing.filter(INVERT);
    } else if (blur.mousePressed()) {
      editing.filter(BLUR);
    } else if (erode.mousePressed()) {
      editing.filter(ERODE);
    } else if (dilate.mousePressed()) {
      editing.filter(DILATE);
    }
  }
  t.mousePressed();
  t2.mousePressed();
  s.mousePressed();
  sup.mousePressed();
  sdown.mousePressed();
  ms.mousePressed();
  msvert.mousePressed();
  r.mousePressed();
  r2.mousePressed();
}


void mouseDragged()
{
  for (Button button : allButtons) {
    button.mouseDragged();
  }

  t.mouseDragged();
  t2.mouseDragged();
  s.mouseDragged();
  sup.mouseDragged();
  sdown.mouseDragged();
  ms.mouseDragged();  
  msvert.mouseDragged();
  r.mouseDragged();
  r2.mouseDragged();
}

void mouseReleased()
{
  for (Button button : allButtons) {
    button.mouseReleased();
  }

  t.mouseReleased();
  t2.mouseReleased();
  s.mouseReleased();
  sup.mouseReleased();
  sdown.mouseReleased();
  ms.mouseReleased();
  msvert.mouseReleased();
  r.mouseReleased();
  if(r2.mouseReleased())
  {
    println(r2.get());
  }
}
