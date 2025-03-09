import java.util.*;
import java.io.IOException;

public class EventEncounter extends Event {
	
	protected ArrayList<Enemy> enemies = new ArrayList<Enemy>();
	protected int xpMin = 0;
	protected int xpRange = 0;
	protected ArrayList<ArrayList<Enemy>> parties = new ArrayList<ArrayList<Enemy>>();
	
	public EventEncounter(int position, int eventRng, ArrayList<Enemy> enemies, int xpMin, int xpRange) {
		this.position = position;
		this.eventRng = eventRng;
		this.enemies = enemies;
		this.xpMin = xpMin;
		this.xpRange = xpRange;
	}
	public EventEncounter(int position, int eventRng, ArrayList<ArrayList<Enemy>> parties) {
		this.position = position;
		this.eventRng = eventRng;
		this.parties = parties;
	}
	
	public void doEvent(ArrayList<Player> pParty) {
		Encounter encounter = new Encounter();
		
		if(enemies.size() > 0) {
			encounter.battle(pParty, this.makeEParty(enemies, xpMin, xpRange));
		}
		else if(parties.size() > 0) {
			encounter.battle(pParty, this.makeEParty(parties));
		}
		
	}
	
	public ArrayList<Enemy> makeEParty(ArrayList<ArrayList<Enemy>> parties) {
		
		ArrayList<Enemy> party = new ArrayList<Enemy>();
		ArrayList<Enemy> partyBase = new ArrayList<Enemy>();
		
		if(parties.size() > 1) {
			partyBase = parties.get(A.rand.nextInt(parties.size()));
		}
		else if(parties.size() == 1) {
			partyBase = parties.get(0);
		}	
		
		for(int i=0; i<partyBase.size(); i++) {
			party.add((Enemy) partyBase.get(i).clone());
		}
		
		return party;
		
	}
	
	public ArrayList<Enemy> makeEParty(ArrayList<Enemy> enemies, int xpMin, int xpRange) {
		
		// float weightTotal = 0f;
		// float weightSelection = 0f;
		// int enemyIndex = 0;
		int xpTotal = 0;
		
		ArrayList<Enemy> party = new ArrayList<Enemy>();
		
		while(xpTotal > xpMin) {
			party.add((Enemy) enemies.get(A.rand.nextInt(enemies.size())).clone());
			xpTotal += party.get(party.size() - 1).getXp();
		}
		
		// for(int i = 0; i < enemies.size(); i++) {
		// 	weightTotal += enemies.get(i).getWeight();
		// }
		
		// if(xpRange > 0) {
		// 	xpMin += A.rand.nextInt(xpRange) - (xpRange / 2);
		// }
		
		// while(true) {
			
		// 	weightSelection = A.rand.nextFloat() * weightTotal + 1f;
		// 	for(int i = 0; i < enemies.size(); i++) {
		// 		if(enemies.get(i).getWeight() >= weightSelection) {
		// 			enemyIndex = i;
		// 			break;
		// 		}
		// 		weightSelection -= enemies.get(i).getWeight();
		// 	}
			
		// 	Enemy e = (Enemy) enemies.get(enemyIndex).clone();
		// 	totalXp += e.getXp();
		// 	party.add(e);
			
		// 	if(totalXp >= xpMin) {
		// 		break;
		// 	}
			
		// }
		
		return party;
		
	}
	
	public boolean newEncounter(ArrayList<Player> pParty, ArrayList<Enemy> eParty) {
		
		
		//initialization
		
		return false;
	}
	
}