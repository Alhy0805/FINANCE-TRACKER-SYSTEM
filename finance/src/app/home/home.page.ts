import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: './home.page.html',
  styleUrls: ['./home.page.scss'],
  imports: [CommonModule, FormsModule],
})
export class HomePage implements OnInit {
  accounts: Account[] = [];
  api = 'http://127.0.0.1:8000/accounts';

  constructor() {}

  async getAccounts(): Promise<void> {
    try {
      const response = await fetch(this.api);

      if (!response.ok) {
        throw new Error(`Request failed: ${response.status}`);
      }

      this.accounts = await response.json() as Account[];
      console.log('Accounts loaded:', this.accounts);
    } catch (error) {
      console.error('Unable to load accounts:', error);
    }
  }

  ngOnInit(): void {
    void this.getAccounts();
  }
}

interface Account {
  account_id: number;
  user_id: number;
  account_name: string;
  account_type: string;
  initial_balance: number;
  created_at: string;
}
