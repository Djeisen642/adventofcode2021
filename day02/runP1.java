import java.io.File;
import java.util.Scanner;
import java.io.FileNotFoundException;

public class Day2 {
    public static void main(String[] args) {
        try {
            File fileInput = new File("input.txt");
            Scanner reader = new Scanner(fileInput);
            part1(reader);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private static void part1(Scanner reader) {
        int forward = 0;
        int depth = 0;
        while (reader.hasNextLine()) {
            String line = reader.nextLine();
            String[] parts = line.split(" ");
            if (parts[0].equals("forward")) {
                forward += Integer.parseInt(parts[1]);
            }
            if (parts[0].equals("down")) {
                depth += Integer.parseInt(parts[1]);
            }
            if (parts[0].equals("up")) {
                depth -= Integer.parseInt(parts[1]);
            }
        }
        System.out.println(forward * depth);
    }
}