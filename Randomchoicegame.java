import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
/*/
 * Anthony Mastrianna #7367479 Final Programming Project
 * Main class with a function that shuffles an array list then returns the arraylist and uses it as an input in a function that pulls each integer from the list,
 * creates a numtile object with this number and the current iteration the for loop is on and adds it to an object array. 
 * This function also defines the string username which is found through another function that returns a userinputted string if the user entered specific names the program will do
 * certain eastereggs like a photo or text refrence. This same username method also asks the player if they need an explanation on how to play the game and will wait for the player to enter a value again to proceed, to allow them to fully read the rules
 * A new randgame object is then made using the numtile array, integer that represents the length of the game and the username that the user inputted.
 * This randgame object uses the numtile array, a game length integer, and the string for the username are then passed into the Randgame object which has a for loop that 
 * will find the rand int assigned to the current iteration of the for loop. It displays the order using a function in the numtile class and then checks using the randint get method of the numtile to check if the number is correct
 * if it is wrong the game goes into the gameover function which shows the user score, username, and asks if the player wants to print a score.txt file if so it will make this file in the same directory of the .java file
 * the playerscore is calculated by multipling the games current integration number by a defined integer and then returning the score into a string that can then be printed and shown to the user
 * if the player gets through all 9 turns of the game they are presented with a victory screen which is from a seperate function which uses the same print score method if the user wishes to have their score printed.
 * The program has the ability to clear the Windows cmd console using a method I was able to find online, this method only works on the windows cmd so that is the best place to play this game. Other terminals won't be cleared and the order from the previous tiles would still be visible
 * The program exits if the player fails to get the order of the tiles correct, if the entered integer is out of range, or if the entered value isn't an integer. It also uses the java sleep method to wait between showing tiles so the order is easy to see.
 * This is a bad explanation but I made this program on a whim and really just had the thoughts in my head
 * 
 * 
 */


public class Randomchoicegame {

	public static void main(String[] args) throws Exception{//define an exception as the program has exception handling
		createNumTile(getRandList());//runs the create numtile method using the returned value from getRandList
	}
	
	private static ArrayList<Integer> getRandList()
	{
		ArrayList<Integer> numtiles = new ArrayList<>();//Creates an array list
		for (int i = 0; i < 9; i++) {//run this loop 9 times
			numtiles.add(i);//add a number to the array list 0-8
		}
		java.util.Collections.shuffle(numtiles);//shuffle this list
		return numtiles;//return the list to the main method
	}
	
	private static void createNumTile(ArrayList<Integer> numtiles) throws Exception//define exception
	{
		NumTile[] numtilesstore = new NumTile[9];//Create a numtile object array
		for(int i = 0; i < numtiles.size(); i++) {//Run for the size of the array
			numtilesstore[i] = new NumTile(numtiles.get(i), i);//Add numtiles to the array using the integration number and the corresponding number from the arraylist
		}
		String enteredUsername = enterUsername();//Set enteredUsername to the returned value of the username function
		RandGame randgame = new RandGame(numtilesstore, 9, enteredUsername);//Create a new randGame object using the numtilesarray, a number that represents the game length and the username entered by the user
	}
	
