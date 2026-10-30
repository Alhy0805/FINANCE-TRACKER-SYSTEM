import { ComponentFixture, TestBed } from '@angular/core/testing';
import { FinanceTrackerPage } from './financetracker.page';

describe('FinanceTrackerPage', () => {
  let component: FinanceTrackerPage;
  let fixture: ComponentFixture<FinanceTrackerPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(FinanceTrackerPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
