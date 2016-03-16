 
import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS =20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs=new ArrayList<MSButton>();; //ArrayList of just the minesweeper buttons that are mined

void setup()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r =0;r< NUM_ROWS;r++)
      for(int c=0; c <NUM_COLS;c++)
          buttons[r][c] = new MSButton(r,c);
    setBombs();
}
public void setBombs()
{
    //your code
  for(int i =0;i<= 24;i++)
  {
  int randomR = (int)(Math.random()*20); 
  int randomC = (int)(Math.random()*20);
  if(!bombs.contains(buttons[randomR][randomC]))
      bombs.add(buttons[randomR][randomC]);
  }
}

public void draw()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int i =0; i <NUM_ROWS;i++)
    {
      for(int j =0; j < NUM_COLS;j++)
      {
           if(!buttons[i][j].isClicked()==true && !bombs.contains(buttons[i][j]))
           {
               return false;
           }
      }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    for(int i =0; i <NUM_ROWS;i++)
      for(int j =0; j < NUM_COLS;j++)
        if(!buttons[i][j].isClicked()&& bombs.contains(buttons[i][j]))
          {
             buttons[i][j].marked=false;
             buttons[i][j].clicked=true;
          } 
   buttons[10][6].setLabel("Y");
   buttons[10][7].setLabel("O");
   buttons[10][8].setLabel("U");
   buttons[10][9].setLabel(" ");
   buttons[10][10].setLabel("L");
   buttons[10][11].setLabel("O");
   buttons[10][12].setLabel("S");
   buttons[10][13].setLabel("E");
   buttons[10][14].setLabel("!");
}
public void displayWinningMessage()
{
    //your code here
    buttons[10][6].setLabel("Y");
    buttons[10][7].setLabel("O");
    buttons[10][8].setLabel("U");
    buttons[10][9].setLabel(" ");
    buttons[10][10].setLabel("W");
    buttons[10][11].setLabel("I");
    buttons[10][12].setLabel("N");
    buttons[10][13].setLabel("!");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        //your code here
        if(mouseButton == LEFT&&!marked)
         clicked = true;
        if(mouseButton == RIGHT)
        {
        if (marked==false)
          marked = true;
         else if(marked ==true)
          marked = false;
        }
         else if(bombs.contains(this))
          displayLosingMessage();
         else if(countBombs(r,c)>0)
           label=""+countBombs(r,c);
          else 
            {
               if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            buttons[r][c-1].mousePressed();
               if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();
                if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();
                if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();
                if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();
                if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();
                if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();
               if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();
            }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if(r<=NUM_ROWS-1 && r >=0&& c >=0 &&  c<=NUM_COLS-1)
           return true;
       else
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row+1,col+1)&&bombs.contains(buttons[row+1][col+1]))
           numBombs++;
        if(isValid(row,col+1)&&bombs.contains(buttons[row][col+1]))
           numBombs++;
        if(isValid(row-1,col+1)&&bombs.contains(buttons[row-1][col+1]))
           numBombs++;
        if(isValid(row-1,col)&&bombs.contains(buttons[row-1][col]))
           numBombs++;
        if(isValid(row-1,col-1)&&bombs.contains(buttons[row-1][col-1]))
           numBombs++;
        if(isValid(row,col-1)&&bombs.contains(buttons[row][col-1]))
           numBombs++;   
        if(isValid(row+1,col-1)&&bombs.contains(buttons[row+1][col-1]))
           numBombs++;
        if(isValid(row+1,col)&&bombs.contains(buttons[row+1][col]))
           numBombs++;    
        return numBombs;
    }
}
