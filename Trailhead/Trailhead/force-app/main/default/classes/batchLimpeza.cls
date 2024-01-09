global class batchLimpeza implements Database.Batchable<sObject>, Schedulable {
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id FROM Account WHERE Inativa__c = false AND (Id NOT IN (SELECT WhatId FROM Task WHERE CreatedDate >= :Date.today().addDays(-90))) AND (Id NOT IN (SELECT AccountId FROM Opportunity WHERE IsClosed = true AND CloseDate >= :Date.today().addDays(-120))) AND (Id NOT IN (SELECT AccountId FROM Opportunity WHERE StageName != \'Fechado\'))';
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext BC, List<sObject> scope) {
        List<Account> accountsToUpdate = new List<Account>();
        
        for (sObject sObj : scope) {
            Account acc = (Account)sObj;
            acc.Inativa__c = true;
            accountsToUpdate.add(acc);
        }
        
        update accountsToUpdate;
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Limpeza de contas completa');
    }

    global void execute(SchedulableContext sc) {
        Datetime currentTime = System.now();
        Integer hour = currentTime.hour();
        Integer minute = currentTime.minute();
        Integer second = currentTime.second();
        Integer minuteOffset = Integer.valueOf(Math.floor(minute / 15)); // Executes every 15 minutes, 4 times a day

    
        String dayOfWeek = currentTime.format('E');
    
        if (hour >= 8 && hour <= 20 && minuteOffset < 4 && (dayOfWeek == 'Mon' || dayOfWeek == 'Tue' || dayOfWeek == 'Wed' || dayOfWeek == 'Thu' || dayOfWeek == 'Fri')) {
            String jobId = System.schedule('AccountCleanupBatch Job', '0 ' + (minuteOffset * 15) + ' ' + hour + ' * * ?', this);
            System.debug('AccountCleanupBatch scheduled. Job ID: ' + jobId);
        }
    }
}