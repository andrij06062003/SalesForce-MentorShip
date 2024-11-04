import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getCarFieldMappings from '@salesforce/apex/getCARS.getCarFieldMappings';
import getCarsFields from '@salesforce/apex/getCARS.getCarsFields';

export default class CarComparison extends LightningElement {
    @track cars = [];
    @track metadataFields = []; // Store the metadata fields

    generateId() {
        const timestamp = Date.now().toString(36); // Converts current time to base-36
        const randomPart = Math.random().toString(36).substring(2, 8); // Random part with 6 characters
        return `${timestamp}-${randomPart}`;
    }

    connectedCallback() {
        // Fetch metadata fields
        getCarFieldMappings()
            .then(result => {
                this.metadataFields = result.map(field => field.ApiName__c); 
            })
            .catch(error => {
                console.error('Error fetching car field mappings:', error);
            });
    }

    fetchCars(fields) {
         
        const carData = {
            name: fields.Name,
            model: fields.Model__c,
            brand: fields.Brand__c,
            EnginePower: parseFloat(fields.Engine_Power__c),
            fields:this.metadataFields
        };

        getCarsFields(carData)
            .then(result => {
                if (result && result.length) {
                    result.forEach(res => {res.uniqueId = this.generateId(); this.cars.push(res)})
                    this.showToast('Success' , 'Your car added to list' , 'success');
                    // result.uniqueId = this.generateId();
                    // this.cars.push(result); // Set cars directly
                } else {
                    console.log('No cars found.');
                    this.cars = []; // Reset if no cars found
                }
            })
            .catch(error => {
                console.error('Error fetching cars:', error);
            });
    }

    handleSubmit(event) {
        event.preventDefault(); // Prevent default form submission
        const fields = event.detail.fields;
        this.fetchCars(fields); // Pass the submitted form data to fetchCars
    }

    handleSuccess() {
        const form = this.template.querySelector('lightning-record-form');
        if (form) {
            form.reset();
            this.cars = []; // Reset the car list on success
        }
    }

    handleError(error) {
        console.error('Error:', error);
    }
    
    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }

    carRemove(event) {
        const uniqueId = event.detail.uniqueId; 
        this.cars = this.cars.filter(car => car.uniqueId !== uniqueId);
        this.showToast('Success', 'Car has been removed successfully!', 'success');
    }
    
}