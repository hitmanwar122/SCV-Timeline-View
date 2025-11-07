public with sharing class CustomerJourneyController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getCustomerJourney(Id voiceCallId) {
        if (voiceCallId == null) return new List<Map<String, Object>>();

        VoiceCall vc = [
            SELECT Id, Name, CallerPhone, RecipientPhone
            FROM VoiceCall
            WHERE Id = :voiceCallId
            LIMIT 1
        ];

        String phone = String.isNotBlank(vc.CallerPhone) ? vc.CallerPhone : vc.RecipientPhone;
        if (String.isBlank(phone)) return new List<Map<String, Object>>();

        List<VoiceCall> calls = [
            SELECT Id, Name, CallType, CallDisposition, CallStartDateTime, CallDurationInSeconds
            FROM VoiceCall
            WHERE (CallerPhone = :phone OR RecipientPhone = :phone)
            ORDER BY CallStartDateTime DESC
            LIMIT 10
        ];

        List<Map<String, Object>> result = new List<Map<String, Object>>();
        for (VoiceCall c : calls) {
            result.add(new Map<String, Object>{
                'Id' => c.Id,
                'Name' => c.Name,
                'Type' => c.CallType,
                'Status' => c.CallDisposition,
                'Timestamp' => String.valueOf(c.CallStartDateTime),
                'Notes' => 'Duration: ' + c.CallDurationInSeconds + 's'
            });
        }
        return result;
    }
}
