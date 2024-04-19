import de.bezier.guido.*;
int NUM_ROWS = 40;
int NUM_COLS = 40;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private Life[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  buttons = new Life[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
    }
  }
  buffer = new Life[NUM_ROWS][NUM_COLS];
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c];
    }
  }
}

public void draw () {
  background(0);
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      if (countNeighbors(r, c) == 3) {
        buffer[r][c].setLife(true);
      } else if (countNeighbors(r, c) == 2 && buttons[r][c].getLife()) {
        buffer[r][c].setLife(true);
      } else {
        buffer[r][c].setLife(false);
      }
      buttons[r][c].draw();
    }
  }

  copyFromBufferToButtons();
}

public void keyPressed() {
  running = !running;
}

public void copyFromBufferToButtons() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new Life(r, c);
      buttons[r][c].setLife(buffer[r][c].getLife());
    }
  }
}

public void copyFromButtonsToBuffer() {
  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buffer[r][c] = buttons[r][c];
    }
  }
}

public boolean isValid(int r, int c) {
  if (r < NUM_ROWS && r > -1 && c < NUM_COLS && c > -1) {
    return true;
  } else {
    return false;
  }
}

public int countNeighbors(int r, int c) {
  int neighbors = 0;
  if (isValid(r-1, c-1) && buttons[r-1][c-1].getLife()) {
    neighbors++;
  } 
  if (isValid(r-1, c) && buttons[r-1][c].getLife()) {
    neighbors++;
  } 
  if (isValid(r-1, c+1) && buttons[r-1][c+1].getLife()) {
    neighbors++;
  } 
  if (isValid(r, c-1) && buttons[r][c-1].getLife()) {
    neighbors++;
  } 
  if (isValid(r, c+1) && buttons[r][c+1].getLife()) {
    neighbors++;
  } 
  if (isValid(r+1, c-1) && buttons[r+1][c-1].getLife()) {
    neighbors++;
  } 
  if (isValid(r+1, c) && buttons[r+1][c].getLife()) {
    neighbors++;
  } 
  if (isValid(r+1, c+1) && buttons[r+1][c+1].getLife()) {
    neighbors++;
  }
  return neighbors;
}
