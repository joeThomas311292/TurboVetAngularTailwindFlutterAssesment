import {
  Component,
  ElementRef,
  ViewChild,
  OnInit,
  OnDestroy,
  ChangeDetectorRef,
} from '@angular/core';

@Component({
  selector: 'app-logs',
  standalone: true,
  templateUrl: './logs.html',
  styleUrl: './logs.css',
})
export class Logs implements OnInit, OnDestroy {
  logs: string[] = [];
  intervalId?: number;

  @ViewChild('logContainer') logContainer?: ElementRef<HTMLDivElement>;

  constructor(private cdr: ChangeDetectorRef) {}

  ngOnInit() {
    this.intervalId = window.setInterval(() => {
      const timestamp = new Date().toISOString();
      const events = [
        'User logged in',
        'Ticket updated',
        'Cache refreshed',
        'Error 500',
        'Background job completed',
      ];

      const line = `[${timestamp}] ${
        events[Math.floor(Math.random() * events.length)]
      }`;

      this.logs.push(line);

      // ✅ ensures UI updates even in zoneless setups
      this.cdr.detectChanges();

      // auto-scroll if container exists
      setTimeout(() => {
        const el = this.logContainer?.nativeElement;
        if (el) el.scrollTop = el.scrollHeight;
      });
    }, 2000);
  }

  ngOnDestroy() {
    if (this.intervalId) clearInterval(this.intervalId);
  }
}
