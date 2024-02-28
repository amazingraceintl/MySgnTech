package com.temenos.sgntech;
import com.temenos.tafj.common.jSession;
import com.temenos.tafj.common.jVar;
import com.temenos.tafj.runtime.jRunTime;
import com.temenos.tafj.runtime.extension.BasicReplacement;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.KeyManager;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import org.apache.commons.lang3.StringEscapeUtils;

/**
 * TODO: Document me!
 *
 * @author Peter
 *
 */
public class HttpClient extends BasicReplacement{
    private static final String className = HttpClient.class.getName();

    public jVar invoke(Object... arg0) {
       String request = String.valueOf(arg0[0]);
       String result = processRequest(request);
       ((jVar)arg0[1]).set(result);
       return null;
    }

    public static void main(String[] args) {
       String payload = "<?xml version=\"1.0\"?><creditBureau xmlns=\"http://www.transunion.com/namespace\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"><document>request</document><version>2.8</version><transactionControl><userRefNumber>20999</userRefNumber><subscriber><industryCode>Q</industryCode><memberCode>4883343</memberCode><inquirySubscriberPrefixCode>0622</inquirySubscriberPrefixCode><password>J2SP</password></subscriber><options><processingEnvironment>standardTest</processingEnvironment><country>us</country><language>en</language><contractualRelationship>individual</contractualRelationship><pointOfSaleIndicator>none</pointOfSaleIndicator></options></transactionControl><product><code>07000</code><subject><number>1</number><subjectRecord><indicative><name><person><first>ZELNINO</first><middle>XX</middle><last>WINTER</last></person></name><address><status>current</status><street><number>760</number><name>SPROUL</name><preDirectional>W</preDirectional><type>RD</type></street><location><city>FANTASY ISLAND</city><state>IL</state><zipCode>60750</zipCode></location></address><socialSecurity><number>666125812</number></socialSecurity><dateOfBirth>1967-04-17</dateOfBirth></indicative><addOnProduct><code>00Q88</code><scoreModelProduct>true</scoreModelProduct></addOnProduct></subjectRecord></subject><responseInstructions><returnErrorText>true</returnErrorText><document/></responseInstructions><permissiblePurpose><inquiryECOADesignator>individual</inquiryECOADesignator></permissiblePurpose></product></creditBureau> ";
       String request = "endPoint*http://localhost:8180|connectionTimeout*120|sessionTimeout*180|headers*Content-Type: application/xml|payload*" + payload + "|requestType*postRequest";
       String result = processRequest(request);
       
       String userRefNumber = null;
       String memberCode = null;
       String Test = "<?xml version=1.0?><creditBureau xmlns=http://www.transunion.com/namespace xmlns:xsi=http://www.w3.org/2001/XMLSchema-instance><document>request</document><version>2.8</version><transactionControl><userRefNumber>"+userRefNumber+"</userRefNumber><subscriber><industryCode>Q</industryCode><memberCode>"+memberCode+"</memberCode><inquirySubscriberPrefixCode>0622</inquirySubscriberPrefixCode><password>J2SP</password></subscriber><options><processingEnvironment>standardTest</processingEnvironment><country>us</country><language>en</language><contractualRelationship>individual</contractualRelationship><pointOfSaleIndicator>none</pointOfSaleIndicator></options></transactionControl><product><code>07000</code><subject><number>1</number><subjectRecord><indicative><name><person><first>ZELNINO</first><middle>XX</middle><last>WINTER</last></person></name><address><status>current</status><street><number>760</number><name>SPROUL</name><preDirectional>W</preDirectional><type>RD</type></street><location><city>FANTASY ISLAND</city><state>IL</state><zipCode>60750</zipCode></location></address><socialSecurity><number>666125812</number></socialSecurity><dateOfBirth>1967-04-17</dateOfBirth></indicative><addOnProduct><code>00Q88</code><scoreModelProduct>true</scoreModelProduct></addOnProduct></subjectRecord></subject><responseInstructions><returnErrorText>true</returnErrorText><document/></responseInstructions><permissiblePurpose><inquiryECOADesignator>individual</inquiryECOADesignator></permissiblePurpose></product></creditBureau>";
    }

