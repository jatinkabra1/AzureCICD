public with sharing class RatingHot {
    public RatingHot() {

    }

    public static void HotRatingAccounts(List<Account> accounts){
        List<Account> accountsToUpdate = new List<Account>();

        for(Account acc : accounts){
            if(acc.Rating == 'Hot'){
                acc.Description = 'This is a hot account';
                accountsToUpdate.add(acc);
            }
        }

        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }
}