	private static String enterUsername() throws InterruptedException//Define exception so the sleep method may be used to delay between tile graphics and text lines
	{
		Scanner userInput2 = new Scanner(System.in);//Create a new scanner 
		int userChoice = 0;//Define a value for userChoice
		System.out.println("Random Tile Game:");//Print name of game
		System.out.println("Please enter your Username to continue.");//Prompt user
		TimeUnit.SECONDS.sleep(1);//wait 1 second
		String username = userInput2.nextLine();//Take username input
		String easteregg = "153";//Set easteregg string
		try {
			if(username == "")//if the user entered nothing as their name
			{
				
				System.out.println("No name eh?, Well I guess you can still play");//funny line
				username = "NoName";//set username to NoName
				TimeUnit.SECONDS.sleep(1);//wait 1 second
				System.out.println("Do you need an explanation on how to play? 0:No 1:Yes");//ask user if they need explanation
				userChoice = userInput2.nextInt();//take input
				while(userChoice > 1 || userChoice < 0)//check if its out of range and prompt reentry
				{
					System.out.println("That entry was invalid please try again.");
					userChoice = userInput2.nextInt();
				}
				if(userChoice == 1)//explain game if user entered 1 and then wait for another input and then start the game
				{
					System.out.println("During the game you will be shown tiles numbered 0-8.");
					System.out.println("Enter these numbers in the order shown one at a time hitting enter between entries.");
					System.out.println("If you fail to enter the tiles in order your test is over...");
					System.out.println("If you enter a number out of this range or something that isn't an integer the game will exit.");
					TimeUnit.SECONDS.sleep(1);//wait
					System.out.println("Enter any value to continue.");
					userInput2.next();//take any input and then start game
					System.out.println("Good Luck "+username+"! begining game...");
					TimeUnit.SECONDS.sleep(1);//wait
				}
				else//begin game if user entered 0
				{
					System.out.println("Good Luck "+username+"! begining game...");
					TimeUnit.SECONDS.sleep(1);//wait
				}
			}
			
			else if(username.equals(easteregg)) //instantly end the game if the player has 153 set as their username. It is a refrence. It shows ASCII art I generated with https://manytools.org/
			{
				//this picture is a meme from teh interwebs
				System.out.println(".,,.......,.....*(((#(((((((/////.,,*,,,,*,.*/**///**/*//////((/////////////////\r\n"
						+ "                *(###########(*,...,*,*,,.....,,,,,,,,***///(((/////////////////\r\n"
						+ "                ,(######(#/*,,.,....,,.................,,***/(((((//////////////\r\n"
						+ "                ,(#####/*,,...,,.......,................,,,,*(####//////////////\r\n"
						+ "                ,##(/*,,....../*..,,,.,,,,,,**********,**,,,**,*////////////////\r\n"
						+ "               ..*,,,,..  ....,,,,,****//(((###########(((/**,,,.,.,*///////////\r\n"
						+ "     . .........,,,.. . ..,,,***,,/(((((####%%%%%%%%%%%####((//*,,.../*/////////\r\n"
						+ "     .,   ..,.**,,,,  .,,,*****/,*((#########%%%%%&&%%#####%##(/*,,....,////////\r\n"
						+ "......,,,,**/*,,,,.  .,**///*/**./(((((#####%%%%%&&&%%%########(/*,,....,///////\r\n"
						+ "####((//*,***/*.... ,***///**,,*(((#(((######%%%%%%&%%#######(#((/*,.....*//////\r\n"
						+ "%%%##%%%%%%%#,,,...,**********/(((#####(######%%%%&%%%%%#######((/**....,/(///((\r\n"
						+ "%%%%%%%%%%%%%/.....,*******/((((((((##((########%%%&&%%%%#######(/*,,..../(///((\r\n"
						+ "%%%%%%%%%%%%%,.....*****,/((((((#(((((((((#(#######%%%##########((*,..,..*(((/((\r\n"
						+ "%%%%%%%%%%%%%#.....****,,,***/((((((((((((((((((((((((///(//(#####(*,...,(((((((\r\n"
						+ "&&&&&&&&&&&%&&/..,**,,,,,.,..,,,****/////(((////**,,,.....,,****(#((,,.. (((((((\r\n"
						+ "%%%%%%%%%%%%%%# ..,.,*/*,,......,,,*****/(((//*/**.. .,*,..,.*//##%#.....(/(((((\r\n"
						+ "%%%%%%%%%%%%%%(,..,**/,..,**, ../,..,**/(#%%(*/,.,,**.,*,#(,*,*#%(/#,.*/,((((/((\r\n"
						+ "%%%%%%%%%%%%%%%...//***,,,,*.... ,..,,,(((#%#(,,..,,,*,*/(#((%%%%%##*,,(/(((((((\r\n"
						+ "%%%%%%%%%%%%%%%,.,/***,,,**/**,,,,,,,,/(###%#(((/***,,,,,*((##((*/((*,,//(((((((\r\n"
						+ "%%%%%%%%%%%%%%/*,,********,,,,*////,,,*/(#%#((((((((//////((#####(//(,//##((((((\r\n"
						+ "%%%%%%%%%%%%%%#..****///(((((((/(/*****/(##((((((((((((((((((######(/*,##%((((((\r\n"
						+ "%%%%%%%%%%%%%%.,.****///((((//********//(###(((((((//****//(((((((#(((#%%#((((((\r\n"
						+ "%%%%%%%%%%%%%%/*.****//////*,,********/(((((((((((((((//*,,,**//#(*/###%#(((/(((\r\n"
						+ "%%%%%%%%%%%%%%%#,/******,.,***********/(#(((((/**/(((((///***.,*/#*//*,*%%#//((,\r\n"
						+ "%%%%%%%%%%%%%%%%&/****,*,,,,,***,,*,*,,***/***//(((((//**,,,,.,.*(*//(/((/(/((((\r\n"
						+ "%#%%%%%%%%%%%%%%%*/****/**, ..,****,,,,,,,**(((//****,**,..**,.///,/(////////(((\r\n"
						+ "###%%%%%%%%%%%%%%,%***/*//**.../****,***********//&#/((%.,(///*//*/(////////((((\r\n"
						+ "*%###%%%%%%%%%%%%*#%***////**,,,##%(&&(%%#/%&@#&@%&&%&*,*(///,((///(((///////(((\r\n"
						+ ",(########%%%%%#%##%&*/**/*/**,,.*%%&%&&&&#&&&&&@&&@***//(((*((/*(((///**///((/,\r\n"
						+ ",,##############%#/%%%%***(*/**,,...../%%%%%%&&*//,#(**/((((((//(/(//***  .     \r\n"
						+ ",,################.%%####*,/*/**,,,*./(/*,,.,.#/%%&%///((((((***///**//,. .  ...\r\n"
						+ ",,/###############/####////*/******,,*////((((#((////(((((((**/,#(///(/.. . . ..\r\n"
						+ ",,.(##############/.,,//*.*,,,*****///////////(((((((((##(#//(/((,##%(*..   .. .\r\n"
						+ ".,,/(######(*,.,***.****. /*,,,******//////////((((((((###**(((((./##(#%%%%#,   \r\n"
						+ ",,###((/***,,,****,,*/*, /**,,,,,*//*/////(///((((##((#(/,,*((((#*.#####%%#((##%\r\n"
						+ "/((//****,,,,*,,/******.**,,,,,*,,/////((((((((#(####(#**/(/,*((#**###########%#\r\n"
						+ "*,,,,,*/*,,,***/***,/**,,**,,****,,,////(((((((((((((*,////((*,,/###########%###\r\n"
						+ ",,,,,****,,,***/**,,/*** *,**,****,,,,*///(//////*/,,*/////(((((*#((############\r\n"
						+ ",,,,,****,,,****/,,,****,.,*,*********,,,,,,,,,,,*****///((##(((((#((###########\r\n"
						+ ",,,,,,*,*,********,.**,,,,.,,***********************//(((((#(((((#(#######(#####\r\n"
						+ "");
				System.out.println("we are watching.");
				System.exit(0);//close program
				
			}
			
			
			else//if the name was normal etc not "" or "153" all of the code is the same as above 
			{
				System.out.println("Welcome "+username+"!");
				TimeUnit.SECONDS.sleep(1);//wait
				System.out.println("Do you need an explanation on how to play? 0:No 1:Yes");
				userChoice = userInput2.nextInt();
				while(userChoice > 1 || userChoice < 0)
				{
					System.out.println("That entry was invalid please try again.");
					userChoice = userInput2.nextInt();
				}
				if(userChoice == 1)
				{
					System.out.println("During the game you will be shown tiles numbered 0-8.");
					System.out.println("Enter these numbers in the order shown one at a time hitting enter between entries.");
					System.out.println("If you fail to enter the tiles in order your test is over...");
					System.out.println("If you enter a number out of this range or something that isn't an integer the game will exit");
					TimeUnit.SECONDS.sleep(1);
					System.out.println("Enter any value to continue.");
					userInput2.next();
					System.out.println("Good Luck "+username+"! begining game...");
					TimeUnit.SECONDS.sleep(1);
				}
				else
				{
					System.out.println("Good Luck "+username+"! begining game...");
					TimeUnit.SECONDS.sleep(1);
				}
			}
			
			
		}
		catch(InputMismatchException e) {//Catch a mismatch exeception
			System.out.println("The entered number must be an integer");
			userChoice = userInput2.nextInt();//Take the imput again
		}
		return username;//return the username to the above function
	}
}

