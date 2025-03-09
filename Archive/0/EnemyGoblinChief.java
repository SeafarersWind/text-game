import java.util.*;
import java.io.IOException;

public class EnemyGoblinChief extends EnemyGoblin {
	
	public EnemyGoblinChief() {
        maxHp = 90;
		at = 12;
		df = 8;
		sp = 6;
		mg = 0;
		
		hp = maxHp;
		name = "Goblin Chief";
		xp = (maxHp / 10) + at + df + sp + mg;
		lv = xp / 10; if(lv == 0) { lv = 1; }
    }
	
	//turn
	public void turn(ArrayList<Player> pParty, ArrayList<Enemy> eParty, ArrayList<Entity> entities) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		Random rand = new Random();
		Actions a = new Actions();
		
		int dmg = 0;
		
		if(cooldown <= 0) {
			
			if(rand.nextInt(8) < 1) {
				this.attackCall(eParty, entities);
			}
			else {
				this.attackRegular(pParty.get(rand.nextInt(pParty.size())));
			}
		}
		else if(cooldown > 0) {
			cooldown--;
		}
	}
	
	public void attackCall(List<Enemy> eParty, ArrayList<Entity> entities) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		Random rand = new Random();
		Actions a = new Actions();
		
		System.out.println(name + " calls for help!");
		a.wait(2000);
		
		if(rand.nextInt(4) < 3) {
			
			EnemyGoblin e = new EnemyGoblin();
			
			eParty.add(e);
			entities.add(e);
			e.join();
		}
		else {
			System.out.println("...But nobody came.");
			
			a.wait(1000);
			System.out.println();
		}
	}
}
