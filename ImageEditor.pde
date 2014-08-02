PImage editing, segment;

Button loadImage;
Button blackWhite, grayScale, invert, blur, erode, dilate;
Button[] allButtons;

int dragInitX, dragInitY;
boolean isDragging = false;

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
}

void draw()
{
  background(100);

  for (Button button : allButtons) {
    button.display();
  }

  if (editing != null) {
    image(editing, (width - editing.width) / 2, 0);
  }

  if (isDragging) {
    noFill();
    rect(dragInitX, dragInitY, mouseX - dragInitX, mouseY - dragInitY);
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
  dragInitX = mouseX;
  dragInitY = mouseY;
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
}


void mouseDragged()
{
  isDragging = true;
  for (Button button : allButtons) {
    button.mouseDragged();
  }
}

void mouseReleased()
{
  isDragging = false;
  for (Button button : allButtons) {
    button.mouseReleased();
  }
}
