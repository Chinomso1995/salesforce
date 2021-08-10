import { LightningElement, track, wire } from 'lwc';
import retrieveContactData from '@salesforce/apex/lwcrecordtypes.retrieveContactData';

export default class Searchcontacts extends LightningElement {
    @track currentRecordName;

    count = 0
     handleChangeRecName(event){
       this.currentRecordName = event.target.value;      
     }
  
    handleIncrement (){
        this.count = count++
    }


     @track records;
     @track dataNotFound;
     @wire (retrieveContactData,{keySearch:'$currentRecordName'})
     wireRecord({data,error}){
         if(data){          
             this.records = JSON.parse(data)
             console.log(data)
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