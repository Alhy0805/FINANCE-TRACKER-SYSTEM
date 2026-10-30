import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { IonContent, IonHeader, IonTitle, IonToolbar } from '@ionic/angular';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  templateUrl: './dashboard.page.html',
  styleUrls: ['./dashboard.page.scss'],
  imports: [IonContent, IonHeader, IonTitle, IonToolbar, CommonModule, FormsModule],
})
export class DashboardPage implements OnInit {
  user: { user_id: number; full_name: string; email: string } | null = null;
  resources: { accounts: { balance: number | string }[] } | null = null;
  totalBalance = 0;

  constructor() {}

  ngOnInit(): void {
    const savedUser = localStorage.getItem('finance-user');
    const savedResources = localStorage.getItem('finance-resources');

    this.user = savedUser ? JSON.parse(savedUser) : null;
    this.resources = savedResources ? JSON.parse(savedResources) : null;
    console.log(this.resources)
    this.totalBalance = this.resources.totalBalance;
  }
}