    private static String processRequest(String data) {
       String[] arr1 = data.split("\\|");
       Map<String, String> map = new HashMap();
       String result;
       if (arr1.length > 0) {
          String[] var6 = arr1;
          int var5 = arr1.length;

          for(int var4 = 0; var4 < var5; ++var4) {
             result = var6[var4];
             String[] arr2 = result.split("\\*");
             if (arr2.length == 2) {
                map.put(arr2[0], arr2[1]);
             }
          }
       }

       if (map.size() == 0) {
          return "05|Invalid number of parameter";
       } else {
          result = "";
          Object obj = map.get("requestType");
          if (obj == null) {
             return "05|Invalid request type";
          } else {
             String requestType = obj.toString();
             switch(requestType.hashCode()) {
             case -2108200547:
                if (!requestType.equals("getISODate")) {
                   return "05|Unsupported request type";
                }

                result = getISODate();
                break;
             case 1630797263:
                if (!requestType.equals("postRequest")) {
                   return "05|Unsupported request type";
                }

                result = postRequest(map);
                break;
             case 2008721394:
                if (!requestType.equals("escapeString")) {
                   return "05|Unsupported request type";
                }

                result = escapeString(map);
                break;
             case 2132553305:
                if (requestType.equals("getRequest")) {
                   result = getRequest(map);
                   break;
                }

                return "05|Unsupported request type";
             default:
                return "05|Unsupported request type";
             }

             return result;
          }
       }
    }

