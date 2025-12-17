import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';

@Component({
  selector: 'app-knowledgebase',
  standalone: true,
  imports: [FormsModule],
  templateUrl: './knowledgebase.html',
  styleUrl: './knowledgebase.css',
})
export class Knowledgebase {
  content = `# FAQ

## Password reset
Go to Settings → Account → Reset Password.

## Refunds
Refunds take 5–10 business days.`;

  splitPreview = true;

  get lines(): string[] {
    return this.content.split('\n');
  }

  onSave() {
    alert('Draft saved (simulated).');
  }
}
