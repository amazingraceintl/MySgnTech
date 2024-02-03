package com.temenos.sgntech;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * TODO: Document me!
 *
 * @author Peter
 *
 */
public class getMachineIp {

    /**
     * @param args
     */
    public static void main(String[] args) {
        // TODO Auto-generated method stub

String ip = null;
        
        try {
            Object DeviceIp = InetAddress.getLocalHost();
            String []ips = DeviceIp.toString().split("\\/");
             ip = ips[1];
         } catch (UnknownHostException e1) {
         }
        System.out.println("My machine ip is ... = " + ip);
        
    }

}
