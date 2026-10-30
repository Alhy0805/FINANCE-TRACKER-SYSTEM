import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar } from '@ionic/angular';

@Component({
  selector: 'app-accounts-and-wallets',
  templateUrl: './accounts-and-wallets.page.html',
  styleUrls: ['./accounts-and-wallets.page.scss'],
  imports: [IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, FormsModule],
})
export class AccountsAndWalletsPage implements OnInit {
  constructor() {}

  ngOnInit() {}
}
