import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar } from '@ionic/angular';

@Component({
  selector: 'app-saving-goals',
  templateUrl: './saving-goals.page.html',
  styleUrls: ['./saving-goals.page.scss'],
  imports: [IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, FormsModule],
})
export class SavingGoalsPage implements OnInit {
  constructor() {}

  ngOnInit() {}
}
