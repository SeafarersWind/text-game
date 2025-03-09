import java.util.*;
import java.io.IOException;

public class Encounter {
	
	public int battle(ArrayList<Player> pParty, ArrayList<Enemy> eParty) {
		
		//initialization
		ArrayList<Entity> entities = new ArrayList<Entity>();
		
		ArrayList<Player> alivePParty = new ArrayList<Player>();
		for(int i=0; i<pParty.size(); i++) {
			if(!pParty.get(i).isDead()) {
				alivePParty.add(pParty.get(i));
			}
		}
		
		int win = 0;
		boolean end = false;
		int battleXp = 0;
		
		//stuff
		
		if(eParty.size() == 1) {
			System.out.println(eParty.get(0).getName() + " appears!");
		}
		else if(eParty.size() == 2) {
			System.out.println(eParty.get(0).getName() + " and " + eParty.get(1).getName() + " appear!");
		}
		else if(eParty.size() > 2) {
			System.out.println(eParty.get(0).getName() + " and its cohorts appear!");
		}
		
		A.wait(1000);
		System.out.println();
		
		fight:
		while(!end) {
			
			// for (int i=0; i<entities.size()-1; i++) {
			// 	if(entities.get(i+1).getSp() > entities.get(i).getSp()) {
			// 		Collections.swap(entities,i,i+1);
			// 		i=-1;
			// 	}
			// }
			
			if(pParty.size() >= eParty.size()) {
				int i2 = 0;
				for(int i=0; i<pParty.size(); i++) {
					entities.add(pParty.get(i));
					if((i % (pParty.size() / eParty.size())) == 0) {
						entities.add(eParty.get(i2));
						i2++;
					}
				}
			}
			else {
				int i2 = 0;
				for(int i=0; i<eParty.size(); i++) {
					entities.add(eParty.get(i));
					if((i % (eParty.size() / pParty.size())) == 0) {
						entities.add(pParty.get(i2));
						i2++;
					}
				}
			}
			turns:
			for(int i=0; i<entities.size(); i++) {
				
				entities.get(i).turn(pParty, eParty, entities);
				
				for(int i2=0; i2<entities.size(); i2++) {
					if(entities.get(i2).isDead()) {
						if(eParty.contains(entities.get(i2))) {
							battleXp += entities.get(i2).getXp();
							eParty.remove(entities.get(i2));
							if(eParty.isEmpty()) { win = 1; break fight; }
						}
						else if(pParty.contains(entities.get(i2))) {
							alivePParty.remove(entities.get(i2));
							if(alivePParty.isEmpty()) { win = 0; break fight; }
						}
						entities.remove(entities.get(i2));
					}
				}
				int playersInBattle = 0;
				for(int i2=0; i2<entities.size(); i2++) {
					if(pParty.contains(entities.get(i2))) {
						playersInBattle++;
					}
				}
				if(playersInBattle == 0) { win = 2; break fight; }
				
			}
			
			entities.clear();
			
		}
		
		if(win == 1) {
			
			System.out.println("Victory!!");
			A.wait(2000);
			
			battleXp /= pParty.size();
			
			if(alivePParty.size() == 1) {
				System.out.println(alivePParty.get(0).getName() + " gained " + battleXp + " XP!");
			}
			else if(alivePParty.size() == 2) {
				System.out.println(alivePParty.get(0).getName() + " and " + alivePParty.get(1).getName() + " gained " + battleXp + " XP!");
			}
			else if(alivePParty.size() > 2) {
				System.out.println(alivePParty.get(0).getName() + "'s party gained " + battleXp + " XP!");
			}
			A.wait(2000);
			
			for(int i=0; i<alivePParty.size(); i++) {
				alivePParty.get(i).addXp((int)Math.round( (float)battleXp / ((float)pParty.size() / 1.5f)));
				//System.out.println(alivePParty.get(i).getName() + "'s XP: " + alivePParty.get(i).getXp());
			}
		}
		
		else if(win < 1) {
			System.out.println("The party was defeated...");
			A.wait(2000);
		}
		
		return win;
		
	}
	
}
