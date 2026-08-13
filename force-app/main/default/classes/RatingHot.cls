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

    public static void UpdateAccountDescription(List<Account> accounts) {

        List<Account> accountsToUpdate = new List<Account>();

        for (Account acc : accounts) {

            if (acc.AnnualRevenue != null && acc.AnnualRevenue >= 1000000) {
                acc.Description = 'Large Revenue Account';
                accountsToUpdate.add(acc);
            }
            else if (acc.NumberOfEmployees != null && acc.NumberOfEmployees >= 500) {
                acc.Description = 'Large Organization';
                accountsToUpdate.add(acc);
            }
            else if (acc.Industry == 'Technology') {
                acc.Description = 'Technology Account';
                accountsToUpdate.add(acc);
            }
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}