package com.temenos.sgntech;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


/**
 * TODO: Document me!
 *
 * @author Peter
 *
 */
public class EntryPoint {

    @SuppressWarnings("deprecation")
    public String sgtransUnion(String Inputs) throws IOException {

        EntryPoint Innercalls = new EntryPoint();
        String mytimestamp;
        final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        System.out.println("Start Time ==== " + timestamp);
        String[] tempm = sdf2.format(timestamp).toString().toString().split("\\+");
        mytimestamp = (tempm[0] + "Z");

        System.out.println("what...................................."+Inputs);
//        String[] temp = Inputs.split("\\^");
//        String usern = temp[0].toString();
//        String psswd = temp[1].toString();
//        String secret = temp[2].toString();
//        String url = temp[3].toString();
//        String url_case = temp[4].toString();
//        String urltk = temp[5].toString();
//        String Ddcurl = temp[6].toString();
//        String Pkey = temp[7].toString();
//        String Add1 = temp[8].toString();
//        String Add2 = temp[9].toString();
//        String Add3 = temp[10].toString();
//        String city = temp[11].toString();
//        String Countrycode = temp[12].toString();
//        String Fname = temp[13].toString();
//        String Lname = temp[14].toString();
//        String postcode = temp[15].toString();
//        String State = temp[16].toString();
//        String ssn = temp[17].toString();
//        String dob = temp[18].toString();

         String usern = "";
         String psswd = "";
         String secret ="";
         String url = "";
         String url_case = "";
         String urltk = "";
         String Ddcurl ="";
         String Pkey = "";
         String Add1 = "";
         String Add2 = "";
         String Add3 = "";
         String city = "";
         String Countrycode ="";
         String Fname ="";
         String Lname ="";
         String postcode ="";
         String State ="";
         String ssn = "";
         String dob = "";

        System.out.println("I am here also");

        // URL obj = new URL(url);

        // String usern = "Cooperativa_Ahorro_y_Credito_TestSite";
        // String psswd = "830058098b40451d8ccb366a3c88a372";
        // String secret = "ae9361c550484a838ca5b6ef0c578488";

        // String url = "https://app.trustev.com/api/v2.0/session";
        // String url_case = "https://app.trustev.com/api/v2.0/case";
        // String urltk = "https://app.trustev.com/api/v2.0/token";
        // String Ddcurl = "https://app.trustev.com/api/v2.1/detaileddecision/";
        // String Pkey = "4448edc64c334237b402bc2656953dad";
        // String Username = "Cooperativa_Ahorro_y_Credito_TestSite";
        // String Psswd = "830058098b40451d8ccb366a3c88a372";
        //
        // String Add1 = "1600 PARK PLACE";
        // String city = "ATLANTA";
        // String Countrycode = "US";
        // String Fname = "PATRICK";
        //
        // String Lname = "TESTP";
        // String postcode = "30326";
        // String State = "GA";
        // String type = "0";
        // String ssn = "666010016";
        // String dob = "4/30/1972";

        String ttkey = null;
        String PIDcall = null;
        String GenTokenID = null;
        String BlackBox = "XYZ";
        String res;
        String type = "0";
        String GeneratedCaseID = null;
        String Id_response = null;
        String result_response = null;
        String sessionID = null;
        String caseNo = null;
        String ctoken = null;
        String actionP = "POST";
        String actionG = "GET";
        String sessionFlag = "false";
        String Isdft = "true";

        // System.out.println("temp = "+ temp);
        System.out.println("usern = " + usern);
        System.out.println("psswd = " + psswd);
        System.out.println("secret =" + secret);
        System.out.println("url =" + url);
        System.out.println("url_case= " + url_case);
        System.out.println("urltk =" + urltk);
        System.out.println("Ddcurl =" + Ddcurl);
        System.out.println("Pkey = " + Pkey);
        System.out.println("Add1 = " + Add1);
        System.out.println("Add2 =" + Add2);
        System.out.println("Add3 = " + Add3);
        System.out.println("city = " + city);
        System.out.println("Countrycode=" + Countrycode);
        System.out.println("Fname = " + Fname);
        System.out.println("Lname = " + Lname);
        System.out.println("postcode=" + postcode);
        System.out.println("State =" + State);
        System.out.println("ssn =" + ssn);
        System.out.println("dob = " + dob);

        System.out.println("I REACH HERE O ....");
        
    
        JSONObject jsonObjectReq = new JSONObject();
        Map<String, String> mapp = new HashMap<>();
        mapp.put("ClientIp", "185.107.57.7");
        System.out.println("I REACH HERE O 1 ....");
        JSONArray Details = new JSONArray();
        Details.add(mapp);
        jsonObjectReq.put("Details", Details);
        jsonObjectReq.put("BlackBox", BlackBox);
        String xml = jsonObjectReq.toString();

        System.out.println("I REACH HERE22 O ....");
        String transuconnector = Innercalls.TransUconnector(Pkey, xml, url, "", actionP);
        JsonParser jsonParser = new JsonParser();
        JsonElement jsonTree = jsonParser.parse(transuconnector);
        if (jsonTree.isJsonObject()) {
            JsonObject jsonObject = jsonTree.getAsJsonObject();
            JsonElement SessnId = jsonObject.get("SessionId");
            if (SessnId != null) {
                sessionFlag = "true";
                sessionID = SessnId.toString();
                sessionID = sessionID.substring(1, sessionID.length() - 1);

                System.out.println("SessionId ==....." + sessionID);
            }
        }

        System.out.println("I REACH HERE 3000 ....");
        if (sessionFlag.equals("true")) {
            String HashResult = Innercalls.HashGenerator(mytimestamp, usern, psswd, secret);
            String[] Tquery = HashResult.toString().split("\\|");
            String Ttsamp = Tquery[0];
            String Husrname = Tquery[1];
            String Hpass = Tquery[2];
            ttkey = Innercalls.PostToken(usern, Ttsamp, Husrname, Hpass); // tokenreqformation
            String Tokencaller = Innercalls.TransUconnector("", ttkey, urltk, "", actionP); // TokenApicall
            JsonElement TokenjsonTree = jsonParser.parse(Tokencaller);
            if (TokenjsonTree.isJsonObject()) {
                JsonObject TokenjsonObject = TokenjsonTree.getAsJsonObject();
                JsonElement Tokenid = TokenjsonObject.get("APIToken");
                GenTokenID = Tokenid.toString();
                System.out.println("Generated token = " + GenTokenID);
            }
            if (!GenTokenID.isEmpty()) {
                final String uuid = UUID.randomUUID().toString().replace("-", "");
                System.out.println("uuid = " + uuid);
                caseNo = uuid;
                PIDcall = Innercalls.PostIDverification(caseNo, sessionID, Add1, Add2, Add3, city, Countrycode, Fname,
                        Isdft, Lname, postcode, State, type, ssn, dob);
                ctoken = GenTokenID.substring(1, GenTokenID.length() - 1);
                ctoken = usern + " " + ctoken;
                String IDcaller = Innercalls.TransUconnector("", PIDcall, url_case, ctoken, actionP);
                System.out.println("ID-Verify-response is " + IDcaller);
                GeneratedCaseID = IDcaller;

                JsonElement IdjsonTree = jsonParser.parse(IDcaller);
                if (IdjsonTree.isJsonObject()) {
                    JsonObject IdjsonObject = IdjsonTree.getAsJsonObject();
                    JsonElement Idc = IdjsonObject.get("Id");
                    Id_response = Idc.toString();
                    Id_response = Id_response.substring(1, Id_response.length() - 1);
                    System.out.println("Generated token Full response  = " + GenTokenID);
                    System.out.println("Generated token = " + Id_response);
                }
            }
            if (!GeneratedCaseID.isEmpty()) {
                // ctoken
                String ddcurl = Ddcurl + "?caseid=" + Id_response;
                System.out.println(ddcurl);
                String usrFinaldcs = Innercalls.TransUconnector("", "NIL", ddcurl, ctoken, actionG);
                System.out.println("Final Result is... " + usrFinaldcs);

                JsonElement ResIdjsonTree = jsonParser.parse(usrFinaldcs);
                if (ResIdjsonTree.isJsonObject()) {
                    JsonObject ResIdjsonObject = ResIdjsonTree.getAsJsonObject();
                    JsonElement Id_result = ResIdjsonObject.get("Result");
                    result_response = Id_result.toString();
                    System.out.println("Final Result is ... " + result_response);
                }
            }

        }
        System.out.println("End Time ==== " + timestamp);

        return "";
    }

