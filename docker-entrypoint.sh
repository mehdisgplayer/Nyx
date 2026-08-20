#!/bin/sh
set -e

echo "===================================================="
echo "🚀 [Nyx Panel] Starting in Cloud Container (PaaS)..."
echo "===================================================="

# Check if Xray binary exists
if [ -f "/app/backend/bin/xray" ]; then
    echo "✅ Xray binary found at /app/backend/bin/xray"
    # اگر خواستی هسته همینجا به صورت تستی در پس‌زمینه اجرا شود، می‌توانی این خط را فعال کنی:
    # /app/backend/bin/xray run -config /path/to/config.json &
else
    echo "⚠️ Xray binary not found in expected path!"
fi

# Auto-migrate database schema on startup
cd /app/backend
npx prisma db push --skip-generate || true

# Start Node.js API + Xray manager + Web UI
exec node dist/index.js
