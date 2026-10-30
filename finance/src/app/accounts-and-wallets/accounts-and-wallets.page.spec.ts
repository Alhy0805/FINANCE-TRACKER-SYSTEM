import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AccountsAndWalletsPage } from './accounts-and-wallets.page';

describe('AccountsAndWalletsPage', () => {
  let component: AccountsAndWalletsPage;
  let fixture: ComponentFixture<AccountsAndWalletsPage>;

  beforeEach(() => {
    fixture = TestBed.createComponent(AccountsAndWalletsPage);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
