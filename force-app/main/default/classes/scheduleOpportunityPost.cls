global class scheduleOpportunityPost implements Schedulable{
    
    global void execute(SchedulableContext context){
        List<Opportunity> oppList = [Select Id,Name from Opportunity where StageName =: 'Closed Won' and Amount >=: 10L];
        FeedItem post = new FeedItem();
        post.ParentId = '0F95i000000DY8ACAW';
        String body = 'There are '+oppList.size()+' opportunities whose stage is closed won and amount is greater than 10L.They are,';
        Integer i = 1;
        for(Opportunity op : oppList)
            body += (i++ + '-->'+op.Name+',');  
        post.Body = body;
        insert post;
    }

}