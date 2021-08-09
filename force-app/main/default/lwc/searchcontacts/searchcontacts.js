import { LightningElement, track, wire } from 'lwc';
import retrieveContactData from '@salesforce/apex/lwcrecordtypes.retrieveContactData';

export default class Searchcontacts extends LightningElement {
    @track currentRecordName;
     handleChangeRecName(event){
       this.currentRecordName = event.target.value;      
     }
  
     @track records;
     @track dataNotFound;
     @wire (retrieveContactData,{keySearch:'$currentRecordName'})
     wireRecord({data,error}){
         if(data){           
             this.records = data;
             this.error = undefined;
             this.dataNotFound = '';
             if(this.records == ''){
                 this.dataNotFound = 'There is no record Type Available';
             }
  
            }else{
                this.error = error;
                this.data=undefined;
            }
     }
}