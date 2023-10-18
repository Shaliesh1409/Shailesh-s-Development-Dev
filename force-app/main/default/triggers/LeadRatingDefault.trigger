trigger LeadRatingDefault on Lead (before insert) {
    LeadHandler.setDefaultRating(Trigger.new);
}