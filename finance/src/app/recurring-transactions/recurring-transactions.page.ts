import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar } from '@ionic/angular';

@Component({
  selector: 'app-recurring-transactions',
  templateUrl: './recurring-transactions.page.html',
  styleUrls: ['./recurring-transactions.page.scss'],
  imports: [IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, FormsModule],
})
export class RecurringTransactionsPage implements OnInit {
  constructor() {}

  ngOnInit() {}
}
