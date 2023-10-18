trigger weather on Lead (before insert) {
    for (Lead newLead : Trigger.new) {
        if (newLead.Rating != 'Hot') {
            newLead.Rating = 'Hot';
        }
    }

    }