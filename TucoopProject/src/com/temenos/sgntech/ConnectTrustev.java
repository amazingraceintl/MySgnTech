package com.temenos.sgntech;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.*;

//import com.google.gson.JsonElement;
//import com.google.gson.JsonParser;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 * TODO: Document me!
 *
 * @author Peter
 *
 */
public class ConnectTrustev {

    /**
     * @param args
     * @throws IOException 
     */
    public static void main(String[] args) throws IOException {
        String ip = null;
        
        try {
            Object DeviceIp = InetAddress.getLocalHost();
            String []ips = DeviceIp.toString().split("\\/");
             ip = ips[1];
         } catch (UnknownHostException e1) {
             // TODO Auto-generated catch block
             // Uncomment and replace with appropriate logger
             // LOGGER.error(e1, e1);
         }
        System.out.println("My machine ip is ... = " + ip);
        
         ///
        
        final String uuid = UUID.randomUUID().toString().replace("-", "");
        System.out.println("uuid = " + uuid);
        
        //////////////////////////////////
       String  caseid = "7ff183f1-6039-493a-a60e-9fb3bd28381e|a980ed07-b307-4211-b850-0f0fe596178d";
       String  urlobj = " https://openlibrary.org/search.json";
        URL objj = new URL(urlobj);
        HttpURLConnection con = (HttpURLConnection)  objj.openConnection();
        
       String query =  "q=the+lord+of+the+rings";
        con.setRequestMethod("GET");
        con.setRequestProperty("Content-Type", "application/json");
        con.setDoOutput(true);
        
        DataOutputStream wr = new DataOutputStream(con.getOutputStream());
        wr.writeBytes(query);
        wr.flush();
        wr.close();
        String responseStatus = con.getResponseMessage();
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = in.readLine()) != null) {
            response.append(inputLine);
        }
        in.close();
        
      //  con.setRequestProperty("X-PublicKey", "");
      //  con.setRequestProperty("Host", "");
       // con.setRequestProperty("User-Agent", "Apache-HttpClient/4.5.5 (Java/16.0.1)");
        
       // con.setRequestProperty("X-Authorization", "Cooperativa_Ahorro_y_Credito_TestSite f40bccc9-341c-47d3-b793-3f8c3716bdad");   
        
        
    //    https://openlibrary.org/search.json?q=the+lord+of+the+rings
        
//        URL url = new URL("give your URL ");
//        URLConnection conn = url.openConnection();
        
        
      //  JsonParser jsonParser = new JsonParser();
      //  JsonElement jsonTree = jsonParser.parse(res);
 ///////////////////////////////
        
        
        
        // creating simple request, creating token request
        final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        Map<Object, Object> tokenreqMap = new HashMap<Object, Object>();
        JSONObject tokenreq_jsonObj;
        String username = null, pssword = null;
        String mytimestamp ;
     //   String ip = null;
        StringBuilder UhexString = new StringBuilder();
        StringBuilder PhexString = new StringBuilder();
        String[] var = { "Ani", "Sam" };

        for (int i = 0; i < var.length; i++) {
            String Variable = var[i];
            try {
                MessageDigest md;
                String input = Variable;
                md = MessageDigest.getInstance("SHA-256");
                byte[] hash = md.digest(input.getBytes());
                if (i == 0) {
                    for (byte b : hash) {
                        UhexString.append(String.format("%02x", b));
                    }
                    username = UhexString.toString();
                } else {
                    for (byte b : hash) {
                        PhexString.append(String.format("%02x", b));
                    }
                    pssword = PhexString.toString();
                }
                System.out.println(input + " :=Result1--1 " + UhexString);
                System.out.println(input + " :=Result--2 " + PhexString);
            } catch (NoSuchAlgorithmException e1) {
            }

            //Block to get timestamp
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            String[] tempm = sdf2.format(timestamp).toString().toString().split("\\.");
             mytimestamp = (tempm[0]+".001Z");
            System.out.println(sdf2.format(timestamp));       
          //End of Block to get timestamp
            
                          
            //Block to create token request
            tokenreqMap.put("UserName", var[0]);
            tokenreqMap.put("Timestamp", mytimestamp);
            tokenreqMap.put("PasswordHash", pssword);
            tokenreqMap.put("UserNameHash", username);
            tokenreq_jsonObj = new JSONObject(tokenreqMap);
            System.out.println("Encoding a JSON object: ");
            System.out.println(tokenreq_jsonObj);
            // End of Block to create token request
            
        }

      //////get system ip
//        try {
//           Object DeviceIp = InetAddress.getLocalHost();
//           String []ips = DeviceIp.toString().split("\\/");
//            ip = ips[1];
//        } catch (UnknownHostException e1) {
//            // TODO Auto-generated catch block
//            // Uncomment and replace with appropriate logger
//            // LOGGER.error(e1, e1);
//        }
//        ///// End of block getting system Ip
        
        
     ///creating session json request
        JSONObject jsonObjectReq = new JSONObject();
        Map<String, String> mapp = new HashMap<>();
        mapp.put("ClientIp", ip);
        JSONArray Details = new JSONArray();
        Details.add(mapp);
        jsonObjectReq.put("Details", Details);
        jsonObjectReq.put("BlackBox","XYZ");
        System.out.println("JSON file created: "+jsonObjectReq);    
        /////// End of session json request
      
      
        
        //Extract session ID
        JSONParser parser = new JSONParser();
        try {
            Object obj = parser.parse(new FileReader("C:/Users/Peter/Desktop/TucoopJava/session.json"));
            JSONObject jsonObject = (JSONObject) obj;
            String session = (String) jsonObject.get("SessionId");
            System.out.println("SessionId: " + session);

        } catch (Exception e) {
            e.printStackTrace();
        }
        //End of Extract session ID
        
    }

}
