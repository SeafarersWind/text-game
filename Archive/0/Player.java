import java.util.*;
import java.io.IOException;

public class Player extends Entity {
	
	protected int[] lvUpStats = new int[6];
	protected int lvNext = 100;
	protected int lvNextChange = 50;
	protected int xpMod = 1;
	
	public void addXp(int xp) { this.xp += xp * xpMod; if(this.xp >= lvNext) { this.levelup(); } }
	
	public Player() {
		maxHp = 40;
		at = 4;
		df = 4;
		sp = 4;
		mg = 4;
		lv = 1;
		
		lvUpStats = new int[]{0, 0, 0, 0, 0, 6};
		name = "Player";
		hp = maxHp;
	}
	public Player(int maxHp, int at, int df, int sp, int mg, int lv, int[] lvUpStats, String name) {
		this.maxHp = maxHp;
		this.hp = maxHp;
		this.at = at;
		this.df = df;
		this.sp = sp;
		this.mg = mg;
		this.lv = lv;
		this.lvUpStats = lvUpStats;
		this.name = name;
	}
	
	public void levelup() {
		
		int menuInput = 0;
		Scanner input = new Scanner(System.in);
		
		lv++;
		lvNext += lvNextChange * lv;
		
		maxHp += lvUpStats[0];
		at += lvUpStats[1];
		df += lvUpStats[2];
		sp += lvUpStats[3];
		mg += lvUpStats[4];
		
		System.out.println();
		System.out.println(name + " reached level " + lv + "!");
		A.wait(1000);
		
		
		// System.out.println("+" + lvUpStats[0] + " HP!");
		// A.wait(250);
		// System.out.println("+" + lvUpStats[1] + " AT!");
		// A.wait(250);
		// System.out.println("+" + lvUpStats[2] + " DF!");
		// A.wait(250);
		// System.out.println("+" + lvUpStats[3] + " SP!");
		// A.wait(250);
		// System.out.println("+" + lvUpStats[4] + " MG!");
		// A.wait(2000);
			
		// System.out.println(lvUpStats[5] + " points:");
		// for(int i=0; i<lvUpStats[5]; i++) {
		// 	System.out.print("(1)+HP (2)+AT (3)+DF (4)+SP (5)+MG :");
		// 	menuInput = input.nextLine();
		// 	System.out.println();
			
			menuInput = A.rand.nextInt(4);
			
			if(menuInput == 0) {
				maxHp += 10;
				System.out.println("+10 HP!");
			}
			else if(menuInput == 1) {
				at += 1;
				System.out.println("+1 AT!");
			}
			else if(menuInput == 2) {
				df += 1;
				System.out.println("+1 DF!");
			}
			else if(menuInput == 3) {
				sp += 1;
				System.out.println("+1 SP!");
			}
			else if(menuInput == 4) {
				mg += 1;
				System.out.println("+1 MG!");
			}
			
			A.wait(3000);
		// }
		
	}
	
	//turn
	public void turn(ArrayList<Player> pParty, ArrayList<Enemy> eParty, ArrayList<Entity> entities) {
		String menuInput = new String();
		Scanner input = new Scanner(System.in);
		
		if(dead) {
			System.out.println(name + " is unconscious...");
			A.wait(1000);
			System.out.println();
			return;
		}
		
		if(hasEffect[0]) {
			this.effectPoison();
		}
		
		System.out.print(name + ": ");
		for(int i=0; i<hp; i+=9) {
			System.out.print("-");
		}
		System.out.println();
		
		main:
		while(true) {
			
			System.out.print("(1)Attack (2)Stats (3)Run (0)End Turn :");
			menuInput = input.nextLine();
			
			if(menuInput.equals("1")) {
				
				if(eParty.size() > 1) {
					
					for(int i = 0; i < eParty.size(); i++) {
						System.out.print("(" + (i + 1) + ")" + eParty.get(i).getName() + " ");
					}
					System.out.print("(0)Back :");
					menuInput = input.nextLine();
					
					for(int i = 0; i < eParty.size(); i++) {
						if(menuInput.equals(Integer.toString(i + 1))) {
							
							System.out.println();
							
							this.attackRegular(eParty.get(i));
							break main;
						}
					}
					
					if(menuInput.equals("0")) {
						
					}
				
				}
				
				else {
					System.out.println();
										
					this.attackRegular(eParty.get(0));
					break main;
					
				}
			}
			
			else if(menuInput.equals("2")) {
				System.out.println();
				
				for(int i = 0; i < pParty.size(); i++) {
					System.out.println(pParty.get(i).getName() + ": " + pParty.get(i).getHp() + "/" + pParty.get(i).getMaxHp() + " HP, " + pParty.get(i).getAt() + " AT, " + pParty.get(i).getDf() + " DF, " + pParty.get(i).getSp() + " SP, " + pParty.get(i).getMg() + " MG");
				}
				for(int i = 0; i < eParty.size(); i++) {
					System.out.println(eParty.get(i).getName() + ": " + eParty.get(i).getHp() + "/" + eParty.get(i).getMaxHp() + " HP, " + eParty.get(i).getAt() + " AT, " + eParty.get(i).getDf() + " DF, " + eParty.get(i).getSp() + " SP, " + eParty.get(i).getMg() + " MG");
				}
				
				A.wait(1000);
				System.out.println();
			}
			
			else if(menuInput.equals("3")) {
				System.out.println();
				
				System.out.print(name + " tries to run away");
				for(int i=0; i<3; i++) {
					System.out.print(".");
					A.wait(1000);
				}
				if(A.rand.nextInt(3) < 1) {
					System.out.println(" but fails.");
					A.wait(2000);
					System.out.println();
					break;
				}
				else {
					System.out.println(" and escapes!");
					entities.remove(this);
				}
				
				break;
			}
			
			else if(menuInput.equals("0")) {
				System.out.println();
				break;
			}
			
			else if(menuInput.equals(".")) {
				this.die();
				break;
			}
		}
		
	}
	
	public void die() {
		
		hp = 0;
		System.out.println(name + " collapsed...");
		dead = true;
		A.wait(2000);
	}
	
	//heal
	public void heal() {
		
		if(hp < maxHp) { hp = maxHp; }
		System.out.println(name + " completely recovered HP!");
	}
	public void heal(float heal) {
		
		if(hp + (maxHp * heal) >= maxHp && heal <= 1f) {
			if(hp < maxHp) { hp = maxHp; }
			System.out.println(name + " completely recovered HP!");
		}
		else if(heal <= 1f) {
			hp += (maxHp * heal);
			System.out.println(name + " recovered " + (maxHp * heal) + " HP!");
		}
		else if(heal > 1f) {
			if(maxHp * heal < hp) { hp = (int) Math.round(maxHp * heal); }
			System.out.println(name + " recovered " + ((maxHp * heal) - maxHp) + " above maximum HP!");
		}
		else if(heal <= 0f) {
			System.out.println(name + " did not recover any HP!");
		}
		
	}
	public void heal(int heal) {
		
		if(hp + (maxHp * heal) >= maxHp) {
			hp = maxHp;
			System.out.println(name + " completely recovered HP!");
		}
		else if(heal <= 1) {
			hp += heal;
			System.out.println(name + " recovered " + (heal) + " HP!");
		}
		else if(heal <= 0) {
			System.out.println(name + " did not recover any HP!");
		}
		
	}
}
