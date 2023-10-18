trigger prefix on Account (before insert) {
    for(Account acc :Trigger.new){
        acc.Name='Mr.'+acc.Name;

}
}