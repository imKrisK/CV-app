# CV Application with Docker

A professional CV/Resume web application containerized with Docker for easy deployment and development.

## Features

- 📄 Interactive web-based resume/CV
- 🖨️ PDF generation capability
- 🐳 Docker containerization
- 🚀 Express.js server
- 📱 Responsive design
- 🔧 Development and production configurations

## Quick Start

### Prerequisites
- Docker and Docker Compose installed on your system
- Node.js (for local development)

### Running with Docker

1. **Build and run the application:**
   ```bash
   docker-compose up --build
   ```

2. **Access the application:**
   - Web interface: http://localhost:3001
   - Health check: http://localhost:3001/health
   - PDF generation: http://localhost:3001/api/generate-pdf

### Alternative Docker Commands

**Build the Docker image:**
```bash
docker build -t cv-app .
```

**Run the container:**
```bash
docker run -p 3001:3001 cv-app
```

**Run with volume mounting for development:**
```bash
docker run -p 3001:3001 -v $(pwd):/app cv-app
```

### Local Development

1. **Install dependencies:**
   ```bash
   npm install
   ```

2. **Start the development server:**
   ```bash
   npm run dev
   ```

3. **Generate PDF locally:**
   ```bash
   npm run generate-pdf
   ```

## Docker Configuration

### Dockerfile Features
- **Base Image:** Node.js 18 Alpine (lightweight)
- **Playwright Support:** Pre-configured for PDF generation
- **Security:** Non-root user execution
- **Optimization:** Multi-stage build capabilities

### Docker Compose Services
- **cv-app:** Main application service
- **nginx:** Optional reverse proxy for production (use `--profile production`)

### Production Deployment

**With nginx reverse proxy:**
```bash
docker-compose --profile production up --build
```

This will start both the application and nginx on ports 80/443.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | 3001 | Application port |
| `NODE_ENV` | development | Environment mode |

## API Endpoints

- `GET /` - Main resume page
- `GET /api/data` - Resume data JSON
- `GET /api/generate-pdf` - Generate and download PDF
- `GET /health` - Health check endpoint

## File Structure

```
├── Dockerfile              # Docker configuration
├── docker-compose.yml      # Docker Compose setup
├── nginx.conf              # Nginx configuration
├── package.json            # Node.js dependencies
├── server.js               # Express.js server
└── resume-web/             # Static web files
    ├── index.html
    ├── style.css
    ├── data.json
    └── generate-pdf.js
```

## Development Workflow

1. **Make changes** to your resume data in `resume-web/data.json`
2. **Test locally** with `npm run dev`
3. **Build Docker image** with `docker-compose up --build`
4. **Deploy** using your preferred container orchestration platform

## Troubleshooting

### Common Issues

**PDF generation fails:**
- Ensure Chromium is properly installed in the container
- Check that the application is fully loaded before generating PDF

**Port conflicts:**
- Change the port mapping in docker-compose.yml: `"8080:3001"`

**Permission issues:**
- The application runs as a non-root user for security
- Ensure file permissions are correct if mounting volumes

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker
5. Submit a pull request

## License

MIT License - see LICENSE file for details.
