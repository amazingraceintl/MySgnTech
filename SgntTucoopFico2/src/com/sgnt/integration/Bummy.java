package com.sgnt.integration;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
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
public class Bummy {
    /**
     * @param args
     * @throws KeyStoreException 
     * @throws CertificateException 
     * @throws NoSuchAlgorithmException 
     * @throws UnrecoverableKeyException 
     * @throws KeyManagementException 
     * @throws Exception
     */
    public static void main(String[] args) throws IOException, KeyStoreException, NoSuchAlgorithmException, CertificateException, UnrecoverableKeyException, KeyManagementException {
        String res;
        String inputLine;
        //String t24data = "<?xml version='1.0' encoding='UTF-8'?>\r\n<creditBureau xmlns=\"http://www.transunion.com/namespace\" xsi:schemaLocation=\"http://www.transunion.com/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\">\r\n\t<version>2.40</version>\r\n\t<document>request</document>\r\n\t<transactionControl>\r\n\t\t<userRefNumber/>\r\n\t\t<subscriber>\r\n\t\t\t<industryCode>Q</industryCode>\r\n\t\t\t<memberCode>4883343</memberCode>\r\n\t\t\t<inquirySubscriberPrefixCode>0622</inquirySubscriberPrefixCode>\r\n\t\t\t<password>J2SP</password>\r\n\t\t</subscriber>\r\n\t\t<options>\r\n\t\t<processingEnvironment>standardTest</processingEnvironment>\r\n\t\t\t<country>us</country>\r\n\t\t\t<language>en</language>\r\n\t\t</options>\r\n\t</transactionControl>\r\n\t<product>\r\n\t\t<code>07000</code>\r\n\t\t<subject>\r\n\t\t\t<number>1</number>\r\n\t\t\t<subjectRecord>\r\n\t\t\t\t<indicative>\r\n\t\t\t\t\t<name>\r\n\t\t\t\t\t\t<person>\r\n\t\t\t\t\t\t\t<first>JANET</first>\r\n\t\t\t\t\t\t\t<middle></middle>\r\n\t\t\t\t\t\t\t<last>BUSCH</last>\r\n\t\t\t\t\t\t</person>\r\n\t\t\t\t\t</name>\r\n\t\t\t\t\t<address>\r\n\t\t\t\t\t\t<status>current</status>\r\n\t\t\t\t\t\t<street>\r\n\t\t\t\t\t\t\t<unparsed>4227 N 27TH AV</unparsed>\r\n\t\t\t\t\t\t</street>\r\n\t\t\t\t\t\t<location>\r\n\t\t\t\t\t\t\t<city>PHOENIX</city>\r\n\t\t\t\t\t\t\t<state>AZ</state>\r\n\t\t\t\t\t\t\t<zipCode>85017</zipCode>\r\n\t\t\t\t\t\t</location>\r\n\t\t\t\t\t</address>\r\n\t\t\t\t\t<socialSecurity>\r\n\t\t\t\t\t\t<number>666822043</number>\r\n\t\t\t\t\t</socialSecurity>\r\n\t\t\t\t\t<dateOfBirth/>\r\n\t\t\t\t</indicative>\r\n\t\t\t</subjectRecord>\r\n\t\t</subject>\r\n\t\t<responseInstructions>\r\n\t\t\t<returnErrorText>true</returnErrorText>\r\n\t\t\t<document/>\r\n\t\t</responseInstructions>\r\n\t\t<permissiblePurpose>\r\n\t\t\t<inquiryECOADesignator>individual</inquiryECOADesignator>\r\n\t\t</permissiblePurpose>\r\n\t</product>\r\n</creditBureau>";
String t24data = "<?xml version='1.0' encoding='UTF-8'?><xmlrequest xmlns=\"http://www.transunion.com/namespace\" xsi:schemaLocation=\"http://www.transunion.com/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><systemId>COOPER15</systemId><systemPassword>TuC00p25</systemPassword><productrequest><creditBureau xmlns=\"http://www.transunion.com/namespace\"><version>2.40</version><document>request</document><transactionControl><userRefNumber/><subscriber><industryCode>Q</industryCode><memberCode>4883343</memberCode><inquirySubscriberPrefixCode>0622</inquirySubscriberPrefixCode><password>J2SP</password></subscriber><options><processingEnvironment>standardTest</processingEnvironment><country>us</country><language>en</language></options></transactionControl><product><code>07000</code><subject><number>1</number><subjectRecord><indicative><name><person><first>JANET</first><middle></middle><last>BUSCH</last></person></name><address><status>current</status><street><unparsed>4227 N 27TH AV</unparsed></street><location><city>PHOENIX</city><state>AZ</state><zipCode>85017</zipCode></location></address><socialSecurity><number>666822043</number></socialSecurity><dateOfBirth/></indicative></subjectRecord></subject><responseInstructions><returnErrorText>true</returnErrorText><document/></responseInstructions><permissiblePurpose><inquiryECOADesignator>individual</inquiryECOADesignator></permissiblePurpose></product></creditBureau>";
        System.setProperty("javax.net.ssl.trustStore", "tucoop.keystore");
        System.setProperty("javax.net.ssl.trustStorePassword", "TuC00p25");
       // KeyStore ks = KeyStore.getInstance("PKCS12");
        
        KeyStore ks = KeyStore.getInstance("JKS");
        FileInputStream fis = new FileInputStream("COOPER15_SHA2.p12");
        ks.load(fis, "TuC00p25".toCharArray());
       KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
        //KeyManagerFactory kmf = KeyManagerFactory.getInstance("X.509");
        kmf.init(ks, "TuC00p25".toCharArray());
        SSLContext sc = SSLContext.getInstance("TLS");
        sc.init(kmf.getKeyManagers(), null, null);
 
        try {
            URL url = new URL("https://netaccess-test.transunion.com");
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            if (connection instanceof HttpsURLConnection) {
                ((HttpsURLConnection) connection).setSSLSocketFactory(sc.getSocketFactory());
            }
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "text/xml");
            connection.setDoOutput(true);
            
            
            DataOutputStream wr = new DataOutputStream(connection.getOutputStream());
            wr.writeBytes(t24data.toString());
            wr.flush();
            wr.close();
            String responseStatus = connection.getResponseMessage().toString();
            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            StringBuffer response = new StringBuffer();

            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            res = response.toString();
            System.out.println("I got this " + res);
            
//            PrintStream ps = null;
//            BufferedReader br = null; String line;
//            String response;
//            ps = new PrintStream(connection.getOutputStream());
//            ps.print(t24data);
//            ps.close();
//            br = new BufferedReader(new InputStreamReader(connection.getInputStream(), StandardCharsets.UTF_8));
//            StringBuilder sb = new StringBuilder();
//            if (br == null) {
//          
//                line = null;
//            } else {
//                while ((line = br.readLine()) != null) {
//                    sb.append(line);
//                    sb.append("\n");
//                }
//
//                br.close();
//                response = sb.toString();   
//                System.out.println("final result is..."+response);
//            }
            ///////

        } catch (Exception var20) {
            System.out.println(var20);
        }  
        }    
    }