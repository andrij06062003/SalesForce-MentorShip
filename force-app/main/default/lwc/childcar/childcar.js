import { LightningElement, wire, track, api } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import PRODUCT2_OBJECT from '@salesforce/schema/Product2';
import getCarsFields from '@salesforce/apex/getCARS.getCarsFields';
export default class CarList extends LightningElement {
    @track _car = {};
    @track _fieldMappings = [];

    @track listToShow = [];
    @api carRemove;

    @api
    set car(carInfo){
        this._car = carInfo;
        this.recalculateListToShow();
    }
    get car(){}

    @api
    set fieldMappings(fieldMappingsInfo){
        this._fieldMappings = fieldMappingsInfo;
        this.recalculateListToShow();
    }
    get fieldMappings(){}

    recalculateListToShow(){
        if(this._car != {} && this._fieldMappings != {}){
            this.listToShow = [];
            this._fieldMappings.forEach(fieldInfo => this.listToShow.push(fieldInfo + ': ' + this._car[fieldInfo]));
        }
    }
    handleDelete(){
        const delEvent = new CustomEvent('getidofcar' , {detail:{uniqueId:this._car.uniqueId}})
        this.dispatchEvent(delEvent);
    }
   
}