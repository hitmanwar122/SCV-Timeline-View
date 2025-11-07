import { LightningElement, wire, api, track } from 'lwc';
import getCustomerJourney from '@salesforce/apex/CustomerJourneyController.getCustomerJourney';

export default class CustomerJourneyTimeline extends LightningElement {
  @api recordId;
  @track journeyData;

  @wire(getCustomerJourney, { voiceCallId: '$recordId' })
  wiredJourney({ error, data }) {
    if (data) {
      this.journeyData = data.map((item) => ({
        ...item,
        badgeClass: item.Type === 'Inbound' ? 'badge inbound' : 'badge outbound',
      }));
    } else if (error) {
      console.error('Error fetching journey:', error);
    }
  }
}
