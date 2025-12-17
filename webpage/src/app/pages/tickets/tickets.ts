import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

type TicketStatus = 'Open' | 'In Progress' | 'Closed';

interface Ticket {
  id: number;
  subject: string;
  status: TicketStatus;
  createdAt: string;
}

@Component({
  selector: 'app-tickets',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './tickets.html',
  styleUrl: './tickets.css',
})
export class Tickets {
  statuses: (TicketStatus | 'All')[] = ['All', 'Open', 'In Progress', 'Closed'];
  selectedStatus: TicketStatus | 'All' = 'All';

  tickets: Ticket[] = [
    { id: 101, subject: 'Login not working', status: 'Open', createdAt: '2025-01-01' },
    { id: 102, subject: 'Refund request', status: 'In Progress', createdAt: '2025-01-03' },
    { id: 103, subject: 'Feature suggestion', status: 'Closed', createdAt: '2025-01-05' },
    { id: 104, subject: 'Crash on checkout', status: 'Open', createdAt: '2025-01-07' },
  ];

  get filteredTickets(): Ticket[] {
    if (this.selectedStatus === 'All') return this.tickets;
    return this.tickets.filter(t => t.status === this.selectedStatus);
  }
}
