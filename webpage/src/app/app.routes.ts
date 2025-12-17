import { Routes } from '@angular/router';

import { LayoutComponent } from './components/layout/layout';
import { Tickets } from './pages/tickets/tickets';
import { Knowledgebase } from './pages/knowledgebase/knowledgebase';
import { Logs } from './pages/logs/logs';

export const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    children: [
      { path: 'tickets', component: Tickets },
      { path: 'knowledgebase', component: Knowledgebase },
      { path: 'logs', component: Logs },
      { path: '', redirectTo: 'tickets', pathMatch: 'full' },
    ],
  },

  { path: '**', redirectTo: 'tickets' },
];