    public String PostToken(String Usernam, String Ttamp, String HUsername, String HPsswd) {
        // creating simple request, creating token request
        Map<Object, Object> tokenreqMap = new HashMap<Object, Object>();
        JSONObject tokenreq_jsonObj;
        tokenreqMap.put("UserName", Usernam);
        tokenreqMap.put("Timestamp", Ttamp);
        tokenreqMap.put("PasswordHash", HPsswd);
        tokenreqMap.put("UserNameHash", HUsername);
        tokenreq_jsonObj = new JSONObject(tokenreqMap);
        System.out.println(tokenreq_jsonObj);
        String tokenkey = tokenreq_jsonObj.toString();
        return tokenkey;
    }

    public String PostIDverification(String CaseNumber, String SessionId, String Address1, String Address2,
            String Address3, String City, String CountryCode, String FirstName, String IsDefault, String LastName,
            String PostalCode, String State, String Type, String SocialSecurityNumber, String DateOfBirth) {
        String id_data = null;
        JSONObject jsonObjectReq = new JSONObject();
        JSONObject OuterjsonObjectReq = new JSONObject();
        Map<String, String> mapp = new HashMap<>();
        OuterjsonObjectReq.put("CaseNumber", CaseNumber);
        OuterjsonObjectReq.put("SessionId", SessionId);
        mapp.put("Address1", Address1);
        mapp.put("Address2", Address2);
        mapp.put("Address3", Address3);
        mapp.put("City", City);
        mapp.put("CountryCode", CountryCode);
        mapp.put("FirstName", FirstName);
        mapp.put("IsDefault", IsDefault);
        mapp.put("LastName", LastName);
        mapp.put("PostalCode", PostalCode);
        mapp.put("State", State);
        mapp.put("Type", Type);

        JSONArray Addresses = new JSONArray();
        Addresses.add(mapp);
        jsonObjectReq.put("Addresses", Addresses);
        OuterjsonObjectReq.put("Customer", jsonObjectReq);
        jsonObjectReq.put("FirstName", FirstName);
        jsonObjectReq.put("LastName", LastName);
        jsonObjectReq.put("SocialSecurityNumber", SocialSecurityNumber);
        jsonObjectReq.put("DateOfBirth", DateOfBirth);
        System.out.println("JSON file created: " + OuterjsonObjectReq.toString().replace("\\/", "/"));

        return OuterjsonObjectReq.toString().replace("\\/", "/");
    }

