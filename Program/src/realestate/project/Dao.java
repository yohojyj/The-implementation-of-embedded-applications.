package realestate.project;

import java.sql.*;
import java.util.*;

public class Dao {
	protected Connection con;
	protected Statement stmt;
	protected ResultSet rs;

	protected static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	protected static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	protected static final String ID = "housemate";
	protected static final String PW = "housemate";

	static {
		try {
			Class.forName(DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	static List<Reservation> list = new ArrayList<Reservation>();
	static Scanner sc = new Scanner(System.in);
	static int myCcode;
	static String logId;
	static String rDate = "";
}
