import java.util.*;
import java.io.IOException;

public class EnemySlime extends Enemy {
	
	public EnemySlime() {
		maxHp = 20;
		at = 4;
		df = 0;
		sp = 3;
		mg = 4;
		
		hp = maxHp;
		name = "Slime";
		xp = (maxHp / 10) + at + df + sp;
		lv = xp / 10; if(lv == 0) { lv = 1; }
    }
	
	//turn
	public void turn(ArrayList<Player> pParty, ArrayList<Enemy> eParty, ArrayList<Entity> entities) {
		
		if(cooldown <= 0) {
			
			if(A.rand.nextInt(4) == 2 && hp > 2) {
				this.attackSplit(eParty, entities);
			}
			else {
				this.attackRegular(pParty.get(A.rand.nextInt(pParty.size())));
			}
		}
		else if(cooldown > 0) {
			cooldown--;
		}
	}
	
	public void attackSplit(List<Enemy> eParty, ArrayList<Entity> entities) {
		
		System.out.println(name + " splits in two!");
		A.wait(500);
		
		hp = (int)Math.round(hp / 2.2);
		xp = (int)Math.round(xp / 1.8);
		
		EnemySlime e = new EnemySlime();
		e.setHp(hp);
		e.setXp(xp);
		e.setCooldown(cooldown + 1);
		
		eParty.add(e);
		entities.add(e);
		
		A.wait(1000);
		System.out.println();
		
	}
}
