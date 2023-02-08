import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.Scanner;

public class Main {
    public static String makeGetRequest(String _url) throws IOException {
        InputStream response = new URL(_url).openStream();

        String responseBody = null;
        try (Scanner scanner = new Scanner(response)) {
            responseBody = scanner.useDelimiter("\\A").next();
        }

        return responseBody;
    }

    public static void main(String[] args) throws IOException {
        System.out.println(makeGetRequest(args[0]));
    }
}