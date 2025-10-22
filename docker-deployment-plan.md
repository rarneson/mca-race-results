# Docker Deployment Plan for MCA Race Results (Dev Environment)

## Current State Assessment
Your application already has:
- Production-ready Dockerfile with multi-stage build
- Kamal deployment configuration (config/deploy.yml)
- Thruster web server for production serving
- SQLite database with persistent volume support
- Docker entrypoint script (bin/docker-entrypoint)
- Pagy gem for pagination

## Deployment Plan

### **Phase 1: Pre-Deployment Configuration**

1. **Configure Kamal for Dev Environment**
   - Update `config/deploy.yml` with your dev server IP (currently placeholder: 192.168.0.1)
   - Set your container registry username (currently: "your-user")
   - Configure SSL/domain settings (currently: app.example.com)
   - Consider creating a separate `config/deploy.dev.yml` for dev-specific config

2. **Set Up Secrets**
   - Create `.kamal/secrets` file with required credentials:
     - `KAMAL_REGISTRY_PASSWORD` - Container registry password
     - `RAILS_MASTER_KEY` - From your `config/master.key`
   - Ensure secrets file is in .gitignore (already configured)

3. **Prepare Dev Server**
   - SSH access with key-based auth
   - Docker installed and running
   - Firewall configured (ports 80, 443, 22)
   - Sufficient disk space for volumes

### **Phase 2: Initial Setup**

4. **Build and Push Image**
   ```bash
   bin/kamal build push
   ```
   - Builds multi-stage Docker image
   - Pushes to configured registry
   - Optimized for production with jemalloc, bootsnap precompilation

5. **Bootstrap Server**
   ```bash
   bin/kamal setup
   ```
   - Creates Docker networks
   - Sets up Traefik proxy for SSL/routing
   - Creates persistent volumes
   - Deploys initial container

### **Phase 3: Database and Initial Data**

6. **Run Database Migrations**
   ```bash
   bin/kamal app exec 'bin/rails db:migrate'
   ```

7. **Seed Initial Data** (if needed)
   ```bash
   bin/kamal app exec 'bin/rails db:seed'
   ```
   - Imports race data from seed files
   - Consider running specific import tasks if needed

### **Phase 4: Verification and Monitoring**

8. **Health Checks**
   - Verify application is accessible via configured domain
   - Check SSL certificate provisioning
   - Test database persistence across container restarts

9. **Set Up Monitoring Access**
   - Use aliases for quick access:
     - `bin/kamal console` - Rails console
     - `bin/kamal logs` - Tail application logs
     - `bin/kamal shell` - Container bash shell
     - `bin/kamal dbc` - Database console

## Key Considerations for Dev Environment

### Database
- SQLite files stored in persistent Docker volume (`mca_race_results_storage:/rails/storage`)
- Production uses 4 separate SQLite databases (primary, cache, queue, cable)
- Volume persists across deployments but should be backed up regularly

### Environment Variables
- `SOLID_QUEUE_IN_PUMA: true` - Background jobs run in Puma process
- Consider setting `RAILS_LOG_LEVEL: debug` for dev environment
- May want to disable SSL for internal dev server

### Alternative: Dev-Specific Docker Compose
If you prefer a simpler dev setup without Kamal:
- Create `docker-compose.dev.yml` for local-style deployment
- Mount volumes for live code editing
- Expose ports directly without Traefik
- Use environment variables from .env file

### Ongoing Deployment
```bash
bin/kamal deploy              # Deploy latest code
bin/kamal rollback           # Rollback to previous version
bin/kamal app boot           # Start application
bin/kamal app stop           # Stop application
bin/kamal app restart        # Restart application
```

## Recommended Dev-Specific Modifications

1. **Create separate deploy config**: `config/deploy.dev.yml` with:
   - Dev server IP
   - Optional: Disable SSL for internal access
   - Dev-specific environment variables
   - Possibly smaller resource limits

2. **Consider database backups**: Add cron job or script to backup SQLite files from volume

3. **Log aggregation**: Configure centralized logging if managing multiple environments

## Quick Reference Commands

### Kamal Deployment
```bash
# Initial setup
bin/kamal setup

# Deploy updates
bin/kamal deploy

# Access running container
bin/kamal console          # Rails console
bin/kamal shell            # Bash shell
bin/kamal logs             # Application logs
bin/kamal dbc              # Database console

# Container management
bin/kamal app stop
bin/kamal app boot
bin/kamal app restart
bin/kamal rollback

# Build and push new image
bin/kamal build push
```

### Database Operations
```bash
# Run migrations
bin/kamal app exec 'bin/rails db:migrate'

# Seed database
bin/kamal app exec 'bin/rails db:seed'

# Database console
bin/kamal dbc
```

## Configuration Files Reference

- **Dockerfile** - Multi-stage production build
- **config/deploy.yml** - Kamal deployment configuration
- **config/database.yml** - Database configuration (SQLite with 4 production databases)
- **.dockerignore** - Files excluded from Docker build
- **bin/docker-entrypoint** - Container startup script
- **.kamal/secrets** - Deployment secrets (create this file)
