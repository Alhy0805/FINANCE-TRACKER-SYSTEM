import {
  AfterViewInit,
  Component,
  ElementRef,
  OnDestroy,
  ViewChild,
} from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import {
  IonButton,
  IonContent,
  IonIcon,
  IonSelect,
  IonSelectOption,
} from '@ionic/angular';
import { addIcons } from 'ionicons';
import {
  downloadOutline,
  personCircleOutline,
  pieChartOutline,
  printOutline,
  trendingDownOutline,
  trendingUpOutline,
  walletOutline,
} from 'ionicons/icons';
import Chart from 'chart.js/auto';

interface Transaction {
  date: string;
  description: string;
  category: string;
  type: 'Income' | 'Expense';
  amount: number;
}

@Component({
  selector: 'app-reports-analytics',
  templateUrl: './reports-and-analytics.page.html',
  styleUrls: ['./reports-and-analytics.page.scss'],
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    IonButton,
    IonContent,
    IonIcon,
    IonSelect,
    IonSelectOption,
  ],
})
export class ReportsAndAnalyticsPage implements AfterViewInit, OnDestroy {
  @ViewChild('incomeExpenseCanvas') incomeExpenseCanvas!: ElementRef<HTMLCanvasElement>;
  @ViewChild('categoryCanvas') categoryCanvas!: ElementRef<HTMLCanvasElement>;

  selectedPeriod = 'This Month';
  selectedCategory = 'All';

  readonly periods = ['This Week', 'This Month', 'Last Month', 'This Year'];
  readonly categories = [
    'All',
    'Food',
    'Transportation',
    'Shopping',
    'Bills',
    'Salary',
    'Side Hustle',
  ];

  readonly transactions: Transaction[] = [
    { date: 'Oct 28, 2026', description: 'Lunch', category: 'Food', type: 'Expense', amount: 150 },
    { date: 'Oct 28, 2026', description: 'Allowance', category: 'Salary', type: 'Income', amount: 500 },
    { date: 'Oct 27, 2026', description: 'Transportation', category: 'Transportation', type: 'Expense', amount: 50 },
    { date: 'Oct 26, 2026', description: 'Groceries', category: 'Food', type: 'Expense', amount: 1200 },
    { date: 'Oct 25, 2026', description: 'Freelance Work', category: 'Side Hustle', type: 'Income', amount: 2000 },
  ];

  incomeExpenseChart?: Chart;
  categoryChart?: Chart;

  constructor() {
    addIcons({
      downloadOutline,
      personCircleOutline,
      pieChartOutline,
      printOutline,
      trendingDownOutline,
      trendingUpOutline,
      walletOutline,
    });
  }

  get filteredTransactions(): Transaction[] {
    if (this.selectedCategory === 'All') return this.transactions;
    return this.transactions.filter((item) => item.category === this.selectedCategory);
  }

  ngAfterViewInit(): void {
    this.createIncomeExpenseChart();
    this.createCategoryChart();
  }

  ngOnDestroy(): void {
    this.incomeExpenseChart?.destroy();
    this.categoryChart?.destroy();
  }

  private createIncomeExpenseChart(): void {
    this.incomeExpenseChart = new Chart(this.incomeExpenseCanvas.nativeElement, {
      type: 'line',
      data: {
        labels: ['Oct 1', 'Oct 5', 'Oct 10', 'Oct 15', 'Oct 20', 'Oct 25', 'Oct 31'],
        datasets: [
          {
            label: 'Income',
            data: [3000, 4000, 5500, 4200, 4800, 7000, 6000],
            borderColor: '#16b981',
            backgroundColor: 'rgba(22, 185, 129, 0.10)',
            fill: true,
            tension: 0.4,
            borderWidth: 2,
          },
          {
            label: 'Expenses',
            data: [1200, 1800, 2800, 1600, 2500, 3500, 3000],
            borderColor: '#f05270',
            backgroundColor: 'rgba(240, 82, 112, 0.10)',
            fill: true,
            tension: 0.4,
            borderWidth: 2,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { position: 'top', align: 'end' } },
        scales: {
          y: {
            beginAtZero: true,
            ticks: { callback: (value) => `₱${Number(value).toLocaleString('en-PH')}` },
            grid: { color: '#edf1f6' },
          },
          x: { grid: { display: false } },
        },
      },
    });
  }

  private createCategoryChart(): void {
    this.categoryChart = new Chart(this.categoryCanvas.nativeElement, {
      type: 'doughnut',
      data: {
        labels: ['Food', 'Transportation', 'Shopping', 'Bills', 'Entertainment', 'Others'],
        datasets: [
          {
            data: [2000, 1000, 750, 500, 500, 250],
            backgroundColor: ['#f59e0b', '#2563eb', '#9333ea', '#14b8a6', '#ec4899', '#94a3b8'],
            borderColor: '#ffffff',
            borderWidth: 3,
            hoverOffset: 5,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        cutout: '65%',
        plugins: { legend: { position: 'bottom' } },
      },
    });
  }
  formatCurrency(amount: number): string {
    return new Intl.NumberFormat('en-PH', {
      style: 'currency',
      currency: 'PHP',
      maximumFractionDigits: 0,
    }).format(amount);
  }

  exportCsv(): void {
    const header = ['Date', 'Description', 'Category', 'Type', 'Amount'];
    const rows = this.filteredTransactions.map((item) => [
      item.date,
      item.description,
      item.category,
      item.type,
      item.amount.toString(),
    ]);
    const csv = [header, ...rows]
      .map((row) => row.map((value) => `"${String(value).replace(/"/g, '""')}"`).join(','))
      .join('\r\n');

    const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
    const url = URL.createObjectURL(blob);
    const link = document.createElement('a');
    link.href = url;
    link.download = 'FinanceTracker_Report.csv';
    link.click();
    URL.revokeObjectURL(url);
  }

  printReport(): void {
    window.print();
  }
}
