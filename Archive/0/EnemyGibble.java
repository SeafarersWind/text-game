import java.util.*;
import java.io.IOException;

public class EnemyGibble extends Enemy {
	
	public EnemyGibble() {
        maxHp = 20;
		at = 3;
		df = 2;
		sp = 5;
		mg = 1;
		
		hp = maxHp;
		name = "Gibble";
		xp = (maxHp / 10) + at + df + sp;
		lv = xp / 10; if(lv == 0) { lv = 1; }
    }
	
}
