import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
public class DataInput {
    public DataInput() {
    }

// це клас для зчитування інформції
    /**
     * приклад використання:
     * public class DataInput {
     * private static DataInput di = new DataInput
     * public void run(){
     * int instance = di.getInt("Введіть якесь число")
     * }
     * */
    public static Long getLong(String prompt){
        String s = "";
        while (true) {
            try {
                System.out.println(prompt);
                s = getStrng();
                if (s.isEmpty()) {
                    System.out.println("Помилка: ви ввели порожній рядок. Спробуйте ще раз.");
                    continue;
                }
                Long value = Long.valueOf(s);
                return value;
            } catch (IOException e) {
                System.out.println("Помилка в зчитуванні. Cпробуйте ще раз");
            } catch (NumberFormatException e) {
                System.out.println("Помилка: ви ввели не ціле число. Cпробуйте ще раз");
            }
        }
    }

    public static Double getDouble(String prompt){
        String s = "";
        while (true) {
            try {
                System.out.println(prompt);
                s = getStrng();
                if (s.isEmpty()) {
                    System.out.println("Помилка: ви ввели порожній рядок. Спробуйте ще раз.");
                    continue;
                }
                Double value = Double.valueOf(s);
                return value;
            } catch (IOException e) {
                System.out.println("Помилка в зчитуванні. Cпробуйте ще раз");
            }catch (NumberFormatException e) {
                System.out.println("Помилка: ви ввели не раціональне число. Cпробуйте ще раз");
            }
        }
    }

    public static char getChar(String prompt){
        String s = "";
        while (true) {
            try {
                System.out.println(prompt);
                s = getStrng();
                if (s.isEmpty()) {
                    System.out.println("Помилка: ви ввели порожній рядок. Спробуйте ще раз.");
                    continue;
                }
                return s.charAt(0);
            } catch (IOException e) {
                System.out.println("Помилка в зчитуванні. Cпробуйте ще раз");
            }
        }
    }
    public static Integer getInt(String prompt){
        String s = "";
        while (true) {
            try {
                System.out.println(prompt);
                s = getStrng();
                if (s.isEmpty()) {
                    System.out.println("Помилка: ви ввели порожній рядок. Спробуйте ще раз.");
                    continue;
                }
                Integer value = Integer.valueOf(s);
                return value;
            } catch (IOException e) {
                System.out.println("Помилка при  зчитуванні. Cпробуйте ще раз");
            } catch (NumberFormatException e) {
                System.out.println("Помилка: ви ввели не ціле число, або взагалі не число. Cпробуйте ще раз");
            }
        }
    }
    //допоміжний метод
    private static String getStrng() throws IOException {
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);
        String s = null;
        s = br.readLine();
        return s;
    }

    public static String getString(String prompt) {
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);
        String s = null;
        while (true) {
            try {
                System.out.println(prompt);
                s = br.readLine();
                return s;
            } catch (IOException e) {
                System.out.println("Помилка: не вдалось зчитати текст. Спробуйте ще раз");
            }catch (NullPointerException e) {
                System.out.println("Помилка: ви нічого не ввели. Спробуйте ще раз.");
            }
        }
    }

}