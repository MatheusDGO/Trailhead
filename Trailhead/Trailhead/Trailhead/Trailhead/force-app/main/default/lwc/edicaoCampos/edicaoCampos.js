// EdicaoCampos.js
import { LightningElement, track } from 'lwc';

export default class EdicaoCampos extends LightningElement {
    @track name;
    @track accountNumber;
    @track type;

    handleFieldChange(event) {
        const fieldName = event.target.dataset.field;
        const fieldValue = event.target.value;

        if (fieldName === 'Name') {
            this.name = fieldValue;
        } else if (fieldName === 'AccountNumber') {
            this.accountNumber = fieldValue;
        } else if (fieldName === 'Type') {
            this.type = fieldValue;
        }
    }

    handleSave() {
        const eventData = {
            name: this.name,
            accountNumber: this.accountNumber,
            type: this.type
        };

        this.dispatchEvent(new CustomEvent('save', { detail: eventData }));
    }
}