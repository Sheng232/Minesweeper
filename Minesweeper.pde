import de.bezier.guido.*;
// See source here: https://github.com/fjenett/Guido/blob/master/src/de/bezier/guido/Interactive.java
// TODO: Declare and initialize constants NUM_ROWS and NUM_COLS = 20
// TODO: DECLARE AND INITIALIZE CONSTANT NUM_MINES
public static final int NUM_ROWS = 20;
public static final int NUM_COLS = 20;
public static final int NUM_MINES = 150;
public boolean processed = false;
private MSButton[][] buttons; // 2d array of minesweeper buttons
private ArrayList <MSButton> mines; // ArrayList of just the minesweeper buttons that are mined
void setup ()
{
  // If size is changed, need to modify MSButton constructor
  size(400, 400); 
  textAlign(CENTER, CENTER);

  // make the Guido manager
  Interactive.make( this );

  // TODO: MAKE THE BOARD OF TILES:
  //INITIALIZE 2D ARRAY OF MSBUTTON OBJECTS
  buttons = new MSButton[NUM_ROWS][NUM_COLS];
  mines = new ArrayList<MSButton>();
  for (int i = 0; i< NUM_ROWS; i++) {
    for (int k = 0; k<NUM_COLS; k++) {
      buttons[i][k] = new MSButton(i, k);
    }
  }
  // ADD MINES TO THE BOARD
  setMines();
}
public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
// CREATE UP TO NUM_MINES RANDOMLY LOCATED MINES
// ADD THEM TO ARRAYLIST OF MINES
// CALL IN SETUP() ONLY
public void setMines()
{
  // TODO: Your code here
  while (mines.size()< NUM_MINES) {
    int i = (int)(Math.random() * NUM_ROWS);
    int k = (int)(Math.random() * NUM_COLS);
    if (!mines.contains(buttons[i][k]))
    {
      mines.add(buttons[i][k]);
    }
  }
}
public boolean isWon()
{
  for (int i = 0; i < NUM_ROWS; i++) {
    for (int k = 0; k< NUM_COLS; k++) {
      if (!mines.contains(buttons[i][k]) && !buttons[i][k].clicked)
        return false;
    }
  }
  return true;
}
public void displayLosingMessage()
{
  background(0);
  String losingMessage = "You Lost";
  fill(200);
  text(losingMessage, 200, 200);
}
public void displayWinningMessage()
{
  String winningMessage = "You Won";
  fill(200);
  text(winningMessage, 200, 200);
}
// TEST IF ROW AND COL ARE ON THE BOARD
public boolean isValid(int r, int c)
{
  if (r >=0 && r < NUM_ROWS && c >= 0 && c<= NUM_COLS)
    return true;
  else
    return false;
}
// COUNT MINES SURROUNDING TILE
public int countMines(int row, int col)
{
  int numMines = 0;
  // TODO: your code here
  if (isValid(row+1, col) == true && mines.contains(buttons[row+1][col]))
    numMines ++;
  if (isValid(row+1, col+1) == true && mines.contains(buttons[row+1][col+1]))
    numMines ++;
  if (isValid(row, col+1) == true && mines.contains(buttons[row][col+1]))
    numMines ++;
  if (isValid(row-1, col+1) == true && mines.contains(buttons[row-1][col+1]))
    numMines ++;
  if (isValid(row-1, col) == true && mines.contains(buttons[row-1][col]))
    numMines ++;
  if (isValid(row-1, col-1) == true && mines.contains(buttons[row-1][col-1]))
    numMines ++;
  if (isValid(row, col-1) == true && mines.contains(buttons[row][col-1]))
    numMines ++;
  if (isValid(row+1, col-1) == true && mines.contains(buttons[row+1][col-1]))
    numMines ++;
  return numMines;
  
}
public class MSButton
  // NOTE: YOU COULD PUT THIS CLASS IN ANOTHER FILE (TAB)
{
  private int myRow, myCol; // Coordinates in grid of buttons

  private float x, y, width, height; // Position in output window
  // Need keywords width and height for Guido to work
  private boolean clicked; // Tile revealed

  private boolean flagged; // Tile flagged as mine

  private String myLabel; // Show count of neighbor mines

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS; // Needs to match size in setup()
    height = 400/NUM_ROWS; // Needs to match size in setup()
    myRow = row;
    myCol = col;
    x = myCol * width;
    y = myRow * height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the Guido manager
  }


  public void mousePressed ()
  {

    // SET TILE AS REVEALED
    clicked = false;

    // TODO: ALT-CLICK TO SET OR UNSET A FLAG ON A TILE
    if (mouseButton == RIGHT) {
      flagged = !flagged;
    }
    // TODO: REVEAL THE HIDDEN STATE OF A CLICKED TILE
    if (!clicked && !flagged) {
      clicked = true;
      if (mines.contains(this)) {
        displayLosingMessage();
      } 
      
      
      else {
        int numMines = countMines(myRow, myCol);
        setLabel(numMines);



        // CASE 1: IT'S A MINE -> GAME OVER
    
        // CASE 2: IT'S NEXT TO A MINE -> DISPLAY COUNT OF NEIGHBORING MINES
        
    
        // CASE 3: NO NEIGHBORING MINES -> RECURSIVELY CALL ON NEIGHBOR TILES
        //if(isValid(myRow, myCol - 1) == false)
        //return;
        //else if(isValid(myRow, myCol - 1) && !buttons[i][k].clicked && !mines.contains(buttons[i][k]))
        //buttons[i][k-1].mousePressed();
      }
      
  if(processed == false){
      if (isValid(myRow, myCol - 1) && !buttons[myRow][myCol - 1].clicked && !mines.contains(buttons[myRow][myCol - 1])) {
    buttons[myRow][myCol - 1].mousePressed();
}
      if (isValid(myRow+1, myCol - 1) && !buttons[myRow+1][myCol - 1].clicked && !mines.contains(buttons[myRow+1][myCol - 1])) {
    buttons[myRow+1][myCol - 1].mousePressed();
}
      if (isValid(myRow-1, myCol - 1) && !buttons[myRow-1][myCol - 1].clicked && !mines.contains(buttons[myRow-1][myCol - 1])) {
    buttons[myRow-1][myCol - 1].mousePressed();
}
      if (isValid(myRow+1, myCol+1) && !buttons[myRow+1][myCol+1].clicked && !mines.contains(buttons[myRow+1][myCol+1])) {
    buttons[myRow+1][myCol+1].mousePressed();
}  
      if (isValid(myRow, myCol+1) && !buttons[myRow][myCol+1].clicked && !mines.contains(buttons[myRow][myCol + 1])) {
    buttons[myRow][myCol + 1].mousePressed();
}
      if (isValid(myRow-1, myCol + 1) && !buttons[myRow-1][myCol + 1].clicked && !mines.contains(buttons[myRow-1][myCol + 1])) {
    buttons[myRow-1][myCol + 1].mousePressed();
}
      if (isValid(myRow+1, myCol) && !buttons[myRow+1][myCol].clicked && !mines.contains(buttons[myRow+1][myCol])) {
    buttons[myRow+1][myCol ].mousePressed();
}
       if (isValid(myRow-1, myCol) && !buttons[myRow-1][myCol].clicked && !mines.contains(buttons[myRow-1][myCol])) {
    buttons[myRow-1][myCol ].mousePressed();
}
  }
  processed = true;





    }
    
    
  }
    // called by Guido manager after top-level draw()
    public void draw()
    {    
      // CASE 1: FLAGGED TILE IN BLACK
      if (flagged)
        fill(0);

      // CASE 2: EXPLODED MINE IN RED
      else if ( clicked && mines.contains(this) )
        fill(255, 0, 0);

      // CASE 3: REVEALED TILE IN LIGHT GRAY
      else if (clicked)
        fill( 200 );

      // CASE 4: HIDDEN TILE IN DARK GRAY
      else
        fill( 100 );
      // DISPLAY TILE AND LABEL IF IT HAS NEIGHBORING MINES
      rect(x, y, width, height);
      fill(0);
      text(myLabel, x + width / 2, y + height / 2);
    }
    public void setLabel(String newLabel)
    {
      myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
      myLabel = "" + newLabel;
    }
    public boolean isFlagged()
    {
      return flagged;
    }
}







