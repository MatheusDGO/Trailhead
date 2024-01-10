@IsTest
public class ValidaContaTriggerTest {
    @IsTest
    public static void testTriggerPositiveCase() {
        Account account = new Account();
        account.Name = 'Parceiro Account';
        account.AccountNumber = '123456789';
        account.Type = 'Parceiro';

        Test.startTest();
        insert account;
        Test.stopTest();

        // Verifica se a oportunidade foi criada para a conta do tipo "Parceiro"
        List<Opportunity> opportunities = [SELECT Name, CloseDate, StageName FROM Opportunity];
        System.assertEquals(1, opportunities.size());
        Opportunity opportunity = opportunities[0];
        System.assertEquals('Parceiro Account - opp Parceiro', opportunity.Name);
        System.assertEquals(System.today().addDays(30), opportunity.CloseDate);
        System.assertEquals('Qualification', opportunity.StageName);
    }

    @IsTest
    public static void testTriggerNegativeCase() {
        Account account = new Account();
        account.Name = 'Consumidor Final Account';
        account.AccountNumber = '987654321';
        account.Type = 'Consumidor final';

        Test.startTest();
        insert account;
        Test.stopTest();

        // Verifica se a tarefa não foi criada para a conta do tipo "Consumidor final"
        List<Task> tasks = [SELECT Subject, WhatId, Status, Priority FROM Task];
        System.assertEquals(0, tasks.size());
    }

    @IsTest
    public static void testTriggerBatchInsert() {
        List<Account> accounts = new List<Account>();

        for (Integer i = 0; i < 200; i++) {
            Account account = new Account();
            account.Name = 'Parceiro Account ' + i;
            account.AccountNumber = '123456789';
            account.Type = 'Parceiro';
            accounts.add(account);
        }

        Test.startTest();
        insert accounts;
        Test.stopTest();

        // Verifica se as oportunidades foram criadas para as contas do tipo "Parceiro" inseridas em lote
        List<Opportunity> opportunities = [SELECT Name, CloseDate, StageName FROM Opportunity];
        System.assertEquals(200, opportunities.size());

        for (Opportunity opportunity : opportunities) {
            System.assertEquals('Qualification', opportunity.StageName);
        }
    }
}