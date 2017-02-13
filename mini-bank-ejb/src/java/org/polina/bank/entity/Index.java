/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package org.polina.bank.entity;

/**
 *
 * @author polina
 */
public class Index {
    public static int accountIndex = 1; 
    public static int personIndex = 1; 
    public static int clientIndex = 1; 
    public static int managerIndex = 1; 

    public static void setAccountIndex(int accountIndex) {
        Index.accountIndex = accountIndex;
    }

    public static void setClientIndex(int clientIndex) {
        Index.clientIndex = clientIndex;
    }

    public static void setManagerIndex(int managerIndex) {
        Index.managerIndex = managerIndex;
    }

    public static void setPersonIndex(int personIndex) {
        Index.personIndex = personIndex;
    }
    
    public static void initAll(int acc, int person, int client, int manager) {
        accountIndex = acc+1;
        personIndex = person+1;
        clientIndex = client+1;
        managerIndex = manager+1;
        
    }
    
    
}
