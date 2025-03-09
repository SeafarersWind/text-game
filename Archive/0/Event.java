import java.util.*;
import java.io.IOException;

public class Event {
	
	protected int position = 0;
	protected int eventRng = 1;
	
	public Event() {
		this(0,0);
	}
	
	public Event(int position, int eventRng) {
		this.position = position;
		this.eventRng = eventRng;
	}
	
	public boolean checkEvent(int pPosition) {
		Random rand = new Random();
		
		if(position > 0 && position == pPosition) {
			return true;
		}
		else if(eventRng > 0 && rand.nextInt(eventRng) == 0) {
			return true;
		}
		else {
			return false;
		}
	}
	public void doEvent(ArrayList<Player> pParty) {
		
	}
	
}