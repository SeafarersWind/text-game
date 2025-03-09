import java.util.*;
import java.io.IOException;

public class Enemy extends Entity implements Cloneable {
	
	protected int cooldown = 0;
	
	//get/set
	public int getCooldown() { return cooldown; }
	public void setCooldown(int cooldown) { this.cooldown = cooldown; }
	public void setXp(int xp) { this.xp = xp; }
	
	//constructor
	public Enemy() {
		this(0, 0, 0, 0, 0, "");
	}
	public Enemy(int maxHp, int at, int df, int sp, int mg, String name) {
		this.maxHp = maxHp;
		this.at = at;
		this.df = df;
		this.sp = sp;
		this.mg = mg;
		
		hp = maxHp;
		this.name = name;
		xp = (maxHp / 10) + at + df + sp + mg;
		lv = xp / 10; if(lv == 0) { lv = 1; }
	}
	
	public Object clone() {
		try {
			return super.clone();
		} catch (CloneNotSupportedException e) {
			throw new RuntimeException(e);
		}
	}
	
	//turn
	public void turn(ArrayList<Player> pParty, ArrayList<Enemy> eParty, ArrayList<Entity> entities) {
		
		if(hasEffect[0]) {
			this.effectPoison();
		}
		
		if(cooldown <= 0) {
			this.attackRegular(pParty.get(A.rand.nextInt(pParty.size())));
		}
		else if(cooldown > 0) {
			cooldown--;
		}
	}
	
	public void join() {
		
		System.out.println(name + " joined the battle!");
		
		A.wait(1000);
		System.out.println();
	}
	
	public void die() {
		
		hp = 0;
		System.out.println(name + " was defeated!");
		//Battle.battleXp += xp;
		dead = true;
		
		A.wait(1000);
	}
}
