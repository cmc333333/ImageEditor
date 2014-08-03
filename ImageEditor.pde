PImage editing, segment;

Button loadImage;
Button blackWhite, grayScale, invert, blur, erode, dilate;
int[] FILTERS = new int[] {-1, THRESHOLD, GRAY, INVERT, BLUR, ERODE, DILATE};
Button[] allButtons;

int dragInitX, dragInitY, dragEndX, dragEndY;
final int NOSELECTION = 0, DRAGGING = 1, AREASELECTED = 2;
int dragState = NOSELECTION;

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

  noFill();
  switch (dragState) {
    case DRAGGING:
      stroke(0);
      rect(dragInitX, dragInitY, dragEndX - dragInitX, dragEndY - dragInitY);
      break;
    case AREASELECTED:
      stroke(0, 0, 220);
      rect(dragInitX, dragInitY, dragEndX - dragInitX, dragEndY - dragInitY);
      break;
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
  for (int i = 1; i < FILTERS.length; i++) {
    if (editing != null && allButtons[i].mousePressed()) {
      editing.filter(FILTERS[i]);
    }
  }
}


void mouseDragged()
{
  dragEndX = mouseX;
  dragEndY = mouseY;
  dragState = DRAGGING;
  for (Button button : allButtons) {
    button.mouseDragged();
  }
}

void mouseReleased()
{
  if (dragState == DRAGGING) {
    dragState = AREASELECTED;
  } else {
    dragState = NOSELECTION;
  }
  for (Button button : allButtons) {
    button.mouseReleased();
  }
}
