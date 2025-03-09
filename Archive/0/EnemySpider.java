import java.util.*;
import java.io.IOException;

public class EnemySpider extends Enemy {
	
	public EnemySpider() {
		maxHp = 18;
		at = 3;
		df = 2;
		sp = 6;
		mg = 5;
		
		hp = maxHp;
		name = "Spider";
		xp = (maxHp / 10) + at + df + sp;
		lv = xp / 10; if(lv == 0) { lv = 1; }
	}
	
	public void attackRegular(Entity def) {
		String menuInput = new String();
		
		System.out.println(name + " attacks " + def.getName() + "!");
		A.wait(750);
		
		if(A.rand.nextFloat() < (float)Math.sqrt(0.5*((float)sp/(float)def.getSp()))) {
			
			def.damage(((int)Math.round(at * 2.8) - (int)Math.round(def.getDf() * 1.2)), (at / 2));
			
			if(A.rand.nextInt(8) < 1) {
				def.affectPoison();
			}
			
			System.out.println();
			
		}
		else {
			System.out.println("Miss!");
			A.wait(1000);
			System.out.println();
		}
	}
}
