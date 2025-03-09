import java.util.*;
import java.io.IOException;

public class Entity {
	
	protected int maxHp = 4;
	protected int hp = maxHp;
    protected int at = 4;
	protected int df = 4;
	protected int sp = 4;
	protected int mg = 4;
	protected int hpMod = 0;
	protected int atMod = 0;
	protected int dfMod = 0;
	protected int spMod = 0;
	protected int mgMod = 0;
	protected int hpModTemp = 0;
	protected int atModTemp = 0;
	protected int dfModTemp = 0;
	protected int spModTemp = 0;
	protected int mgModTemp = 0;
	protected int xp = 0;
	protected int lv = 1;
    protected String name = "";
	protected boolean[] hasEffect = new boolean[]{false};
	protected boolean dead = false;
	
	//get/set
    public int getMaxHp() { return (maxHp + hpMod + hpModTemp); }
	public int getHp() { return hp; }
	public void setHp(int hp) { this.hp = hp; if(hp <= 0) { this.die(); } }
    public int getAt() { return (at + atMod + atModTemp); }
	public int getDf() { return (df + dfMod + dfModTemp); }
	public int getSp() { return (sp + spMod + spModTemp); }
	public int getMg() { return (mg + mgMod + mgModTemp); }
	public void modHp(int mod) { hpMod += mod; }
	public void modAt(int mod) { atMod += mod; }
	public void modDf(int mod) { dfMod += mod; }
	public void modSp(int mod) { spMod += mod; }
	public void modMg(int mod) { mgMod += mod; }
	public void modHpTemp(int mod) { hpModTemp += mod; }
	public void modAtTemp(int mod) { atModTemp += mod; }
	public void modDfTemp(int mod) { dfModTemp += mod; }
	public void modSpTemp(int mod) { spModTemp += mod; }
	public void modMgTemp(int mod) { mgModTemp += mod; }
	public int getXp() { return xp; }
	public int getLv() { return lv; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
	public boolean getHasEffect(int i) { return hasEffect[i]; }
	public boolean isDead() { return dead; }
	
	public void turn(ArrayList<Player> pParty, ArrayList<Enemy> eParty, ArrayList<Entity> entities) {}
	
	public void attackRegular(Entity def) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		
		System.out.println(name + " attacks " + def.getName() + "!");
		A.wait(750);
		
		if(A.rand.nextFloat() < (float)Math.sqrt(0.5*((float)sp/(float)def.getSp()))) {
			
			def.damage(((int)Math.round(at * 2.6) - (int)Math.round(def.getDf() * 1.4)), ((int) (at / 1.8)));
			
			System.out.println();
			
		}
		else {
			System.out.println("Miss!");
			A.wait(1000);
			System.out.println();
		}
	}
	
	public void effectPoison() {
		
		System.out.println(name + " is poisoned!");
		A.wait(750);
		this.damage((maxHp / 20), (maxHp / 30));
		
		if(A.rand.nextInt(9) == 0) {
			hasEffect[0] = false;
			System.out.println(name + " has recovered.");
			A.wait(1000);
		}
		System.out.println();
	}
	
	public void affectPoison() {
		
		if(!hasEffect[0]) {
			hasEffect[0] = true;
			System.out.println(name + " became poisoned!");
			A.wait(1000);
		}
		
	}
	
	public void damage(int dmgBase, int dmgRange) {
		
		int dmg = 0;
		
		if(dmgRange > 0) {
			dmg = (dmgBase + (A.rand.nextInt(dmgRange)) - (dmgRange / 2));
		}
		else {
			dmg = (dmgBase + A.rand.nextInt(2) - 1);
		}
		if(dmg < 0) { dmg = 0; }
		hp -= dmg;
		System.out.println(name + " took " + dmg + " damage!");
		A.wait(1000);
		
		if(hp <= 0) {
			this.die();
		}
		
	}
	
	public void heal(int amount) {
		
		if(hp+amount > maxHp) {
			amount = maxHp-hp;
		}
		hp += amount;
		System.out.println(name + " healed " + amount + "hp!");
		A.wait(1000);
	}
	
	public void healS(int amount) {
		if(hp+amount > maxHp) {
			amount = maxHp-hp;
		}
		hp += amount;
	}
	
	public void die() {
		hp = 0;
		dead = true;
	}
}