    private static synchronized String getRequest(Map<String, String> map) {
       String statusCode = "05";
       String statusMsg = "Generic Error 01";
       String obj = null;
       HttpURLConnection con = null;
       InputStream in = null;
       BufferedReader bf = null;

       String result;
       label479: {
          String var18;
          try {
             String headers;
             try {
                allowCerts();
                obj = (String)map.get("endPoint");
                if (obj == null) {
                   throw new Exception("EndPoint not set");
                }

                result = obj;
                obj = (String)map.get("connectionTimeout");
                if (obj == null) {
                   throw new Exception("Connection Timeout not set");
                }

                int connectionTimeout = Integer.parseInt(obj);
                obj = (String)map.get("headers");
                if (obj == null) {
                   throw new Exception("HTTP Headers not set");
                }

                headers = obj;
                obj = (String)map.get("payload");
                URL url = new URL(result);
                con = result.startsWith("http") ? (HttpURLConnection)url.openConnection() : (HttpsURLConnection)url.openConnection();
                ((HttpURLConnection)con).setDoOutput(true);
                ((HttpURLConnection)con).setRequestMethod("GET");
                String[] arr = headers.split("\\^");
                if (arr.length > 0) {
                   String[] var15 = arr;
                   int var14 = arr.length;

                   for(int var13 = 0; var13 < var14; ++var13) {
                      String s = var15[var13];
                      String[] arr2 = s.split("\\:");
                      if (arr2.length > 0) {
                         ((HttpURLConnection)con).setRequestProperty(arr2[0], arr2[1]);
                      }
                   }
                }

                ((HttpURLConnection)con).setConnectTimeout(connectionTimeout);
                ((HttpURLConnection)con).setDoOutput(true);
                ((HttpURLConnection)con).connect();
                int rescode = ((HttpURLConnection)con).getResponseCode();
                if (rescode == 200) {
                   in = ((HttpURLConnection)con).getInputStream();
                   if (in == null) {
                      in = ((HttpURLConnection)con).getErrorStream();
                   }

                   bf = new BufferedReader(new InputStreamReader(in));
                   StringBuilder sb = new StringBuilder();

                   String line;
                   while((line = bf.readLine()) != null) {
                      sb.append(line);
                   }

                   statusCode = "00";
                   statusMsg = sb.toString();
                   break label479;
                }

                String errstr = rescode + "|Http Request Failed status code";
                System.out.println(errstr);
                var18 = errstr;
                return var18;
             } catch (MalformedURLException var59) {
                statusMsg = String.format("%s:%s", "MalformedURLException: ", var59.getMessage());
                break label479;
             } catch (IOException var60) {
                statusMsg = String.format("%s:%s", "IOException: ", var60.getMessage());
                in = ((HttpURLConnection)con).getErrorStream();
                bf = new BufferedReader(new InputStreamReader(in));
                StringBuilder sb = new StringBuilder();

                while(true) {
                   try {
                      if ((headers = bf.readLine()) != null) {
                         sb.append(headers);
                         continue;
                      }
                   } catch (IOException var58) {
                   }

                   statusMsg = String.format("%s:%s", "IOException: ", sb.toString());
                   System.out.println(statusMsg);
                   var18 = "05|" + statusMsg;
                   return var18;
                }
             } catch (NoSuchAlgorithmException var61) {
                statusMsg = String.format("%s:%s", "NoSuchAlgorithmException: ", var61.getMessage());
                System.out.println(statusMsg);
                break label479;
             } catch (KeyManagementException var62) {
                statusMsg = String.format("%s:%s", "KeyManagementException: ", var62.getMessage());
                System.out.println(statusMsg);
                break label479;
             } catch (NullPointerException var63) {
                statusMsg = String.format("%s:%s", "NullPointerException: ", var63.getMessage());
                System.out.println(statusMsg);
                var18 = "05|" + statusMsg;
             } catch (Exception var64) {
                statusMsg = String.format("%s:%s", "Exception: ", var64.getMessage());
                System.out.println(statusMsg);
                break label479;
             }
          } finally {
             if (bf != null) {
                try {
                   bf.close();
                } catch (Exception var57) {
                   System.out.println(var57.toString());
                }
             }

             if (in != null) {
                try {
                   in.close();
                } catch (Exception var56) {
                   System.out.println(var56.toString());
                }
             }

             if (con != null) {
                try {
                   ((HttpURLConnection)con).disconnect();
                } catch (Exception var55) {
                   System.out.println(var55.toString());
                }
             }

          }

          return var18;
       }

       result = String.format("%s|%s", statusCode, statusMsg);
       System.out.println(String.format("The result is: %s", statusMsg));
       return result;
    }

    private static String getISODate() {
       SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
       return sdf.format(new Date());
    }

    private static String escapeString(Map<String, String> map) {
       String str = (String)map.get("payload");
       return StringEscapeUtils.escapeJava(str);
    }

    private String base64(byte[] bytes) {
       return Base64.getEncoder().encodeToString(bytes);
    }

