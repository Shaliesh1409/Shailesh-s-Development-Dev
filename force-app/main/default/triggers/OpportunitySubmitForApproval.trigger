trigger OpportunitySubmitForApproval on Account (After insert){
    for (Account acc:Trigger.new) {        
Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();     
req.setComments('Submitted for approval. Please approve.');
req.setObjectId(acc.Id);           
Approval.ProcessResult result = Approval.process(req);           
System.debug('Submitted for approval successfully: '+result.isSuccess());         
             }     
            }