class NumTile{//numtile class
	int randint;//define randint
	int iterationint;//define iteration int
	NumTile(int randint, int iterationint){//invoke contructor
		this.randint = randint;
		this.iterationint = iterationint;
	}
	public int getRandInt(){//get method for randInt of the tile 
		return randint;
		}
	public void getNumTileGraphic() {//get method for the tile graphic
		switch(randint)//switch depending on the randint value which is 0-8 so the user can see the tile
		{
		case 0:
			System.out.println("| 0 |---|---|");//3 by 3 box with numbers 0-8 print and break same for the ones below
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			break;
			
		case 1:
			System.out.println("|---| 1 |---|");
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			break;
			
		case 2:
			System.out.println("|---|---| 2 |");
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			break;
		case 3:
			System.out.println("|---|---|---|");
			System.out.println("| 3 |---|---|");
			System.out.println("|---|---|---|");
			break;
		case 4:
			System.out.println("|---|---|---|");
			System.out.println("|---| 4 |---|");
			System.out.println("|---|---|---|");
			break;
		case 5:
			System.out.println("|---|---|---|");
			System.out.println("|---|---| 5 |");
			System.out.println("|---|---|---|");
			break;
		case 6:
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			System.out.println("| 6 |---|---|");
			break;
		case 7:
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			System.out.println("|---| 7 |---|");
			break;
		case 8:
			System.out.println("|---|---|---|");
			System.out.println("|---|---|---|");
			System.out.println("|---|---| 8 |");
			break;
		}//end the get graphic method
		
	}
}


