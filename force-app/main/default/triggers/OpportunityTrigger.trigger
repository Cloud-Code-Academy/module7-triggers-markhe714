trigger OpportunityTrigger on Opportunity (before update, before delete) {
  if (Trigger.isBefore) {

    if (Trigger.isUpdate) {

      List<Contact> contactsCEO = [SELECT Id, AccountId FROM Contact WHERE Title = 'CEO'];

      Map<Id,Id> contactIdToAccountId = new Map<Id,Id>();

      for (Contact contact : contactsCEO) {
        contactIdToAccountId.put(contact.AccountId, contact.Id);
      }


      for (Opportunity opp : Trigger.new) {

  //Question 5
        if (opp.Amount <= 5000 ) {
          opp.Amount.addError('Opportunity amount must be greater than 5000');
        }

  //Question 7
        if (opp.AccountId != Null && contactIdToAccountId.get(opp.AccountId) != Null && opp.Primary_Contact__c != contactIdToAccountId.get(opp.AccountId)) {
          opp.Primary_Contact__c = contactIdToAccountId.get(opp.AccountId);
        }

      }
    }
    if (Trigger.isDelete) {

  //Question 6
      List<Account> bankingAccount = [SELECT Id FROM Account WHERE Industry = 'Banking'];
      Set<Id> bankingAccountIds = (new Map<Id,Account>(bankingAccount)).keySet();

      for (Opportunity opp : Trigger.old) {
        if (opp.StageName == 'Closed Won' && bankingAccountIds.contains(opp.AccountId) == True) {
          opp.addError('Cannot delete closed opportunity for a banking account that is won');
        }
      }
      
    }
  }
}