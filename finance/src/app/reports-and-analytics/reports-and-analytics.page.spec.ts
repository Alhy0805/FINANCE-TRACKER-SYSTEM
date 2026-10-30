import { ComponentFixture, TestBed } from '@angular/core/testing';
import { ReportsAndAnalyticsPage } from './reports-and-analytics.page';

describe('ReportsAndAnalyticsPage', () => {
  let component: ReportsAndAnalyticsPage;
  let fixture: ComponentFixture<ReportsAndAnalyticsPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(ReportsAndAnalyticsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
