/**
 * Created by User on 26.09.2021.
 */

import { LightningElement } from 'lwc';

export default class ContactForm extends LightningElement {

    Product = {};
    TypeProduct = [

        { "label": "Телефон", "value": "Тедефон" },
        { "label": "Навушники", "value": "Навушники" },
        { "label": "Різне", "value": "Різне" },
        { "label": "Чохли", "value": "Чохли" },
        { "label": "Ноутбуки", "value": "" },



    ];


    // метод використовується для перевірки наявності всіх полів введення дійсні чи ні.

    isInputValid() {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
            this.contact[inputField.name] = inputField.value;
        });
        return isValid;
    }


    //метод використовується для створення нового контакту у відділі продажівна основі значень, введених користувачем.

    createContact() {
        if(this.isInputValid()) {
            console.log(this.contact);
        }
    }
}