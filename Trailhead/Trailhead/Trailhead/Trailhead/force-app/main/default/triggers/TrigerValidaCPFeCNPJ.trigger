trigger TrigerValidaCPFeCNPJ on Account (before insert, before update) {
    List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
    List<Task> tasksToInsert = new List<Task>();
    

    for (Account acc : Trigger.new) {
        if (acc.AccountNumber != null) {
            if (!Utils.ValidaCPF(acc.AccountNumber) && !Utils.ValidaCNPJ(acc.AccountNumber)) {
                acc.AccountNumber.addError('Número do cliente é inválido');
            }
        }

        if (acc.Type == 'Parceiro') {
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name + ' - opp Parceiro';
            opp.CloseDate = System.today().addDays(30);
            opp.StageName = 'Qualification';
            opportunitiesToInsert.add(opp);
        } else if (acc.Type == 'Consumidor final') {
            Task task = new Task();
            task.Subject = 'Consumidor Final';
            task.WhatId = acc.Id;
            task.Status = 'Not Started';
            task.Priority = 'Normal';
            tasksToInsert.add(task);
        }
    }

    if (!opportunitiesToInsert.isEmpty()) {
        insert opportunitiesToInsert;
    }

    if (!tasksToInsert.isEmpty()) {
        insert tasksToInsert;
    }
}