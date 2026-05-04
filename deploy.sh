#!/bin/bash
set -e

# Factorio Mod Portal Deployment Script
# Requires: curl, jq, zip

# Configuration
MOD_NAME=$(jq -r .name info.json)
MOD_VERSION=${1-$(jq -r .version info.json)}
ZIP_NAME="${MOD_NAME}_${MOD_VERSION}.zip"
DIST_DIR="dist"
REF="v${MOD_VERSION}"

# Ensure API token is set
if [ -z "$FACTORIO_MOD_PORTAL_TOKEN" ]; then
	# Generate one here: https://factorio.com/profile under 'API Keys'
	# save it in token.sh in the form `FACTORIO_MOD_PORTAL_TOKEN=YOUR_TOKEN`
	TOKEN_FILE="$(dirname $0)/token.sh"
	if [ -e "$TOKEN_FILE" ]
	then
		echo "Loading token from ${TOKEN_FILE}..."
		. "$(dirname $0)/token.sh"
	fi
fi
if [ -z "$FACTORIO_MOD_PORTAL_TOKEN" ]; then
	echo "Loading token from ~/.factorio/player-data.json..."
	FACTORIO_MOD_PORTAL_TOKEN="$(jq -r '."service-token"' ~/.factorio/player-data.json)"
fi
if [ -z "$FACTORIO_MOD_PORTAL_TOKEN" ]; then
    echo "Error: FACTORIO_MOD_PORTAL_TOKEN environment variable is not set."
    exit 1
fi

echo "Packaging $MOD_NAME version $MOD_VERSION..."

# Create dist directory
mkdir -p "$DIST_DIR"

# Zip the mod (excluding development files)
# We zip into a subfolder named MOD_NAME to match Factorio's expected structure
rm -f "$DIST_DIR/$ZIP_NAME"
echo "git archive --format=zip --prefix=\"$MOD_NAME/\" -o \"$DIST_DIR/$ZIP_NAME\" \"${REF}\""
git archive --format=zip --prefix="$MOD_NAME/" -o "$DIST_DIR/$ZIP_NAME" "${REF}"

# Remove irrelevant files from the archive
zip -d "$DIST_DIR/$ZIP_NAME" \
    "$MOD_NAME/deploy.sh" \
    "$MOD_NAME/GEMINI.md" \
    "$MOD_NAME/TODO.md" \
    "$MOD_NAME/token.sh" \
    "$MOD_NAME/.gitignore" \
    "$MOD_NAME/.gitattributes" \
    2>/dev/null || true

echo "Requesting upload URL for $MOD_NAME..."

# 1. Initialize upload
RESPONSE=$(curl -s -X POST https://mods.factorio.com/api/v2/mods/releases/init_upload \
    -H "Authorization: Bearer $FACTORIO_MOD_PORTAL_TOKEN" \
    -F "mod=$MOD_NAME")

UPLOAD_URL=$(echo "$RESPONSE" | jq -r .upload_url)

if [ "$UPLOAD_URL" == "null" ] || [ -z "$UPLOAD_URL" ]; then
    echo "Error: Failed to get upload URL. Response:"
    echo "$RESPONSE"
    exit 1
fi

echo "Uploading $ZIP_NAME..."

# 2. Upload the file
UPLOAD_RESPONSE=$(curl -s -X POST "$UPLOAD_URL" \
    -F "file=@$DIST_DIR/$ZIP_NAME")

if echo "$UPLOAD_RESPONSE" | jq -e .success >/dev/null; then
    echo "Successfully uploaded $MOD_NAME v$MOD_VERSION to the Mod Portal!"
else
    echo "Error: Upload failed. Response:"
    echo "$UPLOAD_RESPONSE"
    exit 1
fi
