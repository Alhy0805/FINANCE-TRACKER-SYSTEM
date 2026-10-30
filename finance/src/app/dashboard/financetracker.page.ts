import { Component } from '@angular/core';
import { addIcons } from 'ionicons';
import {
  homeOutline,
  swapHorizontalOutline,
  trendingUpOutline,
  trendingDownOutline,
  walletOutline,
  pricetagsOutline,
  pieChartOutline,
  trophyOutline,
  repeatOutline,
  barChartOutline,
  notificationsOutline,
  settingsOutline
} from 'ionicons/icons';
import {  IonButton, 
          IonIcon, 
          IonRouterOutlet
        } from '@ionic/angular';
import {
  RouterLink,
  RouterLinkActive
} from '@angular/router';

@Component({
  selector: 'app-financetracker',
  standalone: true,
  templateUrl: './financetracker.page.html',
  styleUrls: ['./financetracker.page.scss'],
  imports: [IonIcon, 
            IonButton, 
            IonRouterOutlet,
            RouterLink,
            RouterLinkActive],
})
export class FinanceTrackerPage {
  constructor() {
    addIcons({
      homeOutline,
      swapHorizontalOutline,
      trendingUpOutline,
      trendingDownOutline,
      walletOutline,
      pricetagsOutline,
      pieChartOutline,
      trophyOutline,
      repeatOutline,
      barChartOutline,
      notificationsOutline,
      settingsOutline,
    });
  }
}
