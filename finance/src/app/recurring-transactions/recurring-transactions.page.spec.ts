import { ComponentFixture, TestBed } from '@angular/core/testing';
import { RecurringTransactionsPage } from './recurring-transactions.page';

describe('RecurringTransactionsPage', () => {
  let component: RecurringTransactionsPage;
  let fixture: ComponentFixture<RecurringTransactionsPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(RecurringTransactionsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
