import java.util.*;
import java.io.IOException;

public class EnemyGoblin extends Enemy {
	
	public EnemyGoblin() {
        maxHp = 30;
		at = 5;
		df = 3;
		sp = 4;
		mg = 1;
		
		hp = maxHp;
		name = "Goblin";
		xp = (maxHp / 10) + at + df + sp;
		lv = xp / 10; if(lv == 0) { lv = 1; }
    }
	
}
