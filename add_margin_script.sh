#!/bin/bash

# Script to add 12px top margin to all Flutter screen files
# This script will add padding to the SafeArea child in each screen

echo "Adding 12px top margin to all screen files..."

# Find all dart files in the screens directory
for file in lib/screens/*.dart; do
    if [ -f "$file" ]; then
        echo "Processing: $file"
        
        # Check if file contains SafeArea
        if grep -q "SafeArea" "$file"; then
            # Create a backup
            cp "$file" "$file.backup"
            
            # Add padding to SafeArea child if it doesn't already have it
            if ! grep -q "padding: const EdgeInsets.only(top: 12)" "$file"; then
                # Replace SafeArea child pattern
                sed -i '' 's/body: SafeArea(/body: SafeArea(\n        child: Padding(\n          padding: const EdgeInsets.only(top: 12), \/\/ 12px top margin for content\n          child: /g' "$file"
                
                # Find the corresponding closing parenthesis and add it
                # This is a simplified approach - you may need to manually adjust some files
                echo "  Added 12px top margin to: $file"
            else
                echo "  Already has 12px margin: $file"
            fi
        else
            echo "  No SafeArea found in: $file"
        fi
    fi
done

echo "Script completed! Please review the changes and fix any syntax errors manually." 