class RandGame{//Randgame class
	int gamelength;//define gamelengthint
	NumTile[] numtilesstore;//define the numtiles array
	Scanner userInput = new Scanner(System.in);//create a new scanner
	String username;//define username
	public RandGame(NumTile[] numtilesstore, int gamelength, String username) throws Exception {//invoke constructor and define exeception for error handling
		this.numtilesstore = numtilesstore;
		this.gamelength = gamelength;
		this.userInput = userInput;
		this.username = username;
		runGame(numtilesstore, gamelength, username);//run method with the numtiles array, gamelength int, and the string username
	}
	public void runGame(NumTile[] numtilestore, int gamelength, String username) throws InterruptedException, IOException //define exceptions for error handling and printwriter
	{
		for(int i = 0; i < gamelength; i++) {//run game for the length of the gamelength int
			switch(i)//switch depending on the iteration
			{
				case 0://all the cases are indentical but the order stacks each iteration so it shows 1 then 1,2 then 1, 2, 3 etc. Extra comments are on case 8 which is different
					try {
					int randint1 = numtilesstore[i].getRandInt();//get the random integer from the current numtiles
					numtilesstore[i].getNumTileGraphic();//show the tile from the current tile
					TimeUnit.SECONDS.sleep(1);//wait one second
					clearScreen();//clear the terminal
					clearNumTile();//show an empty version of the tile graphic
					int userint = userInput.nextInt();//define the user entered int
					while(userint < 0 || userint > 8)//if the number is out of range run the playerGameOver method
					{
						System.out.println("The entered integer must be between 0 and 8, Exiting game....");//prompt user
						playerGameOver(i);//run game over method for the specific integration int
						break;//break loop
					}
					if(userint == randint1)//if the input was correct
					{
						continue;//continue and start at the top of loop preceding to case 1
					}
					else//if the input was wrong run the playerGameOver method
					{
						playerGameOver(i);//triggergameover
						break;//break loop
					}
						}
					catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
						System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
						playerGameOver(i);//run game over method for the specific integration int
						break;//break out of loop
					}
				case 1://repeats order of case 0 then case 1
					int randint2 = numtilesstore[i].getRandInt();
					int randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 2://repeats order of case 0 then case 1 then case 2
					int randint3 = numtilesstore[i].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
					
				case 3://repeats order of case 0 then case 1 then case 2 then case 3 etc. 
					int randint4 = numtilesstore[i].getRandInt();
					randint3 = numtilesstore[2].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[2].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						int userint4 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 4:
					int randint5 = numtilesstore[i].getRandInt();
					randint4 = numtilesstore[3].getRandInt();
					randint3 = numtilesstore[2].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[2].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[3].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						int userint4 = userInput.nextInt();
						int userint5 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8) && (userint5 < 0 || userint5 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4 && userint5 == randint5)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 5:
					int randint6 = numtilesstore[i].getRandInt();
					randint5 = numtilesstore[4].getRandInt();
					randint4 = numtilesstore[3].getRandInt();
					randint3 = numtilesstore[2].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[2].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[3].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[4].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						int userint4 = userInput.nextInt();
						int userint5 = userInput.nextInt();
						int userint6 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8) && (userint5 < 0 || userint5 > 8) && (userint6 < 0 || userint6 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4 && userint5 == randint5 && userint6 == randint6)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 6:
					int randint7 = numtilesstore[i].getRandInt();
					randint6 = numtilesstore[5].getRandInt();
					randint5 = numtilesstore[4].getRandInt();
					randint4 = numtilesstore[3].getRandInt();
					randint3 = numtilesstore[2].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[2].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[3].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[4].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[5].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						int userint4 = userInput.nextInt();
						int userint5 = userInput.nextInt();
						int userint6 = userInput.nextInt();
						int userint7 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8) && (userint5 < 0 || userint5 > 8) && (userint6 < 0 || userint6 > 8) && (userint7 < 0 || userint7 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8");
							System.exit(0);
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4 && userint5 == randint5 && userint6 == randint6 && userint7 == randint7)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 7:
					int randint8 = numtilesstore[i].getRandInt();
					randint7 = numtilesstore[6].getRandInt();
					randint6 = numtilesstore[5].getRandInt();
					randint5 = numtilesstore[4].getRandInt();
					randint4 = numtilesstore[3].getRandInt();
					randint3 = numtilesstore[2].getRandInt();
					randint2 = numtilesstore[1].getRandInt();
					randint1 = numtilesstore[0].getRandInt();
					try {
						numtilesstore[0].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[1].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[2].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[3].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[4].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[5].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[6].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						numtilesstore[i].getNumTileGraphic();
						TimeUnit.SECONDS.sleep(1);
						clearScreen();
						clearNumTile();
						int userint = userInput.nextInt();
						int userint2 = userInput.nextInt();
						int userint3 = userInput.nextInt();
						int userint4 = userInput.nextInt();
						int userint5 = userInput.nextInt();
						int userint6 = userInput.nextInt();
						int userint7 = userInput.nextInt();
						int userint8 = userInput.nextInt();
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8) && (userint5 < 0 || userint5 > 8) && (userint6 < 0 || userint6 > 8) && (userint7 < 0 || userint7 > 8) && (userint8 < 0 || userint8 > 8))
						{
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);
							break;
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4 && userint5 == randint5 && userint6 == randint6 && userint7 == randint7 && userint8 == randint8)
						{
							continue;
						}
						else
						{
							playerGameOver(i);
							break;
							//fail func here
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not a double
							playerGameOver(i);
							break;
						}
				case 8:
					int randint9 = numtilesstore[i].getRandInt();//define a new int for the last entry
					randint8 = numtilesstore[7].getRandInt();//define int for the previous 8 entries
					randint7 = numtilesstore[6].getRandInt();//define int
					randint6 = numtilesstore[5].getRandInt();//define int
					randint5 = numtilesstore[4].getRandInt();//define int
					randint4 = numtilesstore[3].getRandInt();//define int
					randint3 = numtilesstore[2].getRandInt();//define int
					randint2 = numtilesstore[1].getRandInt();//define int
					randint1 = numtilesstore[0].getRandInt();//define int
					try {//present order from 0-8 waiting a second and clearing after each tile
						numtilesstore[0].getNumTileGraphic();//present the first tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear the screen. This method is repeated for the other 8 tiles
						numtilesstore[1].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[2].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[3].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[4].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[5].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[6].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[7].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						numtilesstore[i].getNumTileGraphic();//present the tile's graphic
						TimeUnit.SECONDS.sleep(1);//wait 1 second
						clearScreen();//clear screen
						clearNumTile();//show the empty 3 by 3 tile
						int userint = userInput.nextInt();//take input
						int userint2 = userInput.nextInt();//take input
						int userint3 = userInput.nextInt();//take input
						int userint4 = userInput.nextInt();//take input
						int userint5 = userInput.nextInt();//take input
						int userint6 = userInput.nextInt();//take input
						int userint7 = userInput.nextInt();//take input
						int userint8 = userInput.nextInt();//take input
						int userint9 = userInput.nextInt();//take input
						while((userint < 0 || userint > 8) && (userint2 < 0 || userint2 > 8) && (userint3 < 0 || userint3 > 8) && (userint4 < 0 || userint4 > 8) && (userint5 < 0 || userint5 > 8) && (userint6 < 0 || userint6 > 8) && (userint7 < 0 || userint7 > 8) && (userint8 < 0 || userint8 > 8) && (userint9 < 0 || userint9 > 8))
						{//if one of the entries was out of range tell the player and trigger a game over
							System.out.println("The entered integer must be between 0 and 8, Exiting game....");
							playerGameOver(i);//gameover func
							break;//break loop
						}
						if(userint == randint1 && userint2 == randint2 && userint3 == randint3 && userint4 == randint4 && userint5 == randint5 && userint6 == randint6 && userint7 == randint7 && userint8 == randint8 && userint9 == randint9)
						{//if all entered values are correct run the victory method for the current iteration
							playerVictory(i);//victory func
							break;//break loop
						}
						else//if incorrect
						{
							
							playerGameOver(i);//run gameover func for current iteration
							break;//break loop
						}
							}
						catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
							System.out.println("The entered value must be a integer, Exiting game....");//print to user that the entered value was not an int
							playerGameOver(i);//trigger gameover
							break;//break loop
						}
			}
			
		}
	}
	public static void clearScreen() throws InterruptedException, IOException {//This method clears the terminal of the windows cmd and I found this specific code snippet here https://www.javatpoint.com/how-to-clear-screen-in-java
		 final String os = System.getProperty("os.name");
	        if (os.contains("Windows"))
	            new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
	        else
	            Runtime.getRuntime().exec("clear");
	        //only works in windows cmd
	}  
	private void clearNumTile() {//Print an empty 3 by 3 box after the screen has been cleared
		System.out.println("|---|---|---|");
		System.out.println("|---|---|---|");
		System.out.println("|---|---|---|");
	}
	private int calculateScore(int i) {//calculate score using the current interation
		int multiplier = i;//define an int for i
		int score = multiplier * 3350;//multiply the interation number by a set number
		return score;//return the calculated score
		
	}
	private void playerVictory(int i) throws FileNotFoundException {//uses int i and define file exception for printwriter
		int playerScore = calculateScore(i);//set player score to the returned value from the calulateScore method
		playerScore += 15000;//add 15000 to this score as the player won
		System.out.println("----------VICTORY ROYALE!----------");//print header for victory screen
		System.out.println("\n"+username);//print username
		System.out.println("MAXIMUM SCORE: "+playerScore);//print username
		String endgame = "\n----------VICTORY ROYALE!----------"+"\n"+username+"\nMAXIMUM SCORE: "+playerScore;//add this score info into a string and pass it to the printScore func
		printScore(endgame);//run method
		
	}
	private void playerGameOver(int i) throws FileNotFoundException{
		int playerScore = calculateScore(i);//set player score to the returned value from the calulateScore method
		System.out.println("------GAMEOVER------");//print header for gameover screen
		System.out.println("\n"+username);//print username
		System.out.println("Score: "+playerScore);//print username
		System.out.println("Your test is over....");//bottom header
		String endgame = "------GAMEOVER------"+"\n"+username+"\nScore: "+playerScore+"\nYour test is over and you are SUS...";//add this score info into a string and pass it to the printScore func
		printScore(endgame);//run this string to printScore
	}
	
	private void printScore(String endgame) throws FileNotFoundException {//define exception
		try {
			System.out.println(" ");//add a gap above the below text for formatting
			System.out.println("Would you like to print a score.txt file? If a score.txt file already exists it will be overwritten! 1:Yes 0:No");//prompt user if they want a score file
			int userChoice = userInput.nextInt();//take an input
			while(userChoice < 0 || userChoice > 1)//if the input is out of range tell the user and ask them to reenter the int
			{
				System.out.println("The entered value must be a integer, 1 or 0");//prompt
				userChoice = userInput.nextInt();//take another input
			}
			if(userChoice == 1)//if the user entered 1
			{
				File scoreOutput = new File("score.txt");//create a new .txt file
				PrintWriter writer = new PrintWriter(scoreOutput);//create a printwriter to write to the output file
				writer.println(endgame);//print to the file output
				writer.close();//close out the writer
				userInput.close();//close out scanner
				System.out.println("Saving file and exiting game...");//prompt the user that the file was saved and that the game is exiting
			}
			else if(userChoice == 0)//if the user entered 0
			{
				System.out.println("Exiting game...");//prompt that the game is exiting
			}
		}
		
		catch(InputMismatchException e) {//Catch if the user entered an invalid value like larry for example
			System.out.println("\nThe entered value must be a integer, Exiting game....");//print to user that the entered value was not valid
			System.exit(0);//exit the program
		}
		System.exit(0);//exit game
	}
}

