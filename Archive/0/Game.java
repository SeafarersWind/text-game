import java.util.*;
import java.io.IOException;

public class Game {
	
	public static void main(String[] args) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		int win = 1;
		String[] orderWords = {"First", "Second", "Third", "Fourth", "Fifth", "Sixth", "Seventh", "Eighth", "Ninth", "Tenth", "Eleventh", "Twelfth"};
		
		//initialization
		ArrayList<Player> pParty = new ArrayList<Player>();
		pParty.add(new Player());
		
		EventEncounter forestEncounterRandom = new EventEncounter(0, 10, new ArrayList<Enemy>(Arrays.asList(new EnemySlime(), new EnemyGoblin(), new EnemySpider())), 100, 20);
		
		EventEncounter forestEncoutnerSet = new EventEncounter(0, 10, new ArrayList<ArrayList<Enemy>>(Arrays.asList(
			new ArrayList<Enemy>(Arrays.asList(new EnemySlime(), new EnemySlime(), new EnemySlime())),
			new ArrayList<Enemy>(Arrays.asList(new EnemySlime(), new EnemySlime(), new EnemySlime(), new EnemySlime(), new EnemySlime())),
			new ArrayList<Enemy>(Arrays.asList(new EnemySpider(), new EnemySpider())),
			new ArrayList<Enemy>(Arrays.asList(new EnemyGoblin(), new EnemyGoblin())),
			new ArrayList<Enemy>(Arrays.asList(new EnemyGoblin(), new EnemySlime(), new EnemySlime()))
		)));
		
		EventEncounter forestEncoutnerEasy = new EventEncounter(0, 12, new ArrayList<ArrayList<Enemy>>(Arrays.asList(
			new ArrayList<Enemy>(Arrays.asList(new EnemySlime(), new EnemySlime())),
			new ArrayList<Enemy>(Arrays.asList(new EnemySpider())),
			new ArrayList<Enemy>(Arrays.asList(new EnemyGoblin())),
			new ArrayList<Enemy>(Arrays.asList(new EnemyGibble(), new EnemyGibble())),
			new ArrayList<Enemy>(Arrays.asList(new EnemyGibble(), new EnemySlime())),
			new ArrayList<Enemy>(Arrays.asList(new EnemySlime())),
			new ArrayList<Enemy>(Arrays.asList(new EnemySpider(), new EnemySlime()))
		)));
		
		ArrayList<Event> forestEvents = new ArrayList<Event>(Arrays.asList(forestEncoutnerEasy));
		
		Land forest = new Land("Forest", 60, forestEvents);
		
		//stuff
		System.out.println();
		System.out.println();
		System.out.println();
		
		for(int i=0; i<pParty.size(); i++) {
			System.out.print("Name :");
			pParty.get(i).setName(input.nextLine());
		}
		
		System.out.println();
		
		while(true) {
			
			forest.travel(pParty, true);
		}
		
	}

}
