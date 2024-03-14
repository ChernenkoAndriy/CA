import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.StringTokenizer;

public class Main {
    public static void main(String[] args) {
        String task = filereader("C:\\Users\\andre\\IdeaProjects\\CA\\src\\inp.txt");
        System.out.println(task);
        task = task.replaceAll("\n", " ");
        System.out.println(task);
        StringTokenizer st = new StringTokenizer(task);
        HashMap<String, ArrayList<Integer>> hm = new HashMap<>();
        String curKey = "";
        while (st.hasMoreTokens()) {
            String token = st.nextToken();
            if (token.charAt(0) == 'a') {
                curKey = token;
            } else {
                int value = Integer.parseInt(token);
                hm.computeIfAbsent(curKey, k -> new ArrayList<>()).add(value);
            }
        }
        System.out.println(findAv(hm));
    }


    private static HashMap<String, Double> findAv(HashMap<String, ArrayList<Integer>> hm) {
        String[] keys = hm.keySet().toArray(new String[0]);
        HashMap<String, Double> res = new HashMap<>();
        for (int i =0;i< hm.size(); i++){
        res.put(keys[i],aver(hm.get(keys[i])) );

        }
        return res;
    }
    private static double aver(ArrayList<Integer> ay){
        double res = 0;
        for(int i = 0; i< ay.size(); i++){
        res+= ay.get(i);
        }
        return res/ ay.size();
    }
    private static String filereader(String filename) {
        StringBuilder builder = new StringBuilder();
        try {
            BufferedReader reader = new BufferedReader(new FileReader(filename));
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line).append("\n");
            }
        } catch (IOException e) { //дії вразі винятку
            e.printStackTrace();
            System.out.println("File not found");
        }
        return builder.toString();
    }

}
