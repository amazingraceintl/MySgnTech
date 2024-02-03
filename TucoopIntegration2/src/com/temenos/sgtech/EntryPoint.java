package com.temenos.sgtech;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
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
    public EntryPoint() {
        // TODO Auto-generated constructor stub
    }

    @SuppressWarnings({ "deprecation", "unchecked" })
    public String Sender(String incoming) throws IOException {
        String ip = null;
        String ClientIp = null;

        try {
            Object DeviceIp = InetAddress.getLocalHost();
            String[] ips = DeviceIp.toString().split("\\/");
            ip = ips[1];
            System.out.println("SYSTEM DEFAULT Ip is ...." + ip);
        } catch (UnknownHostException e1) {
        }

        EntryPoint Innercalls = new EntryPoint();
        String mytimestamp;
        final SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        System.out.println("Processing Start Time ==== " + timestamp);
                
        String[] tempm = sdf2.format(timestamp).toString().toString().split("\\+");
         mytimestamp = (tempm[0] + "Z");
        System.out.println("mytimestamp IS  = " + mytimestamp);

        String[] InputdataXtra = incoming.split("\\^");
        String usern = InputdataXtra[0].toString();
        String psswd = InputdataXtra[1].toString();
        String secret = InputdataXtra[2].toString();
        String url = InputdataXtra[3].toString();
        String url_case = InputdataXtra[4].toString();
        String urltk = InputdataXtra[5].toString();
        String Ddcurl = InputdataXtra[6].toString();
        String Pkey = InputdataXtra[7].toString();
        String Add1 = InputdataXtra[8].toString();
        String Add2 = InputdataXtra[9].toString();
        String Add3 = InputdataXtra[10].toString();
        String city = InputdataXtra[11].toString();
        String Countrycode = InputdataXtra[12].toString();
        String Fname = InputdataXtra[13].toString();
        String Lname = InputdataXtra[14].toString();
        String postcode = InputdataXtra[15].toString();
        String State = InputdataXtra[16].toString();
        String ssn = InputdataXtra[17].toString();
        String dob = InputdataXtra[18].toString();
        String blkbox = InputdataXtra[19].toString();
        String ipaddD = InputdataXtra[20].toString();

        System.out.println("I GET here o");
        String ttkey = null;
        String PIDcall = null;
        String GenTokenID = null;
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

        ClientIp = ipaddD;
        if (ipaddD.startsWith("0")) {
            ClientIp = ip;
        }

        String xml = "{\"Details\": [{\"ClientIp\": \" " + ClientIp + "\"}],\"BlackBox\": \" " + blkbox + " \" }";
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
            }
        }
       // System.out.println("SessionId = "+sessionID);

        if (sessionFlag.equals("true")) {
            String HashResult = Innercalls.HashGenerator(mytimestamp, usern, psswd, secret);
            String[] Tquery = HashResult.toString().split("\\|");
            String Ttsamp = Tquery[0];
            String Husrname = Tquery[1];
            String Hpass = Tquery[2];
            ttkey = "{\"UserNameHash\": \"" + Husrname + "\",\"UserName\": \"" + usern + "\",\"PasswordHash\": \""
                    + Hpass + "\",\"Timestamp\": \"" + Ttsamp + "\"}";
            String Tokencaller = Innercalls.TransUconnector("", ttkey, urltk, "", actionP); // TokenApicall
            JsonElement TokenjsonTree = jsonParser.parse(Tokencaller);
            if (TokenjsonTree.isJsonObject()) {
                JsonObject TokenjsonObject = TokenjsonTree.getAsJsonObject();
                JsonElement Tokenid = TokenjsonObject.get("APIToken");
                GenTokenID = Tokenid.toString();
               // System.out.println("GenTokenID = "+GenTokenID);
            }
            if (!GenTokenID.isEmpty()) {
                final String uuid = UUID.randomUUID().toString().replace("-", "");
                caseNo = uuid;
                PIDcall = "{\"Customer\": {\"Addresses\": [{\"IsDefault\": \"" + Isdft + "\",\"Type\": \"" + type
                        + "\",\"FirstName\": \"" + Fname + "\",\"State\": \"" + State + "\",\"Address2\": \"" + Add2
                        + "\",\"Address3\": \"" + Add3 + "\",\"PostalCode\": \"" + postcode + "\",\"Address1\": \""
                        + Add1 + "\",\"City\": \"" + city + "\",\"LastName\": \"" + Lname + "\",\"CountryCode\": \""
                        + Countrycode + "\"}],\"DateOfBirth\": \"" + dob + "\",\"SocialSecurityNumber\": \"" + ssn
                        + "\",\"FirstName\": \"" + Fname + "\",\"LastName\": \"" + Lname + "\"},\"CaseNumber\": \""
                        + caseNo + "\",\"SessionId\": \"" + sessionID + "\"}";
                ctoken = GenTokenID.substring(1, GenTokenID.length() - 1);
                ctoken = usern + " " + ctoken;
                
                //System.out.println("OutgoingReq1 ="+PIDcall);
                //System.out.println("ctokennn ="+ctoken);
                String IDcaller = Innercalls.TransUconnector("", PIDcall, url_case, ctoken, actionP);
                GeneratedCaseID = IDcaller;

                JsonElement IdjsonTree = jsonParser.parse(IDcaller);
                if (IdjsonTree.isJsonObject()) {
                    JsonObject IdjsonObject = IdjsonTree.getAsJsonObject();
                    JsonElement Idc = IdjsonObject.get("Id");
                    Id_response = Idc.toString();
                    Id_response = Id_response.substring(1, Id_response.length() - 1);
                }
            }
            if (!GeneratedCaseID.isEmpty()) {
                // ctoken
                String ddcurl = Ddcurl + "?caseid=" + Id_response;
                String usrFinaldcs = Innercalls.TransUconnector("", "NIL", ddcurl, ctoken, actionG);

                JsonElement ResIdjsonTree = jsonParser.parse(usrFinaldcs);
                if (ResIdjsonTree.isJsonObject()) {
                    JsonObject ResIdjsonObject = ResIdjsonTree.getAsJsonObject();
                    JsonElement Id_result = ResIdjsonObject.get("Result");
                    result_response = Id_result.toString();
                }
            }

        }
        System.out.println("Processing End Time ==== " + timestamp);
        return result_response;

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
        //System.out.println(mytimestamp1 + "|" + Nusername + "|" + Nusername1);
        return mytimestamp1 + "|" + Nusername + "|" + Nusername1;
    }

    private String TransUconnector(String pkey, String reqs, String url, String token, String action)
            throws IOException {
        String readLine = null;
        String res = null;
        try {
            URL obj = new URL(url);
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
                if (responseCode == HttpURLConnection.HTTP_OK) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
                    StringBuffer response = new StringBuffer();
                    while ((readLine = in.readLine()) != null) {
                        response.append(readLine);
                    }
                    in.close();
                    res = response.toString();

                } else {
                    System.out.println("GET NOT WORKED");
                }
            } else {
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

        } catch (IOException e) {
            System.out.println("An I/O error occurs: " + e.getMessage());
        }

        JsonParser jsonParser = new JsonParser();
        JsonElement jsonTree = jsonParser.parse(res);

        return res;
    }

}
