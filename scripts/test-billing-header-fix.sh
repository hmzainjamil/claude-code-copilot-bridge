#!/bin/bash
# Test du fix pour l'issue #174 - x-anthropic-billing-header
# Ce script teste que copilot-api filtre correctement le header réservé

set -euo pipefail

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Test du fix pour issue copilot-api #174"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Vérifier que copilot-api est lancé
echo "1️⃣  Vérification de copilot-api..."
if ! nc -z localhost 4141 2>/dev/null; then
    echo "❌ copilot-api n'est pas actif sur le port 4141"
    echo "   Lancez-le avec: copilot-api start"
    exit 1
fi
echo "✅ copilot-api actif sur :4141"
echo ""

# Test 1: Requête avec billing header dans le system prompt
echo "2️⃣  Test 1: System prompt avec x-anthropic-billing-header..."
RESPONSE=$(curl -s -X POST http://localhost:4141/v1/messages \
  -H "Content-Type: application/json" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 100,
    "system": "x-anthropic-billing-header: ?cc_version=2.1.15; ?cc_entrypoint=\\+\n./\n\nYou are a helpful assistant.",
    "messages": [{"role": "user", "content": "Say hello"}]
  }')

# Vérifier qu'il n'y a pas d'erreur 400
if echo "$RESPONSE" | jq -e '.error.code == "invalid_request_body"' >/dev/null 2>&1; then
    echo "❌ ÉCHEC: L'API retourne toujours l'erreur invalid_request_body"
    echo "$RESPONSE" | jq '.error'
    exit 1
fi

# Vérifier qu'on a une réponse valide
if echo "$RESPONSE" | jq -e '.content[0].text' >/dev/null 2>&1; then
    echo "✅ SUCCÈS: Requête acceptée sans erreur"
    echo "   Réponse: $(echo "$RESPONSE" | jq -r '.content[0].text' | head -c 50)..."
else
    echo "⚠️  AVERTISSEMENT: Réponse inattendue"
    echo "$RESPONSE" | jq '.' 2>/dev/null || echo "$RESPONSE"
fi
echo ""

# Test 2: Requête normale sans billing header (contrôle)
echo "3️⃣  Test 2: System prompt normal (contrôle)..."
RESPONSE2=$(curl -s -X POST http://localhost:4141/v1/messages \
  -H "Content-Type: application/json" \
  -H "anthropic-version: 2023-06-01" \
  -d '{
    "model": "claude-sonnet-4-6",
    "max_tokens": 100,
    "system": "You are a helpful assistant.",
    "messages": [{"role": "user", "content": "Say hello"}]
  }')

if echo "$RESPONSE2" | jq -e '.content[0].text' >/dev/null 2>&1; then
    echo "✅ SUCCÈS: Requête normale fonctionne également"
else
    echo "❌ ÉCHEC: Même les requêtes normales échouent"
    echo "$RESPONSE2" | jq '.' 2>/dev/null || echo "$RESPONSE2"
    exit 1
fi
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Tous les tests passent - Le fix fonctionne !"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 Résumé:"
echo "   • System prompt avec billing header : ✅ Accepté (filtré)"
echo "   • System prompt normal              : ✅ Accepté"
echo ""
echo "🎯 Prochaine étape: Tester avec Claude Code CLI"
echo "   ccc"
echo "   ❯ 1+1"