    private static synchronized String postRequest(Map<String, String> map) {
       String statusCode = "05";
       String statusMsg = "Generic Error 01";
       String obj = null;
       HttpURLConnection con = null;
       InputStream in = null;
       BufferedReader bf = null;

       String endPoint;
       try {
          String headers;
          try {
             allowCerts();
             obj = (String)map.get("endPoint");
             if (obj == null) {
                throw new Exception("EndPoint not set");
             }

             endPoint = obj;
             obj = (String)map.get("connectionTimeout");
             if (obj == null) {
                throw new Exception("Connection Timeout not set");
             }

             int connectionTimeout = Integer.parseInt(obj);
             obj = (String)map.get("headers");
             if (obj == null) {
                throw new Exception("HTTP Headers not set");
             }

             headers = obj;
             obj = (String)map.get("payload");
             if (obj == null) {
                throw new Exception("Request Payload not set");
             }

             System.out.println(String.format("The request is: %s", obj));
             URL url = new URL(endPoint);
             con = endPoint.startsWith("http") ? (HttpURLConnection)url.openConnection() : (HttpsURLConnection)url.openConnection();
             ((HttpURLConnection)con).setRequestMethod("POST");
             String[] arr = headers.split("\\^");
             if (arr.length > 0) {
                String[] var16 = arr;
                int var15 = arr.length;

                for(int var14 = 0; var14 < var15; ++var14) {
                   String s = var16[var14];
                   String[] arr2 = s.split("\\:");
                   if (arr2.length > 0) {
                      ((HttpURLConnection)con).setRequestProperty(arr2[0], arr2[1]);
                   }
                }
             }

             ((HttpURLConnection)con).setConnectTimeout(connectionTimeout);
             ((HttpURLConnection)con).setDoOutput(true);
             DataOutputStream dos = new DataOutputStream(((HttpURLConnection)con).getOutputStream());
             dos.write(obj.getBytes());
             dos.flush();
             dos.close();
             in = ((HttpURLConnection)con).getInputStream();
             if (in == null) {
                in = ((HttpURLConnection)con).getErrorStream();
             }

             bf = new BufferedReader(new InputStreamReader(in));
             StringBuilder sb = new StringBuilder();

             String line;
             while((line = bf.readLine()) != null) {
                sb.append(line);
             }

             statusCode = "00";
             statusMsg = sb.toString();
          } catch (MalformedURLException var52) {
             statusMsg = String.format("%s:%s", "MalformedURLException: ", var52.getMessage());
          } catch (IOException var53) {
             in = ((HttpURLConnection)con).getErrorStream();
             bf = new BufferedReader(new InputStreamReader(in));
             StringBuilder sb = new StringBuilder();

             try {
                while((headers = bf.readLine()) != null) {
                   sb.append(headers);
                }
             } catch (IOException var51) {
             }

             statusMsg = String.format("%s:%s", "IOException: ", sb.toString());
          } catch (NoSuchAlgorithmException var54) {
             statusMsg = String.format("%s:%s", "NoSuchAlgorithmException: ", var54.getMessage());
          } catch (KeyManagementException var55) {
             statusMsg = String.format("%s:%s", "KeyManagementException: ", var55.getMessage());
          } catch (Exception var56) {
             statusMsg = String.format("%s:%s", "Exception: ", var56.getMessage());
          }
       } finally {
          if (bf != null) {
             try {
                bf.close();
             } catch (Exception var50) {
                var50.toString();
             }
          }

          if (in != null) {
             try {
                in.close();
             } catch (Exception var49) {
                var49.toString();
             }
          }

          if (con != null) {
             try {
                ((HttpURLConnection)con).disconnect();
             } catch (Exception var48) {
                var48.toString();
             }
          }

       }

       endPoint = String.format("%s|%s", statusCode, statusMsg);
       System.out.println(String.format("The result is: %s", statusMsg));
       return endPoint;
    }

    private static synchronized void allowCerts() throws NoSuchAlgorithmException, KeyManagementException {
       TrustManager[] trustAllCerts = new TrustManager[]{new X509TrustManager() {
          public X509Certificate[] getAcceptedIssuers() {
             return null;
          }

          public void checkClientTrusted(X509Certificate[] certs, String authType) {
          }

          public void checkServerTrusted(X509Certificate[] certs, String authType) {
          }
       }};
       SSLContext sc = SSLContext.getInstance("SSL");
       sc.init((KeyManager[])null, trustAllCerts, new SecureRandom());
       HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
       HostnameVerifier allHostsValid = new HostnameVerifier() {
          public boolean verify(String hostname, SSLSession session) {
             return true;
          }
       };
       HttpsURLConnection.setDefaultHostnameVerifier(allHostsValid);
    }

    public static jRunTime INSTANCE(jSession session) {
       jRunTime prg = session.getRuntimeCache(className);
       if (prg == null) {
          prg = new HttpClient();
          ((jRunTime)prg).init(session);
       }

       return (jRunTime)prg;
    }

    public void stack(jRunTime prg) {
       this.session.setRuntimeCache(className, prg);
    }
 }
