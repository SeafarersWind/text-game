import java.util.*;
import java.io.IOException;

public class A {
	
	public static Random rand = new Random();
	
	public static void wait(int i) {
		try {
			Thread.sleep(i);
		} catch(InterruptedException ex) {
			Thread.currentThread().interrupt();
		}
	}
}
