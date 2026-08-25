import { LightningElement } from 'lwc';

const COLUMNS = [
    { label: 'Name', fieldName: 'name', type: 'text' },
    { label: 'Status', fieldName: 'status', type: 'text' },
    { label: 'Amount', fieldName: 'amount', type: 'currency' },
    { label: 'Close Date', fieldName: 'closeDate', type: 'date' }
];

export default class MyDemoLWC extends LightningElement {
    columns = COLUMNS;

    data = [
        { id: '1', name: 'Acme Corp', status: 'Open', amount: 12500, closeDate: '2026-09-15' },
        { id: '2', name: 'Globex Inc', status: 'Won', amount: 48200, closeDate: '2026-08-01' },
        { id: '3', name: 'Initech', status: 'Open', amount: 7600, closeDate: '2026-10-03' },
        { id: '4', name: 'Umbrella Ltd', status: 'Lost', amount: 15300, closeDate: '2026-07-20' },
        { id: '5', name: 'Soylent Co', status: 'Open', amount: 22400, closeDate: '2026-09-28' }
    ];

    get rowCount() {
        return this.data.length;
    }
}