    public String HashGenerator(String mytimestamp1, String usern, String psswd, String secret) {

        String username = null;
        String Nusername = null;
        String username1 = null;
        String Nusername1 = null;
        String USERname = null;
        String PASSword = null;
        String Newinput;
        String input;
        String Newinput1;
        String input1;
     
        String[] var = new String[3];
        StringBuilder UhexString = new StringBuilder();
        StringBuilder PhexString = new StringBuilder();
        StringBuilder UhexString1 = new StringBuilder();
        StringBuilder PhexString1 = new StringBuilder();

        var[0] = usern;
        var[1] = psswd;
        var[2] = secret;
        MessageDigest md = null;
        MessageDigest mdn = null;
        MessageDigest md1 = null;
        MessageDigest mdn1 = null;

        String Variable = mytimestamp1 + "." + var[0].toString();
        try {
            input = Variable;
            md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(input.getBytes());
            for (byte b : hash) {
                UhexString.append(String.format("%02x", b));
                username = UhexString.toString();
            }
        } catch (NoSuchAlgorithmException e1) {
        }
        try {
            Newinput = username + "." + var[2];
            mdn = MessageDigest.getInstance("SHA-256");
            byte[] nhash = mdn.digest(Newinput.getBytes());
            for (byte c : nhash) {
                PhexString.append(String.format("%02x", c));
                Nusername = PhexString.toString();
            }
        } catch (NoSuchAlgorithmException e2) {
        }

        String Variable1 = mytimestamp1 + "." + var[1].toString();
        try {
            input1 = Variable1;
            md1 = MessageDigest.getInstance("SHA-256");
            byte[] hash1 = md1.digest(input1.getBytes());
            for (byte d : hash1) {
                UhexString1.append(String.format("%02x", d));
                username1 = UhexString1.toString();
            }
        } catch (NoSuchAlgorithmException e3) {
        }
        try {
            Newinput1 = username1 + "." + var[2];
            mdn1 = MessageDigest.getInstance("SHA-256");
            byte[] nhash = mdn1.digest(Newinput1.getBytes());
            for (byte f : nhash) {
                PhexString1.append(String.format("%02x", f));
                Nusername1 = PhexString1.toString();
            }
        } catch (NoSuchAlgorithmException e2) {
        }
        return mytimestamp1 + "|" + Nusername + "|" + Nusername1;
    }
    
    private String TransUconnector(String pkey, String reqs, String url, String token, String action) throws IOException{
        String readLine = null;
        System.out.println(action);
        URL obj = new URL(url);
        String res = null;
        HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        con.setRequestMethod(action);
        con.setRequestProperty("Content-Type", "application/json");
        con.setRequestProperty("X-PublicKey", pkey);
        con.setRequestProperty("Host", "app.trustev.com");
        con.setRequestProperty("User-Agent", "Apache-HttpClient/4.5.5 (Java/16.0.1)");
        con.setRequestProperty("X-Authorization", token);
        con.setRequestProperty("charset", "utf-8");
        con.setRequestProperty("Connection", "Keep-Alive");
        con.setRequestProperty("Accept-Encoding", "gzip,deflate");

        if (reqs == "NIL") {
            int responseCode = con.getResponseCode();

            System.out.println(responseCode);
            System.out.println(con.getContent());
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                StringBuffer response = new StringBuffer();
                while ((readLine = in.readLine()) != null) {
                    response.append(readLine);
                }
                in.close();
                System.out.println("JSON String Result " + response.toString());
                res = response.toString();
            } else {
                System.out.println("GET NOT WORKED");
            }
        } else 
        {
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(reqs);
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
            res = response.toString();
        }

        JsonParser jsonParser = new JsonParser();
        JsonElement jsonTree = jsonParser.parse(res);

        return res;
    }
    }


