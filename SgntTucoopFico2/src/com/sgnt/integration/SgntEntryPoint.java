package com.sgnt.integration;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.KeyManagementException;
import java.security.KeyStore;
import java.security.KeyStoreException;
import java.security.NoSuchAlgorithmException;
import java.security.UnrecoverableKeyException;
import java.security.cert.CertificateException;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;

/**
 * TODO: Document me!
 *
 * @author Peter
 *
 */
public class SgntEntryPoint {
    public SgntEntryPoint() {
        // TODO Auto-generated constructor stub
    }

    public String Sender(String incoming) throws IOException, KeyStoreException, UnrecoverableKeyException,
            NoSuchAlgorithmException, CertificateException, KeyManagementException {

        String res;  String inputLine;
        System.setProperty("javax.net.ssl.trustStore", "tucoop.keystore");
        System.setProperty("javax.net.ssl.trustStorePassword", "TuC00p25");
        
        String[] InputdataXtra = incoming.split("\\^");
        String Endpoint = InputdataXtra[0].toString();
        String t24data = InputdataXtra[1].toString();
        String certPath = InputdataXtra[2].toString();
       
        System.out.println("I got this1 " + Endpoint);
        System.out.println("I got this2 " + t24data);       
        KeyStore ks = KeyStore.getInstance("PKCS12");
        FileInputStream fis = new FileInputStream("C:/Users/Peter/Music/COOPER15_SHA2.p12"); 
        ks.load(fis, "TuC00p25".toCharArray());
        KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
        kmf.init(ks, "TuC00p25".toCharArray());
        SSLContext sc = SSLContext.getInstance("TLS");
        sc.init(kmf.getKeyManagers(), null, null);

        try {
             URL url = new URL(Endpoint);
            // URL url = new URL("https://netaccess-test.transunion.com");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            if (connection instanceof HttpsURLConnection) {
                ((HttpsURLConnection) connection).setSSLSocketFactory(sc.getSocketFactory());
            }
            
            System.out.println("I got this...5");
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "text/xml");
            System.out.println("I got this...65");
           // connection.setRequestProperty("charset", "utf-8");
            connection.setRequestProperty("Connection", "Keep-Alive");
            connection.setDoOutput(true);
            System.out.println("I got this...66");   
            DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
            wr.writeBytes(t24data);  
            wr.flush();
            wr.close();
            String responseStatus = connection.getResponseMessage().toString();
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuffer response = new StringBuffer();
            
            System.out.println("I got this...6");
          System.out.println("I got this res code :"+responseStatus);

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            res = response.toString();
            System.out.println("I got this " + res);
        } catch (IOException e) {
            System.out.println("An I/O error occurs: " + e.getMessage());
        }
        return incoming;
    }
}

       