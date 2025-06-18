const express = require('express');
const path = require('path');
const { chromium } = require('playwright');

const app = express();
const PORT = process.env.PORT || 3001;

// Serve static files from resume-web directory
app.use(express.static(path.join(__dirname, 'resume-web')));

// API endpoint to get resume data
app.get('/api/data', (req, res) => {
  try {
    const data = require('./resume-web/data.json');
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to load resume data' });
  }
});

// API endpoint to generate PDF
app.get('/api/generate-pdf', async (req, res) => {
  try {
    const browser = await chromium.launch({
      headless: true,
      executablePath: '/usr/bin/chromium-browser',
      args: [
        '--no-sandbox', 
        '--disable-setuid-sandbox',
        '--disable-dev-shm-usage',
        '--disable-accelerated-2d-canvas',
        '--disable-gpu',
        '--window-size=1920x1080'
      ]
    });
    
    const page = await browser.newPage();
    await page.goto(`http://localhost:${PORT}`, { waitUntil: 'networkidle' });
    
    const pdf = await page.pdf({
      format: 'A4',
      printBackground: true,
      margin: { top: '20mm', bottom: '20mm', left: '15mm', right: '15mm' }
    });
    
    await browser.close();
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename="Kristoffer_Kelly_Resume.pdf"');
    res.send(pdf);
  } catch (error) {
    console.error('PDF generation error:', error);
    res.status(500).json({ error: 'Failed to generate PDF' });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

// Serve the main HTML file
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'resume-web', 'index.html'));
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`CV App is running on http://localhost:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/health`);
  console.log(`PDF generation: http://localhost:${PORT}/api/generate-pdf`);
});
