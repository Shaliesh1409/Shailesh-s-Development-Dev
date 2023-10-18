public class LeadHandler {
    public static void setDefaultRating(List<Lead> leads) {
        String hotRatingValue = 'Hot';

        for (Lead lead : leads) {
                lead.Rating = hotRatingValue;
            
        }
    }
}