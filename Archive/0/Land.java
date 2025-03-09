import java.util.*;
import java.io.IOException;

public class Land extends Area {
	
	private String name = new String();
	private int length = 0;
	private ArrayList<Enemy> enemies = new ArrayList<Enemy>();
	private int xpMin = 0;
	private int xpRange = 0;
	private ArrayList<Enemy> boss = new ArrayList<Enemy>();
	private boolean bossKilled = false;
	private ArrayList<Event> events = new ArrayList<Event>();
	
	public Land(String name, int length, ArrayList<Event> events) {
		this.name = name;
		this.length = length;
		this.events = events;
	}
	
	public void travel(ArrayList<Player> pParty, boolean direction) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		int progress = 0;
		int battleRng = ((3 * length) / 4);
		
		System.out.println(pParty.get(0).getName() + " entered " + name + ".");
		A.wait(1000);
		System.out.println();
		
		travel:
		while(true) {
			
			System.out.println(pParty.get(0).getName() + " is traveling through " + name + ".");
			
			for(int i=0; i<progress; i++) { System.out.print("."); }
			
			dots:
			while(true) {
				
				A.wait(1000);
				System.out.print(".");
				progress++;
				
				for (int i=0; i<pParty.size(); i++) {
					if (!pParty.get(i).isDead()) {
						pParty.get(i).healS(1);
					}
				}
				
				if(progress >= length) {
					break travel;
				}
				
				for(int i=0; i<events.size(); i++) {
					boolean eventHappened = false;
					if(events.get(i).checkEvent(progress)) {
						System.out.print("!");
						A.wait(100);
						System.out.print("!");
						A.wait(100);
						System.out.println("!");
						A.wait(1000);
						System.out.println();
						
						events.get(i).doEvent(pParty);
						eventHappened = true;
						
						A.wait(3000);
						System.out.println();
					}
					
					int alivePlayers = 0;
					for(int i2=0; i2<pParty.size(); i2++) {
						if(!pParty.get(i2).isDead()) {
							alivePlayers++;
						}
					}
					if(alivePlayers == 0) { break travel; }
					
					if(eventHappened) {
						System.out.println(pParty.get(0).getName() + " is traveling through " + name + ".");
						for(int i2=0; i2<progress; i2++) { System.out.print("."); }
					}
				}
				
			}
		}
		
		if(progress >= length) {
			System.out.println("Made it!");
		}
		
		else {
			System.out.println("Return...");
		}
		
	}
}