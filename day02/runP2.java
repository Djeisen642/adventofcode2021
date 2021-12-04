import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;

public class Day2 {
    public static void main(String[] args) {
        try {
            File fileInput = new File("input.txt");
            Scanner reader = new Scanner(fileInput);
            part2(reader);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static void part2(Scanner reader) {
        int forward = 0;
        int depth = 0;
        int aim = 0;
        while (reader.hasNextLine()) {
            String line = reader.nextLine();
            String[] parts = line.split(" ");
            if (parts[0].equals("forward")) {
                int curForward = Integer.parseInt(parts[1]);
                forward += curForward;
                depth += aim * curForward;
            }
            if (parts[0].equals("down")) {
                aim += Integer.parseInt(parts[1]);
            }
            if (parts[0].equals("up")) {
                aim -= Integer.parseInt(parts[1]);
            }
        }
        System.out.println(aim);
        System.out.println(forward);
        System.out.println(forward * depth);
    }
}