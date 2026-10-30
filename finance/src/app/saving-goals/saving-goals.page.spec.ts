import { ComponentFixture, TestBed } from '@angular/core/testing';
import { SavingGoalsPage } from './saving-goals.page';

describe('SavingGoalsPage', () => {
  let component: SavingGoalsPage;
  let fixture: ComponentFixture<SavingGoalsPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(SavingGoalsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
