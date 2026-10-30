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
  selector: 'app-dashboard',
  templateUrl: './dashboard.page.html',
  styleUrls: ['./dashboard.page.scss'],
  imports: [IonIcon, 
            IonButton, 
            IonRouterOutlet,
            RouterLink,
            RouterLinkActive],
})
export class DashboardPage {
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
