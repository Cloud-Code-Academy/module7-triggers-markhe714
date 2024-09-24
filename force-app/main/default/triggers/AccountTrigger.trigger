trigger AccountTrigger on Account (before insert, after insert) {

  if (Trigger.isBefore) {

    for (Account a : Trigger.new) {

      if (Trigger.isInsert) {
        // Question 1
        if (a.Type == Null) {
          a.Type = 'Prospect';
        }
        // Question 2
        if (a.ShippingStreet != Null) {
          a.BillingStreet = a.ShippingStreet;
        }

        if (a.ShippingCity != Null) {
          a.BillingCity = a.ShippingCity;
        }

        if (a.ShippingState != Null) {
          a.BillingState = a.ShippingState;
        }

        if (a.ShippingPostalCode != Null) {
          a.BillingPostalCode = a.ShippingPostalCode;
        }

        if (a.ShippingCountry != Null) {
          a.BillingCountry = a.ShippingCountry;
        }
        //Question 3
        if (a.Phone != Null && a.Website != Null && a.Fax != Null) {
          a.Rating = 'Hot';
        }

      } 

    }

  }

  if (Trigger.isAfter) {
    if (Trigger.isInsert) {
      //Question 4
      List<Contact> newContacts = new List<Contact>();

      for (Account a : Trigger.new) {

        newContacts.add(new Contact(AccountId = a.Id, LastName = 'DefaultContact', Email = 'default@email.com'));

      }

      insert newContacts;
    }
    
  }
  

}