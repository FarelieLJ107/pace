
#!/usr/bin/env bash

set -euo pipefail

echo "======================================"
echo "       PACE DEVELOPMENT SETUP"
echo "======================================"

# Check Node.js
echo ""
echo "[1/6] Checking Node.js..."

node --version
npm --version

NODE_MAJOR="$(node -p "process.versions.node.split('.')[0]")"

if [ "$NODE_MAJOR" != "24" ]; then
  echo "ERROR: PACE requires Node.js 24."
  exit 1
fi

# Install pnpm
echo ""
echo "[2/6] Installing pnpm 12..."

npm install --global pnpm@12

pnpm --version

# Check repository root
echo ""
echo "[3/6] Checking repository..."

if [ ! -f package.json ]; then
  echo "package.json not found."
  echo "Skipping dependency installation."
  exit 0
fi

# Install dependencies if lockfile exists
echo ""
echo "[4/6] Installing dependencies..."

if [ -f pnpm-lock.yaml ]; then
  pnpm install --frozen-lockfile
else
  echo "No lockfile found yet."
  echo "Dependency installation will be completed"
  echo "after the initial project scaffold."
fi

# Check project instructions
echo ""
echo "[5/6] Checking instructions..."

if [ -f CLAUDE.md ]; then
  echo "CLAUDE.md found."
fi

if [ -f docs/PRD.md ]; then
  echo "PRD.md found."
fi

# Finish
echo ""
echo "[6/6] Setup complete."

echo "======================================"
echo "       PACE ENVIRONMENT READY"
echo "======================================"
